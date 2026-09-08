# decomp.dev reporting

The hosted dashboard reads an ObjDiff v2 report from this repository's GitHub
Actions artifacts. It does not need the baserom, compiler, or a project-specific
configuration file.

Generate and validate the report locally:

```sh
make decomp-report
python3 tools/agent/objdiff_report.py --check
```

The build-free generator reads `config/decompdev_functions.us.tsv`,
`linker.ld`, and the source tree. Progress is source progress: pure C counts as
matched, while NAKED/NON_MATCHING fallbacks and remaining game assembly do not.
The intentionally retained GAX library, SDK code, and startup/interrupt runtime
are reported in separate completed categories.

The tracked function inventory includes functions still inside raw INCBIN
ranges. Refresh it only from a byte-identical local build:

```sh
make check
python3 tools/agent/objdiff_report.py --update-inventory --check
make check-infra
```

Review inventory changes before committing them. A renamed function or newly
identified raw function is a normal reason for an inventory change.

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
