# Five large functions

Active goal from `ee4fcb9a`: five new substantial game functions, roughly 500 bytes or larger. Baseline: 754 pure C functions, 63 assembly-backed C functions, and approximately 297 functions outside C. There was no user-supplied campaign queue.

Accepted **2/5**, totaling **1220 bytes**, with no added pins or assembly fallbacks:

- `sub_08028270`, 688 bytes, integrated at `07069ac8`: ten primary entities and five paired peers. Ordinary array pointers match. Signed motion inputs are centralized, with unsigned byte storage retained inside the existing 400-byte helper.
- `sub_08024DBC`, 532 bytes, integrated at `f3dc4a66`: path updates and proximity sound control. Unsigned distance staging preserves the signed-threshold conversion. Fifteen literal 64-byte path structs and a typed pointer array have real ROM symbols. Entity_FollowPath's word argument is explicitly narrowed to a byte inside its existing 268-byte definition.

Both accepted ranges have fresh zero-diff oracles, authored-body review, compiled-object ownership checks, and clean whole-ROM validation. Main now has 756 pure C functions and approximately 295 outside C; the 63 existing assembly-backed C functions remain separate. Interface corrections and typed data do not count as additional functions.

## Bounded investigations

- `LevelLayout_WalkRecords`, 976 bytes: best exact-size candidate still 144 byte differences / 88 instructions. Distinct cases 34/54/90 must remain separate. RTL identifies late pool rematerialization; next evidence must distinguish GCSE partial-expression sharing and slot identity. Prior assembly restored.
- `sub_08028858`, 576 bytes: best 572 bytes, 467 differing bytes / 111 instructions. Fresh diagnosis identifies GCSE folding retained mask-minus-one into 0x7fff. A diagnostic narrow-return control preserves the mask, but no justified helper was derived. Reproduction is checked in under `docs/experiments/status-mask-gcse`.
- `sub_08024534`, 632 bytes: exact-size candidate 491 differing bytes / 146 instructions, with real pointer-table split preserved in its packet. Allocation/status mechanism remains unresolved. Prior implementation restored and whole-ROM gate passed.
- `sub_080265D4`, 756 bytes: real typed globals removed dispatch-base hoisting; explicit control-flow exits and a corpus-based unsigned-halfword status intermediate reduced the residual to 46 bytes / 36 instructions. Idle blocks contain a redundant zero OR not explained by ordinary semantics. Fresh Astra and Terra audits found analogous sites in sub_080259C4 but no justified shared helper. The candidate is preserved and assembly restored. Typed scene data passed an independent clean whole-ROM gate and was committed separately as 57f419eb; integration is pending source/build ownership release.
- `EntityPool_SpawnEntry`, 508 bytes: best 496 bytes with 301 differing bytes / 44 instructions. A valid phase reaches a path where the original leaves the motion selector in stale r7. This remains an explicit reconstruction question; no placeholder or pin was accepted.

Three independent implementations are active: GameMode_Scene18, sub_080259C4, and CollisionTable_CheckAndTriggerScript. New evidence about the shared zero OR is supplied to the movement-dispatch worker; existing inline-asm workarounds in the corpus are not accepted authored C patterns.

## Reproduction and corrections

Ignored `nonmatchings/large-five/<function>/` packets preserve best sources, oracles, compiler/configuration fingerprints, failed controls and next discriminating tests. Some early worker trials retained fingerprints without immutable source copies; those trials are not independently reproducible. Accepted sources have full review snapshots. An attempted root mutation failed its whitespace assertion; its subsequent unchanged oracle is explicitly marked invalid as an experiment, and later compound scripts stop on error.

The workflow now requires checking authored C and compiled-object ownership before counting an oracle zero. Baseline-only and empty-scaffold zeroes are not decompilation progress.

The first main integration of the path-data split omitted extraction. Missing raw gap files caused 1101 data-byte differences despite successful compilation. Extraction followed by a clean rebuild restored the ROM. `docs/experiments/missing-extracted-data/verify.py` reproduces the custom preprocessor's warning/empty-initializer behavior; the workflow now requires `make extract` after database integrations.

A broad staging command in the isolated data checkout picked up dependency symlink type changes hidden by submodule status settings. They were removed from the local commit before integration; the runtime links were preserved. Stage explicit owned paths and inspect the staged diff, including file modes.

`large-5.json` records actual bounded per-session counters, including root orchestration and failed experiments. Active runs are measured only through the stated cutoff. Account-wide quota deltas are not attributed to workers. These outcomes support continued bounded attempts on distinct semantic clusters, not replaying failed variable spelling or treating a near-match as accepted progress.
