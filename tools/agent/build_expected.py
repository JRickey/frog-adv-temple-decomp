#!/usr/bin/env python3
"""Generate `expected/<rel>.o` for every `src/<rel>.o` in linker.ld.

Each generated .o has the same symbol(s) as the built version but with
the bytes taken straight from `frog_us_baserom.gba`. Used by
`tools/agent/bin/objdiff-cli` for per-symbol diffs that don't depend on
rebuilding the full 4MB ROM each permuter iteration:

    objdiff-cli diff -1 expected/src/game/foo.o -2 src/game/foo.o SymbolName --format json-pretty

Strategy: for each `src/<rel>.o(.text)` entry in linker.ld, derive the
range [lo, hi) from the trailing comment, look up the function names by
nm-ing the built .o (must `make` first), then emit a tiny .s file that
INCBINs the baserom slice with the right `thumb_func`/`.global` /
`.type` decorations, assemble it into `expected/<rel>.o`. Result: one
ELF per source file, sharing the same set of exported symbols.

Usage:
    python3 tools/agent/build_expected.py                # all entries
    python3 tools/agent/build_expected.py --fn SetGameMode_12   # one
"""

from __future__ import annotations

import argparse
import re
import shutil
import struct
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
LINKER = ROOT / "linker.ld"
EXPECTED = ROOT / "expected"
ROM_BASE = 0x08000000

SRC_LINE_RE = re.compile(
    r'^\s*src/(?P<rel>\S+?)\.o\(\.text\);'
    r'\s*/\*\s*0x(?P<lo>[0-9a-fA-F]+)\s*-\s*0x(?P<hi>[0-9a-fA-F]+)\s*,'
)


@dataclass
class Entry:
    rel: str       # e.g., "game/set_game_mode_12"
    lo: int
    hi: int
    built_o: Path  # src/<rel>.o
    expected_o: Path  # expected/src/<rel>.o
    expected_s: Path  # expected/src/<rel>.s (scratch)


def parse_linker() -> list[Entry]:
    out: list[Entry] = []
    for line in LINKER.read_text().splitlines():
        m = SRC_LINE_RE.match(line)
        if not m:
            continue
        rel = m.group("rel")
        lo = int(m.group("lo"), 16)
        hi = int(m.group("hi"), 16)
        out.append(Entry(
            rel=rel, lo=lo, hi=hi,
            built_o=ROOT / "src" / f"{rel}.o",
            expected_o=EXPECTED / "src" / f"{rel}.o",
            expected_s=EXPECTED / "src" / f"{rel}.s",
        ))
    return out


def nm_symbols(obj: Path) -> list[str]:
    """Return globally-visible function symbols (.text) from an .o."""
    proc = subprocess.run(
        ["arm-none-eabi-nm", "-g", "--defined-only", str(obj)],
        capture_output=True, text=True, check=True,
    )
    out: list[str] = []
    for line in proc.stdout.splitlines():
        # `XXXXXXXX T name` or `XXXXXXXX t name`
        parts = line.split()
        if len(parts) == 3 and parts[1] in ("T", "t"):
            out.append(parts[2])
    return out


def func_symbols(obj: Path) -> list[tuple[int, int, str]]:
    """Return [(offset_in_text, size, name)] for global function symbols.

    Unlike `nm_symbols`, this carries each symbol's *offset within .text*
    and its size, so a multi-function TU (e.g. `Player_CheckTileEvents` +
    `Entity_UpdateVisibility`) is emitted with each symbol at its real
    address instead of collapsing them to aliases at offset 0.
    """
    proc = subprocess.run(
        ["arm-none-eabi-nm", "-g", "--print-size", "--defined-only", str(obj)],
        capture_output=True, text=True, check=True,
    )
    out: list[tuple[int, int, str]] = []
    for line in proc.stdout.splitlines():
        parts = line.split()
        # `OFF SIZE T name`  (sized)  or  `OFF T name`  (size unknown → 0)
        if len(parts) == 4 and parts[2] in ("T", "t"):
            out.append((int(parts[0], 16), int(parts[1], 16), parts[3]))
        elif len(parts) == 3 and parts[1] in ("T", "t"):
            out.append((int(parts[0], 16), 0, parts[2]))
    out.sort()
    return out


def arm_mapping_symbols(obj: Path) -> list[tuple[int, str]]:
    """Return [(offset_in_text, marker)] for $t / $d / $a mapping symbols.

    These tell objdump/objdiff where Thumb code, data, and ARM code start
    inside .text. Without them, .incbin'd bytes are treated as ARM data
    and objdiff reports 0% match even when bytes are identical.
    """
    proc = subprocess.run(
        ["arm-none-eabi-readelf", "-s", str(obj)],
        capture_output=True, text=True, check=True,
    )
    out: list[tuple[int, str]] = []
    for line in proc.stdout.splitlines():
        parts = line.split()
        if len(parts) < 8:
            continue
        name = parts[-1]
        if name not in ("$t", "$d", "$a"):
            continue
        try:
            offset = int(parts[1], 16)
        except ValueError:
            continue
        out.append((offset, name))
    out.sort()
    return out


def _emit_run(body: list[str], all_bytes: bytes, lo: int, hi: int,
              marker: str) -> None:
    """Append directives for bytes [lo, hi) in the given mapping mode.

    No explicit `$t:` / `$d:` labels — `.inst.n` and `.word` / `.short`
    emit the right mapping symbols automatically. Adding our own would
    create duplicates that confuse objdiff. Word/halfword alignment is
    keyed off the absolute offset `i` so `$d` runs split correctly.
    """
    i = lo
    if marker == '$t':
        # Thumb halfwords via `.inst.n` so GAS sets `$t` and the
        # disassembler reads them as Thumb instructions (not data).
        while i < hi:
            if hi - i >= 2:
                hw = all_bytes[i] | (all_bytes[i + 1] << 8)
                body.append(f'        .inst.n 0x{hw:04x}')
                i += 2
            else:
                body.append(f'        .byte 0x{all_bytes[i]:02x}')
                i += 1
    elif marker == '$a':
        # ARM 32-bit instructions via `.inst`. Rare on this title.
        while i < hi:
            if (i % 4 == 0) and (hi - i >= 4):
                w = struct.unpack_from("<I", all_bytes, i)[0]
                body.append(f'        .inst 0x{w:08x}')
                i += 4
            else:
                body.append(f'        .byte 0x{all_bytes[i]:02x}')
                i += 1
    else:
        # Data ($d): words when word-aligned, halfwords/bytes otherwise.
        while i < hi:
            if (i % 4 == 0) and (hi - i >= 4):
                w = struct.unpack_from("<I", all_bytes, i)[0]
                body.append(f'        .word 0x{w:08x}')
                i += 4
            elif (i % 2 == 0) and (hi - i >= 2):
                hw = all_bytes[i] | (all_bytes[i + 1] << 8)
                body.append(f'        .short 0x{hw:04x}')
                i += 2
            else:
                body.append(f'        .byte 0x{all_bytes[i]:02x}')
                i += 1


def emit_expected_s(entry: Entry, funcs: list[tuple[int, int, str]],
                    mappings: list[tuple[int, str]]) -> str:
    """Emit a .s file that reproduces the entry's bytes from baserom with
    every exported function at its *real* offset, replicating the ARM ELF
    mapping symbols ($t / $d / $a) so objdump/objdiff disassemble each
    chunk in the right mode.

    `funcs` is [(offset, size, name)] sorted by offset. Functions sharing
    an offset are emitted as aliases (`name = primary`). Byte emission is
    cut at every mapping boundary *and* every function boundary, so each
    symbol gets a label at its exact offset and a correct `.size`, and no
    word straddles a function boundary.
    """
    size = entry.hi - entry.lo
    file_off = entry.lo - ROM_BASE

    if not funcs:
        funcs = [(0, size, f"sub_{entry.lo:08X}")]

    # Group names by offset (same address → aliases), keeping first-seen order.
    by_off: dict[int, list[str]] = {}
    for off, _sz, name in sorted(funcs):
        by_off.setdefault(off, []).append(name)
    func_offsets = sorted(by_off)

    # Default to a single Thumb chunk if the built .o has no mapping syms.
    if not mappings:
        mappings = [(0, "$t")]
    if mappings[0][0] != 0:
        mappings = [(0, "$t")] + mappings

    def marker_at(off: int) -> str:
        cur = "$t"
        for moff, mk in mappings:
            if moff <= off:
                cur = mk
            else:
                break
        return cur

    with BASEROM.open("rb") as f:
        f.seek(file_off)
        all_bytes = f.read(size)
    if len(all_bytes) != size:
        raise RuntimeError(
            f"can't read {size} bytes from baserom at 0x{file_off:x} "
            f"(got {len(all_bytes)})"
        )

    body = []
    body.append(
        f"@ Auto-emitted by tools/agent/build_expected.py from baserom bytes."
    )
    body.append(
        f"@ Source range: [0x{entry.lo:08x}, 0x{entry.hi:08x})  "
        f"({size} bytes, file offset 0x{file_off:08x})"
    )
    body.append("")
    body.append('        .syntax unified')
    body.append('        .thumb')
    body.append('        .text')
    body.append('        .align  2')
    for off in func_offsets:
        for name in by_off[off]:
            body.append(f'        .global {name}')
            body.append(f'        .type   {name}, %function')

    # Cut points: mapping boundaries ∪ function boundaries ∪ {0, size}, all
    # clamped to the baserom slice. A built .o can be larger than its
    # linker.ld range (e.g. a non-matching scaffold) — offsets past `size`
    # have no bytes to emit, so drop them rather than read out of range.
    cuts = sorted(c for c in ({0, size} | {m[0] for m in mappings}
                              | set(func_offsets)) if 0 <= c <= size)

    open_primary: str | None = None
    for a, b in zip(cuts, cuts[1:]):
        if a in by_off:
            if open_primary is not None:
                body.append(f'        .size   {open_primary}, .-{open_primary}')
            names = by_off[a]
            open_primary = names[0]
            body.append(f'{open_primary}:')
            for alias in names[1:]:
                body.append(f'{alias} = {open_primary}')
        _emit_run(body, all_bytes, a, b, marker_at(a))
    if open_primary is not None:
        body.append(f'        .size   {open_primary}, .-{open_primary}')
    body.append('')
    return "\n".join(body)


def assemble(s_file: Path, o_file: Path) -> None:
    o_file.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run(
        ["arm-none-eabi-as", "-mcpu=arm7tdmi", "-mthumb-interwork",
         str(s_file), "-o", str(o_file)],
        cwd=ROOT, check=True,
    )


def build_one(entry: Entry) -> tuple[bool, str]:
    if not entry.built_o.exists():
        return False, (
            f"built .o missing — run `make -j8` first: {entry.built_o.relative_to(ROOT)}"
        )
    funcs = func_symbols(entry.built_o)
    if not funcs:
        return False, f"no symbols in {entry.built_o.relative_to(ROOT)}"
    mappings = arm_mapping_symbols(entry.built_o)
    entry.expected_s.parent.mkdir(parents=True, exist_ok=True)
    entry.expected_s.write_text(emit_expected_s(entry, funcs, mappings))
    try:
        assemble(entry.expected_s, entry.expected_o)
    except subprocess.CalledProcessError as e:
        return False, f"as failed: {e}"
    names = ", ".join(n for _off, _sz, n in funcs)
    return True, f"{entry.expected_o.relative_to(ROOT)} ({names})"


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("--fn", help="generate only the entry whose .o exports this symbol")
    p.add_argument("--clean", action="store_true",
                   help="remove expected/ before generating")
    args = p.parse_args()

    if args.clean and EXPECTED.exists():
        shutil.rmtree(EXPECTED)

    if not BASEROM.exists():
        print(f"baserom missing: {BASEROM}", file=sys.stderr)
        return 1

    entries = parse_linker()
    if args.fn:
        filtered: list[Entry] = []
        for e in entries:
            if not e.built_o.exists():
                continue
            if args.fn in nm_symbols(e.built_o):
                filtered.append(e)
        if not filtered:
            print(f"no built src/*.o exports symbol {args.fn!r}", file=sys.stderr)
            return 2
        entries = filtered

    ok = fail = 0
    for entry in entries:
        success, msg = build_one(entry)
        prefix = "  ✓" if success else "  ✗"
        print(f"{prefix} {entry.rel}: {msg}")
        if success:
            ok += 1
        else:
            fail += 1

    print(f"\n{ok}/{ok + fail} expected/.o files generated.")
    return 0 if fail == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
