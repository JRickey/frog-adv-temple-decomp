# Decomp tooling

Where each tool lives, what it's for, and which class of mistake it
prevents. Read this once when onboarding; pick the right tool by name
afterwards.

## Layout

```
tools/
├─ agent/                  # Python tooling (existing) + TS ports (new)
│  ├─ *.py                 # See below — picker, progress, compile/view, validators
│  ├─ bin/objdiff-cli      # encounter/objdiff binary (per-symbol asm diff)
│  ├─ prompts/             # System / task / kickoff / stall prompt templates
│  └─ ts/                  # TypeScript ports of mizuchi shared libs + new cmds
│     ├─ shared/           # Ports of mizuchi's src/shared/* (verbatim)
│     └─ cmds/             # Standalone CLI tools (new)
├─ disasm/peel.py          # Byte-range → asm/disasm_0xADDR.s peeler (guarded)
├─ extractor.py            # Pulls binary data blobs from baserom into data/
└─ ...
vendor/
├─ m2c/                    # pret/m2c submodule — initial decomp seed
└─ decomp-permuter/        # simonlindholm/decomp-permuter submodule
scripts/
├─ setup-m2c.sh            # First-time: build vendor/m2c venv
├─ setup-decomp-permuter.sh
└─ compile-agbcc.sh        # Standalone agbcc compile script (called by c-compiler.ts)
```

## Pre-peel safety net (Phase A)

Catches: peel boundaries that swallow adjacent functions (the bug behind
commit `0c989b1`, AgbMain peeled too wide).

| Tool | What it does |
|---|---|
| `npx tsx tools/agent/ts/cmds/extract-function-bytes.ts <Name>` | Authoritative byte range for a named symbol, derived from `frog_us.map`. Use after the symbol is in the map to confirm where it actually lives. Adds `--bytes` and `--asm` for hex/disassembly. |
| `npx tsx tools/agent/ts/cmds/detect-fn-boundary.ts <addr>` | Walks Thumb forward from `addr` in the baserom and reports the detected end address. Flags interior `bl` targets (the strongest possible signal that you're peeling more than one function). Use **before** the symbol exists in the map. |
| `python3 tools/disasm/peel.py --start X --end Y --mode thumb` | Peels the range into `asm/disasm_0xX.s`. Now invokes `detect-fn-boundary.ts` automatically and refuses if the proposed range looks wrong. Override with `--force-boundary` after manual review. |

Typical workflow for a new peel:

```sh
# 1. Identify a range you think contains one function.
# 2. Run the boundary detector — it'll tell you the real end.
npx tsx tools/agent/ts/cmds/detect-fn-boundary.ts 0x080002a4

# 3. Now peel — peel.py will run the detector again as a guard.
python3 tools/disasm/peel.py --start 0x080002a4 --end 0x08000430 --mode thumb
```

## Static validators (Phase B)

Catches mistakes that have already happened, so they don't happen again.

| Tool | Catches |
|---|---|
| `python3 tools/agent/struct_xref.py 0x03005330` | Wrong struct-field offsets. Reports every load/store through a given base address grouped by offset, with reader/writer columns. Would have caught commit `059720d` (gGameStuff.mode at offset 9, not 10) in seconds — offset 10 had 7 writers and 0 readers. |
| `python3 tools/agent/check_relocations.py` | Bad branch encodings. Verifies every BL target in `frog_us.elf` matches a known symbol address or lies inside its own function. Would have caught commit `fa09acf` (PROVIDE() + Thumb BL mis-encoded to ~0x3F00xx). Only sees functions that have been refined to mnemonics — re-run after each refinement step. |
| `python3 tools/agent/lint_hex_literals.py` | Over-wide hex literals. Flags any `0xXXXXXXXXX` (9+ digits, >32-bit) that GAS/ld would silently truncate. Would have caught `0x080020bc1` in commit `fa09acf`. Pre-commit-friendly. |

## Existing Python tooling (still primary for the agent loop)

| Tool | What it does |
|---|---|
| `tools/agent/progress.py` | Whole-ROM and per-function diff vs baserom. `--per-function --human` prints the top mismatches; `--json` for agents. |
| `tools/agent/pick_target.py` | Picks the next legal decomp target by linker.ld neighbour affinity. `--json` for agents, `--all` to see blocked candidates. |
| `tools/agent/compile_and_view_assembly.py` | The loop's oracle: compiles, then byte-diffs a named function against baserom. Already does INSERTION/DELETION/REPLACEMENT/OPCODE_MISMATCH/ARGUMENT_MISMATCH categorization (this is what mizuchi's `objdiff.ts` provides; the Python implementation predates the port and stays primary). |
| `tools/agent/snapshot_addresses.py` | Caches every function's baserom address to `.function_addresses.json` for layout-drift detection. Refresh after every landed decomp. |
| `tools/agent/scaffold_cluster.py` | Scaffolds a new `src/<dir>/<name>.c` with linker.ld plumbing. Verifies byte-neutrality via `make check`. |
| `tools/agent/craft_prompt.py` | Builds the per-function decomp prompt — destination C file lookup via linker.ld, callee declarations from `include/`, sampled neighbour functions. |
| `tools/agent/pre_pr_check.py` | Style/readability lint for staged commits. |
| `tools/agent/scope_survey.py` | Heuristic count of probable Thumb/ARM functions in the ROM. Order-of-magnitude planning. |
| `tools/agent/bin/objdiff-cli` | encounter/objdiff binary. Use when `progress.py` says nonmatching but the function looks right. |

## Mizuchi-ported TS toolchain (under `tools/agent/ts/`)

Read-only background: this is a near-verbatim TypeScript port of mizuchi's
`src/shared/*` modules. They're typed and `npx tsc --noEmit` from repo root
is clean. Wire them into new tools or agent-driven runs as needed.

| File | Mizuchi source | Use it for |
|---|---|---|
| `shared/map-file/map-file.ts` | `src/shared/map-file/map-file.ts` | Parsing `frog_us.map` into symbol→address and symbol→.o maps. |
| `shared/indexer/asm-utils.ts` | `src/shared/indexer/asm-utils.ts` | Parsing `.s` files into per-function chunks; BL/jal extraction. |
| `shared/platform-target.ts` | inlined from `src/shared/config.ts` | `PlatformTarget` enum + `isArmPlatform()`. |
| `shared/objdiff.ts` | `src/shared/objdiff.ts` | objdiff-wasm wrapper with categorized diff output (INSERTION/DELETION/REPLACEMENT/OPCODE_MISMATCH/ARGUMENT_MISMATCH). Not currently wired — see "Why not a TS rewrite of compile_and_view" below. |
| `shared/c-compiler/c-compiler.ts` | `src/shared/c-compiler/c-compiler.ts` | Concatenated-context single-function compile via `scripts/compile-agbcc.sh`. Templating, comment stripping, `cpp -P`, line-offset error remapping. |
| `shared/prompt-builder/*.ts` | `src/shared/prompt-builder/*.ts` | AST-grep-based context extraction (extern decls + transitive type defs from existing `src/` and `include/`). Skips similar-function sampling when no embedding DB is present. |
| `shared/m2c.ts` | `src/shared/m2c.ts` | Invokes `vendor/m2c/m2c.py` with `--target arm` and the `.syntax unified` prepend for UAL Thumb. |
| `shared/decomp-permuter.ts` | `src/shared/decomp-permuter.ts` | Invokes `vendor/decomp-permuter/permuter.py`. Includes the `#writeObjdumpWrapper` per-symbol byte-extractor (lines 472-563) — the source of the byte-range pattern in `extract-function-bytes.ts`. |
| `shared/errors.ts`, `shared/capped-output.ts`, `shared/sdk-error-handlers.ts` | matching mizuchi paths | Utilities. |

### Why not a TS rewrite of compile_and_view_assembly

Mizuchi's `compile_and_view_assembly` MCP tool diffs a freshly-compiled `.o`
against a pre-extracted "expected" `.o` (per-function, generated by a
project-specific build step). We don't have expected `.o` files — instead
the Python tool builds the whole project incrementally and diffs the named
function's byte slice against the baserom. The categorization is identical;
the implementation strategy differs. Keep `compile_and_view_assembly.py`
primary unless/until we set up per-function expected-`.o` extraction.

## Setup: m2c and decomp-permuter

Submodules under `vendor/` — clone with:

```sh
git submodule update --init --recursive
```

Then set up the Python venvs (one-time):

```sh
bash scripts/setup-m2c.sh                # creates vendor/m2c/.venv
bash scripts/setup-decomp-permuter.sh    # creates vendor/decomp-permuter/.venv
```

Both expect a system Python 3.11+ and `pip` on PATH. macOS users who use
pyenv: pin via `.python-version` or set `PYENV_VERSION` before running.

Both wrappers (`tools/agent/ts/shared/{m2c,decomp-permuter}.ts`) call the
venv'd interpreter directly — no need to `source .venv/bin/activate`.

## Adding a Node-side tool

```sh
npm install                               # one-time
npx tsx tools/agent/ts/cmds/your-tool.ts  # run directly
```

`tsx` runs `.ts` files through SWC without a build step. The repo's
`tsconfig.json` is at the root with `paths: { "~/*": ["./tools/agent/ts/*"] }`.

Type-check the entire TS tree with `npx tsc --noEmit`.

## Where to write notes when you learn something

Topic-specific docs live in `docs/`. Read `docs/README.md` once for the
conventions. **Don't expand CLAUDE.md** — it gets loaded into every agent
context.
