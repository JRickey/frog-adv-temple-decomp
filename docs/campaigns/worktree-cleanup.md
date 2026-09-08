# Branch and worktree cleanup

Reviewed against a678fcdc. Main was eight commits behind the campaign branch;
all eight are accepted workflow, interface, matching-code and evidence work.
The cleanup fast-forwards main and removes auxiliary worktrees and branches.
No additional matching decomp was found in the old worktrees.

## Dispositions

| Branch/worktree | Disposition |
|---|---|
| codex/evidence-hitbox-campaign | Fast-forward into main |
| codex/decompile-sub-080132e8 | Already ancestor of campaign; missing checkout registration pruned |
| data-model-unify-pilot | Already ancestor |
| decomp/batch-small-leaves | 89f0a276 exactly patch-equivalent to accepted 98174ad1; missing checkout registration pruned |
| agent-a970cf61b98301879 | 04c2c42e exactly patch-equivalent to accepted 70977d79; six existing pins, no new changes |
| agent-afce5c65afc0cac87 | 3d2e63d5 exactly patch-equivalent to accepted eecfe1f6 |
| agent-ac2b93005aa1a03c9 | c9f57c15 source depin already recovered in a0cf53ce; evidence/hitbox.json cites it |
| agent-a66c6fbfddd1ec20f | Scroll recovery notes consolidated in recovery-packets.md and evidence/recovery.json |
| agent-ad20b591104eadfa1 | Blit depin recovery notes consolidated in the same packet/evidence |
| agent-a025ef9d3a7153d01 | Nonmatching candidate; later root investigation reports supersede old notes. Untracked m2c bridge is an older copy of current tool |
| agent-a2609cb19f7976a10 | Nonmatching blit candidate (historical 41-byte residual). Undocumented EXTRA_CFLAGS experiment archived; not accepted tooling |
| agent-a9327be68bc99c09b | WIP struct variant, historical 776-byte residual; archived |
| agent-a668e9db35df5f586 | Uncommitted sub_08008A5C candidate: clean build with cpp-16 succeeds, make check fails; archived |
| picker-scout | Already ancestor |

The old a668 Makefile requested missing cpp-15. Verification used the installed
cpp-16 via a command-line CPP override, after another clean. No source fix was
made and no mismatch was accepted. Its build log is archived.

## Recovery

Local ignored archive directory: `nonmatchings/worktree-cleanup-20260908/`.
It contains ten complete worktree tar.gz snapshots (symlinks retained without
following them), manifest.json with original registrations, dirty status,
archive member counts and SHA256, and all-branches.bundle preserving every Git
ref at audit time. Each tar was read back and the bundle verified before removal.
These are local recovery files, not portable committed artifacts. Keep them
until the deferred investigations are no longer needed. The archive includes
ignored scratch, untracked files and pre-audit generated artifacts; do not assume
those artifacts are fresh. Rebuild restored candidates with the current oracle.

To inspect history without restoring an old checkout, list refs with
`git bundle list-heads nonmatchings/worktree-cleanup-20260908/all-branches.bundle`.
Restore a selected branch from that bundle into a fresh checkout if required.
Inspect a tar's member list before extracting into a separate directory; its
old .git pointer is historical and must not be reused as a live registration.

Final gates: clean ROM build and make check, plus make check-infra. Cleanup
changes no game source, ROM identity, or CLAUDE.md.
