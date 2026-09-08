# decomp.dev reporting

The hosted dashboard reads an ObjDiff v2 report from this repository's GitHub
Actions artifacts. It does not need the baserom, compiler, or a project-specific
configuration file.

Generate and validate the report locally:

```sh
make decomp-report
python3 tools/agent/objdiff_report.py --check
```

The build-free generator reads `config/decompdev_functions.us.tsv` and
`config/decompdev_layout.us.json`. The latter records actual input-section
addresses and sizes from the verified link map, data credit from ELF object
symbols, and hashes of the linked sources, headers, linker script and Makefile.
Changed inputs make report generation fail until the snapshot is refreshed.
Filename addresses and linker comments are never used to guess ownership.

Progress is reconstructed source: linked ordinary C definitions count as
matched; NAKED/NON_MATCHING fallbacks, inline-assembly implementations, raw
assembly and precompiled dependencies do not. Retaining a library does not
make it decompiled. GAX, BIOS wrappers (SDK), compiler support (libgcc), system
runtime and game code have separate categories. Runtime uses an explicit
audited list: the six startup/interrupt assembly functions plus `WaitVblank`
and `GetFrameTick`. The `src/system` directory itself confers no runtime status:
its scene handlers, attract-mode input, main game dispatcher and game audio
wrappers belong to Game. The mixed `init.c` unit (game RNG, memory clearing,
game-specific VBlank handler) stays in Game until its ownership can be split
without inventing TU boundaries. Category labels describe this report's scope,
not a claim to have recovered the original source organization.

The headline includes all categories. Category totals partition it, so neither
dependencies nor their unresolved work disappear from the denominator. The
Game category can be selected for game-only progress. Pins do not disqualify
otherwise matching C; they remain a separate reconstruction-quality metric.

Data covers linked ROM bytes from `0x08035d9c` (the IRQ handler table after the
last code function) to `0x08400000`. This includes unresolved assets and padding;
it does not assert that every byte has semantic data content. Function-local
literal pools remain in function extents, and RAM/BSS is excluded. Data credit
requires a sized ELF object within its actual input section and an explicit C
array initializer in that section's linked source. Symbol aliases are counted
once. `INCBIN_U8/U16/U32` arrays, raw `.incbin` files, assembly data and binary
extraction receive zero credit, even when named or typed. Discarded sections
receive no credit. This conservative metric can undercount macro-generated or
scalar C data; such cases need a reviewed extension, not a blanket exemption.

This distinction follows the source/extraction separation used by other GBA
projects (see [FE8J's scorecard](https://github.com/laqieer/fireemblem8j)). The
report fields follow the [ObjDiff schema](https://github.com/encounter/objdiff/blob/main/objdiff-core/protos/report.proto).
Matched and complete byte measures both represent verified reconstructed
source here; `complete_units` remains zero because original TU boundaries and
unit completion have not been audited.

The tracked function inventory includes functions still inside raw INCBIN
ranges. Refresh it only from a byte-identical local build:

```sh
make tidy && make -j8 && make check
python3 tools/agent/objdiff_report.py --update-inventory --check
make check-infra
```

Review inventory changes before committing them. A renamed function or newly
identified raw function is a normal reason for an inventory change.
Refresh rejects a ROM with the wrong known SHA1 or sources newer than the ELF.
The clean build is essential: timestamp checks are a guard, not a substitute
for dependency-correct compilation. The dashboard is a verified snapshot, not
an independent CI rebuild or a measure of naming/semantic understanding.

## Hosted registration

1. Push the workflow to the default branch and wait for the `decomp.dev report`
   workflow to finish.
2. Confirm that its Actions run contains an artifact named `us_report`, with
   `report.json` inside it.
3. Sign in at <https://decomp.dev/manage/new> and register
   `https://github.com/JRickey/frog-adv-temple-decomp`.
4. Install the decomp.dev GitHub App if automatic refreshes and pull-request
   progress comments are desired.

decomp.dev discovers only completed default-branch push runs during initial
registration, so a pull-request-only artifact is not sufficient.
