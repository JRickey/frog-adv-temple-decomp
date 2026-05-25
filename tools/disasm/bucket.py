#!/usr/bin/env python3
"""Split the next address-aligned chunk off asm/rom.s into its own bucket file.

asm/rom.s INCBINs a contiguous tail of the baserom (whatever hasn't been
peeled into asm/disasm_*.s function slices yet). This script peels the
*next* aligned chunk off the front of that tail into
asm/text/text_0xNNNNNNNN.s, updates rom.s to start at the new boundary,
inserts a linker.ld entry, and (unless --no-verify) runs `make check` to
confirm the build still matches the baserom.

Goal: turn a 4MB opaque blob into organized address-bucketed files
WITHOUT changing any output bytes. Future per-function peels slot
cleanly between buckets in linker.ld.

Exit codes:
  0  one bucket peeled, build still matches
  1  failure (couldn't parse, build broke, etc.)
  2  nothing left to peel (asm/rom.s already empty / fully drained)
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
ROM_S = ROOT / "asm" / "rom.s"
TEXT_DIR = ROOT / "asm" / "text"
LINKER_LD = ROOT / "linker.ld"

ROM_BASE = 0x08000000
DEFAULT_BUCKET = 0x10000  # 64KB

# .incbin "frog_us_baserom.gba", 0xNN[, 0xMM]
INCBIN_RE = re.compile(
    r'(?P<lead>\.incbin\s+"[^"]+",\s*)'
    r'(?P<skip>0x[0-9a-fA-F]+|\d+)'
    r'(?P<rest>(?:\s*,\s*(?P<count>0x[0-9a-fA-F]+|\d+))?)'
)

# linker.ld line for the rom.o blob, e.g.:
#   asm/rom.o(.text);                /* 0x080000C0 onward, still unparsed */
ROM_O_LINE_RE = re.compile(
    r'^(?P<indent>\s*)asm/rom\.o\(\.text\);.*$', re.MULTILINE
)


def _hex(addr: int) -> str:
    return f"0x{addr:08x}"


def parse_rom_s() -> tuple[int, int | None, str] | None:
    """Return (skip, count_or_None, full_text), or None if rom.s is gone."""
    if not ROM_S.exists():
        return None
    text = ROM_S.read_text()
    m = INCBIN_RE.search(text)
    if not m:
        sys.exit(f"ERROR: no .incbin found in {ROM_S}")
    skip = int(m.group("skip"), 0)
    count = int(m.group("count"), 0) if m.group("count") else None
    return skip, count, text


def baserom_size() -> int:
    if not BASEROM.exists():
        sys.exit(f"ERROR: {BASEROM.name} missing (symlink not set up?)")
    return BASEROM.stat().st_size


def compute_bucket(skip: int, size: int, rom_size: int) -> tuple[int, int]:
    """Return (next_skip, bucket_bytes) for the next aligned bucket.

    Aligns *up* from `skip` to the next multiple of `size`. The first call
    (skip=0xC0) gives a partial bucket [0xC0, 0x10000). All subsequent calls
    give full `size`-byte buckets except possibly the very last.
    """
    next_boundary = ((skip // size) + 1) * size
    next_boundary = min(next_boundary, rom_size)
    if next_boundary <= skip:
        sys.exit(f"ERROR: bucket size {size:#x} produced no progress from {skip:#x}")
    return next_boundary, next_boundary - skip


def bucket_filename(start_addr: int) -> Path:
    return TEXT_DIR / f"text_{_hex(start_addr)}.s"


def bucket_symbol(start_addr: int) -> str:
    return f"text_{start_addr:08x}"


def emit_bucket_file(path: Path, start_addr: int, end_addr: int) -> None:
    file_off = start_addr - ROM_BASE
    nbytes = end_addr - start_addr
    sym = bucket_symbol(start_addr)
    body = f"""@ Auto-emitted by tools/disasm/bucket.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [{_hex(start_addr)}, {_hex(end_addr)})  ({nbytes:#x} bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.
@ As individual functions are identified and peeled out into
@ asm/disasm_0xADDR.s slices, they will appear in linker.ld between
@ this bucket and its neighbours, at their correct baserom addresses.

        .section .text, "ax", %progbits
        .align  2
        .global {sym}
        .type   {sym}, %object
{sym}:
        .incbin "frog_us_baserom.gba", {_hex(file_off)}, {_hex(nbytes)}
        .size   {sym}, . - {sym}
"""
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(body)


def rewrite_rom_s(text: str, new_skip: int, rom_size: int) -> str | None:
    """Return new rom.s text with INCBIN skip advanced to new_skip.

    If new_skip >= rom_size, return None to signal the file should be
    deleted entirely.
    """
    if new_skip >= rom_size:
        return None

    def _sub(m: re.Match) -> str:
        # Preserve "count" if present, otherwise leave it off (= read to EOF).
        if m.group("count") is not None:
            new_count = rom_size - new_skip
            return f"{m.group('lead')}{_hex(new_skip)}, {_hex(new_count)}"
        return f"{m.group('lead')}{_hex(new_skip)}{m.group('rest')}"

    new_text, n = INCBIN_RE.subn(_sub, text, count=1)
    if n != 1:
        sys.exit("ERROR: failed to rewrite INCBIN in asm/rom.s")
    return new_text


def insert_linker_entry(start_addr: int, end_addr: int, rom_dropped: bool) -> None:
    """Insert the new bucket .o(.text) line immediately before the asm/rom.o
    line. If rom_dropped is True, also remove the asm/rom.o line."""
    text = LINKER_LD.read_text()
    m = ROM_O_LINE_RE.search(text)
    if not m:
        sys.exit("ERROR: could not find 'asm/rom.o(.text);' line in linker.ld")
    indent = m.group("indent")
    bucket_path = bucket_filename(start_addr).relative_to(ROOT).as_posix()
    obj_path = bucket_path[:-2] + ".o"
    comment = f"  /* {_hex(start_addr)} - {_hex(end_addr)}, raw bytes */"
    new_line = f"{indent}{obj_path}(.text);{comment}"

    if rom_dropped:
        # Replace the rom.o line with the new bucket entry (no trailing rom.o)
        new_text = text[: m.start()] + new_line + text[m.end():]
    else:
        # Insert new bucket line BEFORE the rom.o line
        new_text = text[: m.start()] + new_line + "\n" + text[m.start():]
    LINKER_LD.write_text(new_text)


def run_make_check() -> tuple[bool, str]:
    """Build then verify. Return (ok, combined_output)."""
    build = subprocess.run(
        ["make", "-j8"], cwd=ROOT, capture_output=True, text=True
    )
    if build.returncode != 0:
        return False, f"make failed:\n{build.stdout[-2000:]}\n{build.stderr[-2000:]}"
    check = subprocess.run(
        ["make", "check"], cwd=ROOT, capture_output=True, text=True
    )
    ok = check.returncode == 0
    return ok, check.stdout + check.stderr


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("--size", type=lambda s: int(s, 0), default=DEFAULT_BUCKET,
                   help=f"bucket size in bytes (default {DEFAULT_BUCKET:#x} = 64KB)")
    p.add_argument("--dry-run", action="store_true",
                   help="show what would happen; don't write files")
    p.add_argument("--no-verify", action="store_true",
                   help="skip `make check` (caller will verify)")
    p.add_argument("--json", action="store_true",
                   help="machine-readable output")
    args = p.parse_args()

    rom_size = baserom_size()
    parsed = parse_rom_s()
    if parsed is None:
        out = {"status": "drained", "reason": "asm/rom.s removed (last bucket drained it)"}
        if args.json:
            json.dump(out, sys.stdout); sys.stdout.write("\n")
        else:
            print("asm/rom.s already removed; nothing to do")
        return 2
    skip, count, rom_text = parsed

    if skip >= rom_size:
        out = {"status": "drained", "skip": skip, "rom_size": rom_size}
        if args.json:
            json.dump(out, sys.stdout); sys.stdout.write("\n")
        else:
            print(f"asm/rom.s already drained at {_hex(skip)}; nothing to do")
        return 2

    start_addr = ROM_BASE + skip
    new_skip, nbytes = compute_bucket(skip, args.size, rom_size)
    end_addr = ROM_BASE + new_skip
    bucket_path = bucket_filename(start_addr)
    rom_dropped = new_skip >= rom_size

    result = {
        "status": "planned" if args.dry_run else "peeled",
        "start_addr": start_addr,
        "end_addr": end_addr,
        "bytes": nbytes,
        "bucket_file": bucket_path.relative_to(ROOT).as_posix(),
        "rom_s_dropped": rom_dropped,
        "verified": False,
    }

    if args.dry_run:
        if args.json:
            json.dump(result, sys.stdout); sys.stdout.write("\n")
        else:
            print(f"DRY RUN: would peel [{_hex(start_addr)}, {_hex(end_addr)}) "
                  f"({nbytes:#x} bytes) into {bucket_path.relative_to(ROOT)}")
            print(f"  rom.s after: skip={_hex(new_skip)} "
                  f"{'(file removed)' if rom_dropped else ''}")
        return 0

    emit_bucket_file(bucket_path, start_addr, end_addr)
    new_rom_text = rewrite_rom_s(rom_text, new_skip, rom_size)
    if new_rom_text is None:
        ROM_S.unlink()
    else:
        ROM_S.write_text(new_rom_text)
    insert_linker_entry(start_addr, end_addr, rom_dropped)

    if not args.no_verify:
        ok, output = run_make_check()
        result["verified"] = ok
        if not ok:
            result["status"] = "broke_build"
            result["build_output_tail"] = output[-2000:]
            if args.json:
                json.dump(result, sys.stdout); sys.stdout.write("\n")
            else:
                print(f"BUILD BROKE after peeling {bucket_path.relative_to(ROOT)}",
                      file=sys.stderr)
                print(output[-2000:], file=sys.stderr)
            return 1

    if args.json:
        json.dump(result, sys.stdout); sys.stdout.write("\n")
    else:
        print(f"peeled [{_hex(start_addr)}, {_hex(end_addr)}) -> "
              f"{bucket_path.relative_to(ROOT)} ({nbytes:#x} bytes)"
              + ("  [VERIFIED]" if result["verified"] else "  [unverified]"))
        if rom_dropped:
            print("asm/rom.s drained; removed from linker.ld")
    return 0


if __name__ == "__main__":
    sys.exit(main())
