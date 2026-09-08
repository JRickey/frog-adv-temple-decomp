# Frogger matching decomp: agent guide

This is the USA GBA matching decompilation of *Frogger's Adventures: Temple
of the Frog*. The current objective is readable, byte-identical C, with
consistent interfaces and evidence-backed names. Matching comes before the
later shiftable-ROM and PC-port phases.

`AGENTS.md` is the active Codex workflow. `CLAUDE.md` is preserved historical
Claude guidance, no longer a symlink target for this file. Historical notes
and `.claude/workflows/` may contain superseded allocation verdicts; use
this guide and `docs/matching-workflow.md` for new work.

## Non-negotiable constraints

- Clean-room: never consult leaked or otherwise obtained Konami source.
  Analyze the baserom disassembly, project code, compiler source, and public
  clean-room decomp examples. Follow `CONTRIBUTING.md`.
- Never commit or modify `baserom.gba`, `frog_us_baserom.gba`, or
  `frog_us.sha1`. Expected SHA1: `7b4c27009198df18555e63fb5dcad223eaf09815`.
  Do not alter extraction metadata to conceal a mismatch.
- `make check` exiting 0 is the whole-ROM matching gate. A target's zero
  diff alone does not establish correct surrounding layout or source freshness.
- Preserve unrelated changes and prior experiments. Do not use blanket
  reset/clean commands to undo an experiment. Keep best candidates in ignored
  `nonmatchings/<function>/` with a short reproduction manifest.
- Never modify shared compiler binaries while workers use them. Instrument a
  private compiler copy and record its identity.
- Do not disable warnings, skip hooks, push, or open a PR to bypass a failure.
  Publishing requires a user request.

After changing agent tooling or evidence, run `make check-infra`. This runs
the tooling regression suite, evidence source/DAG validation, and campaign
ledger validation. It does not replace the ROM gate `make check`.

## Start with a focused brief

Read `docs/README.md` once. Do not routinely load the complete codegen notes
or a full predecessor transcript. Retrieve relevant evidence and the cited
source sections:

```sh
python3 tools/agent/evidence.py validate --sources
python3 tools/agent/evidence.py brief EntityHitbox_RegisterGridPoints --limit 8
python3 tools/agent/data_model_inventory.py --function EntityHitbox_RegisterGridPoints
python3 tools/agent/pick_target.py --max-size 40 --limit 10
python3 tools/agent/decomp_brief.py <function>
```

Use `evidence.py brief` for already-decompiled/pinned functions. The existing
full `decomp_brief.py` also supplies peel/layout/m2c context for assembly
frontier functions. `build_callgraph.py` builds deterministic call/data
relationships from the linked binary; indirect edges are best-effort, not a
complete call graph. A graph/index is derived context, not source truth.

## Reconstruct interfaces and semantics before allocation

Work on coherent function clusters. Compare callers, definitions, prototypes,
returns, field accesses, and sibling instruction sequences. Investigate:

- Width/signedness mismatches, including stack parameters and inline returns.
- Shared inline helpers obscured by hand-expanded pinned code.
- Incorrect struct views, discarded return values, and missing live state.
- Symbol versus integer-address expressions and compiler phase behavior.

The current definition is a candidate, not automatically the canonical
prototype. Place an evidence-supported interface in its owning header and
include that header from the definition and callers. Test changes across the
whole affected cluster. Do not widen parameters or omit prototypes merely to
hide a conflict. Unresolved signatures remain explicit questions.

Use names that express verified behavior. Preserve ROM-address identity in
memory records across renames. Do not invent exact semantics to eliminate an
address-named field. Name hardware constants and established states/flags.

## Matching loop

1. Establish a green baseline and retrieve related successes and failed
   hypotheses. State the semantic/compiler explanation being tested.
2. Before writing C, peel any unpeeled cross-region BL callees:
   `python3 tools/agent/auto_peel.py --callees-of <function> --apply`.
   Real Thumb symbols are required; `PROVIDE` is not a substitute.
3. Respect baserom address order. Append to the preceding C neighbor in
   `linker.ld`; use the picker/scaffold tools, never guess placement.
   Run boundary detection before a Thumb peel.
4. Predict a concrete instruction or lifetime change, implement one meaningful
   source hypothesis, and run the oracle:
   `python3 tools/agent/compile_and_view_assembly.py <function> --human`.
   For a NAKED function's reference C use `--non-matching`.
5. Keep the original symbol name during nonmatching trials so the cached
   baserom address remains valid. Rename after matching, then refresh the
   address snapshot from the verified ROM.
   Use the oracle's freshness/provenance output. Do not substitute hand-rolled
   objdump diffs. Fine-grained objdiff is only a fallback for a specific
   unresolved alignment/pool issue.
6. If shape diverges, inspect the relevant agbcc pass and corpus examples.
   Narrow the explanation before launching broad mutation searches. Register
   mismatches can be downstream effects of wrong types or source structure.
7. Accept readable changes only after `make check`; use a clean rebuild for
   interface changes and final source candidates:
   `make tidy && make -j8 && make check`.
8. Refresh address snapshots after layout/decomp changes and README statistics
   after accepted code/data passes. Record evidence and the essential mutation.

Useful tools: `dump_pool.py`, `struct_xref.py`, `struct_grow.py`,
`check_relocations.py` (after refining BL mnemonics), `lint_hex_literals.py`,
`snapshot_addresses.py`, `progress.py`, and `progress_stats.py --update-readme`.
See `docs/tooling.md` for invocation details.

## Pins and fallback policy

Aim for zero register pins in authored C. Existing pins are unresolved
reconstruction constraints, not proof they are necessary. A failed source
shape, classifier signal, or permuter plateau is not an impossibility proof.
`classify_unmatchable.py` is advisory only. Historical "unmatchable classes"
must be re-examined against current type/helper/compiler evidence.

Do not introduce NAKED/INCBIN replacements to improve the decomp counter.
Keep the prior matching implementation when a new C candidate fails. Record
an actionable hypothesis and the evidence needed to reopen it. Intentional
startup/interrupt assembly and byte-verified libgcc archive members are
separate categories; do not decompile libgcc just to reduce assembly totals.
Existing NAKED inline assembly must end with `.syntax divided`.

Use corpus source/history before a permuter run. Permute only from the best
justified source shape, with an explicit resource bound and stop condition.
A plateau requires a new hypothesis, not automatic replay. Harvest the
essential change; do not paste generated variable/scope noise into source.

## Evidence and efficient collaboration

Store reusable claims in `docs/evidence/*.json` using the schema and commands
in `docs/matching-workflow.md`. Separate observed, hypothesized, historically
verified, and superseded claims. Cite repository paths, locations, and commits.
A historical match does not certify the current checkout. General knowledge
relations may cycle; explicit work prerequisites must form a DAG.

Use deterministic scripts for inventories, builds, and batch experiments.
Workers receive a small brief with target identity, owned files, evidence IDs,
prediction, verification gate, and expected deliverable. Retrieve additional
context as needed instead of forking long histories by default.

Astra orchestrates and handles cross-cluster reasoning/compiler diagnosis.
Start Sol on substantial implementation, Terra on bounded audits and defined
transformations, and Luna on mechanically checkable extraction. These are
initial routing hypotheses, not measured repo-specific rankings. Record
model, effort, result, review corrections, and usage when available; unknown
usage is null, never invented. Evaluate total cost per accepted improvement.

Delegate concrete independent work. At most three workers alongside the
orchestrator in this environment. One writer/build owner per checkout;
workers sharing headers/linker layout must serialize integration. Prefer
isolated worktrees for code experiments. Never run a clean build while
another worker is using the same checkout's artifacts. Preserve shared
compiler/dependency symlinks but do not write through them.

Escalate when an explanation stalls with a compact packet: best candidate,
provenance, exact residual, tested hypotheses, and a discriminating next test.
Reopen affected deferred work when a prerequisite claim changes.

## Adaptive investigation contract

Optimize verified progress per measured usage, including orchestration and
failed experiments. Do not treat activity, a lower isolated score, or model
reputation as evidence of progress. After an experiment, record what changed
in the explanation and which next test would distinguish the remaining causes.

- Three consecutive trials with the same instruction residual end that source
  variation loop. Continue only with new evidence: compiler traces, an audited
  interface, a corpus idiom, or an independently derived source structure.
- Before a detour, name its blocker, reusable benefit, bounded deliverable and
  stop condition. Prefer detours that unlock several functions. Resume the
  original task after the deliverable; do not expand a tool into a framework.
- Use a fresh, focused worker for prolonged diagnosis. The orchestrator reviews
  compact evidence and owns acceptance; it should not replay a large history
  for each compile attempt. Separate compiler instrumentation from mechanism
  review, with explicit file/build ownership.
- Each trial needs immutable source/configuration/compiler identity, prediction,
  outputs and outcome. Never attribute a changing shared .s to a past source.
  Probe compiler flags on a tiny input before a full ROM build.
- Recover per-worker usage from local session counters when available. Include
  cached input, uncached input and output separately. Quota snapshots are
  account-wide; do not attribute their entire delta to one task without evidence.
- Commit a reusable correction when a mistake reveals a general failure mode.
  Persist learning in evidence, tests and workflow rules; summaries alone do
  not change the next run. Re-evaluate routing using reviewed outcomes.

## Readability and reporting

Use project integer types, `/* */` comments, named constants, and human
variable names. Avoid misleading variable reuse, uninitialized placeholder
arithmetic, gratuitous temporaries, and pins disguised as inline-asm barriers.
Explain non-obvious matching constraints briefly. Preserve required branch
structure, but normally prefer early returns and separate side effects from
conditions. Follow `.clang-format`; never bypass its hook.

Track separate outcomes: matching C functions/bytes, pins, NAKED fallbacks,
interface conflicts, verified semantics, and named/typed data. A depin or
interface correction need not reduce the assembly-function count. A notes-only
checkpoint is useful but must not be reported as a completed decomp.

Public progress reports must derive ownership from a verified linked build,
not filename addresses or linker comments. Retaining an INCBIN library, SDK
wrapper, or NAKED body does not earn reconstructed-source credit. Distinguish
matching compiler-library members, authored assembly, reference-only C, and
remaining binary blobs. Extracted data files alone do not prove reconstructed
data; count linked definitions under the documented report policy. Refresh the
decomp.dev inventory after accepted source/layout changes and validate freshness
before publishing. See `docs/decompdev.md`.

Consolidate adjacent, semantically related TUs only after checking compiler
flags, literal pools, static-name collisions and interfaces. Preserve address
identity across semantic renames. Directory placement should describe verified
ownership (`system` for hardware/runtime, `game` for scenes/menus, `engine` for
shared services); do not infer original source filenames from ROM adjacency.

Keep infrastructure and game-source changes in separate commits. Commit
messages are imperative and concise. Refresh the evidence and campaign report
with actual checks and limitations. Do not claim full completion from a
partial matching result.
