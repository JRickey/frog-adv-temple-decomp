# Readability pass 02

Two isolated worktrees prepared the scene and menu source changes; root
reviewed and integrated them serially. The compiler installation and baserom
were read-only shared dependencies, with separate build products per worktree.

- Scene: ten source units become five named game units, covering 19 functions.
- Menu: eleven credits slices get semantic game paths; three file-select/save
  slot slices become one ordinary C module, covering 19 functions in total.
- Three Mode8 helpers get Scene08 names, including FinishFrame for a forwarder
  previously misleadingly called Teardown.
- Nine include-only/TODO scaffolds and their zero-byte linker entries are
  removed; their actual assembly implementations are preserved.
- No new C/data bytes, pins or NAKED fallbacks are introduced.

Review rejected implementation-only headers as the final file-select layout;
the follow-up flattened them into one C file. The TilemapRect palette interface
uses the owning graphics header. Other legacy ABI-shaped graphics declarations
and scene pointer-width conflicts remain explicitly unresolved.

Reporting now distinguishes the reproduced compiler library's completed/linked
status from authored C reconstruction. Its archive hash is verified before
granting completion. Ordinary C is classified per function so a neighboring
conditional fallback does not penalize a semantic TU merge; ambiguous multiple
definitions remain conservative. The reporting increase is corrected accounting,
not newly decompiled functions.

The decomp.dev GitHub App is installed for this repository only. A new pushed
workflow was imported without a manual refresh, verifying the connection.
Without the app the service polls periodically; it is not wholly disconnected.

See the JSON ledger for configured model routing, measured outcomes and
unavailable usage fields. Detailed unresolved grouping/interface work is in
`docs/repository-structure.md`.

Final integrated `make tidy && make -j8 && make check` passed. All 81 tooling
regression tests, evidence-source checks and campaign validation passed. The
refreshed report is accepted by decomp.dev's parser: 715/1,292 reconstructed
functions, 93,106/220,092 code bytes (42.30%), and unchanged 3,500/3,973,732 data
bytes. The six-function/1,226-byte increase is the mixed-TU accounting fix.
libgcc separately has 6,846 inventoried code bytes and 13 completed units.
