#!/usr/bin/env python3
"""Post-link relocation sanity check.

Scans the linked program for `bl` (Thumb call) and `b` (Thumb branch)
instructions and verifies that each decoded target either:
  (a) Matches an exported symbol address in `frog_us.map`, or
  (b) Lies inside the function from which the branch originates (an
      intra-function branch).

Flags every BL whose target is neither — the smoking gun for commit
`fa09acf` (PROVIDE() + Thumb BL silently mis-encoded all 27 callees to
~0x3F00xx because ld couldn't supply Thumb-mode info on a PROVIDE'd
symbol).

SCOPE: this checks the ELF, which only contains real Thumb code for
functions that have been refined to mnemonics. Raw INCBIN regions don't
get disassembled (and can't carry bad relocations anyway), so this tool
naturally focuses on the danger zone — newly-decompiled function bodies
whose BLs go through the linker. Re-run after every refine-to-mnemonics
step.

Usage:
    python3 tools/agent/check_relocations.py                    # repo-wide
    python3 tools/agent/check_relocations.py --function AgbMain  # just one fn
"""
from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
ELF = ROOT / "frog_us.elf"
MAP = ROOT / "frog_us.map"

ROM_BASE = 0x08000000
ROM_END  = 0x0A000000   # generous upper bound for GBA ROM

FUNCTION_HEADER_RE = re.compile(r"^([0-9a-f]+)\s+<(\S+)>:\s*$")
INSN_RE = re.compile(r"^\s*([0-9a-f]+):\s+([0-9a-f][0-9a-f ]*?)\s*\t(\S+)(?:\s+(.*))?$")
BRANCH_TARGET_RE = re.compile(r"(?:0x)?([0-9a-f]+)")


def parse_map_addresses() -> dict[str, int]:
    """Return {symbol_name: address} for every text-section symbol."""
    if not MAP.exists():
        raise RuntimeError(f"{MAP} not present — run `make -j8`")
    addr_for_name: dict[str, int] = {}
    in_text = False
    text_hdr_re = re.compile(r"^\s*\.text\s+0x[\da-f]+\s+0x[\da-f]+\s+\S+\.o", re.IGNORECASE)
    sym_re = re.compile(r"^\s+0x([\da-f]+)\s+(\S+)$")
    for line in MAP.read_text().splitlines():
        if text_hdr_re.match(line):
            in_text = True
            continue
        if in_text:
            m = sym_re.match(line)
            if m:
                a = int(m.group(1), 16)
                name = m.group(2).replace(".NON_MATCHING", "")
                addr_for_name.setdefault(name, a)
            else:
                in_text = False
    return addr_for_name


def disassemble_elf() -> str:
    proc = subprocess.run(
        ["arm-none-eabi-objdump", "-d", str(ELF)],
        capture_output=True, text=True, check=False,
    )
    if proc.returncode != 0:
        raise RuntimeError(f"objdump failed:\n{proc.stderr}")
    return proc.stdout


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("--function", help="filter to a single source function")
    p.add_argument("--include-branches", action="store_true",
                   help="also check intra-function `b`/`b.n`/`b.w` (default: only `bl`)")
    p.add_argument("--quiet", action="store_true", help="only print violations")
    args = p.parse_args()

    if not ELF.exists():
        print(f"ERROR: {ELF} missing — run `make -j8` first.", file=sys.stderr)
        return 1

    symbol_addrs = parse_map_addresses()
    addr_to_name: dict[int, str] = {}
    for name, a in symbol_addrs.items():
        # Don't let secondary names overwrite primary
        addr_to_name.setdefault(a, name)
    sorted_addrs = sorted(addr_to_name.keys())

    def containing_function(addr: int) -> tuple[int, str] | None:
        """Largest sym <= addr, with addr < next-sym."""
        import bisect
        i = bisect.bisect_right(sorted_addrs, addr) - 1
        if i < 0:
            return None
        a = sorted_addrs[i]
        return (a, addr_to_name[a])

    disasm = disassemble_elf()
    current_fn = "?"
    current_fn_addr = 0
    next_fn_addr = ROM_END
    fn_starts = sorted(addr_to_name.items())  # [(addr, name), ...] but we need by name too

    violations: list[dict] = []
    checked = 0

    for line in disasm.splitlines():
        hdr = FUNCTION_HEADER_RE.match(line)
        if hdr:
            current_fn_addr = int(hdr.group(1), 16)
            current_fn = hdr.group(2)
            # Find the next function's address
            import bisect
            i = bisect.bisect_right(sorted_addrs, current_fn_addr)
            next_fn_addr = sorted_addrs[i] if i < len(sorted_addrs) else ROM_END
            continue

        if args.function and current_fn != args.function:
            continue

        m = INSN_RE.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        mnemonic = m.group(3).lower()
        operands = m.group(4)

        if mnemonic == "bl" or (args.include_branches and mnemonic in ("b", "b.n", "b.w", "bx")):
            tgt_match = BRANCH_TARGET_RE.search(operands)
            if not tgt_match:
                continue
            target = int(tgt_match.group(1), 16)
            checked += 1

            # OK if target is a known symbol address?
            if target in addr_to_name:
                continue
            # OK if target is inside the current function (intra-function branch)?
            if current_fn_addr <= target < next_fn_addr and mnemonic != "bl":
                continue
            # OK if target lies inside some other declared function (e.g.,
            # arm-vs-thumb pc offset by 1 — though we should also catch that)?
            # Heuristic: a BL to an interior address is suspicious; a B to an
            # interior address (of THIS function) is fine but we already
            # excluded that. So at this point: violation.

            ctn = containing_function(target)
            note = ""
            if ctn is None:
                note = "no containing symbol (target out of any function)"
            else:
                ctn_addr, ctn_name = ctn
                if mnemonic == "bl":
                    note = (f"target is interior of {ctn_name} (entry 0x{ctn_addr:08x}, "
                            f"offset +{target - ctn_addr})")
                else:
                    note = f"target is interior of {ctn_name}"

            # Suspicious values per the fa09acf incident: ~0x3F00xx range.
            if 0x003F0000 <= target <= 0x003FFFFF or 0x803F0000 <= target <= 0x803FFFFF:
                note += " — looks like a Thumb-BL relocation failure (matches fa09acf signature)"

            violations.append({
                "from": f"0x{addr:08x}",
                "from_fn": current_fn,
                "mnemonic": mnemonic,
                "target": f"0x{target:08x}",
                "note": note,
                "raw": line.strip(),
            })

    if not args.quiet:
        print(f"Checked {checked} branch instructions.")

    if not violations:
        if not args.quiet:
            print("OK: all branch targets resolve to known symbols or "
                  "intra-function locations.")
        return 0

    print(f"\nFAIL: {len(violations)} suspicious branch target(s):\n")
    for v in violations:
        print(f"  {v['from']}  in {v['from_fn']}")
        print(f"    {v['mnemonic']} {v['target']}  — {v['note']}")
        print(f"    raw: {v['raw']}")
    return 1


if __name__ == "__main__":
    sys.exit(main())
