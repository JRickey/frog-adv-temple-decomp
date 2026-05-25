#!/usr/bin/env python3
"""Snapshot every function's baserom address to a JSON cache.

The diff tool (`compile_and_view_assembly.py`) needs to detect "layout drift"
— when a decomp moves a function to a different ROM address. To do that it
needs the function's *baserom* address as ground truth.

Two sources, in order of precedence:
  1. `@ 0xADDR` comments in `asm/disasm_*.s` (always correct for functions
     still in asm form; ground truth straight from the original disassembly)
  2. `frog_us.map` from a matching build (correct for functions already
     decompiled to C, since the build is byte-identical to the baserom)

This script merges those and writes `tools/agent/.function_addresses.json`.
Refresh it whenever you've just landed a matching decomp — the new C-defined
function's address gets folded in via source (2) so subsequent drift checks
remain accurate.

Usage:
    snapshot_addresses.py            # write the cache
    snapshot_addresses.py --print N  # show first N entries (debug)

Safety: refuses to run if `frog_us.gba != frog_us_baserom.gba` to avoid baking
wrong addresses from a non-matching build.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
ASM_DIR = ROOT / "asm"
MAP_FILE = ROOT / "frog_us.map"
BASEROM = ROOT / "frog_us_baserom.gba"
BUILTROM = ROOT / "frog_us.gba"
CACHE = Path(__file__).parent / ".function_addresses.json"

ROM_BASE = 0x08000000
DISASM_ADDR_RE = re.compile(r"^(\S+):\s*@\s*0x([0-9a-fA-F]{8})")
MAP_SYM_RE = re.compile(r"^\s+0x([0-9a-fA-F]{8,})\s+([A-Za-z_]\w*)\s*$")


def sha1(p: Path) -> str:
    h = hashlib.sha1()
    with p.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 16), b""):
            h.update(chunk)
    return h.hexdigest()


def from_disasm() -> dict[str, int]:
    out: dict[str, int] = {}
    for p in sorted(ASM_DIR.glob("disasm_*.s")):
        for line in p.read_text(errors="replace").splitlines():
            m = DISASM_ADDR_RE.match(line)
            if m:
                out[m.group(1)] = int(m.group(2), 16)
    return out


def from_map() -> dict[str, int]:
    out: dict[str, int] = {}
    if not MAP_FILE.exists():
        return out
    for line in MAP_FILE.read_text(errors="replace").splitlines():
        m = MAP_SYM_RE.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        if addr < ROM_BASE:
            continue
        name = m.group(2)
        if name.startswith(("PROVIDE", "ABSOLUTE")):
            continue
        out[name] = addr
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--print", type=int, default=0,
                    help="print N sample entries instead of writing")
    ap.add_argument("--force", action="store_true",
                    help="write even if build doesn't match baserom")
    args = ap.parse_args()

    if not BASEROM.exists():
        print(f"ERROR: missing {BASEROM.name}", file=sys.stderr)
        return 1
    if not BUILTROM.exists():
        print(f"ERROR: missing {BUILTROM.name} — run `make` first",
              file=sys.stderr)
        return 1

    if not args.force:
        if sha1(BASEROM) != sha1(BUILTROM):
            print("ERROR: built ROM does not match baserom — refusing to "
                  "snapshot addresses from a non-matching build. Run `make "
                  "tidy && make -j8 && make check` first, or pass --force.",
                  file=sys.stderr)
            return 2

    disasm_addrs = from_disasm()
    map_addrs = from_map()

    # asm `@ 0xADDR` comments are the authoritative source for any function
    # currently in asm form. .map is the authoritative source for already-
    # decompiled C functions. They don't overlap (a function lives in one
    # or the other), but if a duplicate ever appears the asm wins.
    merged: dict[str, int] = dict(map_addrs)
    merged.update(disasm_addrs)

    if args.print:
        for name in sorted(merged)[: args.print]:
            print(f"  {merged[name]:#010x}  {name}")
        print(f"... {len(merged)} total")
        return 0

    payload = {
        "baserom_sha1": sha1(BASEROM),
        "count": len(merged),
        "addresses": merged,
    }
    CACHE.write_text(json.dumps(payload, indent=2, sort_keys=True))
    print(f"wrote {len(merged)} addresses to {CACHE.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
