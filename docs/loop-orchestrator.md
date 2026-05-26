# Loop orchestrator runbook

What the autonomous `/loop` does each iteration. The orchestrator is me
(the main conversation), not a script — I follow this runbook each cycle
and dispatch background agents to do the actual work.

## Per-iteration sequence

### 1. Pre-flight (always)

```sh
git status               # MUST be clean (no uncommitted changes from prior iter)
make check               # MUST pass (ROM matches baserom)
python3 tools/agent/progress_stats.py   # snapshot the scoreboard
```

If the tree isn't clean, find out why. If a prior agent's work is partly
staged-uncommitted, finish committing it (or revert if it was unsalvageable).
**Never start a new iteration on a broken build** — that compounds layout
drift.

### 2. Pick targets

**Decomp target** — use the picker:

```sh
python3 tools/agent/pick_target.py --max-size 80 --limit 5
```

If the picker shows zero unblocked candidates at `≤80 instr`, retry with
`--all --limit 10` to see blocked-but-tractable shapes. Prefer
unblocked-leaf > blocked-leaf > non-leaf. Skip targets that need MORE
than one callee peeled (auto-peel handles 1 callee fine, multi-callee
chains burn time).

**Data target** — use the refcount tool:

```sh
python3 tools/agent/refcount_pool_loads.py --pending-only --threshold 5
```

Top-of-list is the natural anchor. Adjacent same-region entries usually
belong to one cluster — note the cluster boundary so the data agent
extracts coherent groups, not single tables.

### 3. Dispatch

Use the short brief format from `tools/agent/prompts/README.md`:

```
You are a {decomp|data} agent. Playbook: tools/agent/prompts/{decomp,data}.md.

{Target | Charter}: ...

Notes specific to this {target | pass}:
  - <thing the playbook doesn't already say>
  - <reference to a sibling commit if relevant>

Output: usual 6 (decomp) / 6 (data) items from the playbook.
```

Both agents in background, in the same Agent-call message if possible
(parallel). Coordinate hint in each brief: "the other agent is touching
linker.ld around `<distant address range>` — use precise `Edit`, not
`replace_all`."

### 4. Wait for notifications

The harness wakes me when each agent finishes. While they're running,
I `ScheduleWakeup` with 1800s delay + `<<autonomous-loop-dynamic>>` as a
fallback in case an agent hangs.

### 5. Process each completion

When an agent completes:

a. **Verify** before commit:
   - `git status` — what they staged.
   - `make check` — must pass.
   - For decomp: `python3 tools/agent/compile_and_view_assembly.py <FN>
     --human` — `byte_diff: 0`.
   - For data: spot-check that the new `database.json` entries point at
     in-range file offsets (strip 0x08000000), and that `linker.ld`'s
     blob ranges still sum to the right total.

b. **Stage + commit** if clean. Commit messages follow the templates
   already in git history (see `git log --oneline -20`). Stick to the
   "real decomp" / "agent infra" / "data extraction" categorization
   from CLAUDE.md commit hygiene.

c. **Revert** if broken: `git restore --staged` then `git checkout`.
   Append an entry to `docs/loop-log.md` describing what failed and
   why we didn't ship. If this is the second revert in a row, halt
   the loop per stop condition #2.

### 6. Architectural duties (every iteration)

After both agents land or are otherwise resolved:

- **Scan for repeated patterns**: did 2+ recent landings hit the same
  agbcc quirk? If so, ensure it's in `docs/codegen-notes.md` AND
  CLAUDE.md's short quirks list. If not, fold it in.
- **Watch for friction triplicates**: if the same manual step shows up
  in 3 iterations (e.g., "had to hand-recompute a linker.ld blob
  boundary"), build a tool. Land it as a separate "agent infra" commit
  with `tools/agent/` placement and `docs/tooling.md` row.
- **Update playbook hashes**: if I edit `tools/agent/prompts/{decomp,data}.md`
  for a real new step, bump the "Last verified" hash in the same commit.
- **Append to `docs/loop-log.md`**: one paragraph per iteration —
  before scoreboard, targets, outcomes, after scoreboard, commits,
  any `docs/decisions.md` entries.
- **Append to `docs/decisions.md`** when I made a judgment call that
  wasn't strictly mechanical. Examples: "ship as NAKED even though
  byte_diff was only 35 because the shape matches the two-stage-loop
  class"; "skipped target X because it has 5 unpeeled callees and the
  auto-peel chain would eat 30+ min".

### 7. Decide: continue or stop

Continue conditions:
- Pre-flight passes next iteration.
- `asm_funcs_remaining > 0` AND tractable target exists.
- raw INCBIN still > 50% (lots of data work remaining).
- Fewer than 3 consecutive no-op iterations.
- Fewer than 2 consecutive un-revertable build failures.

Stop conditions trigger an entry in `docs/loop-log.md` summarizing why
and a final scoreboard snapshot.

## Notes the orchestrator should preserve

The loop's value over individual dispatches is **continuity** — the
ability to apply lessons from iteration N to iteration N+1 without the
user manually relaying them. Concrete things the orchestrator must
NOT drop on the floor:

- **New unmatchable classes** discovered by a decomp agent → added to
  `docs/codegen-notes.md` AND pointed at from CLAUDE.md quirks list,
  in the SAME commit that lands the function. Future iterations'
  agents read CLAUDE.md and would otherwise re-discover.
- **Rename signals** from a data agent → applied to the offending
  `_Unknown` symbols immediately (rename in `src/data/*.c` + update
  `database.json` `path` field + bump `progress_stats.py --update-readme`).
- **Cluster boundary corrections** — if the data agent says "I left
  X to a future pass because Y", record Y in the loop-log so the next
  data-pass charter is informed.
- **Refcount-tool drift** — the refcount output's "EXTRACTED" tags
  rely on `database.json` being current. If a data agent shipped
  without updating database.json (impossible if they followed the
  playbook but worth verifying), refcount's `--pending-only` will
  re-recommend a finished anchor. Sanity-check the top-5 against
  recent commits before dispatching.

## What to do when blocked

If pick_target returns no unblocked target AND no tractable blocked
target (e.g., all remaining functions need new file scaffolding in a
region where the data extraction isn't ready), DON'T dispatch a
"any leaf" pass — that produces noise. Instead:

1. Document in `docs/decisions.md` why the decomp side is blocked.
2. Run a data-only iteration (just dispatch the data agent).
3. If TWO data-only iterations in a row don't unblock decomp, halt
   with a note for the user.

Similarly, if the refcount tool returns no anchors with `≥5` refs,
drop to `≥3`. If `≥3` returns nothing, the data side has cleared
all the cheap anchors and needs a strategy decision — halt with note.
