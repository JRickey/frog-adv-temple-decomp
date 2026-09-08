# Evidence-driven matching workflow

The campaign unit is a small related cluster of functions, types and data.
Its acceptance gate is a readable change plus a byte-identical ROM. The
active policy is `AGENTS.md`; `CLAUDE.md` and `.claude/workflows/*.js` are
preserved historical entry points and are not the Codex campaign runner.

Run `make check-infra` after tooling, workflow, evidence or campaign-ledger
changes. Its sequential steps stop on failure: regression tests, evidence
validation with source checks, and campaign-ledger validation. It does not
build or certify the ROM; use `make check` for that gate.

## Start a campaign

1. Inspect the working tree and establish `make check` baseline.
2. Retrieve evidence for the target and inspect callers/callees, shared fields,
   declarations and definitions. Use graph edges as leads; verify indirect
   calls and type claims against source/disassembly.
3. Select a coherent interface/semantic question with several dependent
   targets when possible. Schedule code work only after its required evidence
   is available. Related functions can form a cyclic cluster; prerequisites
   between work items cannot cycle.
4. Assign bounded tasks with file ownership. Serialize shared header and
   linker changes and builds in the same checkout.
5. Test a prediction, preserve the best candidate, and validate the whole ROM.
6. Publish the essential source change and the evidence that explains it.
   Revisit dependent questions when the explanation changes.

After changing or integrating `database.json`, run `make extract` before the
clean build. The custom INCBIN preprocessor runs before conditional preprocessing
and deliberately warns, rather than aborting, for absent files; fixed-extent C
arrays can therefore become zero-filled. A successful compile does not validate
new extraction gaps. The whole-ROM check catches this, but regenerating the
extracted data first avoids a misleading integration failure.

In worktrees with dependency symlinks, stage explicit owned paths and inspect
`git diff --cached --summary` before committing. Submodule status settings can
hide runtime symlink substitutions from the ordinary status display; broad
staging can accidentally record them as repository changes.

Before counting a new C function, verify that its symbol is defined in the
intended compiled C object and that the linker selects that object. A zero-diff
oracle on an unchanged assembly function or an empty scaffold is only a baseline,
not decompilation progress. Inspect the authored body separately for pins and
assembly fallbacks; object ownership alone does not establish readable C.

## Evidence records

The reviewable source is JSON in `docs/evidence/*.json` (one object or an
array per file). The CLI loads this source directly; SQLite indexes are
optional, regenerable context. Example:

```json
{
  "schema_version": 1,
  "id": "hitbox.example.question",
  "kind": "dependency",
  "title": "Resolve parameter width before depinning",
  "status": "hypothesized",
  "claim": "The declaration and definition disagree; verify both call sites and entry conversions.",
  "subjects": ["fn:0800a83c"],
  "provenance": [{"path": "src/engine/sub_0800a83c.c", "location": "EntityHitbox_RegisterGridPoints"}],
  "tags": ["hitbox", "prototype"]
}
```

Kinds: `behavior`, `layout`, `compiler`, `dependency`, `data`, `workflow`.
Statuses: `observed`, `hypothesized`, `verified`, `superseded`.
Optional `relations: [{"type": "explains", "target": "other.record.id"}]`
links claims. `prerequisites: ["other.record.id"]` encodes work dependencies;
only these edges must be acyclic. `superseded_by` identifies the replacement
for an old claim. Historical verified results cite the exact commit; they do
not automatically validate later checkouts. `current_validation` is a
recorded report, not an action performed by reading the record.

Never infer baserom symbol identity from a mutable or nonmatching ELF/map.
Use direct baserom disassembly or an address snapshot tied to a successful
whole-ROM check. A worker's layout drift can make an ordinary function pointer
look like an interior code entry; see [the reproduced failure](experiments/mutable-elf-addresses/README.md).

Use stable address subjects (`fn:0800a83c`, `data:030060a0`) across renames;
use descriptive tags and titles for discovery. Provenance paths are
repository-relative, with a symbol/section/range in `location` and a full
commit hash where relevant. Raw private transcript paths and generated RTL
stay in ignored scratch; durable claims cite the committed supporting code
or documentation. Never put ROM bytes or private account data in records.

```sh
python3 tools/agent/evidence.py validate --sources
python3 tools/agent/evidence.py search hitbox --limit 8
python3 tools/agent/evidence.py plan hitbox --limit 12
python3 tools/agent/evidence.py brief EntityHitbox_RegisterGridPoints --limit 8
python3 tools/agent/evidence.py brief 0x0800a83c --json --limit 8
```

Read the cited source before acting on a claim. Summaries can be wrong, and
a matching instruction sequence alone does not prove a semantic name.

## Reliable experiments

Normal and NON_MATCHING oracle runs must rebuild changed inputs even when
filesystem timestamps are identical. Results should identify source,
configuration/toolchain and output fingerprints. Header/configuration changes
must invalidate affected translation units. Use isolated checkout build
ownership; fingerprinting is not permission to race writers or compilers.

A useful experiment record contains:

- Target/ROM identity, base commit and owned source paths.
- Model and reasoning effort; token usage only if exposed by the runner.
- Evidence IDs and hypothesis with a predicted instruction/lifetime change.
- Candidate/reproduction path, oracle provenance and residual differences.
- Whole-ROM gate, accepted commit or precise unresolved question.
- Review corrections and elapsed time when measured.

Keep large candidate batches and raw logs under `nonmatchings/`. Summarize
new reusable findings in evidence records. Do not promote a failed parameter
variant into a universal claim that a register pin is necessary.
Use scoped or symbol-aware renames: replacement across raw C text can change
character/string literals, as a rejected text-renderer cleanup demonstrated.

Before attributing a shorter body or smaller frame to allocation, check the
reference control flow independently: signed widths, per-iteration resets,
wrap branches, and store/reload ordering. A second decompiler must use the
immutable ROM extent, not the candidate's linked size. The first ScaleAnim
candidate omitted semantic distinctions that a fresh m2c lifetime review
found; its allocation-only explanation was therefore premature.

## Interfaces and source review

Audit scalar widths, signedness, argument count, returns, and struct views
before consolidating declarations. The definition is not authoritative merely
because it currently matches using pins. `unify_prototype.py` is a mechanical
consolidator after this audit, not an ABI inference engine. Use an explicit
reviewed signature (`--sig`) for a semantic correction. Selecting
`--use-definition` explicitly only authorizes mechanical reuse after review. Include the owning header from
both definition and callers so disagreement cannot remain hidden.

Probe caller and callee effects together; accepted interface changes require
a clean build and `make check`. Preserve separately named semantic views of
shared storage when evidence supports different behavior layouts. Avoid a
single speculative mega-struct or a catch-all header.

## Model calibration

Astra remains technical lead and integration reviewer. Initial routing is Sol
for substantial implementation, Terra for bounded audits/defined edits, Luna
for extraction with mechanical validation. Route hard mechanism questions to
Astra early when the current hypothesis stops predicting the output.

Calibrate using bounded tasks with explicit correctness gates. Record actual
outcomes and review effort; compare matched improvements per total tokens
when usage is available. Null usage means unavailable. Different task results
are not a controlled model comparison. Do not schedule duplicated expensive
runs merely to produce a ranking. The first hitbox campaign exercises this
routing and records its limits before broader deployment.

Validate and summarize recorded runs with `python3 tools/agent/campaign_report.py`.
The JSON ledgers in `docs/campaigns/` preserve unknown usage as null and report
review corrections without inferring fees or a model ranking.

## Legacy guidance

The successful session disproved several historical allocation verdicts.
`classify_unmatchable.py` reports clues, not permission to ship NAKED code.
The old `.claude/workflows/` dispatchers retain historical model names,
deferral policies and rollback behavior; they are not used by this campaign.
Use the evidence brief and explicit bounded assignments rather than invoking
those loops. `CLAUDE.md` is intentionally unchanged at the user's request.
