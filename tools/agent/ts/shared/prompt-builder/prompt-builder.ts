import type { PlatformTarget } from '~/shared/platform-target.js';

import { getFuncContext, type MizuchiDbLike } from './codebase-context.js';
import { craftPrompt } from './craft-prompt.js';

/**
 * Build a per-function decompile prompt.
 *
 * Mizuchi's original entrypoint took a `MizuchiDb` plus a function ID and
 * looked up everything (name, asm body, callees, callers, similar functions).
 * We don't yet have the embeddings/index layer ported, so the caller supplies
 * `asmName`, `asmCode`, `modulePath`, and the list of callee names directly.
 *
 * If a `mizuchiDb`-shaped DB becomes available (once the indexer port lands),
 * pass it together with `functionId` to re-enable similar-function sampling
 * and caller injection.
 */
export async function createDecompilePrompt(params: {
  projectRoot: string;
  platform: PlatformTarget;
  asmName: string;
  asmCode: string;
  modulePath: string;
  calledFunctionNames: string[];
  mizuchiDb?: MizuchiDbLike;
  functionId?: string;
}): Promise<string> {
  const { projectRoot, platform, asmName, asmCode, modulePath, calledFunctionNames, mizuchiDb, functionId } = params;

  const { asmDeclaration, calledFunctionsDeclarations, sampling, typeDefinitions } = await getFuncContext({
    projectRoot,
    functionName: asmName,
    calledFunctionNames,
    mizuchiDb,
    functionId,
  });

  return craftPrompt({
    platform,
    modulePath,
    asmName,
    asmDeclaration,
    asmCode,
    calledFunctionsDeclarations,
    sampling,
    typeDefinitions,
  });
}
