#!/usr/bin/env python3
"""Lint that linker.ld blob ranges match the actual `.incbin` directives.

Friction observed across iters 4, 5, 6, and 7 (commits 843b857, 0e1d8eb,
b9f96eb, a054c65): data extraction passes that split an
`asm/text/text_0x*.s` blob into pre-table + tail-blob pieces are easy
to off-by-N when recomputing the new `.incbin "frog_us_baserom.gba",
<skip>, <count>` numbers. The wrong values build silently and only
surface at `make check` time as a cryptic ROM diff far from the actual
edit site.

This lint cross-checks each `asm/text/text_0x*.s` linker entry against
the file's `.incbin` directive:

  linker.ld: `asm/text/text_0xADDR.o(.text);  /* 0xADDR_LO - 0xADDR_HI, raw bytes */`
  the .s file:   `.incbin "frog_us_baserom.gba", <skip>, <count>`

Asserts:
  - The comment's ADDR_LO equals the file's `_0xADDR` name (sanity).
  - The .incbin's `<skip>` == ADDR_LO - 0x08000000 (file offset).
  - `<skip> + <count>` == ADDR_HI - 0x08000000 (next blob's file offset).

Exits 0 on clean tree; 4 on any mismatch. Same exit-code convention as
the other pre-commit lints (baserom=1, clang-format=2, apostrophe=3).

Run standalone via:

    python3 tools/agent/lint_blob_boundaries.py

Wire into scripts/pre-commit as step 4 once verified.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
LINKER = ROOT / "linker.ld"
ROM_BASE = 0x08000000

# Match linker.ld lines of the form:
#   asm/text/text_0xADDR.o(.text);  /* 0xADDR_LO - 0xADDR_HI, raw bytes */
LINKER_TEXT_BLOB_RE = re.compile(
    r"^\s*asm/text/text_0x(?P<filename_addr>[0-9a-fA-F]+)\.o\(\.text\);\s*"
    r"/\*\s*0x(?P<lo>[0-9a-fA-F]+)\s*-\s*0x(?P<hi>[0-9a-fA-F]+)"
)

# Match the .incbin line inside an asm/text/*.s file:
#   .incbin "frog_us_baserom.gba", 0xSKIP, 0xCOUNT
INCBIN_RE = re.compile(
    r'^\s*\.incbin\s+"(?:frog_us_baserom\.gba|baserom\.gba)"\s*,\s*'
    r"0x(?P<skip>[0-9a-fA-F]+)\s*,\s*0x(?P<count>[0-9a-fA-F]+)"
)


def lint() -> int:
    failures: list[tuple[str, str]] = []

    try:
        lines = LINKER.read_text().splitlines()
    except OSError as e:
        print(f"ERROR: can't read {LINKER}: {e}", file=sys.stderr)
        return 4

    for lineno, line in enumerate(lines, start=1):
        m = LINKER_TEXT_BLOB_RE.search(line)
        if not m:
            continue

        filename_addr = int(m.group("filename_addr"), 16)
        lo = int(m.group("lo"), 16)
        hi = int(m.group("hi"), 16)

        # Sanity: the filename's address should equal the comment's lo.
        if filename_addr != lo:
            failures.append((
                f"linker.ld:{lineno}",
                f"filename text_0x{filename_addr:x} disagrees with comment "
                f"0x{lo:08x}-0x{hi:08x}",
            ))
            continue

        # Sanity: the range should be in the ROM-VMA range.
        if not (ROM_BASE <= lo < hi <= ROM_BASE + 0x400000):
            failures.append((
                f"linker.ld:{lineno}",
                f"range 0x{lo:08x}-0x{hi:08x} is outside ROM",
            ))
            continue

        # Open the .s file and check the .incbin directive.
        s_path = ROOT / f"asm/text/text_0x{filename_addr:08x}.s"
        # Tolerate filenames without leading zeros (e.g., text_0x80c0000.s).
        if not s_path.exists():
            alt = ROOT / f"asm/text/text_0x{filename_addr:x}.s"
            if alt.exists():
                s_path = alt
            else:
                failures.append((
                    f"linker.ld:{lineno}",
                    f"linker entry references {s_path.relative_to(ROOT)} but no such file",
                ))
                continue

        try:
            content = s_path.read_text()
        except OSError as e:
            failures.append((str(s_path), f"can't read: {e}"))
            continue

        # Find .incbin line(s). Tolerate multiple (some hand-edited slices
        # have header + body INCBINs); check that the LAST one extends to
        # the expected hi address. If there are multiple, also check the
        # earlier ones don't exceed.
        incbin_lines = []
        for sline_no, sline in enumerate(content.splitlines(), start=1):
            mm = INCBIN_RE.match(sline)
            if mm:
                incbin_lines.append((
                    sline_no,
                    int(mm.group("skip"), 16),
                    int(mm.group("count"), 16),
                ))

        if not incbin_lines:
            failures.append((
                f"{s_path.relative_to(ROOT)}",
                f"no .incbin directive found, but linker.ld:{lineno} expects bytes",
            ))
            continue

        # Sum the .incbin ranges and check coverage of [lo, hi).
        # Each incbin must use 'frog_us_baserom.gba' as source so skip is
        # an in-ROM file offset.
        expected_skip = lo - ROM_BASE
        expected_end = hi - ROM_BASE

        if len(incbin_lines) == 1:
            sline_no, skip, count = incbin_lines[0]
            if skip != expected_skip:
                failures.append((
                    f"{s_path.relative_to(ROOT)}:{sline_no}",
                    f".incbin skip 0x{skip:x} does not match expected file offset "
                    f"0x{expected_skip:x} (= ROM addr 0x{lo:08x} - 0x08000000)",
                ))
            if skip + count != expected_end:
                failures.append((
                    f"{s_path.relative_to(ROOT)}:{sline_no}",
                    f".incbin extends 0x{skip:x}..0x{skip+count:x}; linker.ld "
                    f"declares 0x{lo:08x}..0x{hi:08x} (file offsets "
                    f"0x{expected_skip:x}..0x{expected_end:x}). "
                    f"Off-by-0x{abs((skip+count) - expected_end):x}.",
                ))
        else:
            # Multiple .incbin (rare; conservative check: first must start
            # at expected_skip, last must end at expected_end, and they
            # must form a contiguous run).
            first_skip = incbin_lines[0][1]
            last_end = incbin_lines[-1][1] + incbin_lines[-1][2]
            if first_skip != expected_skip:
                failures.append((
                    f"{s_path.relative_to(ROOT)}",
                    f"first .incbin skip 0x{first_skip:x} != expected 0x{expected_skip:x}",
                ))
            if last_end != expected_end:
                failures.append((
                    f"{s_path.relative_to(ROOT)}",
                    f"last .incbin ends at 0x{last_end:x} != expected 0x{expected_end:x}",
                ))
            # Check contiguity.
            for i in range(len(incbin_lines) - 1):
                this_end = incbin_lines[i][1] + incbin_lines[i][2]
                next_start = incbin_lines[i + 1][1]
                if this_end != next_start:
                    failures.append((
                        f"{s_path.relative_to(ROOT)}",
                        f".incbin lines {incbin_lines[i][0]}+{incbin_lines[i+1][0]}: "
                        f"gap between 0x{this_end:x} and 0x{next_start:x}",
                    ))

    if not failures:
        return 0

    print(f"ERROR: blob-boundary mismatch in {len(failures)} place(s):", file=sys.stderr)
    print(file=sys.stderr)
    for where, msg in failures:
        print(f"  {where}: {msg}", file=sys.stderr)
    print(file=sys.stderr)
    print("Each text_0xADDR.o linker entry must have:", file=sys.stderr)
    print("  - file name matches the address in the comment", file=sys.stderr)
    print("  - .incbin skip == (comment_lo - 0x08000000)", file=sys.stderr)
    print("  - .incbin skip + count == (comment_hi - 0x08000000)", file=sys.stderr)
    print(file=sys.stderr)
    print("Recompute the .incbin numbers carefully; off-by-0x1000 is the most", file=sys.stderr)
    print("common form. See docs/codegen-notes.md \"`.incbin` second arg is", file=sys.stderr)
    print("FILE OFFSET\".", file=sys.stderr)
    return 4


if __name__ == "__main__":
    sys.exit(lint())
