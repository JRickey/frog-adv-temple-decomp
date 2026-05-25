# Prompt / template attribution

The prompts and prompt-construction logic in this directory are adapted from
[Mizuchi](https://github.com/macabeus/mizuchi), a multi-platform matching-decomp
agent pipeline. Mizuchi targets the same toolchain we do (agbcc 2.x +
arm-none-eabi-binutils, ARMv4T), so the prompts apply almost verbatim with the
substitutions noted below.

Mizuchi is MIT-licensed. The full license follows.

Files adapted (each carries a per-file attribution header):

- `system.md` ← `mizuchi.example.yaml::plugins.claude-runner.systemPrompt`
- `kickoff.md` ← `mizuchi.example.yaml::plugins.claude-runner.kickoffMessage`
- `stall.md` ← `mizuchi.example.yaml::plugins.claude-runner.softTimeout.prompt`
- `task_template.md` ← `src/shared/prompt-builder/craft-prompt.ts`
- `../craft_prompt.py` ← Python port of the same `craft-prompt.ts`

TypeScript ports under `../ts/` (each is a near-verbatim copy of the
corresponding mizuchi source with import paths rewritten for our tree
layout):

- `../ts/shared/map-file/map-file.ts` ← `src/shared/map-file/map-file.ts`
- `../ts/shared/indexer/asm-utils.ts` ← `src/shared/indexer/asm-utils.ts`
- `../ts/shared/platform-target.ts` ← extracted minimum from `src/shared/config.ts`
- `../ts/shared/errors.ts` ← `src/shared/errors.ts`
- `../ts/shared/capped-output.ts` ← `src/shared/capped-output.ts`
- `../ts/shared/sdk-error-handlers.ts` ← `src/shared/sdk-error-handlers.ts`
- `../ts/shared/objdiff.ts` ← `src/shared/objdiff.ts`
- `../ts/shared/c-compiler/c-compiler.ts` ← `src/shared/c-compiler/c-compiler.ts`
- `../ts/shared/prompt-builder/{prompt-builder,craft-prompt,codebase-context,ast-grep-utils}.ts`
   ← `src/shared/prompt-builder/*.ts`
- `../ts/shared/m2c.ts` ← `src/shared/m2c.ts`
- `../ts/shared/decomp-permuter.ts` ← `src/shared/decomp-permuter.ts`
- `../../../scripts/setup-m2c.sh` ← `scripts/setup-m2c.sh`
- `../../../scripts/setup-decomp-permuter.sh` ← `scripts/setup-decomp-permuter.sh`
- `../../../scripts/compile-agbcc.sh` ← derived from `mizuchi.example.yaml::compilerScript`

Substitutions vs upstream Mizuchi:

- Our agent uses `Read`/`Edit`/`Write` against `src/*.c` directly rather than
  Mizuchi's "C code concatenated with `ctx.h`" sandbox flow. The system prompt
  is updated to describe that workflow.
- `compile_and_view_assembly` is implemented here as
  `tools/agent/compile_and_view_assembly.py` against an incrementally-built ROM
  plus byte-range diff against `frog_us_baserom.gba`, rather than Mizuchi's
  isolated `.o` compile + objdiff-wasm comparison.

---

MIT License

Copyright (c) 2025 macabeus

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
