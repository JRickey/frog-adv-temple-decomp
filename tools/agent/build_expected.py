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


def emit_expected_s(entry: Entry, symbols: list[str],
                    mappings: list[tuple[int, str]]) -> str:
    """Emit a .s file that INCBINs the entry's bytes under each exported
    symbol, replicating the ARM ELF mapping symbols ($t / $d / $a) from
    the built .o so objdump/objdiff disassemble each chunk in the right
    mode.

    Splits the .incbin into runs between mapping symbols. Each run is
    one `.incbin "...", off, size` line preceded by a single-letter
    mapping label.
    """
    size = entry.hi - entry.lo
    file_off = entry.lo - ROM_BASE
    primary = symbols[0] if symbols else f"sub_{entry.lo:08X}"

    # Default to a single Thumb chunk if the built .o has no mapping syms.
    if not mappings:
        mappings = [(0, "$t")]
    # Normalize: ensure the list starts at 0 and ends at size.
    if mappings[0][0] != 0:
        mappings = [(0, "$t")] + mappings
    # Append a sentinel so we can iterate as ranges.
    runs: list[tuple[int, int, str]] = []
    for i, (off, marker) in enumerate(mappings):
        nxt = mappings[i + 1][0] if i + 1 < len(mappings) else size
        if nxt > off:
            runs.append((off, nxt - off, marker))

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
    body.append(f'        .global {primary}')
    body.append(f'        .type   {primary}, %function')
    body.append(f'{primary}:')
    for alias in symbols[1:]:
        body.append(f'        .global {alias}')
        body.append(f'        .type   {alias}, %function')
        body.append(f'{alias} = {primary}')
    # Read the function's full byte slice from baserom up front so we can
    # emit per-halfword/word directives in each run. Using `.incbin` here
    # confuses the assembler's mapping-symbol tracking — it always inserts
    # a `$d` at the .incbin site even inside `.thumb` mode, which makes
    # objdiff treat code bytes as data.
    with BASEROM.open("rb") as f:
        f.seek(file_off)
        all_bytes = f.read(size)
    if len(all_bytes) != size:
        raise RuntimeError(
            f"can't read {size} bytes from baserom at 0x{file_off:x} "
            f"(got {len(all_bytes)})"
        )
    for run_off, run_size, marker in runs:
        # No explicit `$t:` / `$d:` labels — `.inst.n` and `.word` /
        # `.short` emit the right mapping symbols automatically. Adding
        # our own would create duplicates that confuse objdiff.
        if marker == '$t':
            # Thumb halfwords via `.inst.n` so GAS sets `$t` and the
            # disassembler reads them as Thumb instructions (not data).
            i = run_off
            while i < run_off + run_size:
                if run_off + run_size - i >= 2:
                    hw = all_bytes[i] | (all_bytes[i + 1] << 8)
                    body.append(f'        .inst.n 0x{hw:04x}')
                    i += 2
                else:
                    body.append(f'        .byte 0x{all_bytes[i]:02x}')
                    i += 1
        elif marker == '$a':
            # ARM 32-bit instructions via `.inst`. Rare on this title.
            i = run_off
            while i < run_off + run_size:
                if (i % 4 == 0) and (run_off + run_size - i >= 4):
                    w = struct.unpack_from("<I", all_bytes, i)[0]
                    body.append(f'        .inst 0x{w:08x}')
                    i += 4
                else:
                    body.append(f'        .byte 0x{all_bytes[i]:02x}')
                    i += 1
        else:
            # Data ($d): words when word-aligned, halfwords/bytes otherwise.
            i = run_off
            while i < run_off + run_size:
                if (i % 4 == 0) and (run_off + run_size - i >= 4):
                    w = struct.unpack_from("<I", all_bytes, i)[0]
                    body.append(f'        .word 0x{w:08x}')
                    i += 4
                elif (i % 2 == 0) and (run_off + run_size - i >= 2):
                    hw = all_bytes[i] | (all_bytes[i + 1] << 8)
                    body.append(f'        .short 0x{hw:04x}')
                    i += 2
                else:
                    body.append(f'        .byte 0x{all_bytes[i]:02x}')
                    i += 1
    body.append(f'        .size   {primary}, .-{primary}')
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
    syms = nm_symbols(entry.built_o)
    if not syms:
        return False, f"no symbols in {entry.built_o.relative_to(ROOT)}"
    mappings = arm_mapping_symbols(entry.built_o)
    entry.expected_s.parent.mkdir(parents=True, exist_ok=True)
    entry.expected_s.write_text(emit_expected_s(entry, syms, mappings))
    try:
        assemble(entry.expected_s, entry.expected_o)
    except subprocess.CalledProcessError as e:
        return False, f"as failed: {e}"
    return True, f"{entry.expected_o.relative_to(ROOT)} ({', '.join(syms)})"


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
