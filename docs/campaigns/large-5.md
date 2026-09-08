# Five large functions

Completed **5/5 new large matching C functions**, totaling **3,340 ROM bytes**. Baseline was `ee4fcb9a`; final source integration is `e47355c8`. There was no user-supplied queue. Astra owned strategy and acceptance.

| Function | ROM start | Matching range | Source commit |
|---|---|---:|---|
| Entity_CollisionProbe | 08001e24 | 864 bytes | a761f40e |
| Scroll_UpdateCameraAlt | 08002ee8 | 748 bytes | da794b0d |
| DrawTextGlyphs | 0801be7c | 508 bytes | e47355c8 |
| sub_08024DBC | 08024dbc | 532 bytes | f3dc4a66 |
| sub_08028270 | 08028270 | 688 bytes | 07069ac8 |

The ranges include literal pools and four total alignment bytes. All five have authored C bodies, no added pins/barriers/NAKED replacements, and verified C-object ownership. Existing assembly references remain unselected. No compiler flag changes were accepted.

The final integrated `make tidy && make -j8 && make check` passes with SHA1 `7b4c27009198df18555e63fb5dcad223eaf09815`. All five fresh oracles report zero byte and instruction differences. The infrastructure suite passes **67 tests**, plus evidence and campaign validation. The address snapshot was refreshed from the verified ROM and README statistics updated: **759 pure-C functions**, **292 estimated functions outside C**, and **63 existing assembly-backed C functions**. The latter are separate from the outside-C count; the inventory is an estimate, not a vetted queue.

## Accepted source and interface findings

- Paired movement covers ten primaries and five peers using ordinary entity array pointers. MotionDesc_Set takes signed byte inputs and preserves unsigned byte storage inside its existing body.
- Path/proximity updates retain unsigned halfword distance staging followed by signed threshold comparisons. Entity_FollowPath accepts a word index and explicitly narrows it inside its existing definition.
- The scripted camera uses existing entity/scroll structs and a signed halfword vertical offset, with a shared gfx.h declaration.
- Text drawing needed reference grouping `palette + (escapeIndex + escapeBase)`, separate escape lifetimes and direct special-glyph stores. Word API parameters with explicit local narrowing preserve callers. ParseDecimalStr is centralized unchanged. Named physical VRAM address calculations replace pointer placeholders. One documented subtraction of a negated, bounded glyph index preserves operand order; ordinary addition differed by two bytes.
- Collision updates use typed slots/masks and ordinary entity fields. The spawn-mask assignment is separate from its condition. The existing typed Entity_UpdateHitboxWithTile definition is now declared in entity.h, with eight conflicting local declarations removed. Some legacy wrapper APIs still carry pointers as words; explicit boundary casts preserve them, and that API debt remains unresolved.
- HUD_DrawStatus, separately integrated at `7e11b32b`, accepts signed halfword values and an unsigned halfword counter, then renders their low bytes. Root corrected reversed proposed left/right argument names using actual draw columns. Its existing 420-byte body remains identical.

Fifteen literal EntityPath globals plus their pointer table, two scene path pairs, a 25-element scene layout array and its dispatch table are separately verified typed-data outcomes: **20 objects / 2,048 bytes**. Unknown header fields retain neutral names. The scene array is one object, not 25 separately defined globals. Neither data nor interface corrections count toward the five functions.

## Preserved investigations

Ignored `nonmatchings/large-five/<function>/` packets retain immutable best candidates, compiler/configuration identities, oracles and reopening questions. None of these deferred candidates is counted as accepted C.

| Target | Best preserved result | Next evidence needed |
|---|---|---|
| LevelLayout_WalkRecords | 976 bytes / 144 differing bytes | GCSE sharing versus slot identity; distinct identical switch targets must remain separate |
| sub_08028858 | 572 of 576 bytes / 467 differences | A justified source mechanism for the retained mask; diagnostic narrow-return helper is not accepted game code |
| sub_08024534 | 632 bytes / 491 differences | Slot/status allocation with the preserved real pointer table |
| sub_080265D4 | 756 bytes / 46 differences | Explain redundant zero OR without copying existing asm workarounds |
| EntityPool_SpawnEntry | 496 of 508 bytes / 301 differences | Resolve the apparently stale selector on a reachable path |
| GameMode_Scene18 | 732 bytes / 4 differences | Initial address/zero allocation; actual helper inlining fixed prior call scheduling |
| GameMode_Scene19 | 972 bytes / 10 differences | Same initial-store question; every later instruction matches |
| sub_080259C4 | 792 of 808 bytes / 520 differences | Distinct companion/flag lifetimes after corrected collision/timer semantics |
| Entity_Update | 756 of 844 bytes / 656 differences | Independent semantic and compiler audit of omitted selector reloads |
| CollisionTable_CheckAndTriggerScript | 724 of 756 bytes / 644 differences | Loop index versus script-base lifetimes |
| ScaleAnim_BlitFrameToVram | 808 of 852 bytes / 494 differences | Corrected semantic graph has exact 64-byte frame; GCSE PRE creates a new global-base lifetime |
| PadGrid_FillGrid | 648 of 952 bytes / 585 differences | Independent packed-coordinate/control-flow audit before allocator claims |

The failed initial text pass was reopened by a fresh reference CFG review and is now accepted. Fresh scale review corrected six semantic distinctions in the first source; its earlier allocation-only explanation was premature. Source changes stopped when trials ceased distinguishing hypotheses; retained near-matches are not impossibility proofs.

## Reproducible corrections

- The picker treated a prototype as an unrelated following function body, hiding DrawTextGlyphs. `85796cd6` fixes declaration/body detection with five regressions.
- m2c used a shorter candidate's linked extent for baserom input. `7009fd24` restores immutable range/callee identity, handles multi-function peels and declines unknown sibling bounds, with five regressions.
- Missing extracted gap files caused 1,101 data differences during an earlier integration. Extraction plus a clean rebuild fixed them. The warning/empty-initializer hazard has a standalone reproduction and workflow rule.
- A root address audit used a concurrently changing ELF and briefly misidentified a callback. Direct baserom disassembly corrected it to Entity_DispatchBC before dependent edits. The frozen observation/reproduction and immutable-address workflow rule are checked in.
- Broad staging once picked up dependency-symlink type changes. They were removed before integration; explicit owned-path staging is now required.
- A failed whitespace assertion produced an unchanged oracle; that run is explicitly invalid, and later scripts stop on edit failure. A text rename briefly corrupted a character literal; the compiler caught it and the repaired immutable trial supersedes it. Formatting-hook rejections were fixed normally.

[Scene inline/compiler evidence](../experiments/scene18-inline-addresses/README.md) includes both formatted candidates, fresh 75-byte/4-byte reproductions and the local-allocation explanation. Some early trials saved fingerprints without full source snapshots; their reproducibility is limited and they are not acceptance evidence. Final accepted sources are immutable commits, with final hashes/oracles/object ownership in `nonmatchings/large-five/final-acceptance/`.

## Measured usage and routing

[large-5.json](large-5.json) records **28 of 28 campaign sessions** with actual local cumulative-counter deltas, including root review, orchestration, tool fixes and failed experiments. Cutoff: **2026-09-08T08:20:30.602930+00:00**. Work after that cutoff is not included; account-wide quota deltas are never attributed to workers.

| Counter | Measured tokens |
|---|---:|
| Uncached input | 4,988,792 |
| Cached input | 162,206,976 |
| Output | 666,935 |

Across the five accepted functions, that is 997,758 uncached input and 133,387 output tokens per accepted function, including the unsuccessful work and orchestration measured through the cutoff. These are token measures, not monetary cost estimates or a controlled model ranking.

Sol began substantial implementation; Terra handled bounded audits/transformations; fresh Astra reviews handled compiler/source-structure diagnosis. The camera succeeded in one focused worker, and a fresh Astra CFG review converted the text plateau into a match. Root review corrected interfaces and readability before acceptance. Thread-limit failures required compact resets of the movement worker for Scene19 and the short HUD worker for PadGrid; each reused session's counters cover both tasks and are not presented as separate fresh sessions.
