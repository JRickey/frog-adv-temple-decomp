#!/usr/bin/env python3
"""Cross-reference accesses to a struct base address.

Given a base address (e.g., `0x03005330` for gGameStuff), reports every
load and store in the linked program that uses that base address as the
register operand. Groups by offset so you can see "field at offset N is
read by X, written by Y" — the canonical evidence for assigning struct
field offsets.

Would have caught commit `059720d` (gGameStuff.mode at offset 9, not 10):
the seven SetGameMode_NN helpers all wrote offset 10, but AgbMain's
initialization wrote offset 9 AND every reader read offset 9. A
cross-reference would have made that mismatch obvious.

How it works:
  1. Disassemble `frog_us.elf` with `objdump -d` (uses ELF symbol modes
     so Thumb/ARM is picked correctly per function).
  2. Find every `ldr Rn, [pc, #disp]` whose pool address (resolved by
     objdump's `@ (addr)` comment) contains the target value when read
     from `frog_us.gba`.
  3. For each such load, walk forward in the disassembly tracking the
     destination register Rn until: Rn is overwritten, a control-flow
     instruction is hit, or the function ends.
  4. Collect every `[Rn, #offset]` and `[Rn]` access along the way,
     classifying as reader (ldr/ldrh/ldrb) or writer (str/strh/strb).
  5. Group by offset; report.

Usage:
    python3 tools/agent/struct_xref.py 0x03005330
    python3 tools/agent/struct_xref.py 0x03005330 --offset 9
    python3 tools/agent/struct_xref.py 0x03005330 --json
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
ELF = ROOT / "frog_us.elf"
GBA = ROOT / "frog_us.gba"
ROM_BASE = 0x08000000

# objdump line shapes:
#  80002a6:    490b          ldr     r1, [pc, #44]   @ (80002d4 <AgbMain+0x30>)
#  80002b6:    7248          strb    r0, [r1, #9]
#  80002bc:    4807          ldr     r0, [pc, #28]   @ (80002dc <AgbMain+0x38>)
INSN_RE = re.compile(
    r"^\s*([0-9a-f]+):\s+([0-9a-f][0-9a-f ]*?)\s*\t(\S+)(?:\s+(.*))?$"
)
FUNCTION_HEADER_RE = re.compile(r"^([0-9a-f]+)\s+<(\S+)>:\s*$")
LDR_PC_RE = re.compile(r"ldr\s+(\w+),\s*\[pc,\s*#(-?\d+)\]\s*@\s*\(?(?:0x)?([0-9a-f]+)")
# Match [Rn, #N] or [Rn]
MEM_OPERAND_RE = re.compile(r"\[(\w+)(?:,\s*#(-?\d+|0x[0-9a-fA-F]+))?\]")

READERS = {"ldr", "ldrh", "ldrb", "ldrsb", "ldrsh"}
WRITERS = {"str", "strh", "strb"}
ACCESS_OPS = READERS | WRITERS

# Heuristic: instruction mnemonics that write their first operand register
# (and thus kill our base-register tracking).
REG_WRITERS = {
    "mov", "movs", "mvn", "mvns", "add", "adds", "sub", "subs",
    "lsl", "lsls", "lsr", "lsrs", "asr", "asrs", "ror", "rors",
    "and", "ands", "orr", "orrs", "eor", "eors", "bic", "bics",
    "neg", "negs", "mul", "muls",
    "ldr", "ldrh", "ldrb", "ldrsb", "ldrsh",
    "pop",
}


def disassemble_elf() -> str:
    proc = subprocess.run(
        ["arm-none-eabi-objdump", "-d", str(ELF)],
        capture_output=True, text=True, check=False,
    )
    if proc.returncode != 0:
        raise RuntimeError(f"objdump failed:\n{proc.stderr}")
    return proc.stdout


def disassemble_unpeeled_functions() -> str:
    """Disassemble every `.incbin`-only `asm/disasm_0x*.s` slice directly
    from the baserom, in Thumb mode.

    The .incbin form intentionally preserves bytes byte-for-byte (matching
    is free), but it confuses GAS's mapping-symbol logic: the assembler
    emits `$d` (data) at offset 0 of the function instead of `$t` (Thumb
    code). Objdump on the linked ELF then reads the function's bytes as
    32-bit data words instead of Thumb instructions, so struct_xref's
    elf-scan misses every `ldr`/`str` inside these peels.

    Solution: bypass the ELF entirely for these slices and run objdump on
    the baserom slice with `-Mforce-thumb`. Prepend a function-header line
    that matches FUNCTION_HEADER_RE so callers in this script still see
    each access tagged with the right `current_fn`.
    """
    chunks: list[str] = []
    for path in sorted((ROOT / "asm").glob("disasm_0x*.s")):
        text = path.read_text(errors="replace")
        # Only fall back for slices that haven't been refined to mnemonics.
        if ".incbin" not in text:
            continue
        m_fn = re.search(r"thumb_func_start\s+(\S+)", text)
        m_rng = re.search(
            r"Range:\s*\[0x([0-9a-fA-F]+),\s*0x([0-9a-fA-F]+)\)", text)
        if not (m_fn and m_rng):
            continue
        name = m_fn.group(1)
        start = int(m_rng.group(1), 16)
        end = int(m_rng.group(2), 16)
        proc = subprocess.run(
            [
                "arm-none-eabi-objdump",
                "-D", "-b", "binary", "-m", "arm7tdmi", "-Mforce-thumb",
                f"--adjust-vma=0x{ROM_BASE:x}",
                f"--start-address=0x{start:x}",
                f"--stop-address=0x{end:x}",
                str(GBA.parent / "frog_us_baserom.gba"),
            ],
            capture_output=True, text=True, check=False,
        )
        if proc.returncode != 0:
            continue
        # Strip objdump's auto-emitted `<.data+0xNNN>:` section-relative
        # headers — they'd override our prepended `<sub_NNN>:` header via
        # FUNCTION_HEADER_RE and the access lines would get tagged with
        # the misleading section label.
        cleaned = "\n".join(
            ln for ln in proc.stdout.splitlines()
            if not re.match(r"^[0-9a-f]+\s+<\.data[+>]", ln)
        )
        chunks.append(f"\n{start:08x} <{name}>:\n{cleaned}\n")
    return "".join(chunks)


def pool_word(addr: int) -> int | None:
    """Read 4 little-endian bytes at ROM address `addr`."""
    file_off = addr - ROM_BASE
    if file_off < 0:
        return None
    try:
        with GBA.open("rb") as f:
            f.seek(file_off)
            data = f.read(4)
    except OSError:
        return None
    if len(data) != 4:
        return None
    return int.from_bytes(data, "little")


def get_dest_register(operands: str) -> str | None:
    """First register in operand list (the destination of most insns)."""
    m = re.match(r"\s*([a-z]\w*)", operands)
    return m.group(1) if m else None


def find_loads_of(target_value: int, disasm: str) -> list[tuple[int, str, str]]:
    """Return list of (load_addr, register, function_name) for every
    `ldr Rn, [pc, #disp]` whose pool word equals target_value."""
    out: list[tuple[int, str, str]] = []
    current_fn = "?"
    for line in disasm.splitlines():
        hdr = FUNCTION_HEADER_RE.match(line)
        if hdr:
            current_fn = hdr.group(2)
            continue
        m = LDR_PC_RE.search(line)
        if not m:
            continue
        # Parse the address column too so we know WHERE the load happens.
        insn = INSN_RE.match(line)
        if not insn:
            continue
        load_addr = int(insn.group(1), 16)
        reg = m.group(1)
        pool_addr = int(m.group(3), 16)
        val = pool_word(pool_addr)
        if val == target_value:
            out.append((load_addr, reg, current_fn))
    return out


def walk_register_uses(
    disasm_lines: list[str],
    start_idx: int,
    base_reg: str,
) -> list[tuple[int, str, int, str]]:
    """Walk forward from `start_idx` collecting (addr, mnemonic, offset, full_line)
    for every [base_reg, #offset] access until base_reg is overwritten or a
    control-flow instruction is reached.
    """
    results: list[tuple[int, str, int, str]] = []
    for line in disasm_lines[start_idx + 1 : start_idx + 80]:
        # Function header? Hit end of caller's function.
        if FUNCTION_HEADER_RE.match(line):
            break
        # End of an empty line marks end of function.
        if not line.strip():
            continue
        insn = INSN_RE.match(line)
        if not insn:
            continue
        addr = int(insn.group(1), 16)
        mnemonic = insn.group(3).lower()
        operands = insn.group(4)

        # Control flow → bail.
        if mnemonic in ("bl", "blx", "b", "b.n", "b.w", "bx", "pop") and (
            mnemonic != "pop" or "pc" in operands.lower()
        ):
            break

        # Memory access through base_reg?
        for mm in MEM_OPERAND_RE.finditer(operands):
            reg = mm.group(1)
            off_str = mm.group(2)
            if reg == base_reg and mnemonic in ACCESS_OPS:
                off = int(off_str, 0) if off_str else 0
                results.append((addr, mnemonic, off, line.strip()))

        # Does this insn overwrite base_reg?
        if mnemonic in REG_WRITERS:
            dest = get_dest_register(operands)
            if dest == base_reg:
                break

    return results


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("base", help="32-bit base address (e.g. 0x03005330)")
    p.add_argument("--offset", type=lambda s: int(s, 0),
                   help="filter to a single offset")
    p.add_argument("--json", action="store_true", help="JSON output")
    args = p.parse_args()

    if not ELF.exists():
        print(f"ERROR: {ELF} missing — run `make -j8` first.", file=sys.stderr)
        return 1
    if not GBA.exists():
        print(f"ERROR: {GBA} missing — run `make -j8` first.", file=sys.stderr)
        return 1

    target = int(args.base, 0)

    disasm = disassemble_elf() + disassemble_unpeeled_functions()
    disasm_lines = disasm.splitlines()
    line_idx_for_addr: dict[int, int] = {}
    for i, line in enumerate(disasm_lines):
        m = INSN_RE.match(line)
        if m:
            line_idx_for_addr[int(m.group(1), 16)] = i

    loads = find_loads_of(target, disasm)
    by_offset: dict[int, dict[str, list[dict]]] = defaultdict(
        lambda: {"readers": [], "writers": []})
    total_accesses = 0

    # Same access may be discovered twice when a function has both refined
    # mnemonics in the ELF AND a still-.incbin tail that we baserom-disassemble
    # (notably AgbMain). Dedup by (addr, mnemonic, offset).
    seen: set[tuple[int, str, int]] = set()
    for load_addr, reg, fn in loads:
        idx = line_idx_for_addr.get(load_addr)
        if idx is None:
            continue
        accesses = walk_register_uses(disasm_lines, idx, reg)
        for addr, mnemonic, offset, raw in accesses:
            if args.offset is not None and offset != args.offset:
                continue
            key = (addr, mnemonic, offset)
            if key in seen:
                continue
            seen.add(key)
            bucket = by_offset[offset]
            kind = "readers" if mnemonic in READERS else "writers"
            bucket[kind].append({
                "addr": f"0x{addr:08x}",
                "fn": fn,
                "mnemonic": mnemonic,
                "raw": raw,
            })
            total_accesses += 1

    if args.json:
        out = {
            "base": f"0x{target:08x}",
            "loadSites": len(loads),
            "totalAccesses": total_accesses,
            "byOffset": {
                f"0x{k:x}": v for k, v in sorted(by_offset.items())
            },
        }
        print(json.dumps(out, indent=2))
        return 0

    print(f"Base address:  0x{target:08x}")
    print(f"Load sites:    {len(loads)} (PC-relative loads in the linked program)")
    print(f"Accesses:      {total_accesses}")
    print()
    if not by_offset:
        print("(no accesses found — either the value isn't referenced or "
              "the register was killed before any access)")
        return 0

    for offset in sorted(by_offset.keys()):
        bucket = by_offset[offset]
        readers = bucket["readers"]
        writers = bucket["writers"]
        print(f"offset 0x{offset:x} ({offset}):  "
              f"{len(readers)} readers, {len(writers)} writers")
        for w in writers:
            print(f"    W  {w['addr']}  {w['fn']:30}  {w['raw']}")
        for r in readers:
            print(f"    R  {r['addr']}  {r['fn']:30}  {r['raw']}")
        print()

    return 0


if __name__ == "__main__":
    sys.exit(main())
