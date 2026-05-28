# decomp-permuter runbook (for stuck-but-matchable functions)

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

```sh
vendor/decomp-permuter/.venv/bin/python vendor/decomp-permuter/permuter.py \
    nonmatchings/<fn>-<id> -j4 --stop-on-zero --better-only
```
- `--stop-on-zero` exits the instant it finds a byte match (score 0) — so on success the
  command returns on its own, well under budget.
- **Time-boxing on macOS:** there is NO `timeout`/`gtimeout` binary here. Do NOT use them,
  and do NOT `pkill -f permuter.py` (that cross-kills sibling worktrees' permuters in the
  parallel workflow). Instead bound the run ONE of two safe ways:
  - run it as a foreground command with your Bash tool's own ~50 s timeout (simplest —
    `--stop-on-zero` returns early on success, otherwise the tool stops it and you read the
    best score from the captured status line); OR
  - background it and kill only its own tree:
    `… permuter.py <scratch> -j4 --stop-on-zero --better-only & PID=$!; sleep 45; pkill -P $PID 2>/dev/null; kill $PID 2>/dev/null`
- `-j4` keeps thread use modest — sibling decomp worktrees may be permuting too. Lower to
  `-j2` if the machine is contended.
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
