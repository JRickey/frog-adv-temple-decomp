<!--
  Decomp-agent playbook. Reference this file from one-shot agent briefs:

      "You are a decomp agent. Playbook: tools/agent/prompts/decomp.md.
       Target: <fn>. Notes specific to this target: …"

  This file lives in the repo (not in `.claude/skills/` or similar) because
  it is agent-facing — passed to subagents in dispatch briefs, not invoked
  by the user. The mizuchi-derived prompts in this same directory
  (`system.md`, `task_template.md`, etc.) target a different workflow: the
  per-function auto-decompiler pipeline. This file is for the broader
  general-purpose agents that pick a target, scaffold a new C file, drive
  it to match, and handle the decision tree around fallbacks.

  Last verified: commit e68028c. Update the "last verified" line in every
  PR that materially changes the playbook.
-->

# Decomp agent playbook

## Goal

Take one named target function from the still-asm cluster and ship a
**matching** decompilation — either a pure-C definition that yields
byte-identical output, or a NAKED inline-asm body in C with a parallel
`#ifdef NON_MATCHING` reference body (for codegen the corpus has proven
unmatchable in C).

Success criterion: `make check` exits 0 AND
`python3 tools/agent/compile_and_view_assembly.py <FN> --human` reports
`byte_diff: 0`. **Nothing else qualifies.** Self-assessed "should match"
is wrong about half the time on agbcc 2.x.

## Setup reading (in this order)

1. `git log --oneline -10` — recent decomp commits. Note any new patterns
   landed since this playbook was "Last verified" at top of file.
2. `CLAUDE.md` — re-read the "Agent workflow — peel-first, then decomp"
   section. The agbcc 2.x quirks list in step 5 is the short version of
   what you need to know about the toolchain.
3. `docs/codegen-notes.md` — full quirks reference. The sections that
   bite hardest are documented in order of how often they bite:
   - "Adjacent IWRAM bases — defeat CSE-fold via linker-assigned symbols"
   - "`register T *p asm("rN")` pins agbcc's register choice"
   - "`asm("" : "=r"(dst) : "0"(src))` as a mov-fence"
   - "High registers (sl/r10, sb/r9, r8) — corpus-validated unmatchable"
   - "`.syntax unified` in NAKED inline asm bleeds into the rest of the .o"
   - "Apostrophes in C comments break `tools/preproc`" (rare for code,
     more common for data — but the pre-commit guard catches it anyway).
4. **The siblings in the same cluster.** If the target is in
   `src/system/sound_channel.c`'s cluster, read that file end-to-end:
   struct typedefs, existing functions (both pure-C and NAKED forms),
   the docstring near each function. Reuse types. Don't re-derive offsets.
5. The picker's brief on your target:
   `python3 tools/agent/decomp_brief.py <FN>`. Note pool entries,
   struct cross-refs, callees.

## Workflow

1. **Refine the asm slice to Thumb mnemonics** in
   `asm/disasm_0x<addr>.s`. Replace `.incbin` with real instructions,
   matching byte-for-byte. Preserve any inline literal pools at their
   exact relative offsets, and trailing alignment padding. Confirm with
   `make -j8 && make check` (must still pass).
2. **Scaffold the destination** (one of):
   - **Append/prepend to an existing C file** if it's in the same
     cluster (e.g., the sound functions all land in
     `src/system/sound_channel.c`). Extend that .o's `linker.ld` range
     to cover the new function's bytes.
   - **Create a new file** if there's no adjacent C neighbor. Pick a
     thematic name (`src/system/sound_envelope.c`,
     `src/game/<system>.c`, etc.). Add to `linker.ld` at the slot
     currently held by the asm slice. Reuse struct typedefs from the
     cluster (either via a shared `include/` header or by duplicating
     locally with a comment pointing at the source).
3. **Try pure C first.** Match the asm's control flow shape, type the
   pool literals against any already-extracted typed symbols
   (`grep -l 0x<addr> src/data/*.c`), apply `register T x asm("rN")`
   pins from the first attempt (don't wait for register-allocation
   drift to bite you). Use mov-fences (`asm("" : "=r"(d) : "0"(s))`)
   if agbcc folds an init+shift into a single instruction the baserom
   doesn't.
4. **Iterate.** After every edit run
   `python3 tools/agent/compile_and_view_assembly.py <FN> --human`.
   Read the diff lines — they tell you exactly which instructions
   differ. Patch the C accordingly; don't rewrite parts that already
   match. Budget ~5-8 iterations.
5. **Use the corpus** when you hit a stubborn fold pattern:
   `python3 tools/agent/corpus.py grep '<idiom>' --c`. Other agbcc decomps
   have almost certainly solved the same idiom; the answer is usually
   in their git history (the asm-as-incbin form gets deleted when they
   match, so the idiom only survives in git).
6. **Permuter as a finishing tool** (5-10 min budget) when you're close
   (byte_diff ≤ 10) but plateaued. Standard invocation pattern is in
   `git show c636032` — it found the `gpsp` trick on `sub_0802ED5C` in
   one iteration after manual attempts plateaued.

## Decision tree

After step 4 (iteration), branch on the diff state:

- **`byte_diff = 0`**: matched in pure C. Delete the asm slice, update
  `linker.ld` (remove the disasm entry; the src/ entry's range now
  covers it). Run `tools/agent/snapshot_addresses.py`,
  `tools/agent/progress_stats.py --update-readme`. Leave staged.
- **`byte_diff ≤ 30`, no high-register pins, no other agent has solved
  this specific shape**: try corpus search + permuter. Budget ≤ 30
  min total. If it doesn't land, fall through.
- **High-register pins seen in the asm** (`mov sl, …`, `mov sb, …`,
  `mov r8, …` for loop state): SKIP pure C and permuter. Corpus
  evidence (`docs/codegen-notes.md` "High registers") says no agbcc
  decomp has ever matched this shape in C. Ship as NAKED +
  `#ifdef NON_MATCHING`.
- **NAKED + `#ifdef NON_MATCHING` fallback**:
  - Outer: `NAKED void <FN>(void) { asm(".syntax unified\n" … ".syntax divided\n"); }`
  - Inner: `#ifdef NON_MATCHING / void <FN>(void) { … readable goto-shaped C … } / #endif`
  - **CRITICAL**: every NAKED `asm()` block ends with `".syntax divided\n"`.
    `.syntax unified` bleeds into following functions in the same .o
    and breaks Thumb-1 syntax silently. See `docs/codegen-notes.md`.
  - The reference body doesn't need to compile; it documents intent
    for the phase-3 PC port. Use `register T x asm("rN")` pins, gotos,
    raw casts — whatever makes the algorithm readable.
- **`byte_diff > 30` after a reasonable effort and no NAKED-trigger**:
  stop. Don't ship a half-matching C. Restore the asm slice + the
  refined-mnemonics version. Land a comment in the cluster's C file
  describing what blocked you. Future agents can pick it up.

## Common pitfalls

- **agbcc 2.x rounds nested structs upward.** A nested 6-byte struct
  gets padded to 8 inside an outer struct with u32 alignment.
  Compensate with smaller pad arrays (`u8 _pad34[2]` not `[6]`). When
  in doubt, verify offsets with `compile_and_view_assembly.py` — the
  diff tells you immediately.
- **`(u32)x >> 8` vs `x >> 8`**: the cast triggers `lsrs` (logical),
  bare expression on a signed type triggers `asrs` (arithmetic).
  Baserom often wants the logical form.
- **`gpsp = &gpSoundSystem` trick**: when the baserom caches a global
  address into a register (typically `ip` or `sl`) early in the
  prologue, agbcc only does this if you give it an explicit local
  pointer. Without `SoundSystem **gpsp = &gpSoundSystem;` inside the
  count guard, the cache emits lazily at first use and the scheduler
  picks a different prologue order.
- **CSE on `env->step`** (or any field read multiple times in a basic
  block): agbcc caches the first `ldrsh` and reuses it. If the
  baserom emits three separate loads, you need either a destructive
  add that overwrites the cached register, or a mov-fence to break
  the cache.
- **Pre-commit hooks** are non-negotiable. clang-format always runs;
  the apostrophe-in-comment guard runs on INCBIN-using C files.
  Don't `--no-verify`.
- **Coordinate** when other agents run in parallel: a data agent
  modifying `linker.ld` around `0x083xxxxx` won't conflict with your
  code-region linker.ld edits if you use precise `Edit` (with
  surrounding context lines), not `replace_all`.

## Output (final report)

When you finish, tell the user:

1. **Final `make check` status** (must be OK) and per-function
   `byte_diff` (must be 0).
2. **Match path**: pure C / permuter-helped / NAKED+NON_MATCHING.
3. **Pool literals you swapped** to already-extracted typed symbols
   (if any). Drives the data-pass to confirm coverage.
4. **Struct extensions** if you grew `SoundSlot`/`SoundSystem`/etc.
   List the offsets. Future siblings inherit them.
5. **New agbcc/preproc quirks**. Format as a `TODO note for
   docs/codegen-notes.md:` line in your report — the user will fold
   them in.
6. **Scoreboard delta**: `progress_stats.py --update-readme` after
   landing. Leave staged.

## Hard constraints (apply to every dispatch)

- **NO leaked Konami source.** Disassembly + project files + the
  curated corpus only.
- **NEVER edit** `frog_us.sha1`, `baserom.gba`, `frog_us_baserom.gba`,
  or `database.json` (data agents own that).
- **NEVER `git commit` or `git push`** — leave staged. The user reviews
  every landing.
- **NEVER skip pre-commit hooks** (`--no-verify`). If clang-format
  complains, run `clang-format -i <file>` and re-stage.
- **No apostrophes in `/* */` or `//` inside INCBIN-using C files**
  (use `’` typographic, or rephrase). The pre-commit guard catches
  it but don't waste a roundtrip.
