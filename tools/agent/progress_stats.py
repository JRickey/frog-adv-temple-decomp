#!/usr/bin/env python3
"""Compute project-wide decomp + data-extraction progress stats.

Two coupled headline numbers:
 - Function count progress: how much of the .text (code) has been moved
   into C, normalized against an estimated total function count derived
   from a Thumb function-prologue scan over the code region.
 - Data extraction progress: how many bytes of the 4 MB ROM have been
   extracted out of the raw INCBIN blobs into typed C / `database.json`
   entries, normalized against the data region size.

Run with `--update-readme` to also patch the "## Progress" section of
README.md in place. Run with `--json` for machine-readable output.

The function-count estimate is heuristic — see `--explain` for the
methodology and known caveats. Treat all percentages as ±20% honest
estimates, not promises.
"""

from __future__ import annotations

import argparse
import json
import re
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
LINKER = ROOT / "linker.ld"
README = ROOT / "README.md"
DATABASE_JSON = ROOT / "database.json"

ROM_BASE = 0x08000000
ROM_SIZE = 4 * 1024 * 1024  # 4 MiB

# Heuristic: end of executable code in this ROM. Derived from the highest
# in-ROM Thumb BL target seen during the prologue scan (0x08035d94 at the
# time of writing). Round up to the next 4-byte slot so we err generously.
CODE_END_GUESS = 0x08036000


@dataclass
class FunctionCounts:
    decomped_c: int            # function defs in src/**/*.c
    peeled_asm: int            # asm/disasm_*.s slices not yet in C
    strong_signal_total: int   # lower bound: 4B-aligned `push {…,lr}` preceded by clean fn-end
    aligned_total: int         # upper bound: all 4B-aligned `push {…,lr}` in code region
    arm_total: int             # ARM `stmfd sp!, {…,lr}` count
    estimate_total: int        # realistic estimate (midpoint, capped)

    @property
    def landed(self) -> int:
        return self.decomped_c

    @property
    def identified(self) -> int:
        return self.decomped_c + self.peeled_asm


@dataclass
class DataStats:
    raw_blob_bytes: int        # total bytes in asm/text/text_0x*.s INCBINs
    asm_slice_bytes: int       # total bytes in asm/disasm_*.s slices
    src_text_bytes: int        # total bytes in src/**/*.c (.text contribution)
    database_entries: int      # len(database.json)
    code_region_size: int = CODE_END_GUESS - ROM_BASE
    rom_size: int = ROM_SIZE

    @property
    def total_text(self) -> int:
        return self.raw_blob_bytes + self.asm_slice_bytes + self.src_text_bytes

    @property
    def data_region_size(self) -> int:
        return self.rom_size - self.code_region_size


def parse_linker_ranges() -> tuple[int, int, int]:
    """Sum the byte counts of asm/text/, asm/disasm_*, and src/ entries in linker.ld."""
    raw = asm = src = 0
    range_re = re.compile(
        r"^\s*(?P<kind>asm/text/text_0x[0-9a-f]+|asm/disasm_0x[0-9a-f]+|src/[^.]+)\.o\(\.(?:text|rodata)\);"
        r"\s*/\*\s*0x(?P<lo>[0-9a-f]+)\s*-\s*0x(?P<hi>[0-9a-f]+)"
    )
    with LINKER.open() as f:
        for line in f:
            m = range_re.search(line)
            if not m:
                continue
            size = int(m.group("hi"), 16) - int(m.group("lo"), 16)
            kind = m.group("kind")
            if kind.startswith("asm/text/text"):
                raw += size
            elif kind.startswith("asm/disasm_"):
                asm += size
            else:
                src += size
    return raw, asm, src


def count_c_functions() -> int:
    """Count top-level function definitions across src/**/*.c."""
    fn_def_re = re.compile(r"^[A-Za-z_][\w\s\*]*\s+[A-Za-z_]\w*\s*\([^)]*\)\s*$")
    n = 0
    for p in ROOT.glob("src/**/*.c"):
        try:
            for line in p.read_text().splitlines():
                if fn_def_re.match(line) and "typedef" not in line and "#" not in line:
                    n += 1
        except UnicodeDecodeError:
            continue
    return n


def count_peeled_asm() -> int:
    """Count asm/disasm_*.s files (= peeled-but-not-yet-C functions)."""
    return sum(1 for _ in ROOT.glob("asm/disasm_0x*.s"))


def scan_function_prologues() -> tuple[int, int, int]:
    """Scan the code region for Thumb/ARM function-start prologues.

    Returns (strong_signal, aligned_total, arm_count).

    - strong_signal: 4B-aligned `push {…,lr}` (b5XX) preceded by a clean
      function-end marker (`bx lr`, `pop {…,pc}`, NOP padding, or zero
      padding). Lower-bound function count.
    - aligned_total: every 4B-aligned `push {…,lr}` in the code region.
      Upper bound — includes some byte-pattern collisions and switch-table
      blocks that aren't real function starts.
    - arm_count: ARM `stmfd sp!, {…,lr}` (e92d4XXX).
    """
    rom = BASEROM.read_bytes()
    strong = aligned = arm = 0
    bxlr = 0x4770
    poppc_mask = 0xff00
    poppc_val = 0xbd00
    nop = 0x46c0
    pad = 0x0000

    end = CODE_END_GUESS - ROM_BASE

    # Thumb scan
    for i in range(0xC0, end - 2, 2):
        if rom[i + 1] == 0xB5 and i % 4 == 0:
            aligned += 1
            if i >= 2:
                prev = (rom[i - 1] << 8) | rom[i - 2]
                if prev == bxlr or (prev & poppc_mask) == poppc_val or prev == nop or prev == pad:
                    strong += 1

    # ARM scan (e92d4XXX little-endian: XX 4X 2d e9)
    for i in range(0xC0, end - 4, 4):
        if rom[i + 3] == 0xE9 and rom[i + 2] == 0x2D and (rom[i + 1] & 0xF0) == 0x40:
            arm += 1

    return strong, aligned, arm


def gather_stats() -> tuple[FunctionCounts, DataStats]:
    raw_bytes, asm_bytes, src_bytes = parse_linker_ranges()
    db_entries = 0
    if DATABASE_JSON.exists():
        try:
            db_entries = len(json.loads(DATABASE_JSON.read_text()))
        except json.JSONDecodeError:
            db_entries = 0

    strong, aligned, arm = scan_function_prologues()
    # Midpoint between strong (lower bound) and aligned*0.6 (upper bound minus
    # known collision fudge — switch tables, BL stubs, etc account for ~40%
    # of the aligned count empirically on similar GBA titles). Clamped to
    # [strong, aligned].
    estimate = max(strong, min(aligned, (strong + int(aligned * 0.6)) // 2 + arm))

    fns = FunctionCounts(
        decomped_c=count_c_functions(),
        peeled_asm=count_peeled_asm(),
        strong_signal_total=strong,
        aligned_total=aligned,
        arm_total=arm,
        estimate_total=estimate,
    )
    data = DataStats(
        raw_blob_bytes=raw_bytes,
        asm_slice_bytes=asm_bytes,
        src_text_bytes=src_bytes,
        database_entries=db_entries,
    )
    return fns, data


def fmt_pct(num: int, denom: int) -> str:
    return f"{(num / denom * 100) if denom else 0:.1f}%"


def fmt_bytes(n: int) -> str:
    if n < 1024:
        return f"{n} B"
    if n < 1024 * 1024:
        return f"{n / 1024:.1f} KiB"
    return f"{n / (1024 * 1024):.2f} MiB"


def render_human(fns: FunctionCounts, data: DataStats) -> str:
    out = []
    out.append("Progress (estimates; recompute after every landed pass)")
    out.append("=" * 60)
    out.append("")
    out.append("Functions (code region [0x08000000, 0x{:08x})):".format(CODE_END_GUESS))
    out.append(f"  decomped to C       : {fns.decomped_c}")
    out.append(f"  peeled to asm slice : {fns.peeled_asm}")
    out.append(f"  estimated TOTAL     : {fns.estimate_total} "
               f"(range {fns.strong_signal_total} … {fns.aligned_total + fns.arm_total})")
    out.append(f"  → decomp progress   : {fmt_pct(fns.decomped_c, fns.estimate_total)} "
               f"(of estimated total)")
    out.append("")
    out.append("Data / bytes (whole ROM = 4 MiB):")
    out.append(f"  raw INCBIN blobs    : {fmt_bytes(data.raw_blob_bytes)} "
               f"({fmt_pct(data.raw_blob_bytes, data.rom_size)} of ROM)")
    out.append(f"  asm slices          : {fmt_bytes(data.asm_slice_bytes)}")
    out.append(f"  src C .text         : {fmt_bytes(data.src_text_bytes)}")
    out.append(f"  database.json entries: {data.database_entries}")
    out.append(f"  → data deblob       : {fmt_pct(data.rom_size - data.raw_blob_bytes, data.rom_size)} "
               f"(non-blob ROM coverage)")
    return "\n".join(out)


# README "## Progress" section markers.
README_BEGIN = "<!-- BEGIN PROGRESS (managed by tools/agent/progress_stats.py) -->"
README_END = "<!-- END PROGRESS -->"


def render_readme_section(fns: FunctionCounts, data: DataStats) -> str:
    """Markdown block that replaces the BEGIN/END region in README.md."""
    decomp_pct = fns.decomped_c / fns.estimate_total * 100 if fns.estimate_total else 0
    blob_pct = data.raw_blob_bytes / data.rom_size * 100
    deblob_pct = 100 - blob_pct
    lines = [
        README_BEGIN,
        "",
        "**All figures are estimates** — the function-count denominator is a",
        "Thumb prologue scan, not a ground-truth disassembly. Treat ±20% as honest.",
        "Regenerate with `python3 tools/agent/progress_stats.py --update-readme`.",
        "",
        f"- **Functions decompiled to C**: {fns.decomped_c} / ~{fns.estimate_total} "
        f"estimated total (**{decomp_pct:.1f}%**)",
        f"  - peeled-but-still-asm: {fns.peeled_asm}",
        f"  - estimate range (lower / upper): {fns.strong_signal_total} / "
        f"{fns.aligned_total + fns.arm_total}",
        f"- **Data deblobbed**: {fmt_bytes(data.rom_size - data.raw_blob_bytes)} "
        f"of {fmt_bytes(data.rom_size)} (**{deblob_pct:.2f}%**)",
        f"  - raw INCBIN bytes: {fmt_bytes(data.raw_blob_bytes)} "
        f"({blob_pct:.1f}% of ROM)",
        f"  - `database.json` entries: {data.database_entries}",
        "",
        "Code occupies roughly [0x08000000, 0x{:08x}) (~{}). Past that the".format(
            CODE_END_GUESS, fmt_bytes(CODE_END_GUESS - ROM_BASE)),
        "ROM is graphics, audio, level/script data, and lookup tables.",
        "",
        README_END,
    ]
    return "\n".join(lines)


def patch_readme(fns: FunctionCounts, data: DataStats) -> bool:
    """Replace the README progress block. Returns True if the file changed."""
    text = README.read_text()
    new_block = render_readme_section(fns, data)
    if README_BEGIN in text and README_END in text:
        # Replace existing block (line-anchored, includes trailing newline).
        pattern = re.compile(
            re.escape(README_BEGIN) + r".*?" + re.escape(README_END),
            re.DOTALL,
        )
        new_text = pattern.sub(new_block, text)
    else:
        # First-time install: replace the "## Status" section if present,
        # otherwise insert just before "## Contributing".
        if re.search(r"^## Status$", text, re.MULTILINE):
            new_text = re.sub(
                r"^## Status\n.*?(?=^## )",
                "## Progress\n\n" + new_block + "\n\n",
                text,
                count=1,
                flags=re.DOTALL | re.MULTILINE,
            )
        else:
            new_text = text.replace(
                "## Contributing",
                "## Progress\n\n" + new_block + "\n\n## Contributing",
            )
    if new_text == text:
        return False
    README.write_text(new_text)
    return True


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--json", action="store_true", help="emit JSON instead of human text")
    ap.add_argument("--update-readme", action="store_true", help="patch README.md in place")
    ap.add_argument("--explain", action="store_true", help="print methodology and exit")
    args = ap.parse_args()

    if args.explain:
        print(__doc__)
        return

    fns, data = gather_stats()

    if args.json:
        print(json.dumps({
            "functions": {
                "decomped_c": fns.decomped_c,
                "peeled_asm": fns.peeled_asm,
                "estimate_total": fns.estimate_total,
                "strong_signal_lower": fns.strong_signal_total,
                "aligned_upper": fns.aligned_total + fns.arm_total,
            },
            "data": {
                "raw_blob_bytes": data.raw_blob_bytes,
                "asm_slice_bytes": data.asm_slice_bytes,
                "src_text_bytes": data.src_text_bytes,
                "database_entries": data.database_entries,
                "rom_size": data.rom_size,
                "code_end_guess": CODE_END_GUESS,
            },
        }, indent=2))
        return

    print(render_human(fns, data))

    if args.update_readme:
        changed = patch_readme(fns, data)
        print()
        print(f"README.md: {'updated' if changed else 'no change needed'}")


if __name__ == "__main__":
    main()
