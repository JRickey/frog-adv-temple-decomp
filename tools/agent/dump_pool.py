#!/usr/bin/env python3
"""Dump every `ldr Rx, [pc, #N]` site in a Thumb function, resolved.

For each PC-relative load, prints:
  - the load instruction's address
  - the pool word's address (PC + offset, word-aligned)
  - the 32-bit LE value at that pool word
  - a human label for the value, cross-referenced against
    `docs/memory-map.md` and a few hard-coded MMIO/region buckets

Prevents the "I had the halfwords flipped" mistake (and the related
36-bit `sub_080020B30` mistake) by surfacing the actual interpreted
word next to its source, instead of leaving the reader to mentally
swap bytes from objdump's `0200 0400` halfword display.

Usage:
    python3 tools/agent/dump_pool.py sub_08000430
    python3 tools/agent/dump_pool.py 0x08000430        # by address
    python3 tools/agent/dump_pool.py sub_08000430 --json
"""

from __future__ import annotations

import argparse
import json
import re
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
MEMORY_MAP = ROOT / "docs" / "memory-map.md"
ROM_BASE = 0x08000000

LDR_PC_RE = re.compile(
    r"^\s*([0-9a-f]+):\s+([0-9a-f]+)\s+ldr\s+(\w+),\s*\[pc,\s*#(\d+)\]"
)

# Pre-baked region labels. Specific symbols win over region buckets.
REGION_LABELS = [
    (0x02000000, 0x02040000, "EWRAM"),
    (0x03000000, 0x03008000, "IWRAM"),
    (0x04000000, 0x04000400, "MMIO"),
    (0x08000000, 0x08400000, "ROM"),
]


def parse_memory_map() -> dict[int, str]:
    """Pull `| 0xADDR | symbol | ...` rows from docs/memory-map.md.

    Returns an addr → human label map. Multi-word labels are kept; the
    first column after the address wins.
    """
    out: dict[int, str] = {}
    if not MEMORY_MAP.exists():
        return out
    row_re = re.compile(
        r"^\|\s*`0x([0-9a-fA-F]{8})`\s*\|\s*(?:`([^`]+)`|\(([^)]+)\))[^|]*\|"
    )
    for line in MEMORY_MAP.read_text(errors="replace").splitlines():
        m = row_re.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        symbol = (m.group(2) or m.group(3) or "").strip()
        if symbol and symbol.lower() != "tbd":
            out[addr] = symbol
    return out


def label_for(addr: int, memory_map: dict[int, str]) -> str:
    """Return the best human label for an address."""
    if addr in memory_map:
        return memory_map[addr]
    # MMIO-with-offset (e.g., 0x04000208 = REG_IE_extra)?
    for ma in sorted(memory_map):
        if 0 <= addr - ma <= 0x40 and 0x04000000 <= ma < 0x04000400:
            return f"{memory_map[ma]} + {addr - ma:#x}"
    for lo, hi, name in REGION_LABELS:
        if lo <= addr < hi:
            return f"{name} 0x{addr:08x}"
    return f"<unrecognized 0x{addr:08x}>"


def resolve_function(name_or_addr: str) -> tuple[int, int]:
    """Resolve a Thumb function name or hex address to (start, end).

    Looks the name up in any asm/disasm_0x*.s file with a matching
    `thumb_func_start NAME` and reads the file's `Range:` header for
    the end. Falls back to detect-fn-boundary if only an address is
    given.
    """
    try:
        addr = int(name_or_addr, 0)
        return _by_address(addr)
    except ValueError:
        pass

    for path in ROOT.glob("asm/disasm_0x*.s"):
        text = path.read_text(errors="replace")
        if not re.search(rf"thumb_func_start\s+{re.escape(name_or_addr)}\b", text):
            continue
        m = re.search(
            r"Range:\s*\[0x([0-9a-fA-F]+),\s*0x([0-9a-fA-F]+)\)", text)
        if m:
            return int(m.group(1), 16), int(m.group(2), 16)
        # No range header; fall back to address from the filename.
        fm = re.match(r"disasm_(0x[0-9a-fA-F]+)\.s", path.name)
        if fm:
            return _by_address(int(fm.group(1), 16))
    raise SystemExit(f"function {name_or_addr!r} not found in asm/disasm_*.s")


def _by_address(start: int) -> tuple[int, int]:
    detector = ROOT / "tools/agent/ts/cmds/detect-fn-boundary.ts"
    proc = subprocess.run(
        ["npx", "tsx", str(detector), f"0x{start:08x}", "--json"],
        capture_output=True, text=True, cwd=ROOT,
    )
    if proc.returncode not in (0, 2):
        raise SystemExit(
            f"detect-fn-boundary failed (exit {proc.returncode}): {proc.stderr}"
        )
    rep = json.loads(proc.stdout)
    return start, int(rep["recommendedEnd"])


def objdump_thumb(start: int, end: int) -> str:
    proc = subprocess.run(
        [
            "arm-none-eabi-objdump",
            "-D", "-b", "binary", "-m", "arm7tdmi", "-Mforce-thumb",
            f"--adjust-vma=0x{ROM_BASE:x}",
            f"--start-address=0x{start:x}",
            f"--stop-address=0x{end:x}",
            str(BASEROM),
        ],
        capture_output=True, text=True, cwd=ROOT, check=True,
    )
    return proc.stdout


def read_word(file_off: int) -> int:
    with BASEROM.open("rb") as f:
        f.seek(file_off)
        b = f.read(4)
    if len(b) != 4:
        raise SystemExit(f"can't read 4 bytes from baserom at offset {file_off:#x}")
    return struct.unpack("<I", b)[0]


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("target", help="function name or hex address")
    p.add_argument("--json", action="store_true", help="emit JSON")
    args = p.parse_args()

    start, end = resolve_function(args.target)
    mm = parse_memory_map()
    disasm = objdump_thumb(start, end)

    entries: list[dict] = []
    for line in disasm.splitlines():
        m = LDR_PC_RE.match(line)
        if not m:
            continue
        site_addr = int(m.group(1), 16)
        reg = m.group(3)
        # objdump prints `[pc, #N]` where N is the BYTE offset added to
        # the word-aligned PC (= (site+4) & ~3).
        offset = int(m.group(4))
        pc = (site_addr + 4) & ~3
        pool_addr = pc + offset
        # Pool word lives in the same baserom file; offset == VMA - ROM_BASE.
        pool_off = pool_addr - ROM_BASE
        value = read_word(pool_off)
        entries.append({
            "site": site_addr,
            "reg": reg,
            "pool_addr": pool_addr,
            "value": value,
            "label": label_for(value, mm),
        })

    if args.json:
        json.dump({
            "function": args.target,
            "range": [start, end],
            "entries": entries,
        }, sys.stdout, indent=2)
        sys.stdout.write("\n")
        return 0

    print(f"Function:      {args.target}")
    print(f"Range:         [0x{start:08x}, 0x{end:08x})")
    print(f"Pool entries:  {len(entries)}")
    print()
    if not entries:
        return 0
    site_w = max(len(f"0x{e['site']:08x}") for e in entries)
    pool_w = max(len(f"0x{e['pool_addr']:08x}") for e in entries)
    print(f"  {'load':<{site_w}}  {'reg':<4}  {'pool':<{pool_w}}  "
          f"{'word value':<12}  label")
    print("  " + "-" * (site_w + 6 + pool_w + 18 + 20))
    for e in entries:
        print(f"  0x{e['site']:08x}  {e['reg']:<4}  "
              f"0x{e['pool_addr']:08x}  0x{e['value']:08x}    {e['label']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
