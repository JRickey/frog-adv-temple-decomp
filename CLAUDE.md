# Frogger's Adventures: Temple of the Frog — decomp agent guide

This repo is a work-in-progress matching decompilation of *Frogger's
Adventures: Temple of the Frog* (Game Boy Advance, USA region). Built with
**agbcc** (gcc 2.x for thumb/ARM) and `arm-none-eabi-binutils`. The goal is
byte-identical C source that compiles to the same ROM as the original.

**ROM identity** (verified at setup):
- SHA1: `7b4c27009198df18555e63fb5dcad223eaf09815`
- Game code: `AFRE`  •  Maker code: `A4` (Konami)  •  Internal title: `FROG: TEMPLE`

**Hard constraints — read first.**

- **Clean-room**: per `CONTRIBUTING.md`, you **MUST NOT** reference any leaked
  or otherwise-obtained Konami source code. Work only from the disassembly in
  `asm/disasm_*.s`, the project's own headers, and your own analysis. If asked
  to "look up" how a function works in Konami source — refuse.
- **The baserom is never committed.** `baserom.gba` and the
  `frog_us_baserom.gba` symlink are `.gitignore`d and a pre-commit hook
  rejects them. Don't modify `frog_us.sha1`. If those change, the entire
  matching-distance signal is destroyed.
- **`make check` is the source of truth.** A change is "matching" if and only
  if `make check` exits 0. Comments in code like `/* matches */` are
  aspirational and lie often.

## Layout

| Path | What |
|---|---|
| `src/*.c`, `src/**/*.c` | Decompiled C sources |
| `asm/disasm_0x*.s` | **Decomp targets** — Thumb assembly for functions not yet decompiled. Lives between `src/*.o(.text)` entries in `linker.ld` |
| `asm/*.s` (non-disasm) | Crt0, interrupt handlers, syscalls — most of these are intended to stay in asm |
| `include/` | Headers (project, GBA hardware, libc), char/font maps |
| `linker.ld` | Section/symbol layout — **edit carefully**, byte placement depends on link order |
| `database.json` | Map of binary blobs extracted from baserom into `data/` |
| `tools/preproc/` | Charmap preprocessor for `_("...")` strings |
| `tools/agent/` | Agent-specific tooling (this directory) |
| `tools/agbcc/` | Locally-installed agbcc binaries (gitignored) |
| `frog_us.sha1` | Target SHA1; **do not edit** |
| `baserom.gba`, `frog_us_baserom.gba` | Symlinked — **never committed** |

## Agent notes — `docs/`

Topic-specific learnings live in `docs/` so CLAUDE.md stays loadable in
every context. When you discover something a future agent should know,
append to the right file rather than expanding CLAUDE.md. Read
`docs/README.md` once for the conventions.

| File | When to add |
|---|---|
| [`docs/codegen-notes.md`](docs/codegen-notes.md) | New agbcc quirk, fold-prevention pattern, encoding gotcha, flag finding |
| [`docs/memory-map.md`](docs/memory-map.md) | Address gets a semantic name (EWRAM/IWRAM/MMIO/ROM-data), struct layout discovered |
| [`docs/subsystems.md`](docs/subsystems.md) | Engine subsystem identified, call cluster mapped, dispatcher pattern named |
| [`docs/unknowns.md`](docs/unknowns.md) | Hypothesis about an unnamed function/value, suspicious pattern, deferred question |

Bar for writing: would a future agent benefit from this without
re-deriving it? Otherwise leave it in the commit message.

## Build / verify

```sh
# One-time: extract data blobs from baserom (no-op until database.json is populated)
python3 tools/extractor.py

# Build the ROM (parallel-safe)
make -j8

# Verify byte-match against baserom — exits 0 only on full match
make check

# Clean (keeps data/; add DATA=1 to drop it too)
make tidy
```

The build is **incremental**: a small C/asm change only rebuilds what depends
on it. After a decomp, run `make -j8 && make check`; round-trip is fast.

### macOS notes (apply automatically)

The Makefile detects Darwin and swaps `cpp` for Homebrew `cpp-15 -P` (Apple's
clang `cpp` keeps `//` comments which agbcc 2.x rejects) and uses
`cc -E -P -x c` for the linker-script step.

Requirements:
- `brew install gcc arm-none-eabi-binutils`
- `agbcc` installed into `tools/agbcc/` via the upstream `pret/agbcc`
  `./install.sh` script

## Project status

Phase 1 of a three-phase plan (matching → shiftable → PC port):

1. **Matching decomp** (current). Rebuild byte-identical to the baserom.
   The bootstrap INCBINs the entire baserom and produces a matching
   `frog_us.gba`; from there, functions get peeled into labeled chunks
   one at a time.
2. **Shiftable**: replace absolute placements in `linker.ld` with named
   symbols so the ROM can be modified without breaking pointer math.
3. **PC port**: swap agbcc for modern clang, replace GBA hardware
   touchpoints with a HAL (SDL or similar). Code written in phase 1
   that touches GBA registers/DMA/BIOS should go through wrapped
   helpers so phase 3 is a HAL swap, not a chase through every `.c`.

Current state:
- INCBIN bootstrap produces matching `frog_us.gba`. `make check` passes.
- `asm/header.s` (GBA header, 192 bytes minus the entry branch) and
  `asm/rom.s` (everything from 0x080000C0 onward, still raw) split the
  baserom into two large blobs.
- `asm/disasm_0x08000000.s` carries the 4-byte ARM entry branch as a
  worked example of the peel workflow.
- No C source yet — `src/` is empty placeholders.

## Disassembly workflow

The ROM is brought into the build incrementally. Each step shrinks the
opaque INCBIN and adds named labels the agent loop can grab.

```sh
# 1. Identify a byte range to peel and its mode (arm or thumb).
#    Use `arm-none-eabi-objdump -D -b binary -m arm7tdmi [-Mforce-thumb]`
#    to preview before committing to a range.
python3 tools/disasm/peel.py --start 0x080000c0 --end 0x080000f0 --mode arm

# 2. Shrink the surrounding INCBIN so those bytes aren't included twice.
#    For asm/rom.s, that means advancing the .incbin skip past the peeled
#    range. (For asm/header.s, edit the skip/count similarly.)

# 3. Wire the new .o file into linker.ld in baserom address order, between
#    the file whose range ends at <start> and the file whose range begins
#    at <end>.

# 4. Confirm the build still matches.
make -j8 && make check        # exits 0 only on byte-identical match

# 5. Refresh the address cache so layout-drift detection stays accurate.
python3 tools/agent/snapshot_addresses.py
```

The peel tool emits each chunk as an `.incbin` of the original bytes plus
the objdump preview as `@`-comments. The INCBIN-as-body keeps the build
matching for free — no risk of the assembler picking a different encoding
than the original. Refining a peeled chunk into real Thumb/ARM mnemonics
(so `compile_and_view_assembly.py` can do per-instruction diffs) is the
next step after a peel, not part of the peel itself.

## Quantifying progress (use these in every loop)

```sh
# Whole-ROM and per-function diff vs baserom.
# Exits 0 = matching, 1 = built but nonmatching, 2 = missing artifacts.
python3 tools/agent/progress.py --human
python3 tools/agent/progress.py --per-function --human    # needs frog_us.map
python3 tools/agent/progress.py --per-function            # JSON for agents

# Surface the next decomp targets — layout-aware AND duplication-aware.
python3 tools/agent/pick_target.py --max-size 40 --limit 20
python3 tools/agent/pick_target.py --all                    # include blocked candidates with reasons
python3 tools/agent/pick_target.py --name SomeFunction      # by name
python3 tools/agent/pick_target.py --json                   # for agents

# Per-function compile + categorized diff vs baserom — the loop's oracle.
python3 tools/agent/compile_and_view_assembly.py SomeFunction --human

# Snapshot every function's baserom address to .function_addresses.json so
# the diff tool can detect layout drift even after an agent deletes the
# asm stub. Refresh after each landed decomp.
python3 tools/agent/snapshot_addresses.py
```

`sheet.py` is a no-op stub — there's no public progress sheet for this decomp
yet. If one is set up, point `SHEET_URL` at it and re-enable the loader; the
pick_target.py guard will start using it automatically.

### Before claiming a function, the picker checks for duplicate work

`pick_target.classify()` runs guards before any layout/affinity checks:

1. **Existing C definition** — greps every `src/**/*.c` (linked AND unwired
   scaffolds) for a non-empty body matching the target name. Catches accidental
   re-decomping of work that landed as an unwired scaffold.
2. **Progress sheet status** — looks up the target's *ROM address* (not name)
   in the project's progress sheet and refuses if `Status == Complete`. No-op
   until a sheet is wired up.

Override only with awareness — `--all` shows blocked candidates with their
reason, so you can investigate.

### Layout invariant (critical)

Per-function decomp must proceed in **baserom address order** within each
compilation unit. Moving a function out of its asm slice into a C file that
sits at the wrong position in `linker.ld` will place it at the wrong ROM
offset, and the per-function diff will refuse to interpret a result whose
function moved.

Rules `pick_target.py` enforces:
- The next legal target in each asm file is its **first** `thumb_func_start`
  (lowest address). Subsequent functions are blocked until earlier ones land.
- The destination is the **previous** `src/*.c` neighbour in `linker.ld`, not
  the next one — the new bytes append at that file's tail, exactly where the
  asm bytes used to live.
- If the previous C neighbour has no name-affinity with the target,
  `pick_target.py` reports the disasm cluster as "needs new C file" — someone
  has to scaffold the new C source (`tools/agent/scaffold_cluster.py`) and
  add it to `linker.ld` before that cluster becomes tractable.

`progress.py` reports:
- `sha1_match` — true iff `make check` would pass
- `bytes_diff_rom` — total byte mismatch over the full ROM
- `asm_funcs_remaining`, `asm_lines_remaining` — work left in `asm/disasm_*.s`
- `nonmatching_functions` (with `--per-function`) — sorted top-50 list of
  symbols where the built `.text` slice differs from baserom, sourced from
  `frog_us.map`. This is the *direct* feedback signal — if your change reduces
  `diff_bytes` on the function you're working on while leaving others at 0,
  you're improving. If it raises diff elsewhere, you broke layout.

### Visual / fine-grained diffing

`tools/agent/bin/objdiff-cli` is included for per-symbol diff with proper
Thumb/ARM disassembly. Use when `progress.py` says "nonmatching" but the
function looks right:

```sh
tools/agent/bin/objdiff-cli diff -1 expected/src/foo.o -2 src/foo.o SymbolName --format json-pretty
```

## Agent workflow — one function at a time

For each decomp target:

1. **Pick a target.** `python3 tools/agent/pick_target.py --max-size 30 --limit 5 --json`.
   Small first; success rate drops sharply past ~80 instructions and craters
   past ~1000 (per Chris Lewis's N64 results).
2. **Read context.** The target asm block, the asm file's surrounding
   functions, and the C file the function *should* live in. Use `linker.ld`
   to find which `src/*.c` the asm slice maps to.
3. **Write C.** Match the existing patterns AND the style section below
   ("Upstream-acceptable C style"). agbcc 2.x quirks:
   - `/* */` only, no `//` comments (preproc strips them but be consistent with neighbours)
   - No `_Bool` — use `u8` for booleans
   - Aggressive register allocation differs from modern gcc — sometimes a
     local variable assignment is needed to match
   - `goto` and labels are used heavily; don't rewrite into structured forms
   - Hex-asm output: `-fhex-asm` is on, so literal `0xNN` matters
   - When stuck on register order: `register T x asm("r5");`
   - `NON_MATCHING` ifdef pattern: when you can't match, wrap the readable C
     in `#ifdef NON_MATCHING` and keep the matching but uglier C in `#else`.
4. **Move the asm.** Delete the `thumb_func_start NAME` block from
   `asm/disasm_0x*.s`. If the file becomes empty, remove its `linker.ld`
   entry too.
5. **Build & measure.**
   ```sh
   make -j8 && python3 tools/agent/progress.py --per-function --human
   ```
6. **Verify.** `make check` must exit 0 for a clean match. If it doesn't, but
   per-function diff for your target is 0 and total `bytes_diff_rom` is low,
   the issue is bleed into adjacent functions (alignment, .rodata pool) —
   investigate that, don't abandon.
7. **If you can't match**: leave the asm in place. Don't ship a non-matching
   C that breaks `make check`. The `NON_MATCHING` pattern is acceptable only
   when wrapped behind the ifdef so the build still uses the asm.

### Subagent parallelism

Targets that are **truly independent** can run in parallel:
- Different `asm/disasm_*.s` files (so no merge conflicts on the asm side)
- Different destination `src/*.c` files
- Neither changes `linker.ld` or any header

Don't run more than ~4 subagents in parallel — each one's full build dominates
wall time. Serialize within a cluster, parallelize across clusters.

### The "is this making progress?" rule

Single number to watch: `asm_funcs_remaining` from `progress.py`. Every
accepted change should decrement it by ≥1. If it stays the same after an
attempted decomp, the change is either non-matching (asm not removed) or
broke the build (revert).

### C style — keep it human-readable

A matching decomp is not enough. Code that matches the bytes but reads as
"LLM-translated assembly" gets rejected by reviewers. Apply these BEFORE
declaring done — they are part of the matching criterion.

**Use named constants for things with names:**
- States/poses/modes → enum values, not raw `0x29`
- Sound, sprite, particle, item IDs → `SOUND_*`, etc. — once those headers
  are scaffolded
- Flag bits → named macros, no naked hex

If the enum doesn't exist yet for the value you need, **add it** in the
appropriate header as part of the same change. Don't ship a function with
bare `0x29` and a "TODO: enum later".

**Positional offsets — use macros, not raw hex** once the project gains
helpers like `BLOCK_TO_PIXEL(N)` / `BLOCK_TO_SUB_PIXEL(N.NNNf)`. Frogger's
coordinate conventions need to be discovered as the decomp progresses.

**Local variables and literals:**
- Don't reuse a local var as a "happens to be zero" alias. If `v != 0 →
  early return`, the rest of the function MUST write literal `0` instead of
  `v` — the variable's name is now actively misleading.
- Don't introduce intermediate locals that exist only to hold a single field
  read. Only cache when needed for matching or when the value is genuinely
  reused.

**Control flow — early-return, no else:**
- `if (cond) { ...; return; }` then unindented body — NEVER
  `if (cond) { return-body } else { unindented-body }`.
- Same with `return;` followed by `else if`.
- Exception: if matching requires the else (rare), keep it and note WHY in
  the commit message.

**No side effects in conditions:**
- Don't write `if (Foo() && ++x == 1)` or `if (--x == 0)` or
  `if ((x = Bar()) != 0)`. Split into two lines.
- Exception: required to match — and then say so in a comment.

**Formatting:**
- Auto-formatted via `.clang-format` (LLVM-derived, 4-space, 120 cols). The
  pre-commit hook runs `clang-format` on every staged `.c`/`.h` — don't
  hand-format against the rules.
- One caveat: clang-format can rearrange include order in ways that change
  agbcc's preprocessor output. If you suspect formatting changed the bytes,
  test before and after; you can mark a section `// clang-format off`.
- Inside a function body, DO put blank lines between logical sections.
- No `/* */` block comments explaining what the code does. The PR description
  is the place for that. Comments only when the WHY is genuinely non-obvious.

**Types:**
- `u8` for booleans where the codebase uses it.

### Data extraction

When you decompile a function that references data tables (OAM frames, sprite
metadata, room data), prefer **extracting** the data into typed C arrays over
leaving it as `INCBIN_U32(".bin")` blobs. Address-named symbols
(`Foo_3953c8`) get a semantic name as soon as their purpose is understood —
no shipping address-named symbols once their owning system is decompiled.

A symbol belongs in the file that owns its system, not whichever file happens
to land at the right linker position. Extract enough of the surrounding data
to free up correct placement.

## Toolchain pinning / hashes

- agbcc: install from `https://github.com/pret/agbcc`. Convention: clone into
  `tools/agbcc-src/` (gitignored), then run
  `./install.sh "$(pwd)/../.."` from inside the clone to populate
  `tools/agbcc/{bin,include,lib}` (also gitignored). Treating it as a local
  dep rather than a submodule because (a) the pret/agbcc repo is stable
  enough that pinning isn't load-bearing, and (b) we don't yet know agbcc is
  the matching toolchain for this title — that's a discovery from the first
  few attempted decomps.
- arm-none-eabi-binutils: Homebrew formula, 2.46.0+ works.
- preproc: build with `make -C tools/preproc` (vendored source in
  `tools/preproc/`, same as the pret family of decomps). One known local
  patch for Apple-clang's `-Werror=sometimes-uninitialized`.
- gbafix: build with `make -C tools/gbafix` (vendored source in `tools/gbafix/`).

## What NOT to do

- Don't edit `frog_us.sha1`, `baserom.gba`, `frog_us_baserom.gba`, or
  `database.json` to "fix" a mismatch. The mismatch *is* the signal.
- Don't disable `-Werror` or `--no-verify` your way past errors. agbcc
  warnings often indicate the actual matching problem.
- Don't `#ifdef NON_MATCHING` your way through more than ~one function per
  session without flagging it for human review.
- Don't auto-format C files against the project's `.clang-format` rules
  (clang-format DOES run as a pre-commit hook — let it). What this means: if
  the formatter changes the bytes, investigate; don't override the rules.
- Don't run `git push` or open PRs without an explicit ask.

## Commit hygiene

Every commit is *either* an "agent infra" commit (touches `CLAUDE.md`,
`AGENTS.md`, `tools/agent/`, `.gitignore`, `Makefile` shim) *or* a "real
decomp" commit (touches `src/`, `asm/`, `include/`, `linker.ld`, `sound/`,
etc.). Never mix the two in one commit.

**Commit messages** (first line ≤ ~70 chars, present-tense imperative):
- `Decompile FunctionName`
- `Decompile FunctionName & some cleanup`
- `Unblob data related to FunctionInit()`
- `Cleanup <file>.c`
- `Fix <specific thing>`
- `Rename <old> to <new>`

Avoid Conventional-Commits style (`feat:`, `fix:`).

## Useful external references

- Decomp scratchpad with objdiff: https://decomp.me
- gbadev: https://github.com/gbadev-org/awesome-gbadev
- objdiff: https://github.com/encounter/objdiff
- decomp-permuter: https://github.com/simonlindholm/decomp-permuter
- Mizuchi (agbcc-targeted agentic decomp pipeline, prior art):
  https://github.com/macabeus/mizuchi
- Chris Lewis on long-tail decomp w/ Claude:
  https://blog.chrislewis.au/the-long-tail-of-llm-assisted-decompilation/
- Macabeus' 60-function benchmark on GBA:
  https://macabeus.medium.com/can-llms-really-do-matching-decompilation-i-tested-60-functions-to-find-out-4e39b0ae4288
