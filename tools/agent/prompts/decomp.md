# Bounded matching/depin assignment

Follow `AGENTS.md` and `docs/matching-workflow.md`. This template supersedes
historical automatic pin/NAKED and retry-count fallback gates.

The orchestrator supplies:

- Target name and stable ROM address; coherent subsystem/cluster.
- Checkout, base commit, owned files, and build ownership.
- Evidence IDs plus a bounded `evidence.py brief` and necessary source sections.
- A semantic/compiler question and a predicted instruction/lifetime change.
- Deliverable and verification gate; resource bound when one is specified.

## Work

1. Inspect owned files and baseline. Resolve callers, definitions, prototypes,
   returns, struct views and possible inline siblings before allocation tuning.
2. Read cited evidence. Historical failures are source-specific, and historical
   verified results are not current-checkout validation.
3. Use the picker/brief tools for legal layout and peel callees before new C.
   Use the whole-ROM oracle for fresh-build categorized differences.
4. Test an explanation rather than accumulating arbitrary variants. Inspect
   agbcc compiler passes and relevant corpus successes when structure diverges.
5. Preserve best candidates and reproducible experiment results. Batch mechanical
   changes through scripts, summarize differences instead of dumping all logs.
6. When the explanation stalls, report the exact residual and a discriminating
   next test to the orchestrator. Escalation is not an impossibility verdict.
7. Verify readable accepted changes with `make check`; clean-rebuild final C
   candidates and interface changes. Never claim success from stale intermediates.

## Constraints

No leaked source, ROM/hash edits, shared compiler mutation, or blanket cleanup.
One build/writer owner per checkout. Do not introduce pins, barriers, or NAKED
bodies as an automatic response to a classifier or plateau. Preserve matching
live code if a candidate fails. Intentional platform assembly and proven libgcc
archive members are distinct from unresolved authored game C.

## Return

Report target/owned files, essential change or open hypothesis, evidence IDs,
oracle provenance/residual, whole-ROM result, preserved candidate location and
commit if requested. Report model/effort and token usage only when known.
Distinguish matching decomp, depin, interface correction, semantic discovery,
and notes-only checkpoint. Include review-relevant limitations concisely.
