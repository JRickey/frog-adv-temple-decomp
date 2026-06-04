#!/usr/bin/env python3
"""Build a CORRECT decomp-permuter target.o for one function.

Why this exists
---------------
decomp-permuter scores a candidate by disassembling both the candidate .o and
the target .o with `arm-none-eabi-objdump -drz` and diffing the instruction
streams (see vendor/decomp-permuter/src/{scorer,objdump}.py). objdump tells
Thumb code from the literal pool using the ELF `$t` / `$d` mapping symbols.

The agbcc-built *candidate* carries proper `$t`/`$d`, so its pool shows as
`.word` data. If the *target* is assembled from raw bytes with `.inst.n` for the
WHOLE function (the old nonmatchings/*/target.s format), the pool has no `$d`
markers and objdump disassembles it as garbage Thumb. The two streams then
misalign in every pool region, and each phantom insertion/deletion costs 100
points — inflating the base score by thousands (e.g. sub_080112C0: 2545 instead
of its true 40) and making score-0 unreachable. This made the permuter useless
for every function in this project.

The fix: emit the target from baserom bytes but mirror the *candidate's* mapping
symbols (so `$t` runs are `.inst.n`, `$d` runs are `.word`/`.short`) AND the
candidate's relocations (so `bl sub_X` / `.word gSym` match symbolically instead
of as absolute values). Then a true byte-match scores exactly 0.

Usage
-----
    python3 tools/agent/make_permuter_target.py <FunctionName> [--out DIR]

Requires the function's src/*.o to be built (it is the reference candidate for
the mapping-symbol / relocation layout) and frog_us.map for the address.
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASEROM = ROOT / "frog_us_baserom.gba"
ROM_BASE = 0x08000000


def sh(*cmd: str) -> str:
    return subprocess.run(cmd, capture_output=True, text=True, check=True).stdout


def find_candidate_o(fn: str) -> Path:
    """Return the built src/*.o that exports `fn`."""
    for o in (ROOT / "src").rglob("*.o"):
        out = subprocess.run(
            ["arm-none-eabi-nm", "-g", "--defined-only", str(o)],
            capture_output=True, text=True,
        ).stdout
        for line in out.splitlines():
            p = line.split()
            if len(p) == 3 and p[1] in ("T", "t") and p[2] == fn:
                return o
    raise SystemExit(f"no built src/*.o exports {fn!r} — build it first (make -j8)")


def func_address(fn: str) -> int:
    mp = ROOT / "frog_us.map"
    if not mp.exists():
        raise SystemExit("frog_us.map missing — run `make` first")
    for line in mp.read_text().splitlines():
        m = re.search(r"0x([0-9a-fA-F]+)\s+" + re.escape(fn) + r"\b", line)
        if m:
            return int(m.group(1), 16)
    raise SystemExit(f"{fn} not found in frog_us.map")


def text_size(o: Path) -> int:
    for line in sh("arm-none-eabi-objdump", "-h", str(o)).splitlines():
        parts = line.split()
        if len(parts) >= 3 and parts[1] == ".text":
            return int(parts[2], 16)
    raise SystemExit(f"no .text in {o}")


def mapping_symbols(o: Path, size: int) -> list[tuple[int, str]]:
    """[(offset, '$t'|'$d')] sorted; from the candidate .o."""
    out = sh("arm-none-eabi-readelf", "-s", str(o))
    maps = []
    for line in out.splitlines():
        m = re.search(r":\s+([0-9a-f]{8})\s+\d+\s+NOTYPE\s+LOCAL\s+DEFAULT\s+\d+\s+(\$[tda])\b", line)
        if m:
            maps.append((int(m.group(1), 16), m.group(2)))
    maps = sorted(set(maps))
    if not maps or maps[0][0] != 0:
        maps = [(0, "$t")] + maps
    # normalize $a (arm) → treat like $t for our thumb funcs (shouldn't appear)
    maps = [(off, "$d" if mk == "$d" else "$t") for off, mk in maps]
    return maps


def relocations(o: Path) -> dict[int, tuple[str, str]]:
    """offset -> (symbol, type) from the candidate .o."""
    out = sh("arm-none-eabi-objdump", "-r", str(o))
    relocs = {}
    for line in out.splitlines():
        m = re.match(r"([0-9a-f]{8})\s+(R_ARM_\S+)\s+(\S+)", line)
        if m:
            off = int(m.group(1), 16)
            typ = m.group(2)
            sym = m.group(3).split("+")[0]
            relocs[off] = (sym, typ)
    return relocs


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("fn")
    ap.add_argument("--out", help="output dir (default nonmatchings/<fn>/)")
    ap.add_argument("--candidate", help="explicit candidate .o for the $t/$d + reloc "
                    "layout (default: search src/**/*.o for the symbol)")
    ap.add_argument("--addr", help="function baserom address, hex (default: frog_us.map)")
    args = ap.parse_args()
    fn = args.fn

    cand = Path(args.candidate) if args.candidate else find_candidate_o(fn)
    addr = int(args.addr, 16) if args.addr else func_address(fn)
    size = text_size(cand)
    file_off = addr - ROM_BASE
    data = BASEROM.read_bytes()[file_off:file_off + size]
    if len(data) != size:
        raise SystemExit(f"short baserom read at {file_off:#x}")

    maps = mapping_symbols(cand, size)
    relocs = relocations(cand)

    runs = []
    for i, (off, mk) in enumerate(maps):
        nxt = maps[i + 1][0] if i + 1 < len(maps) else size
        if nxt > off:
            runs.append((off, nxt, mk))

    out = [
        f"@ Permuter target for {fn} — generated by tools/agent/make_permuter_target.py",
        f"@ Mirrors the candidate ({cand.relative_to(ROOT)}) $t/$d mapping + relocations",
        f"@ so objdump disassembles the literal pool as data and a true match scores 0.",
        ".syntax unified",
        ".thumb",
        ".text",
        ".align 2",
        f".global {fn}",
        f".type {fn}, %function",
        f"{fn}:",
    ]
    i = 0
    for lo, hi, mk in runs:
        i = lo
        while i < hi:
            if i in relocs:
                sym, typ = relocs[i]
                if typ in ("R_ARM_THM_CALL", "R_ARM_CALL"):
                    out.append(f"    bl {sym}")
                    i += 4
                    continue
                if typ == "R_ARM_ABS32":
                    out.append(f"    .word {sym}")
                    i += 4
                    continue
            if mk == "$t":
                hw = data[i] | (data[i + 1] << 8)
                out.append(f"    .inst.n 0x{hw:04x}")
                i += 2
            else:  # $d
                if hi - i >= 4 and i % 4 == 0:
                    w = int.from_bytes(data[i:i + 4], "little")
                    out.append(f"    .word 0x{w:08x}")
                    i += 4
                else:
                    hw = data[i] | (data[i + 1] << 8)
                    out.append(f"    .short 0x{hw:04x}")
                    i += 2

    out_dir = Path(args.out) if args.out else (ROOT / "nonmatchings" / fn)
    out_dir.mkdir(parents=True, exist_ok=True)
    tgt_s = out_dir / "target.s"
    tgt_o = out_dir / "target.o"
    tgt_s.write_text("\n".join(out) + "\n")
    sh("arm-none-eabi-as", "-mthumb", "-mcpu=arm7tdmi", str(tgt_s), "-o", str(tgt_o))

    print(f"wrote {tgt_s.relative_to(ROOT)} and {tgt_o.relative_to(ROOT)}")
    print(f"  addr 0x{addr:08x}  size {size}  runs {len(runs)}  relocs {len(relocs)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
