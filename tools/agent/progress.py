#!/usr/bin/env python3
"""Quantitative progress metric for the Frogger's Adventures decomp.

Designed for an agentic decompilation loop. Computes:
  - sha1_match: True if built ROM byte-equals baserom
  - bytes_total_rom / bytes_diff_rom: whole-ROM byte-diff
  - asm_funcs_remaining: count of thumb_func_start labels still in asm/disasm_*.s
  - asm_lines_remaining: raw line count of asm/disasm_*.s
  - per_function_diff (when --per-function): for each text symbol in the .map,
    the byte-mismatch count vs. baserom over its address range. Drives
    "which function to attack next" and "did this change improve match?"

Output formats: --json (default) for agents, --human for terminal review.

Exit codes:
  0  fully matching (sha1 ok)
  1  built but nonmatching
  2  build artifacts missing — run `make` first
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from dataclasses import dataclass, asdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
BUILTROM = ROOT / "frog_us.gba"
MAP_FILE = ROOT / "frog_us.map"
ASM_DIR = ROOT / "asm"

ROM_BASE = 0x08000000

# Lines like: "0x08000000  symbol_name"  OR  ".text  0x08000000  0x40  src/foo.o"
MAP_SYMBOL_RE = re.compile(r"^\s+0x([0-9a-fA-F]{8,})\s+([A-Za-z_][\w.$]*)\s*$")
MAP_SECTION_RE = re.compile(
    r"^\s+\.text\s+0x([0-9a-fA-F]{8,})\s+0x([0-9a-fA-F]+)\s+(\S+\.o)\s*$"
)


@dataclass
class FuncDiff:
    name: str
    addr: int
    size: int
    diff_bytes: int

    @property
    def match_ratio(self) -> float:
        return 1.0 - (self.diff_bytes / self.size) if self.size else 1.0


def sha1(path: Path) -> str:
    h = hashlib.sha1()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 16), b""):
            h.update(chunk)
    return h.hexdigest()


def whole_rom_diff(base: bytes, built: bytes) -> tuple[int, int]:
    n = min(len(base), len(built))
    diff = sum(1 for i in range(n) if base[i] != built[i])
    diff += abs(len(base) - len(built))
    return len(base), diff


def parse_map_symbols(map_path: Path) -> list[tuple[int, str]]:
    """Return [(rom_addr, symbol_name), ...] sorted by addr.

    We pick up bare symbols of the form `  0xADDR  name` that the linker
    emits between section entries. These are usually function entry points
    when their address is in ROM (>=0x08000000).
    """
    syms: list[tuple[int, str]] = []
    seen: set[tuple[int, str]] = set()
    for line in map_path.read_text(errors="replace").splitlines():
        m = MAP_SYMBOL_RE.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        if addr < ROM_BASE:
            continue
        name = m.group(2)
        # Skip linker-generated symbols, section-bracket symbols, .L locals
        if name.startswith((".", "_", "PROVIDE", "ABSOLUTE")):
            continue
        key = (addr, name)
        if key in seen:
            continue
        seen.add(key)
        syms.append(key)
    syms.sort()
    return syms


def per_function_diff(
    base: bytes, built: bytes, symbols: list[tuple[int, str]]
) -> list[FuncDiff]:
    """Diff each symbol's byte range against baserom.

    Range is [addr, next_addr) computed from sorted symbol list. The last
    symbol gets a generous tail (16 bytes) — usually fine since the actual
    next entry is a data table boundary.
    """
    out: list[FuncDiff] = []
    n = min(len(base), len(built))
    for i, (addr, name) in enumerate(symbols):
        next_addr = symbols[i + 1][0] if i + 1 < len(symbols) else addr + 16
        size = next_addr - addr
        if size <= 0:
            continue
        off = addr - ROM_BASE
        end = off + size
        if off >= n or off < 0:
            continue
        end = min(end, n)
        diff = sum(1 for k in range(off, end) if base[k] != built[k])
        out.append(FuncDiff(name=name, addr=addr, size=end - off, diff_bytes=diff))
    return out


def asm_stub_stats() -> tuple[int, int]:
    """(num remaining thumb_func_start in disasm_*.s, total line count)."""
    funcs = 0
    lines = 0
    for p in sorted(ASM_DIR.glob("disasm_*.s")):
        text = p.read_text(errors="replace")
        funcs += text.count("thumb_func_start")
        funcs += text.count("arm_func_start")
        lines += text.count("\n")
    return funcs, lines


def build_report(per_function: bool) -> dict:
    report: dict = {
        "baserom_present": BASEROM.exists(),
        "built_rom_present": BUILTROM.exists(),
        "map_present": MAP_FILE.exists(),
    }
    if not BASEROM.exists():
        report["error"] = f"missing {BASEROM.name}; symlink your USA baserom"
        return report
    if not BUILTROM.exists():
        report["error"] = f"missing {BUILTROM.name}; run `make`"
        return report

    base = BASEROM.read_bytes()
    built = BUILTROM.read_bytes()
    base_sha = hashlib.sha1(base).hexdigest()
    built_sha = hashlib.sha1(built).hexdigest()
    total, diff = whole_rom_diff(base, built)
    report.update(
        {
            "sha1_baserom": base_sha,
            "sha1_built": built_sha,
            "sha1_match": base_sha == built_sha,
            "bytes_total_rom": total,
            "bytes_diff_rom": diff,
            "match_ratio_rom": 1.0 - diff / total if total else 1.0,
        }
    )

    funcs, lines = asm_stub_stats()
    report["asm_funcs_remaining"] = funcs
    report["asm_lines_remaining"] = lines

    if per_function and MAP_FILE.exists():
        syms = parse_map_symbols(MAP_FILE)
        diffs = per_function_diff(base, built, syms)
        nonmatching = [d for d in diffs if d.diff_bytes > 0]
        nonmatching.sort(key=lambda d: d.diff_bytes, reverse=True)
        report["nonmatching_functions_count"] = len(nonmatching)
        report["nonmatching_functions"] = [asdict(d) for d in nonmatching[:50]]

    return report


def human_print(report: dict) -> None:
    if "error" in report:
        print(f"ERROR: {report['error']}", file=sys.stderr)
        return
    print(f"SHA1 baserom:  {report['sha1_baserom']}")
    print(f"SHA1 built:    {report['sha1_built']}")
    print(f"MATCH:         {report['sha1_match']}")
    print(
        f"ROM diff:      {report['bytes_diff_rom']:,} / {report['bytes_total_rom']:,}"
        f"  ({report['match_ratio_rom']*100:.4f}% match)"
    )
    print(f"ASM stubs:     {report['asm_funcs_remaining']} funcs, "
          f"{report['asm_lines_remaining']:,} lines remaining")
    if "nonmatching_functions" in report:
        print(f"Top nonmatching ({report['nonmatching_functions_count']} total):")
        for f in report["nonmatching_functions"][:15]:
            print(
                f"  {f['addr']:#010x}  {f['name']:<48}"
                f"  {f['diff_bytes']:>5} / {f['size']:>5} bytes diff"
            )


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("--per-function", action="store_true",
                   help="include per-symbol byte-diff (requires .map file)")
    p.add_argument("--human", action="store_true", help="terminal output")
    args = p.parse_args()

    report = build_report(per_function=args.per_function)
    if args.human:
        human_print(report)
    else:
        json.dump(report, sys.stdout, indent=2)
        sys.stdout.write("\n")

    if "error" in report:
        return 2
    return 0 if report.get("sha1_match") else 1


if __name__ == "__main__":
    sys.exit(main())
