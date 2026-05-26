<!--
  Data-agent playbook. Reference this file from one-shot agent briefs:

      "You are a data agent. Playbook: tools/agent/prompts/data.md.
       This pass's charter: <N> entries / <region>. Notes specific to
       this pass: …"

  This file lives in the repo (not in `.claude/skills/`) because it is
  agent-facing — passed to subagents in dispatch briefs, not invoked by
  the user.

  Last verified: commit de99d1d. Update the "last verified" line in every
  PR that materially changes the playbook.
-->

# Data agent playbook

## Goal

Convert raw INCBIN bytes from the still-blob region of the ROM into
**typed, named C arrays** in `src/data/*.c`, with each extraction
backed by a `database.json` entry. Every entry needs a meaningful name
and a typed C symbol — anonymous `INCBIN_U8("data/blob_XXXX.bin")`
stubs are forbidden.

Success criterion: `make check` exits 0 after every table you add AND
the `progress_stats.py` scoreboard moves in the right direction
(raw INCBIN bytes ↓, `database.json` entries ↑, `src/data/` text ↑).

A typical pass lands 10-30 named tables and 5-25 KiB extracted. Quality
over quantity — a single well-named, well-typed, well-placed table
beats five `Foo_3953c8` placeholders. The exception: a long mechanical
run of uniform-shape records (e.g., DMA load records, animation
descriptors) can ship at higher volume because the per-table reasoning
collapses.

## Setup reading (in this order)

1. `git log --oneline -10` — recent data commits. Note any new patterns
   landed since this playbook was "Last verified" at top of file.
2. The previous data-pass commit message — it almost certainly lists
   deferred targets and untouched regions. Those are your candidate
   pool unless the dispatch brief redirects you.
3. `tools/extractor.py` (top half) — the `database.json` schema and
   the **critical** gotcha that `addr` is a ROM file offset, NOT a
   ROM address. Strip `0x08000000` in every entry.
4. `tools/agent/refcount_pool_loads.py` — the anchor-finder tool.
   Default human output ranks ROM addresses by pool-load reference
   count. `--pending-only` filters out already-EXTRACTED/NAMED. This is
   how you pick anchors when the dispatch brief doesn't name them.
5. `docs/codegen-notes.md` — the data-relevant sections:
   - "`(.rodata)` pull trick"
   - "Apostrophes in C comments break `tools/preproc`"
6. `src/data/` — read 2-3 existing files to learn the project's
   typing style (`u32[N]` for unknown blobs, literal C array for
   known-MMIO/pointer tables, INCBIN+typed-cast for byte blobs).

## Workflow (per pass)

1. **Pick anchors.** If the dispatch brief gives you addresses, work
   from those. Otherwise run:
   ```sh
   python3 tools/agent/refcount_pool_loads.py --pending-only | head -25
   ```
   Top entries with `--threshold 5` are charter-grade anchors.
   Adjacent same-region entries usually belong to one structural
   cluster — extract the cluster as one coherent C file.

2. **Per table — inspect the bytes.** Use objdump:
   ```sh
   arm-none-eabi-objdump -D -b binary -m arm7tdmi \
     --start-address=0x... --stop-address=0x... frog_us_baserom.gba
   ```
   Determine type (u8 / u16 / u32 / struct / function-pointer table),
   count, and end boundary. Boundaries usually mark themselves with
   alignment padding (`0x00` or `0xff` runs), a shape change, or a
   sentinel record. When in doubt, check the consuming asm via grep
   to see what stride/offset the consumer expects.

3. **Per table — name it.** Cross-reference the consuming code to
   infer purpose. Names like `sNoteRatioTable`, `sChannelRegTable`,
   `sSpriteAssetIndexTable` are good. `sUnknownSoundLut_82F8DE0` is
   an acceptable temporary placeholder ONLY when you've examined
   the consumer and genuinely can't infer — and only with a
   `/* TODO: confirm purpose after sub_XXXX lands in C */` comment.

4. **Per table — extract.**
   - Add a `database.json` entry. **Strip `0x08000000`** from the
     `addr` (file offset, not ROM address).
     ```json
     { "path": "sound/wave_vol_lut.bin",
       "addr": { "us": "0x3DDA3C" },
       "count": "0x10", "size": 1 }
     ```
   - Drop typed C into `src/data/<thematic>.c`. Group related tables
     in one file (`src/data/sound_tables.c`,
     `src/data/sprite_dispatch.c`) — don't make 20 separate files.
   - For binary blobs: `const T sFoo[N] = INCBIN_U8/U16/U32("data/<path>.bin");`
     The `INCBIN_*` macros are in `include/macros.h`. Use the variant
     that matches element width.
   - For MMIO pointer tables or other known-semantics arrays: prefer
     a literal C array, no INCBIN. Example: `sChannelRegTable[4] = { (vu16 *)0x04000062, … };`
   - Use `const` where the data is read-only. agbcc emits `const`
     arrays to `.rodata` — see step 5.

5. **Wire into `linker.ld`.** Split the enclosing
   `asm/text/text_0x*.s` blob. The pattern (from `14eec4d`):
   - Shrink the upstream blob: edit its `.incbin "frog_us_baserom.gba",
     <skip>, <count>` to end at your table's start address.
   - Add your `src/data/<file>.o(.rodata)` entry. **Use `.rodata` not
     `.text`** — agbcc emits `const` arrays to `.rodata` by default,
     and the linker pulls them into the `.text` SECTIONS region
     transparently when you write `.o(.rodata)`. Writing `.o(.text)`
     produces an empty object.
   - Add a new downstream blob: create
     `asm/text/text_0x<end_addr>.s` that starts at your table's end
     address and runs to the next existing boundary.

6. **Verify after every table.**
   ```sh
   make -j8 && make check                # must stay OK
   ```
   If `make check` fails, the table boundary or type is wrong — back
   it out and re-inspect. Never ship a broken extraction; never use
   `--no-verify`.

7. **Promote address-named symbols in already-landed C files.** If
   a landed `src/system/foo.c` has a `#define sFooTable
   ((T *)0x08...)` or a hard-coded `(void *)0x08...` literal that
   resolves to a table you just extracted, replace it with an
   `extern` against the new typed symbol. Same byte output, killed
   magic number. (Commit `14eec4d` did this for `0x08035DB4` →
   `&sIrqHandlerTable[6]`.)

8. **Every ~5 tables, refresh the scoreboard.**
   ```sh
   python3 tools/agent/progress_stats.py --update-readme
   ```
   The README's `## Progress` block is the public scoreboard;
   include the regen in the same commit that lands the work.

## Decision tree

- **Anchor falls inside the code region** `[0x08000000, 0x08036000)`:
  it's a function pointer or label, not a data table. Skip — the
  decomp agent owns that.
- **Anchor falls in a uniform-shape region** (long run of 16-byte
  records etc.): extract the entire run as one typed array. Don't
  fragment by sub-boundaries unless the consuming code branches on
  them (e.g., a magic-value sentinel).
- **Anchor's purpose unclear from local context**: do a quick
  `grep -rn '0x<addr>' asm/` to find every load site, then look at
  the surrounding instructions to infer entry shape (`ldr` then
  `+ #N` stride = entry size, `<< N` shift = index granularity).
  If still unclear, name conservatively with a `_Unknown` prefix +
  TODO comment and proceed.
- **Multiple adjacent anchors in the refcount output**: they're
  almost always one logical cluster. Extract together, name from the
  cluster's purpose (e.g., `sSpriteAnimBlock_06838` for an
  intermediate-shape table inside the anim block).
- **A table extends past the next anchor in the refcount list**:
  the inner anchor is probably a sub-entry pointer, not a separate
  table. Common for dispatch tables that reference their own data
  rows. Extract the outer table; the inner pointer resolves
  automatically through `.rodata`.
- **An anchor falls in audio sample data** `[0x083d0000, 0x083dda1c)`
  or similar: skip unless the dispatch brief specifically asks. Audio
  samples need a different workflow (encoder/decoder, sample
  metadata structs) — separate pass.
- **An anchor falls in tile/sprite pixel data**: skip unless the
  dispatch brief asks. Same reasoning — encoder-needed work.

## Common pitfalls

- **`database.json` `addr` is a ROM file offset.** `0x083dda3c` seeks
  past EOF silently and produces a 0-byte file. Strip `0x08000000`:
  `"0x3dda3c"`.
- **agbcc emits `const` arrays to `.rodata`.** Pull with
  `src/data/foo.o(.rodata)` in linker.ld, not `(.text)`.
- **Apostrophes in `/* */` comments** in INCBIN-using C files break
  `tools/preproc` silently — single `'s`/`don't` swallows every
  subsequent INCBIN in the file. Pre-commit guard catches it; avoid
  in the first place by using `’` (U+2019, typographic) or
  rephrasing the comment.
- **Outer-`const` on volatile pointer arrays** breaks compilation.
  `vu16 *const sChannelRegTable[4]` is correct (array of vu16*const,
  the data behind each pointer is MMIO and volatile). `const vu16
  *const` errors with "incompatible pointer type" on the existing
  assignment sites.
- **Splitting an asm/text blob mid-table** loses bytes. The shrunk
  blob's `.incbin` end address MUST equal your table's start; the
  new tail blob's `.incbin` start MUST equal your table's end. Off-
  by-one here is the most common cause of a post-pass `make check`
  failure.
- **Coordinate with parallel agents.** Use precise `Edit` on
  `linker.ld` (with surrounding context lines), not `replace_all`,
  so a parallel decomp agent's edits in a different address range
  don't conflict.

## Output (final report)

When you finish, tell the user:

1. **Count and total bytes** of tables extracted this pass.
2. **Updated scoreboard** from `progress_stats.py --update-readme`
   (DB entries, deblob %).
3. **Table-by-table list**: address / size / type / name / file /
   consumer-context notes.
4. **Renames** of previously-extracted `_Unknown*` symbols (if any)
   triggered by consumer-code grep revealing semantic intent.
5. **New gotchas/discoveries** worth a `docs/codegen-notes.md` or
   `docs/tooling.md` follow-up — format as `TODO note for docs/...:`
   lines.
6. **Untouched** in the prioritized regions, with reasons (size,
   ambiguous boundaries, missing consumer context).

## Hard constraints (apply to every dispatch)

- **NO leaked Konami source.** Inspect bytes via objdump only.
- **NEVER edit** `frog_us.sha1`, `baserom.gba`, `frog_us_baserom.gba`.
- **NEVER `git commit` or `git push`** — leave staged. The user
  reviews every landing.
- **NEVER skip pre-commit hooks** (`--no-verify`). Apostrophe guard
  is the latest addition; clang-format runs too. If either complains,
  fix the file and re-stage.
- **No anonymous extractions.** Every entry gets a meaningful name
  and type. `_Unknown` placeholders are OK only with a TODO
  comment + consumer-code citation.
