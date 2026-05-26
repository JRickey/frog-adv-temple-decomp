# Agent prompts

Two unrelated prompt families live in this directory.

## Auto-decomp pipeline (mizuchi-derived)

For the per-function automated decompilation pipeline. The pipeline
runs `claude` against `task_template.md` (a per-function prompt
generated from `craft_prompt.py`) with `system.md` as the system
prompt, retrying via `stall.md` if iteration plateaus and bootstrapping
with `kickoff.md`.

- `system.md`
- `kickoff.md`
- `stall.md`
- `task_template.md`

These are passed through `claude` directly, not via Claude Code's
`Agent` tool. Adapted from [Mizuchi](https://github.com/macabeus/mizuchi);
see `ATTRIBUTION.md` for the license + full upstream pointer.

## Dispatch playbooks (this repo's own)

Reference one of these from a one-shot `Agent` dispatch brief. The
brief stays short (~30 lines: target + this-pass-specific notes); the
playbook carries everything that's stable across passes (setup
reading list, workflow, decision tree, output shape, hard constraints).

- **`decomp.md`** — for an agent landing one decomp target. Covers the
  pure-C → permuter → NAKED+NON_MATCHING decision tree. Reuses across
  every decomp pass.
- **`data.md`** — for an agent running a data-extraction pass.
  Covers anchor selection (via `refcount_pool_loads.py`), the
  `database.json` schema gotcha, the `.o(.rodata)` linker pull,
  and the per-table workflow loop.

Each playbook records a "Last verified" commit hash near the top.
When you materially change a playbook, bump the hash in the same
commit. When a new pattern emerges (e.g., the `.syntax divided`
requirement from commit 9cb31b1, or the `gpsp` trick from c636032),
document the WHY in `docs/codegen-notes.md` and the OPERATIONAL
instruction in the playbook — both layers stay in sync.

### Dispatch-brief template

```
You are a decomp agent. Playbook: tools/agent/prompts/decomp.md.

Target: sub_0802EA80 (180 B, pure leaf, scaffold new C file).

Notes specific to this target:
  - Belongs in src/system/sound_X.c (no adjacent C exists).
  - Pool entries: ...
  - The function at <addr> was just landed; reuse its struct ...

Output: report the usual six items.
```

Same shape for data agents (charter line, region, this-pass notes).

The dispatch briefs in the project's git history (see `git log -i
--grep "background agent"` informally) are the audit trail for what
each individual pass actually attempted, so the briefs themselves
remain valuable — what we're abstracting away is the BOILERPLATE
that repeated across all of them.
