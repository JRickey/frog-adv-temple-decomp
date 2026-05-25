<!--
  Adapted from Mizuchi (https://github.com/macabeus/mizuchi),
  src/shared/prompt-builder/craft-prompt.ts :: templateDecompile
  Copyright (c) 2025 macabeus, MIT License. See ATTRIBUTION.md.

  Rendered by tools/agent/craft_prompt.py. The {{placeholders}} are filled
  in from the local project state; any slot whose source data is empty is
  dropped before rendering (no empty headings in the output).
-->

You are decompiling an assembly function called `{{assemblyFunctionName}}` in {{assemblyLanguage}} from a {{platformName}} game.

{{examplePrompts}}

{{functionsCallingTargetPrompt}}

{{targetAssemblyDeclarationPrompt}}

{{functionDeclarationsPrompt}}

{{typeDefinitionsPrompt}}

# Primary Objective

Decompile the following target assembly function from `{{modulePath}}` into clean, readable C code that compiles to an assembly matching EXACTLY the original one.

```asm
{{assemblyCode}}
```

# Rules

- The C function must live inside `{{destinationCFile}}`. Read that file first to learn the project's local conventions before adding your function.
- If you need a new type or struct, search `include/` first to confirm it doesn't already exist under a different name.
- After every code edit, run `tools/agent/compile_and_view_assembly.py {{assemblyFunctionName}}` and act on the diff.
- Once `diff_count == 0`, delete the corresponding `thumb_func_start {{assemblyFunctionName}}` block (and its body up to the next `thumb_func_start` or `arm_func_start`) from `{{assemblyFile}}`.
- Show the complete C function in your final answer; do not abbreviate.

# Style (HARD)

A matching decomp is not enough. The C must look like code a human would write. Apply all of these before declaring done — they are part of the matching criterion, not a follow-up.

**Use enums / defines for every named-thing constant:**
- Whenever a literal stands for a *kind of thing* (state, mode, flag, ID, sound, sprite type), use the named constant. If the enum doesn't exist yet for the value you need, ADD it in the same change. No bare `0x29` for things that have names.

**Local variables and literals:**
- Don't reuse a local var as a "happens to be zero" alias. If `v != 0 -> early return`, write the literal `0` in the rest of the function, not `v`.
- Don't introduce intermediate locals that exist only to cache one field read; inline them. Only cache when matching demands it.

**Control flow — early-return, no `else`:**
- `if (cond) { ...; return; }` then unindented body — NEVER `if (cond) { return-body } else { unindented-body }`.
- No `else` after a branch that returns.

**No side effects in conditions:**
- Don't write `if (++x == 0)`, `if (--x ...)`, `if ((x = Foo()) ...)`. Split into two statements unless required to match (and then say so in the commit message).

**Formatting:**
- Match the include-grouping convention of the destination file.
- No process or "explanation" comments in code ("will be replaced when X", "non-static so the linker keeps it", etc.). Put those in the PR description.

**When matching is hard:**
- Failing to match because the C is in upstream-friendly style is preferable to matching with raw hex everywhere. If a stylistic form blocks the match, leave a `/* TODO permuter: matching needs ... */` comment AND report it — don't quietly downgrade to LLM-translated assembly.
