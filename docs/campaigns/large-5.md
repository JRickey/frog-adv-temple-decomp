# Five large functions

Active goal, starting at `ee4fcb9a`: five new substantial game functions, roughly 500 bytes or larger. Baseline: 754 pure C functions, 63 assembly-backed C functions, and an estimated 297 functions outside C. These estimates do not constitute a fixed campaign queue.

Accepted at `07069ac8`: `sub_08028270`, 688 bytes, ten primary entities and five paired peers. The compiled C object owns the symbol; the linker selects it. Final oracle and clean whole-ROM check pass. Signed motion inputs are centralized in `include/entity_motion.h`; the existing 400-byte helper remains identical after explicit byte conversion. That interface correction is not another new function.

The 976-byte `LevelLayout_WalkRecords` attempt is deferred. The best exact-size source still differs by 144 bytes / 88 instructions. Separate cases 34, 54 and 90 must remain distinct despite identical arithmetic. RTL inspection identifies late pool rematerialization after global allocation; case-local bases instead permit GCSE to share slot multiplication through the common tail. The next investigation must discriminate partial-expression sharing and slot identity. More integer-address versus symbol spelling trials do not distinguish the mechanism. The prior assembly implementation is restored.

The 576-byte `sub_08028858` attempt reached 572 bytes with 467 differing bytes / 111 instructions. Three equivalent source variations ended the initial loop. A fresh worker is investigating why GCSE destroys the mask lifetime used by the original status-bit transfer. Intermediate linker aliases are not acceptable final data definitions. No result from this target is counted yet.

Independent work is underway on `sub_080265D4` (756 bytes) and `sub_08024534` (632 bytes). Accepted count is **1/5**, not the number of attempts or passing baseline oracles.

Reproduction packets are in ignored `nonmatchings/large-five/<function>/`. Each accepted candidate retains source and oracle provenance. Some early worker trials retained fingerprints without source copies and cannot be treated as independently reproducible; later review snapshots correct this for the accepted source. The workflow now explicitly requires checking authored C and compiled-object ownership before counting an oracle zero as new C.

`large-5.json` records per-session measured usage through its stated cutoff, including orchestration and failed attempts. Active runs are partial; quota snapshots are not attributed to workers. Root owns strategy and acceptance. Initial routing remains provisional: the paired movement implementation produced an accepted result after interface review; the two deeper compiler investigations produced reusable evidence but no additional accepted C.
