#!/usr/bin/env python3
"""Rank ROM data addresses by how many times they're referenced from code.

Scans the Thumb code region of the baserom for `ldr Rd, [pc, #N]`
instructions, resolves each pool target, and tallies references per
target address. ARM-mode `ldr Rd, [pc, #N]` (12-bit offset) is scanned
separately over the same window so the IRQ stub region at
[0x0800012c, 0x08000240) is covered too.

The result is the single most useful view for picking the next data
extraction anchor: targets referenced many times from code are almost
always named tables, and naming them unblocks downstream decomps in
bulk. Neither m2c nor decomp-permuter surfaces this view.

Status column meanings:
  EXTRACTED   covered by a `database.json` entry (bytes live in `data/`)
  NAMED       has a project symbol in `frog_us.map` (named, but bytes
              may still live in a raw INCBIN bucket)
  pending     no name, no extraction — candidate for the next data pass

Methodology caveats:
  * Catches Thumb `ldr Rd, [pc, #N]` (encoding `0100 1xxx ...`, halfwords
    in `0x4800..0x4FFF`) — the standard 4 KiB pool reach. Catches ARM
    `ldr Rd, [pc, #N]` (`e59f xxxx`) so IntrMain's pool is counted too.
  * Misses indirect loads of the shape `ldr Rn, =global; ldr Rd, [Rn, #imm]`
    — those need a second pass that walks the literal pool. Common for
    struct-base access.
  * References from already-decompiled C ARE counted — we scan the
    baserom, not the asm files, so a function that's been moved to C
    still contributes to its anchors' refcounts.
  * Pool words that happen to look like ROM addresses but aren't really
    code-referenced data (e.g., function pointers in switch tables) get
    counted too. Filter via `--threshold N` to cut the noise.

Usage:
    python3 tools/agent/refcount_pool_loads.py
    python3 tools/agent/refcount_pool_loads.py --pending-only --threshold 5
    python3 tools/agent/refcount_pool_loads.py --range 0x08300000 0x08310000
    python3 tools/agent/refcount_pool_loads.py --json
"""

from __future__ import annotations

import argparse
import json
import re
import struct
import sys
from collections import Counter
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
DATABASE_JSON = ROOT / "database.json"
MAP_FILE = ROOT / "frog_us.map"

ROM_BASE = 0x08000000
ROM_END = 0x08400000  # 4 MiB cartridge max

# Same heuristic as progress_stats.py — last observed in-ROM BL target,
# rounded up to a 4-byte slot.
CODE_END_GUESS = 0x08036000

# Conservative IWRAM / EWRAM / MMIO bounds for the region-tag column.
REGION_TAGS: list[tuple[int, int, str]] = [
    (0x02000000, 0x02040000, "ewram"),
    (0x03000000, 0x03008000, "iwram"),
    (0x04000000, 0x04000400, "mmio"),
]


@dataclass
class Hit:
    site: int       # instruction VMA
    target: int     # resolved pool-target address
    mode: str       # "thumb" or "arm"


def load_baserom() -> bytes:
    if not BASEROM.exists():
        raise SystemExit(f"baserom not found at {BASEROM}")
    return BASEROM.read_bytes()


def scan_thumb_pool_loads(rom: bytes, lo: int, hi: int) -> list[Hit]:
    """Walk Thumb halfwords in [lo, hi) and resolve every `ldr Rd, [pc, #N]`.

    Encoding: `0100 1ddd iiii iiii` (halfword 0x4800..0x4FFF). N = imm8 * 4
    bytes added to PC, where PC = (instr_addr + 4) & ~3.
    """
    hits: list[Hit] = []
    code_start = lo - ROM_BASE
    code_end = hi - ROM_BASE
    if code_start < 0 or code_end > len(rom):
        return hits
    for i in range(code_start, code_end - 1, 2):
        hi_byte = rom[i + 1]
        if (hi_byte & 0xF8) != 0x48:
            continue
        # imm8 is the low byte; offset = imm8 * 4
        imm8 = rom[i]
        site_addr = ROM_BASE + i
        pc = (site_addr + 4) & ~3
        pool_addr = pc + (imm8 << 2)
        pool_off = pool_addr - ROM_BASE
        if pool_off < 0 or pool_off + 4 > len(rom):
            continue
        value = struct.unpack_from("<I", rom, pool_off)[0]
        if ROM_BASE <= value < ROM_END:
            hits.append(Hit(site=site_addr, target=value, mode="thumb"))
    return hits


def scan_arm_pool_loads(rom: bytes, lo: int, hi: int) -> list[Hit]:
    """Walk ARM words in [lo, hi) for `ldr Rd, [pc, #N]`.

    Encoding (A1, unconditional and conditional): cccc 0101 U101 1111 dddd
    nnnn nnnn nnnn, with PC=0xF as base. We accept any condition code so the
    IRQ dispatcher's conditional loads are caught.

    Match mask: bits [27:16] form `01_U_101_1111` with U=add (we treat both
    U=0 and U=1; subtract is `e51f xxxx`, add is `e59f xxxx`). Then PC for
    ARM is `instr_addr + 8` (no word-align mask — ARM is always 4-aligned).
    """
    hits: list[Hit] = []
    code_start = lo - ROM_BASE
    code_end = hi - ROM_BASE
    if code_start < 0 or code_end > len(rom):
        return hits
    # 4-byte aligned scan.
    code_start = (code_start + 3) & ~3
    for i in range(code_start, code_end - 3, 4):
        word = struct.unpack_from("<I", rom, i)[0]
        # Mask out condition (bits 31:28) before matching the rest of the encoding.
        masked = word & 0x0F7F0000
        # `01_U_101_1111_xxxx` for U=1 → 0x059F0000; U=0 → 0x051F0000.
        if masked != 0x059F0000 and masked != 0x051F0000:
            continue
        imm12 = word & 0xFFF
        u_bit = (word >> 23) & 1
        site_addr = ROM_BASE + i
        pc = site_addr + 8
        pool_addr = pc + imm12 if u_bit else pc - imm12
        pool_off = pool_addr - ROM_BASE
        if pool_off < 0 or pool_off + 4 > len(rom):
            continue
        value = struct.unpack_from("<I", rom, pool_off)[0]
        if ROM_BASE <= value < ROM_END:
            hits.append(Hit(site=site_addr, target=value, mode="arm"))
    return hits


def load_database_entries() -> list[tuple[int, int, str]]:
    """Return (start_vma, end_vma, path) tuples for every database.json entry."""
    if not DATABASE_JSON.exists():
        return []
    out: list[tuple[int, int, str]] = []
    for entry in json.loads(DATABASE_JSON.read_text()):
        addr = entry.get("addr", {}).get("us")
        size = entry.get("size", 1)
        count = entry.get("count", 0)
        if addr is None:
            continue
        start = int(addr, 16) | ROM_BASE if int(addr, 16) < ROM_BASE else int(addr, 16)
        # database.json stores raw offsets (e.g. "0x35D9C") that get OR'd into
        # the ROM base elsewhere — handle both forms defensively.
        start &= 0xFFFFFFFF
        if start < ROM_BASE:
            start |= ROM_BASE
        nbytes = int(count, 16) * size if isinstance(count, str) else int(count) * size
        out.append((start, start + nbytes, entry.get("path", "?")))
    return out


def load_map_symbols() -> dict[int, str]:
    """Return addr → best project symbol from `frog_us.map`.

    Only symbol lines (indented, then `0xADDR  name`); skips section
    headers and linker assignments like `gIwram_3480 = .`. When multiple
    symbols share an address (linker chunk-id + real data symbol), the
    "data anchor"-like name wins: `text_*` and `sub_*` are demoted.
    """
    if not MAP_FILE.exists():
        return {}
    sym_re = re.compile(r"^\s+0x([0-9a-fA-F]{8,16})\s+([A-Za-z_][\w]*)\s*$")
    candidates: dict[int, list[str]] = {}
    for line in MAP_FILE.read_text(errors="replace").splitlines():
        m = sym_re.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16) & 0xFFFFFFFF
        candidates.setdefault(addr, []).append(m.group(2))

    def is_anchor(name: str) -> bool:
        # Project convention: real data tables are `sFoo`, globals `gFoo`.
        # `text_*` and `sub_*` are linker chunk / address-named placeholders.
        return not (name.startswith("text_") or name.startswith("sub_"))

    out: dict[int, str] = {}
    for addr, names in candidates.items():
        anchors = [n for n in names if is_anchor(n)]
        out[addr] = anchors[0] if anchors else names[0]
    return out


def region_for(addr: int, code_end: int) -> str:
    for lo, hi, name in REGION_TAGS:
        if lo <= addr < hi:
            return name
    if ROM_BASE <= addr < code_end:
        return "code"
    if code_end <= addr < ROM_END:
        return "data"
    return "?"


def status_for(
    addr: int,
    db: list[tuple[int, int, str]],
    syms: dict[int, str],
) -> tuple[str, str]:
    """Return (status, label). label is "" if neither extracted nor named."""
    for start, end, path in db:
        if start <= addr < end:
            return "EXTRACTED", path
    if addr in syms:
        return "NAMED", syms[addr]
    return "pending", ""


def gather_hits(
    rom: bytes,
    scan_lo: int,
    scan_hi: int,
) -> list[Hit]:
    return (
        scan_thumb_pool_loads(rom, scan_lo, scan_hi)
        + scan_arm_pool_loads(rom, scan_lo, scan_hi)
    )


def render_human(
    hits: list[Hit],
    db: list[tuple[int, int, str]],
    syms: dict[int, str],
    *,
    code_end: int,
    target_lo: int,
    target_hi: int,
    threshold: int,
    pending_only: bool,
    limit: int,
    scan_lo: int,
    scan_hi: int,
) -> str:
    by_target: dict[int, list[Hit]] = {}
    for h in hits:
        if not (target_lo <= h.target < target_hi):
            continue
        by_target.setdefault(h.target, []).append(h)

    counter: Counter[int] = Counter({t: len(hs) for t, hs in by_target.items()})

    rows: list[tuple[int, int, str, str, str, list[int]]] = []
    for target, count in counter.most_common():
        if count < threshold:
            continue
        status, label = status_for(target, db, syms)
        if pending_only and status != "pending":
            continue
        region = region_for(target, code_end)
        sites = sorted(h.site for h in by_target[target])
        rows.append((target, count, region, status, label, sites))
        if len(rows) >= limit:
            break

    out: list[str] = []
    title = (
        f"Top {limit} pool-load references "
        f"(scan [0x{scan_lo:08x}, 0x{scan_hi:08x}), "
        f"target [0x{target_lo:08x}, 0x{target_hi:08x}), "
        f"threshold ≥{threshold}"
    )
    if pending_only:
        title += ", pending-only"
    title += "):"
    out.append(title)
    out.append("")

    if not rows:
        out.append("  (no targets matched)")
        return "\n".join(out)

    out.append(
        f"  {'target':<12}  {'refs':>4}  {'region':<6}  "
        f"{'status':<10}  first refs / label"
    )
    out.append("  " + "-" * 78)
    for target, count, region, status, label, sites in rows:
        first3 = ", ".join(f"0x{s:08x}" for s in sites[:3])
        if len(sites) > 3:
            first3 += ", ..."
        tail = f"   ({label})" if label else ""
        out.append(
            f"  0x{target:08x}  {count:>4}  {region:<6}  "
            f"{status:<10}  {first3}{tail}"
        )
    out.append("")
    out.append(
        f"Total unique targets in window: {sum(1 for c in counter.values() if c >= threshold)}; "
        f"total references counted: {sum(counter.values())}."
    )
    return "\n".join(out)


def render_json(
    hits: list[Hit],
    db: list[tuple[int, int, str]],
    syms: dict[int, str],
    *,
    code_end: int,
    target_lo: int,
    target_hi: int,
    threshold: int,
    pending_only: bool,
    scan_lo: int,
    scan_hi: int,
) -> str:
    by_target: dict[int, list[Hit]] = {}
    for h in hits:
        if not (target_lo <= h.target < target_hi):
            continue
        by_target.setdefault(h.target, []).append(h)

    entries = []
    for target, hs in sorted(by_target.items(), key=lambda kv: (-len(kv[1]), kv[0])):
        if len(hs) < threshold:
            continue
        status, label = status_for(target, db, syms)
        if pending_only and status != "pending":
            continue
        entries.append({
            "target": f"0x{target:08x}",
            "refs": len(hs),
            "region": region_for(target, code_end),
            "status": status,
            "label": label,
            "sites": [f"0x{h.site:08x}" for h in sorted(hs, key=lambda x: x.site)],
            "modes": sorted({h.mode for h in hs}),
        })
    return json.dumps(
        {
            "scan_range": [f"0x{scan_lo:08x}", f"0x{scan_hi:08x}"],
            "target_range": [f"0x{target_lo:08x}", f"0x{target_hi:08x}"],
            "code_end_guess": f"0x{code_end:08x}",
            "threshold": threshold,
            "pending_only": pending_only,
            "entries": entries,
        },
        indent=2,
    )


def parse_hex(s: str) -> int:
    return int(s, 0)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--json", action="store_true", help="emit JSON")
    ap.add_argument("--explain", action="store_true",
                    help="print full methodology docstring and exit")
    ap.add_argument("--threshold", type=int, default=1,
                    help="only show targets referenced ≥ N times (default 1)")
    ap.add_argument("--pending-only", action="store_true",
                    help="filter out EXTRACTED + NAMED targets")
    ap.add_argument("--limit", type=int, default=50,
                    help="cap human-mode rows (default 50)")
    ap.add_argument("--range", nargs=2, metavar=("LO", "HI"), type=parse_hex,
                    default=[ROM_BASE, ROM_END],
                    help="restrict TARGET addresses to [LO, HI) (default whole ROM)")
    ap.add_argument("--scan-range", nargs=2, metavar=("LO", "HI"), type=parse_hex,
                    default=[ROM_BASE, CODE_END_GUESS],
                    help="restrict SCAN addresses to [LO, HI) (default code region)")
    args = ap.parse_args()

    if args.explain:
        print(__doc__)
        return 0

    rom = load_baserom()
    scan_lo, scan_hi = args.scan_range
    target_lo, target_hi = args.range

    hits = gather_hits(rom, scan_lo, scan_hi)
    db = load_database_entries()
    syms = load_map_symbols()

    if args.json:
        print(render_json(
            hits, db, syms,
            code_end=CODE_END_GUESS,
            target_lo=target_lo, target_hi=target_hi,
            threshold=args.threshold,
            pending_only=args.pending_only,
            scan_lo=scan_lo, scan_hi=scan_hi,
        ))
    else:
        print(render_human(
            hits, db, syms,
            code_end=CODE_END_GUESS,
            target_lo=target_lo, target_hi=target_hi,
            threshold=args.threshold,
            pending_only=args.pending_only,
            limit=args.limit,
            scan_lo=scan_lo, scan_hi=scan_hi,
        ))
    return 0


if __name__ == "__main__":
    sys.exit(main())
