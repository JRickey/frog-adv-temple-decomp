import { SgNode, findInFiles } from '@ast-grep/napi';

import { getFirstParentWithKind, registerClangLanguage } from './ast-grep-utils.js';

export type DecompFuncContext = {
  asmDeclaration?: string;
  calledFunctionsDeclarations: { [functionName: string]: string };
  sampling: SamplingCFunction[];
  typeDefinitions: string[];
};

export type SamplingCFunction = {
  name: string;
  cCode: string;
  asmCode: string;
  callsTarget: boolean;
};

/**
 * Minimal shape we use from mizuchi's `MizuchiDb`. Best-effort inferred from
 * the call sites in mizuchi's original `getFuncContext`. The embeddings layer
 * is NOT yet ported into this repo; until it is, callers should pass
 * `mizuchiDb: undefined` and the similar-functions branch is skipped.
 *
 * Once the indexer/embeddings layer is ported, replace this interface with
 * the real `MizuchiDb` import.
 */
export interface MizuchiDbLike {
  getFunctionById(id: string): MizuchiDbFunction | undefined;
  findSimilar(fnName: string, k: number): { function: MizuchiDbFunction }[];
  getCalledBy(id: string): MizuchiDbFunction[];
}

export interface MizuchiDbFunction {
  name: string;
  cCode?: string;
  asmCode: string;
  callsFunctions: string[];
}

type CodebaseContext = {
  asmDeclaration?: string;
  calledFunctionsDeclarations: { [functionName: string]: string };
  typeDefinitions: string[];
};

async function getCodebaseContext(
  functionName: string,
  calledFunctionNames: string[],
  projectRoot: string,
): Promise<CodebaseContext> {
  registerClangLanguage();

  const allFunctionsName = [functionName, ...calledFunctionNames];

  const typeDefinitionsAddedNames = new Set<string>();
  const result: CodebaseContext = {
    calledFunctionsDeclarations: {},
    typeDefinitions: [],
  };

  const declarationsNode: SgNode[] = [];

  // Phase 1: Find function declarations
  await findInFiles(
    'c',
    {
      paths: [projectRoot],
      matcher: {
        rule: {
          kind: 'identifier',
          regex: allFunctionsName.map((name) => `^(${name})$`).join('|'),
          inside: {
            kind: 'function_declarator',
          },
        },
      },
      languageGlobs: ['*.c', '*.h'],
    },
    (err, nodes) => {
      if (err) {
        console.warn('Error finding function declarations:', err);
      }

      for (const node of nodes) {
        const declarationNode = getFirstParentWithKind(node, 'declaration');
        if (!declarationNode) {
          continue;
        }

        declarationsNode.push(declarationNode);

        if (node.text() === functionName) {
          result.asmDeclaration = declarationNode.text();
        } else {
          result.calledFunctionsDeclarations[node.text()] = declarationNode.text();
        }
      }
    },
  );

  // Phase 2: Find type definitions for custom types used in declarations
  if (declarationsNode.length) {
    const ignoreTypes = new Set(['u8', 'u16', 'u32', 'u64', 's8', 's16', 's32', 's64']);

    const typesFromDeclarations = new Set<string>();
    for (const declaration of declarationsNode) {
      declaration.findAll({ rule: { kind: 'type_identifier' } }).forEach((typeNode) => {
        const typeName = typeNode.text();

        if (ignoreTypes.has(typeName)) {
          return;
        }

        typesFromDeclarations.add(typeName);
      });
    }

    if (typesFromDeclarations.size > 0) {
      await findInFiles(
        'c',
        {
          paths: [projectRoot],
          matcher: {
            rule: {
              kind: 'type_identifier',
              regex: [...typesFromDeclarations].map((name) => `^(${name})$`).join('|'),
              inside: {
                kind: 'type_definition',
              },
            },
          },
          languageGlobs: ['*.c', '*.h'],
        },
        (err, nodes) => {
          if (err) {
            console.warn('Error finding type definitions:', err);
          }

          for (const node of nodes) {
            const typeDefinitionNode = getFirstParentWithKind(node, 'type_definition');
            if (!typeDefinitionNode) {
              continue;
            }

            if (!typeDefinitionsAddedNames.has(node.text())) {
              typeDefinitionsAddedNames.add(node.text());
              result.typeDefinitions.push(typeDefinitionNode.text());
            }
          }
        },
      );
    }
  }

  return result;
}

/**
 * Build the codebase-context portion of a decompile prompt.
 *
 * Two calling modes:
 *
 *   1. With a `mizuchiDb`-shaped DB (full mizuchi behaviour): resolves
 *      callee names from function IDs, performs vector-similarity sampling,
 *      and pulls callers. This branch is currently dormant in our repo —
 *      no MizuchiDb implementation has been ported yet.
 *
 *   2. Without a DB (the current default in this repo): caller supplies
 *      `functionName` and `calledFunctionNames` directly. The
 *      similar-functions / callers `sampling` array comes back empty.
 *
 * Both modes share the ast-grep-driven declaration + type-definition
 * extraction.
 */
export async function getFuncContext(params: {
  projectRoot: string;
  functionName: string;
  calledFunctionNames: string[];
  /** Optional. When omitted, similar-function sampling is skipped. */
  mizuchiDb?: MizuchiDbLike;
  /** Required when `mizuchiDb` is provided — used to drive findSimilar/getCalledBy. */
  functionId?: string;
}): Promise<DecompFuncContext> {
  const { projectRoot, functionName, calledFunctionNames, mizuchiDb, functionId } = params;

  const context = await getCodebaseContext(functionName, calledFunctionNames, projectRoot);

  const result: DecompFuncContext = {
    asmDeclaration: context.asmDeclaration,
    calledFunctionsDeclarations: context.calledFunctionsDeclarations,
    sampling: [],
    typeDefinitions: context.typeDefinitions,
  };

  if (mizuchiDb && functionId) {
    // Similar functions from vector search — filter to those with cCode
    const similarResults = mizuchiDb.findSimilar(functionId, 50);
    for (const similar of similarResults) {
      if (!similar.function.cCode) {
        continue;
      }
      result.sampling.push({
        name: similar.function.name,
        cCode: similar.function.cCode,
        asmCode: similar.function.asmCode,
        callsTarget: similar.function.callsFunctions.includes(functionId),
      });
    }

    // Functions that call the target — filter to those with cCode
    const callers = mizuchiDb.getCalledBy(functionId);
    for (const caller of callers) {
      if (!caller.cCode) {
        continue;
      }
      // Avoid duplicates if already added from similarity search
      if (result.sampling.some((s) => s.name === caller.name)) {
        continue;
      }
      result.sampling.push({
        name: caller.name,
        cCode: caller.cCode,
        asmCode: caller.asmCode,
        callsTarget: true,
      });
    }
  }

  return result;
}
