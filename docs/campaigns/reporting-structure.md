# Reporting and structure correction

Base: `43eb6cbc`. The initial public report confused retained binary with
reconstructed source and omitted data. Corrected map-derived ownership and
source-hashed snapshots report 709/1,292 C functions, 91,880/220,092 code bytes,
and 3,500/3,973,732 explicitly initialized C data bytes. The decrease is a
measurement correction, not lost decompilation. Extracted assets remain zero
under this conservative reconstruction metric.

Nine adjacent files were consolidated into three named TUs. Three router
functions were renamed using their observed writes. No new C functions,
decompiled bytes, pins or NAKED fallbacks were added. Existing interface
conflicts are recorded in `docs/repository-structure.md`, not silently widened.

The clean `make tidy && make -j8 && make check` gate passed, preserving SHA1
`7b4c27009198df18555e63fb5dcad223eaf09815`. Address snapshots and public layout
inventory were refreshed afterward. All 78 infrastructure regression tests
passed, including ten report tests; evidence and campaign validation passed.

Astra integrated the source clusters and reviewed reporting; the reporting
worker implemented the snapshot and data audit, and the structure worker
performed a read-only grouping/interface audit. Review corrected an initial
scanner that mistook register pins for instruction replacement, and two stale
overlapping function extents. A final ownership review excluded scene and audio
code from runtime despite its historical `src/system` placement. Per-worker model/effort and usage measurements
are unavailable in this checkpoint (null); no account quota delta is attributed
to this work.

This is the first bounded cleanup pass, not a completed repository-wide
interface, naming or asset audit.
