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

  Last verified: commit 3ce7961 (+ removed the High-register NAKED
  fast-path; high-reg pins are matchable pure-C levers, per CLAUDE.md).
  Update the "last verified" line in every PR that materially changes the
  playbook.
-->

# Decomp agent playbook

## Goal

Take one named target function from the still-asm cluster and drive it to a
**byte-identical match in pure C** — the only real success.

If, after an honest hunt, it genuinely will not match, you DEFER — which now
means: record the analysis AND map the function into `src/` as a
NAKED+NON_MATCHING TU (your best-attempt C under `#ifdef NON_MATCHING`, the
bytes supplied by an `#else` `.incbin`). That keeps the repo fully mapped and
the target in the revisit queue (see "DEFER, and MAP it" below). Deferring is a
fallback *after* the hunt, never a shortcut around it.

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
   - "High registers (sl/r10, sb/r9, r8)" — for the `register asm("rN")`
     pin syntax; these are usually MATCHABLE in pure C, not a NAKED trigger
     (see "High registers are NOT a NAKED fast-path" below)
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

- **`byte_diff > 0` (any nonzero value)**: you are NOT done. The
  default is to keep iterating in pure C. NAKED is a LAST resort with
  hard prerequisites — see "NAKED gate" below.

### NAKED gate — the honest-hunt bar before you defer-and-map

A 9-iter retrospective (iters 16-28) found that ~9 of 10 NAKED commits
shipped without honest evidence of unmatchability. Multiple were later
shown to be matchable in pure C with simple source mutations. So before you
DEFER (which ships a NAKED+NON_MATCHING TU + doc — see "DEFER, and MAP it"
below), you MUST clear ALL of the following. They are the line between a
legitimate defer-and-map and giving up early:

1. **Permuter was actually run.** Set up `nonmatchings/<fn>/` with the
   pure-C base and the target asm. Run at least 1000 iterations OR
   until the best score has been stalled for 500 iterations. Save the
   `permuter.log` tail showing iter count + best score in your report.
   "Permuter probably won't help" or "same class as X" is NOT
   sufficient — RUN IT.
2. **At least 5 distinct source-form variations were tried** in pure C
   before resorting to NAKED. Document each in the report:
   - Variant tried (one-line description)
   - Resulting byte_diff
   Examples of variants: register pins on different regs, local-var
   factoring, explicit casts, pointer typedef changes, statement
   reordering, splitting compound expressions, volatile.
3. **The specific unmatchable class is matched by EVIDENCE for THIS
   function**, not borrowed from a sibling. Cite either:
   - A concrete corpus hit pattern (run `tools/agent/corpus.py grep
     '<exact-pattern>' --c` and quote the result).
   - A specific permuter log line showing the score plateaued for
     500+ iters at >0.
   "Same class as sub_XYZ" without independent evidence is REJECTED.
4. **The NON_MATCHING reference body MUST be present.** A NAKED-only
   commit without a parallel `#ifdef NON_MATCHING / void <FN>(...)`
   readable C body is rejected. The readable body documents intent
   for the phase-3 PC port and IS the source-of-truth for future
   re-attempts when permuter improves or a new idiom is discovered.

### High registers are NOT a NAKED fast-path

Earlier guidance treated `mov sl/sb/r8/ip` high-register pins as a shape
that *skips* the NAKED gate. That was wrong and is removed — it caused
premature NAKED ships (see CLAUDE.md "High-register pins are NOT a blanket
NAKED trigger" and the corpus finding that a Konami GBA agbcc title matches
game logic ~100% in pure C). A high register holding a value is usually
**matchable** via a `register T x asm("r8"/"r9"/"sl")` declaration — that is
a *pure-C* matching lever, not inline asm and not a NAKED trigger
(sub_080210A0 matches with all three; sub_08004508 holds r8+r9 across a
`bl`). Treat a high-reg pin as **advisory**: a hint for *which* lever to
reach for in step 3, never license to skip the attempt.

The genuinely-unmatchable high-reg case is narrow — a high reg holding *loop
state across an inner function-pointer `bl`* (the opcode-dispatch /
two-stage-loop classes). That case still goes through the full NAKED gate
above (`classify_unmatchable.py` STRONG verdict + the four prerequisites),
exactly like any other candidate. There is no fast path.

### NAKED format

The `#ifdef NON_MATCHING` branch is **the agent's best attempt** — the
closest-matching readable C you developed during the hunt, preserved as live
source (NOT a vague paraphrase, NOT just a comment). The `#else` branch is the
byte-providing fallback. The compiled branch is `#else`; `NON_MATCHING` is never
defined in the build.

```c
#ifdef NON_MATCHING
<your best-attempt C — the near-match you drove to, kept verbatim>
#else
NAKED void <FN>(void)
{
    /* deferral/mapping form: byte-guaranteed, no asm transcription needed */
    asm(".incbin \"frog_us_baserom.gba\", 0x<file_off>, 0x<len>\n");
}
#endif /* NON_MATCHING */
```

- `<file_off>` = `addr − 0x08000000`; `<len>` is the byte count from the slice's
  `.incbin` line. This is the **standard deferral form** — it maps the function
  with zero risk of a transcription error.
- **Alternative (only if you genuinely transcribed the asm):** an `#else` body of
  real Thumb mnemonics, `asm(".syntax unified\n" … ".syntax divided\n")`. It has
  NO advantage over `.incbin` for a deferred (un-matched) function, so reserve it
  for the rare case you actually analyzed instruction-by-instruction.
- **CRITICAL** (mnemonic form only): every NAKED `asm()` block MUST end with
  `".syntax divided\n"` — `.syntax unified` bleeds into following functions in
  the same .o and breaks Thumb-1 silently. See `docs/codegen-notes.md`. The
  `.incbin` form does not use `.syntax` and is immune to this.

### `byte_diff > 0` after an honest hunt — DEFER, and MAP it

When you genuinely cannot reach byte_diff 0 (the gate prerequisites are
met: permuter actually run, ≥5 distinct pure-C structures tried, drift
understood), you DEFER. A defer is **not** a bare give-up and no longer
leaves the function as a raw asm slice — it does TWO things so the repo
gets fully mapped and the work resumes warm:

1. **Write the deferred-analysis doc** — `docs/deferred-analysis/<FN>.md`
   with a `## Drift` section (best byte_diff/diff_count, WHICH
   register/fold/schedule diverged, levers + permuter score tried, so the
   next agent picks a DIFFERENT lever) and a `## Best-effort C` section
   (your most-correct readable C in a ```c block).

2. **Ship a NAKED+NON_MATCHING TU** — give the function a real home in
   `src/`: the best-effort readable C under `#ifdef NON_MATCHING`, and an
   `#else` NAKED body that supplies the bytes via `.incbin` (the
   byte-guaranteed deferral form — see "NAKED format" below). Wire the TU
   into `linker.ld` in the slot the asm slice held and delete the slice.
   `make check` must stay green.

Because the deferred-analysis doc is present, `function_status.py` reports
the function as **`deferred`** (NOT terminal `naked`), so it stays in the
revisit/escalation queue — a later pass or stronger model resumes from your
drift note instead of starting cold. You are mapping the repo and recording
intent, not abandoning the target.

**The caveat that keeps this honest:** NAKED+NON_MATCHING is the OUTCOME of
a real match hunt, NEVER a shortcut to skip it. Do not reach for the
`.incbin` to dodge the pure-C work — the gate prerequisites ARE the line
between a legitimate defer-and-map and giving up early. A function shipped
NAKED without that hunt is the failure mode the gate exists to prevent; a
function deferred-and-mapped *after* the hunt is correct and expected.

If you cannot even ship the NAKED+NON_MATCHING TU for a mechanical reason
(the asm slice needs mnemonic refinement too large to do safely), revert to
a clean tree and report the blocker — never commit a broken/non-matching
build.

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
