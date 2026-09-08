# Historical Claude workflow runners

These JavaScript workflows preserve earlier Claude campaigns. They are not the
active runner for the evidence-driven Codex campaign. Their embedded prompts,
model routing, automatic fallback rules and cleanup commands may be superseded.
Do not invoke them as the current default.

Use `AGENTS.md`, `docs/matching-workflow.md`, and
`tools/agent/prompts/decomp.md` for bounded assignments with explicit checkout
ownership and evidence retrieval. `CLAUDE.md` is deliberately unchanged.

A future migration of a legacy runner must reconcile its embedded instructions
with those files, use recorded model/effort and actual usage, preserve prior
work, and never turn a classifier/plateau into automatic NAKED conversion.
