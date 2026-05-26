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
| `python3 tools/agent/dump_pool.py sub_08000430` | Pool-literal mis-reading. For every `ldr [pc, #N]` in a function, prints the resolved 32-bit value + a human label (REG_IE, gGameStuff, IWRAM 0x...). Prevents the "halfwords flipped" mistake (objdump shows `0200 0400`, the actual word is `0x04000200`). |
| `python3 tools/agent/check_relocations.py` | Bad branch encodings. Verifies every BL target in `frog_us.elf` matches a known symbol address or lies inside its own function. Would have caught commit `fa09acf` (PROVIDE() + Thumb BL mis-encoded to ~0x3F00xx). Only sees functions that have been refined to mnemonics — re-run after each refinement step. |
| `python3 tools/agent/lint_hex_literals.py` | Over-wide hex literals AND `sub_<9+digit>` symbol names — both are the same 36-bit silent-truncation bug. Would have caught `0x080020bc1` (commit `fa09acf`) and `sub_080020B30` (commit `b3832da`). Pre-commit-friendly. |

## Peel-first orchestration (Phase C)

The unblocker for any C decomp whose function calls outside its own
slice. Cross-region Thumb BLs need real Thumb-typed symbols at the
target address; `PROVIDE()` and `.thumb_set` both fail (see
`codegen-notes.md`, "Cross-region Thumb BL targets").

| Tool | What it does |
|---|---|
| `python3 tools/agent/auto_peel.py --callees-of <fn> --apply` | For every cross-slice BL the target makes: boundary-detect → `peel.py` → bucket-split → `linker.ld` rewrite → `make check`. Reverts any peel whose build breaks. Also runnable as `--addr 0x<ADDR>` for a single peel. |
| `python3 tools/agent/decomp_brief.py <fn>` | One-command briefing before writing C: range, callees + peel status (with the exact `auto_peel.py` command needed to unblock), pool labels, struct cross-ref per IWRAM/EWRAM base, m2c seed C, destination hint from `linker.ld` adjacency. `--seed-only` prints just the m2c output. |
| `python3 tools/agent/struct_grow.py 0x<addr> --name <Type>` | Renders a typed C struct from observed accesses to a base. Sized per the widest observed access (strb→u8, strh→u16, str→u32) with `_unkNN` placeholder names and `_padNN[N]` for gaps. `--apply --header <path>` writes it into the header. |
| `python3 tools/agent/build_expected.py` | For each `src/<rel>.o` in `linker.ld`, emits `expected/<rel>.o` with the same symbols pointing at baserom bytes. Used by `objdiff-cli` for per-symbol diff that doesn't rebuild the whole 4MB ROM each permuter iteration. Generated bytes use `.inst.n` + `.word` so ARM ELF mapping symbols ($t/$d) match the built `.o` — otherwise objdiff reports 0% match for byte-identical functions. |

Typical decomp workflow now reads:

```sh
python3 tools/agent/pick_target.py --max-size 40 --limit 10
python3 tools/agent/decomp_brief.py <target>            # see what's blocked
python3 tools/agent/auto_peel.py --callees-of <target> --apply
python3 tools/agent/struct_grow.py 0x<addr> --name <Type>  # one per base
# … write C, move asm, …
python3 tools/agent/build_expected.py --fn <name>
tools/agent/bin/objdiff-cli diff -1 expected/src/<rel>.o -2 src/<rel>.o <name> --format json-pretty
make -j8 && make check
```

## Corpus search (Phase D)

When agbcc throws a matching problem at us, it's almost certainly been
solved in another agbcc decomp already. Phase D caches a curated set of
those repos locally so we can grep their C and walk their commit
history. Castlevania: Aria of Sorrow (same publisher + era) and the
pret pokemon family are the highest-leverage references.

The cache lives at `~/.cache/decomp-corpus/` (override with
`DECOMP_CORPUS_DIR`). Clones use `--filter=blob:none` so commit history
is walkable without dragging every binary asset across the network.

| Tool | What it does |
|---|---|
| `scripts/corpus-sync.sh` | Clones/fetches the curated repo list and writes `~/.cache/decomp-corpus/.metadata.json` (slug, toolchain, head, status). The list is inline at the top of the script — adding a repo means editing it. Per-repo failures are non-fatal. |
| `python3 tools/agent/corpus.py sync` | Delegates to `corpus-sync.sh`. |
| `python3 tools/agent/corpus.py grep PATTERN [--c|--asm] [--repo R]` | `rg` across every cached repo. Default filter: `toolchain=agbcc` (drop with `--any-toolchain`). Output formatted as `repo:path:line:content` for easy paste-back. |
| `python3 tools/agent/corpus.py decomps [--name X] [--repo R]` | Walks each repo's `git log` for `^Decompile\|^Match\|^Decomp` subjects. Use to find prior art on a similarly-named function. `--stat` adds a files-changed count (slower). |
| `python3 tools/agent/corpus.py show REPO@COMMIT` | `git show --stat --patch` on a specific commit, truncated to `--max-lines`. |
| `python3 tools/agent/corpus.py status` | Last sync time, per-repo commit count, total disk. |

Trigger for adding this phase: `docs/unknowns.md`'s "Init1 decomp
attempt". agbcc CSE-folds adjacent IWRAM base loads (`adds rN, #imm`).
A direct fix doesn't exist in the local tree — but cvaos and the
Pokemon family ran into the same compiler the same way, and their
solutions live in git history. The first thing to try when stuck on
agbcc codegen is now `corpus.py grep` and `corpus.py decomps`.

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
| `tools/agent/refcount_pool_loads.py` | Ranks ROM data addresses by how many times code loads them via `ldr Rd, [pc, #N]`. Scans both Thumb and ARM pool-load encodings across the code region. Cross-checks each target against `database.json` (`EXTRACTED`) and `frog_us.map` (`NAMED`), so `--pending-only` surfaces unclaimed high-yield anchors for the next data pass. `--threshold 5` is the suggested cutoff for charter-grade anchors. |
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

### `compile_and_view_assembly.py` vs the `expected/.o` pipeline

Two paths to per-symbol diff now coexist:

- `compile_and_view_assembly.py` — full incremental rebuild +
  objdump-of-baserom-bytes. Reads regardless of whether the function is
  already wired into `linker.ld`. Best for fast in-loop feedback during
  the matching grind.
- `build_expected.py` + `objdiff-cli` — generates `expected/<rel>.o`
  (one ELF per source file) with the same symbols pointing at baserom
  bytes. Diff via `objdiff-cli` reports a per-symbol `match_percent`
  with full instruction categorization (matches the mizuchi/objdiff
  pipeline). Best for permuter iterations where avoiding the full ROM
  rebuild matters, and for visual side-by-side review.

The Python tool stays primary for the first-cut "did my edit match"
question; the expected-`.o` path is the fast permuter loop.

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
