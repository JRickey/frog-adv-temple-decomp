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
| `tools/agent/` | Agent-specific Python tooling + `ts/` (TypeScript ports of mizuchi shared libs + new boundary/validator CLIs) |
| `tools/agbcc/` | Locally-installed agbcc binaries (gitignored) |
| `vendor/m2c`, `vendor/decomp-permuter` | Git submodules — initial-decomp seed and last-mile mutation brute-force. `scripts/setup-*.sh` to install venvs. |
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
# 0. (Thumb only) Detect the real function end before guessing a range.
#    Walks Thumb forward from the start address, flags interior bl targets.
#    Would have prevented commit 0c989b1 (AgbMain peeled too wide).
npx tsx tools/agent/ts/cmds/detect-fn-boundary.ts 0x080002a4

# 1. Identify a byte range to peel and its mode (arm or thumb).
#    Use `arm-none-eabi-objdump -D -b binary -m arm7tdmi [-Mforce-thumb]`
#    to preview before committing to a range.
python3 tools/disasm/peel.py --start 0x080000c0 --end 0x080000f0 --mode arm
# (peel.py runs detect-fn-boundary as a pre-check for thumb peels and
#  refuses to write if the proposed range looks wrong. Override with
#  --force-boundary after manual review.)

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

**Shortcut for the common case:** when prepping a C decomp, every
cross-region BL target needs a peel. Use `auto_peel.py` to do all of
them in one shot instead of running the steps above per callee:

```sh
python3 tools/agent/auto_peel.py --callees-of <target> --apply
```

It runs `detect-fn-boundary` + `peel.py` + bucket-split + `linker.ld`
rewrite + `make check` per callee, reverting any peel whose build
breaks.

### Validators (run before assigning struct offsets, after refining BLs)

```sh
# Cross-reference every load/store through a struct's base address.
# Reports reader/writer columns grouped by offset.
# Would have caught 059720d (gGameStuff.mode at offset 9, not 10).
python3 tools/agent/struct_xref.py 0x03005330

# Resolved pool literals for a function — surface the 32-bit value at
# each `ldr [pc, #N]` site with a human label, instead of mentally
# byte-swapping objdump's halfword display.
python3 tools/agent/dump_pool.py sub_08000430

# Re-disassemble every BL in the linked program and verify targets match
# known symbol addresses. Would have caught fa09acf (PROVIDE() + Thumb BL
# silently mis-encoded). Re-run after every refine-to-mnemonics step.
python3 tools/agent/check_relocations.py

# Lint hex literals > 32 bits AND sub_<9-digit> symbol names (both are
# the same 36-bit / silent-truncation bug). Pre-commit-friendly.
python3 tools/agent/lint_hex_literals.py

# Cross-reference other agbcc decomps when a matching blocker looks
# idiomatic (CSE folds, register-allocation drift, specific MMIO
# patterns). Local cache of 7 curated repos — see Agent workflow step
# 7 below for when to use it, and docs/tooling.md "Phase D" for the
# full surface.
python3 tools/agent/corpus.py grep '<regex>' --c
python3 tools/agent/corpus.py decomps --name <prefix>

# When stuck on an asm IDIOM you can't reproduce (a fold, a register
# spread/funnel, an addressing mode), search the corpus *git history*:
# the match commit DELETES the asm and ADDS the C, so history pairs the
# exact asm with its known-good C. Needs the full mirrors (blobs) at
# tools/agent/corpus-mirrors/ (gitignored). See Agent workflow step 7.
python3 tools/agent/corpus_asm_search.py search --asm '<asm-line-regex>' --require-c
python3 tools/agent/corpus_asm_search.py search --idiom highreg-spread   # preset
python3 tools/agent/corpus_asm_search.py show <repo>@<sha>               # the C
```

See `docs/tooling.md` for the full tool inventory, including the
TypeScript-ported mizuchi shared libs under `tools/agent/ts/shared/`
and the m2c + decomp-permuter integration under `vendor/`.

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
# THIS is the answer to "why doesn't <fn> match?" — do NOT hand-roll
# objdump|diff, raw objdiff-cli, or a custom JSON parser; this wraps all of
# that and reads ROM byte-ranges so it has no symbol-boundary pitfalls.
python3 tools/agent/compile_and_view_assembly.py SomeFunction --human
# For a function shipped NAKED/asm (whose live form matches by construction,
# so the oracle would report MATCH): diff its #ifdef NON_MATCHING reference
# body instead — auto-activates it, diffs, restores the source.
python3 tools/agent/compile_and_view_assembly.py SomeFunction --non-matching --human

# Snapshot every function's baserom address to .function_addresses.json so
# the diff tool can detect layout drift even after an agent deletes the
# asm stub. Refresh after each landed decomp.
python3 tools/agent/snapshot_addresses.py

# Recompute project-wide function-decomp + data-deblob percentages and
# patch the "## Progress" block of README.md in place. Run this after every
# landed pass — a decomp, a peel batch, a database.json data extraction —
# and include the README update in the same commit. The numbers shown in
# the README are estimates (function-count denominator is a Thumb prologue
# scan, not ground-truth), so each pass keeps them slightly more honest.
python3 tools/agent/progress_stats.py --update-readme
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

## Agent workflow — peel-first, then decomp

The bottleneck on this title is **cross-region Thumb BL relocations**:
any function that calls outside its own slice can't be matched in C
unless every callee already has a real Thumb-typed symbol. Neither
`PROVIDE()` nor `.thumb_set` give ld enough info (the latter triggers
`.text.__stub` veneers — see `docs/codegen-notes.md`). So the only
order that works is: **peel callees first, decomp last.** The tools
below mechanize that.

For each decomp target:

1. **Pick a target.**
   ```sh
   python3 tools/agent/pick_target.py --max-size 40 --limit 10
   ```
   Small first; success rate drops sharply past ~80 instructions and
   craters past ~1000 (per Chris Lewis's N64 results).

2. **Brief yourself in one command.**
   ```sh
   python3 tools/agent/decomp_brief.py <target>
   ```
   Reports range, callees + their peel status, pool labels with
   resolved addresses (no halfword-flipping mistakes), struct
   cross-ref per IWRAM/EWRAM base, m2c-emitted seed C, and the
   linker.ld-adjacent destination hint. Read the **Callees** section
   first — anything tagged `UNPEELED ✗` blocks the C decomp.

3. **Peel unpeeled callees (recursive).** If the brief reports any
   `UNPEELED ✗`:
   ```sh
   python3 tools/agent/auto_peel.py --callees-of <target> --apply
   ```
   This runs `detect-fn-boundary` + `peel.py` + bucket-splitting +
   `linker.ld` rewrite + `make check` per callee, reverting any peel
   whose build doesn't match. Commit each peel ("Peel sub_XYZ") or
   the bundle ("Peel <target>'s callees").

4. **Grow struct headers from observed offsets.** For each unnamed
   IWRAM/EWRAM base the brief surfaces:
   ```sh
   python3 tools/agent/struct_grow.py 0x<addr> --name <Type>
   # add --apply --header <path> to write the typedef into a header
   ```
   Land typed offsets *before* writing the C — keeps the C body from
   shipping with raw `[r0, #16]` magic numbers.

5. **Write C.** Use the brief's m2c seed as a starting point, then
   adapt to project style ("C style" below). agbcc 2.x quirks:
   - `/* */` only, no `//` comments (preproc strips them but be consistent with neighbours)
   - No `_Bool` — use `u8` for booleans
   - Aggressive register allocation differs from modern gcc — sometimes a
     local variable assignment is needed to match
   - `goto` and labels are used heavily; don't rewrite into structured forms
   - Hex-asm output: `-fhex-asm` is on, so literal `0xNN` matters
   - When stuck on register order: `register T x asm("r5");` — incl. HIGH regs
     (`asm("r8")`/`asm("r9")`/`asm("sl")`). High-reg pins are matchable in pure C
     (sub_080210A0 matches with all three) — see below.
   - Per-TU `CFLAGS +=` flag surface beyond `OLD_AGBCC`: `-ffixed-rN` (free a
     register), `-fno-strength-reduce` (defeat loop-reversal → signed `ble.n`
     count-up), `-fno-gcse`/`-fno-schedule-insns`. The whole gcc-2.x `-fXXX` set
     is a lever. See `docs/codegen-notes.md` "Cracking the unmatchable tail".
   - Read the agbcc SOURCE (`tools/agbcc-src/gcc_arm/{local-alloc,reload,cse,loop}.c`)
     to learn WHY a register/fold/loop diverges, then write the C that avoids it.
     A near-match is a local minimum — re-derive structure, don't tweak it.
   - `NON_MATCHING` ifdef pattern: when you can't match, wrap the readable C
     in `#ifdef NON_MATCHING` and keep the matching but uglier C in `#else`.
   - High-register pins (`mov sl, …`, `mov r9/r8, …`) are NOT a blanket NAKED
     trigger (codex matched sub_080210A0 with r8/r9/sl; sub_0800A1C8 was a
     premature NAKED). The genuinely-hard case is narrow: a high reg holding
     *loop state across an inner function-pointer BL* (the two-stage / opcode-
     dispatch classes below). A straight-line init/handler with high-reg pins
     should be ATTEMPTED (`classify_unmatchable.py` already treats it as advisory).
   - Two-stage loops over a shared `*gpGlobal` (baserom reloads from `ip`
     at every count-check; agbcc instead caches in a low callee-saved
     register) — also unmatchable. Same NAKED + NON_MATCHING fallback.
     See `docs/codegen-notes.md` "Two-stage loop functions with shared
     `*gpGlobal` cache".
   - `push {r4-r7, lr}` prologue + libgcc helper BL (`__divsi3`,
     `__umodsi3`, etc.) — third unmatchable class. agbcc 2.x knows
     libgcc helpers don't clobber r4-r7 and emits a smaller prologue;
     baserom keeps the full save. NAKED + NON_MATCHING. See
     `docs/codegen-notes.md` "Third unmatchable class".
   - Opcode-dispatch iterator (handler-table base kept callee-saved
     across an inner function-pointer BL) — fourth unmatchable class.
     Every m4a.c MPlayMain/MP2KPlayerMain in the corpus ships as
     hand-asm. NAKED + NON_MATCHING. See `docs/codegen-notes.md`
     "Fourth unmatchable class: opcode-dispatch iterator".
   - In-ROM libgcc helpers (`__divsi3` at 0x08033D14, `__pack_f` at
     0x0803401C, `__pack_d` at 0x080349D8, `_call_via_rX` at
     0x08033CD8, …). When a peeled range byte-matches
     `tools/agbcc/lib/libgcc.a`, link the exact archive member in
     `linker.ld`, add compatibility aliases only for existing
     `sub_XXXXXXXX` call sites, and delete any asm/C scaffolds. Do not
     attempt to decompile libgcc. See `docs/codegen-notes.md` "In-ROM
     libgcc helpers".
   - Every NAKED inline-asm block MUST end with `"    .syntax divided\n"` —
     the `.syntax unified` directive at the top of the block bleeds into the
     rest of the .o and breaks subsequent agbcc-emitted Thumb-1 instructions.
     See `docs/codegen-notes.md` "`.syntax unified` in NAKED inline asm bleeds".

6. **Move the asm.** Delete the `thumb_func_start <name>` block from
   `asm/disasm_0x*.s`. If the file becomes empty, remove its
   `linker.ld` entry too.

7. **Iterate to match.** The oracle is one command — reach for it FIRST,
   and don't reconstruct what it already does (objdump|diff, raw
   objdiff-cli, custom JSON parsing). It rebuilds incrementally and
   categorizes the diff off ROM byte-ranges.
   ```sh
   # Primary: whole-ROM compile + categorized per-instruction diff.
   python3 tools/agent/compile_and_view_assembly.py <name> --human
   # Function shipped NAKED? Diff its NON_MATCHING reference body instead:
   python3 tools/agent/compile_and_view_assembly.py <name> --non-matching --human

   # Fallback — fine-grained per-symbol objdiff (proper Thumb render) only
   # when the oracle says "nonmatching" but the function looks right (e.g.
   # suspected .rodata/alignment bleed). Needs expected/.o built first.
   python3 tools/agent/build_expected.py --fn <name>
   tools/agent/bin/objdiff-cli diff \
       -1 expected/src/<rel>.o -2 src/<rel>.o <name> --format json-pretty
   ```
   **Stuck on a fold? Search the corpus FIRST, permuter LAST.** Other
   agbcc decomps have almost certainly solved the same idiom — and the
   asm-as-incbin form gets deleted when they match, so the pattern only
   lives in git history. Two complementary searches:

   ```sh
   # (a) CURRENT-tree grep — fast, for C patterns / similar fn names.
   #     blob:none clones at ~/.cache/decomp-corpus (corpus.py sync once).
   python3 tools/agent/corpus.py grep '<regex>' --c       # C patterns
   python3 tools/agent/corpus.py decomps --name <prefix>  # similar fn names

   # (b) HISTORY search — THE asm-idiom analysis step. Finds the commit
   #     that REMOVED asm matching your idiom and shows the C it ADDED in
   #     the same commit (the exact asm<->C pairing). Operates on FULL
   #     mirrors (blobs) at tools/agent/corpus-mirrors/ (gitignored, ~1.4G;
   #     `corpus_asm_search.py sync --from <src>` to (re)populate).
   python3 tools/agent/corpus_asm_search.py search --asm '<asm-line-regex>' --require-c
   python3 tools/agent/corpus_asm_search.py search --idiom highreg-spread   # presets
   python3 tools/agent/corpus_asm_search.py show <repo>@<sha>               # read the C
   ```

   **How to run the (b) history search** (do it whenever agbcc emits a
   shape — a fold, a register spread/funnel, an addressing mode — you
   can't reproduce):
   1. Reduce the *target* asm idiom to a **register-agnostic** regex over
      asm lines (use char classes for regs: `r[0-7]`, `(r8|r9|sl)`). E.g.
      the funnel/spread case is `mov\s+r[0-7],\s*(r8|r9|sl)`. (`\s`/`\d`/`\w`/
      `\b` are auto-translated to POSIX ERE for the git pickaxe, so either the
      `\s` form or literal-space `mov +r[0-7], *(r8|r9|sl)` works.)
   2. `search --asm '<regex>' --require-c` — this hits **all 23 mirrors**
      by default (all agbcc, so any repo's C is usable) and sweeps them
      most-complete-first, so pret pokeemerald/firered/ruby and the big
      metroid/FE/tmc decomps (the most matched code = most idiom coverage)
      surface before the `--limit` runs out. Don't `--repo`-scope unless
      you have a reason — completeness, not publisher, is the leverage. (A
      same-publisher repo like cvaos = Konami can help with publisher
      conventions, but cvaos is incomplete, so it's a tiebreaker, not the
      primary.)
   3. For the most relevant hit, `show <repo>@<sha>` and read how their C
      produced that asm — then adapt that structure to your function.

   Worked example: `sub_08000430` (Init1) was blocked for two sessions
   on agbcc's adjacent-IWRAM-base CSE-fold. Manual variations got to
   byte_diff 22; permuter 15 min got 90 (worse). **3 minutes of
   corpus grep found the idiomatic answer** in `testyourmine/cvaos`
   — declare each base as a linker-assigned C symbol
   (`. = 0x00002CB0; gUnk_03002CB0 = .;` in `linker.ld`) instead of
   casting absolute addresses. First-try byte match on
   re-implementation. See `docs/codegen-notes.md` "Adjacent IWRAM
   bases — defeat CSE-fold via linker-assigned symbols".

   Caveat (from `sub_08017364`): the history search proves what's
   *reachable* (the spread idiom IS reproducible from plain unpinned C),
   but a near-match can still be a sharp register-coloring local minimum
   no single source shape escapes. When corpus + manual both stall on
   pure coloring, fall back to `vendor/decomp-permuter` from the
   near-matching base. Permuter mutates statement ordering and variable
   scope; it doesn't invent new idioms.

8. **Verify.** `make check` must exit 0 for a clean match. If it
   doesn't but per-function diff for your target is 0 and total
   `bytes_diff_rom` is low, the issue is bleed into adjacent functions
   (alignment, .rodata pool) — investigate that, don't abandon.

9. **If you can't match**: leave the asm in place. Don't ship a
   non-matching C that breaks `make check`. The `NON_MATCHING` pattern
   is acceptable only when wrapped behind the ifdef so the build still
   uses the asm.

### Permuter: when it pays off, how to run it, how to harvest

`vendor/decomp-permuter` is the last-mile tool for **register-coloring**
matches after corpus + manual structure stall (and for reaping
`register … asm("rN")` pins, task #14). Hard-won rules:

**Decide if it's worth a run BEFORE starting one** — the permuter mutates
C structure and hopes agbcc colours differently; it does not steer the
allocator directly, so its reach is uneven:
- ✅ **High-register *permutations***: agbcc already keeps the right values
  in r8/r9/sl but in a different order than the baserom. Relieve the
  pressure source (classic: make a spare `volatile` stack-temp non-volatile,
  or add/remove a spill) and it recolours — reaped `Entity_UpdateHitboxSlots`
  r8/r9 this way (the whole fix was "make `typeStack` non-volatile").
- ✅ **Structural diffs you SEED by hand first**: get the instruction *shape*
  right manually, then let the permuter finish the coloring. `Blit_ApplyFlaggedRecords`
  went byte_diff 114→27 by hand-adding a `volatile u32 x = (u32)ptr;` stack
  spill to match the baserom; the permuter then chips at the residual.
- ❌ **Pure low-register coloring** (a scalar agbcc deterministically parks
  in a different low reg: `sceneType→r2`, `rec→r5`): the permuter PLATEAUS
  every time — Scene_EntityTick / EntityHitbox_RegisterHitPoint / Mode4_BlitRect
  all stuck at 24–36k iters. **Keep the pin** (the function still matches with
  it — this is a reaping limit, not an "unmatchable" verdict; cf.
  codegen-notes "Permuter convergence audit").

**Run mechanics** (macOS has no `timeout`/`gtimeout`):
```sh
# base.c = your BEST manual near-match, NOT the naive de-pin. Keep load-bearing
# pins (reaping targets the MINIMAL pin set, not zero). pycparser chokes on
# expressions inside extended-asm operands — hoist them out:
#   u32 t = x << 24;  asm volatile("" : "=r"(o) : "0"(t));
python3 tools/agent/setup_permuter.py <Fn> --base nonmatchings/<Fn>/base.c
PERMUTER_PROJECT_ROOT=$PWD nohup vendor/decomp-permuter/.venv/bin/python \
  vendor/decomp-permuter/permuter.py nonmatchings/<Fn> -j5 --stop-on-zero \
  > /tmp/perm_<Fn>.log 2>&1 &       # poll the log; kill by hand when done
```
- **Run it LONG**: 35k+ iterations is normal — do NOT call a function resistant
  after a few hundred (that mistake costs a restart). It self-stops on score 0
  and writes `nonmatchings/<Fn>/output-0-*`. ~2 permuters at once on a 10-core
  box (`-j4`/`-j5` each); don't run foreground clean builds during a run.
- **Read the score** (it is NOT byte_diff): structural diffs (DELETION /
  INSERTION / REPLACEMENT) cost ~100 *each*; coloring (ARGUMENT_MISMATCH) far
  less. Score ≈ a small multiple of byte_diff ⇒ pure coloring (if it plateaus,
  it's the ❌ class). Score dominated by ×100 jumps ⇒ still structural ⇒ fix
  base.c by hand, don't just add iterations.
- **Iterate the base**: when it plateaus, fold the next structural insight into
  base.c and re-run `setup_permuter` from the closer base.

**Harvest — never paste the winner verbatim.** `output-0-*/source.c` is
pycparser-expanded and littered with `if (1) {}` / `do {} while (0)` / `new_var`
noise. Diff it against base.c, extract the **one essential mutation** (usually a
single change, e.g. a type/volatile flip or a split assignment), apply *that*
cleanly to the real src, then `make tidy && make -j8 && make check`.
`nonmatchings/` is gitignored, so scratch never reaches a commit.

### Subagent parallelism

Targets that are **truly independent** can run in parallel:
- Different `asm/disasm_*.s` files (so no merge conflicts on the asm side)
- Different destination `src/*.c` files
- Neither changes `linker.ld` or any header

Don't run more than ~4 subagents in parallel — each one's full build dominates
wall time. Serialize within a cluster, parallelize across clusters.

### The "is this making progress?" rule

For decomp passes: single number to watch is `asm_funcs_remaining` from
`progress.py`. Every accepted change should decrement it by ≥1. If it
stays the same after an attempted decomp, the change is either
non-matching (asm not removed) or broke the build (revert).

For data extraction passes: the equivalent number is the raw INCBIN byte
count in `progress_stats.py` (or equivalently, `database.json` entry
count). Every extraction pass should reduce the raw-INCBIN bytes and add
≥1 named entry to `database.json` — pointing at a typed C array in
`src/data/` or a per-system file, never at an anonymous `INCBIN_U8`
stub. Re-run `python3 tools/agent/progress_stats.py --update-readme`
after each pass; the README percentages are the public scoreboard, so
keep them current in the same commit that lands the work.

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

**Comments — write only when the WHY is non-obvious.** Default: no comment.
A future reader can read the code; what they can't read is the constraint
or context that forced the code to be this shape. Specifically:

- ✅ KEEP comments for:
  - **agbcc matching tricks** ("the local pointer var anchors the
    base-address load before the constant"; "two `t |= …` lines instead
    of `s->field |= 3` so agbcc emits two `orr` instructions").
  - **Layout constraints** ("two empty stubs kept as separate symbols so
    the surrounding layout stays byte-identical").
  - **Hardware/MMIO context** that's not in `include/gba/*.h` yet
    (e.g., "REG_DMA3.cnt = DMA_ENABLE | 0x400 covers IntrMain + sub_08000240
    + AgbMain — the whole low-ROM dispatcher cluster").
  - **Calling context** when not obvious from grep ("Called from Init1"
    on a leaf helper is fine; a one-line `gGameStuff.x = y` setter doesn't
    need it).

- ❌ STRIP comments that:
  - Narrate WHAT the code does in prose. The code says it once already.
    "Copies the handler into IWRAM" next to `memcpy(IWRAM, handler, n)`
    is filler.
  - Restate the function name in different words ("This function does X"
    for `DoX(…)`).
  - Refer to ephemeral state ("this is the third refactor", "TODO when
    we figure out subsystems"). PR descriptions and `docs/unknowns.md`
    are the right homes for those.
  - Annotate per-line magic numbers when the named constant exists or
    the value is one self-explanatory operation (`u8 mode = 3` doesn't
    need `/* set mode to 3 */`).

If a comment would say what the named constant says, use the constant
(add it to the right `include/gba/*.h` if it doesn't exist yet — see
"C style — Use named constants").

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
