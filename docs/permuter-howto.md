# decomp-permuter runbook (for stuck-but-matchable functions)

> ## ⚠️ Two setup bugs make the steps below UNRELIABLE — fix first (2026-06-03)
>
> The flow as originally written silently mis-scores by ~100× and/or optimizes the
> wrong compiler. Until the scripts are fixed, override two things:
>
> 1. **target.o must carry `$t`/`$d` mapping symbols.** The
>    `extract-function-bytes.ts` target uses `.inst.n` for the whole function, so
>    objdump disassembles the literal pool as garbage Thumb → ~100 pts per phantom
>    insert/delete (sub_080112C0 scored 2545 for byte_diff 8). Use instead:
>    `python3 tools/agent/make_permuter_target.py <fn>` (writes a correct
>    `nonmatchings/<fn>/target.{s,o}` with `$t`/`$d` + matching relocations).
> 2. **Compile candidates with the SAME agbcc as the real build.** The Makefile
>    default is `old_agbcc`; new and old agbcc differ for some functions.
>    `tools/permuter_compile.sh` now defaults to old_agbcc — for the ~4
>    agbcc-exception TUs, prefix `AGBCC=tools/agbcc/bin/agbcc`.
>
> Sanity check before trusting a run: base score should be ≈ `5 ×` the
> `agbcc_oracle.py` instruction-diff count, and a *matching* function must score 0.
> See docs/tooling.md "CRITICAL".

The permuter brute-forces *register-coloring / instruction-scheduling* drift — the
last-mile case where your C is structurally right and **near** a byte match but agbcc
colours registers or schedules instructions differently than the baserom. It does NOT
invent idioms; it mutates statement order, variable scope, temp introduction, and the
like. Use it only when a real match is plausible.

## When to use it (and when NOT)

USE the permuter when ALL of these hold:
- The classifier returned **ATTEMPT_MATCH** (no `mov pc, rN` / structural impossibility),
  i.e. the function is **NOT corpus-validated as unmatchable**.
- You have written real C and reached a **small** `byte_diff` (roughly ≤ ~40, ideally
  single digits) — a near-match. `compile_and_view_assembly.py <fn> --human` shows it.
- You already tried the cheap levers (local base-ptr anchor, `register asm("rN")` pins,
  void-return epilogue, `OLD_AGBCC_BIN` per-TU override) and they didn't close it.

Do NOT use the permuter for:
- A `STRONG_UNMATCHABLE` function — that goes straight to corpus-confirm → NAKED.
- A function that isn't close yet (huge `byte_diff`, wrong structure). Permuting a wrong
  base is a waste — fix the C first.
- A function with no readable C base at all.

## Prerequisites (already set up — verify, don't reinstall)

- `vendor/decomp-permuter/.venv` — the permuter + deps. In a worktree this is symlinked
  from main by the bootstrap. If it's missing: `bash scripts/setup-decomp-permuter.sh`.
- `permuter_settings.toml` (repo root, tracked) — already wires `compiler_type="gcc"`,
  `compiler_command="tools/permuter_compile.sh …"`, the assembler, and
  `asm_prelude_file=tools/permuter_prelude.inc`. Don't edit it.
- `tools/permuter_compile.sh` — the preproc | cpp-15 | agbcc | as pipeline as one
  `.c -> .o` step. `nonmatchings/<fn>-*/` dirs from prior runs are working examples.

## Build a scratch (the validated flow)

The function must live in a `.c` that compiles (your normal decomp base — write the
near-matching C into `src/.../<fn>.c` first). Then:

1. Produce the target asm (`glabel <fn>` + the baserom disassembly):
   ```sh
   npx tsx tools/agent/ts/cmds/extract-function-bytes.ts <fn> --asm > /tmp/<fn>.s
   # prepend a `glabel <fn>` line if the tool doesn't (import.py needs the file to
   # start with `glabel <function_name>` and contain no other functions).
   ```
   Reference format: `nonmatchings/sub_08009884/target.s` (a working prior scratch).
2. Import — this creates `nonmatchings/<fn>-<id>/` with base.c, target.o, target.s,
   compile.sh, settings.toml:
   ```sh
   vendor/decomp-permuter/.venv/bin/python vendor/decomp-permuter/import.py \
       src/<rel>/<fn>.c /tmp/<fn>.s
   ```
   IMPORTANT (worktree): run import.py **from your worktree root** so the generated
   `compile.sh` cd's into YOUR worktree, not main. If you hand-build the scratch by
   copying a prior one, FIX the `cd <path>` line in compile.sh to your worktree — a
   leftover `cd /Users/.../Dev/frog-adv-decomp` would compile against main and lie.
   If reusing a `target.s` from a prior scratch, STRIP everything above `glabel <fn>` —
   the prelude (`tools/permuter_prelude.inc`) already defines the `glabel` macro and
   import.py re-adds it, so a baked-in preamble causes "Macro `glabel' already defined".
3. VALIDATE the scratch before trusting a run — a few-second smoke run must report a
   finite baseline score and a healthy iteration rate (tens–hundreds/sec), not an error.
   If it errors (can't compile base, can't read target, 0 iters/sec) the scratch is
   misconfigured — fix it or skip the permuter. Do NOT burn time on a broken scratch.

## Run it — the BUDGET RULE (hard discipline)

The permuter is FAST: ~2000 iterations in ~30 seconds on this machine. **That is the
whole budget.** Past ~2000 iterations / ~30–45 s with no score-0, you are either wasting
time or the base/config is wrong — STOP and rewrite the C approach; do not let it grind
for minutes.

**Time-boxing — use EXACTLY this recipe (a process-group kill).** There is NO
`timeout`/`gtimeout` on macOS, and the naive `cmd & PID=$!; kill $PID` LEAKS: the permuter
forks `-j` multiprocessing workers that orphan (reparent to PID 1) when only the main is
killed — and if you PIPE the permuter (`… | grep | head &`), `$!` is `head`, so the kill
misses the permuter entirely. Both leak CPU-burning workers. So: do NOT pipe the permuter
(redirect to a file), and kill the whole PROCESS GROUP with `set -m`:

```sh
set -m   # job control: the bg job becomes its own process-group leader
vendor/decomp-permuter/.venv/bin/python vendor/decomp-permuter/permuter.py \
    nonmatchings/<fn>-<id> -j4 --stop-on-zero --better-only > /tmp/perm-<fn>.log 2>&1 &
PGID=$!
sleep 45
kill -- -$PGID 2>/dev/null   # negative = kill the ENTIRE group (main + all -j workers)
wait 2>/dev/null
grep -E 'base score|new best|score = 0|Found match' /tmp/perm-<fn>.log | tail -20
# safety net (scoped to THIS scratch — never cross-kills siblings):
pkill -f "permuter.py nonmatchings/<fn>-<id>" 2>/dev/null || true
```
- `--stop-on-zero` exits the instant it finds a byte match, so on success it returns early.
- NEVER `pkill -f permuter.py` unscoped — that cross-kills sibling worktrees' permuters.
- `-j4` keeps thread use modest — sibling worktrees may be permuting too. Lower to `-j2`.
- After your run, VERIFY nothing leaked: `pgrep -f "nonmatchings/<fn>-<id>"` must be empty.
- Watch the status line's best score. If it's still > 0 and plateaued at ~2000 iters, stop.

## Outcomes

- **Score 0 found**: the permuter writes the matching variant under
  `nonmatchings/<fn>-<id>/output-*/`. Copy that C into `src/<rel>/<fn>.c`, then CONFIRM
  independently: `make -j8 && python3 tools/agent/compile_and_view_assembly.py <fn> --human`
  must show `byte_diff 0`. Ship as a **true match** (`status="matched"`). Delete the
  scratch dir (don't commit `nonmatchings/`).
- **No score 0 after the budget**: do ONE rewrite — change the C base structurally
  (different locals, different control-flow phrasing, split/merge statements the
  permuter can't reach) — and run the bounded permuter ONE more time. The permuter
  refines a base; it can't fix a wrong one.
- **Still nothing after the rewrite**: this is now a genuine register-coloring NAKED.
  Corpus-confirm, then ship NAKED+NON_MATCHING (`status="naked"`), and in `corpusEvidence`
  note that the permuter was run (best score reached) and which levers/rewrites you tried,
  so a future pass knows not to re-attempt blindly.

## Cleanup

`nonmatchings/` scratch dirs are local scratch — never `git add` them, and remove the
dir when done (`rm -rf nonmatchings/<fn>-<id>`) so worktrees stay clean for commit.
