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

Function classification is per function, not per source file: a neighboring
NON_MATCHING fallback does not invalidate otherwise ordinary C when TUs are
consolidated. Multiple conditional definitions remain conservatively uncredited
until their selected implementation can be established.

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
Matched bytes represent reconstructed C/data here. Complete ("fully linked")
bytes additionally include the audited, reproduced libgcc dependency. Its 13
archive members are complete units; other unit completion has not been audited.

## Compiler runtime is a resolved dependency

`tools/agbcc/lib/libgcc.a` supplies code linked into the ROM, not merely a
host-side build tool. Linking compiler archive members directly is also used
by [pokeemerald](https://github.com/pret/pokeemerald/blob/master/ld_script.ld).
[FE8J](https://github.com/laqieer/fireemblem8j#status--honest-four-axis-scorecard)
also includes installed compiler-library functions in its function totals.
These projects do not establish one universal progress-counter convention.

Our archive was built from public `pret/agbcc` revision
`da598c1d918402c42c0c0d7128ba14567f3175e9`: `build.sh` builds libgcc and
`install.sh` copies the result. Source-built and installed archives compare
identically with SHA-256
`5086cf015e316b4dcef8952305e2e6364d835bd9a11e7328db13027359635ef9`.
The verified ROM links 13 archive members. Their 65 inventoried functions
cover 6,846 bytes; the 6,888-byte linker band also has 42 non-function bytes.

Thus libgcc is **100% complete as a reproduced compiler dependency**, not
unfinished reverse engineering. It earns no *authored reconstructed C* credit.
Snapshot refresh checks the actual linked archive hash before granting this
completion status. An unknown archive fails closed to zero completion credit.
GAX's retained INCBIN implementation does not have this source-build provenance
and receives neither kind of credit. See `docs/decisions.md` for the original
archive-placement decision.

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
4. Install the decomp.dev GitHub App for immediate workflow-completion refreshes
   and pull-request progress comments. Without the app, the service polls every
   30 minutes; manual Force refresh is also available.

The app is installed for `JRickey/frog-adv-temple-decomp` only. It has read
access to Actions, code and metadata, plus read/write access to issues and pull
requests for progress comments. No broader repository selection is required.

decomp.dev discovers only completed default-branch push runs during initial
registration, so a pull-request-only artifact is not sufficient.
