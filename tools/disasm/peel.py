#!/usr/bin/env python3
"""Peel a byte range from the baserom into a labeled disassembly asm file.

Workhorse for moving bytes from `asm/rom.s` (raw INCBIN of the whole
baserom) into named chunks the agent loop can pick. Each invocation:

  1. Reads [start, end) from frog_us_baserom.gba.
  2. Runs arm-none-eabi-objdump on those bytes in the requested mode.
  3. Emits a single `asm/disasm_0xADDR.s` containing one
     `thumb_func_start sub_<addr>` block, with the original bytes as an
     `.incbin` (which always matches) plus the disassembly above as @-
     comments for readability.

The INCBIN-as-body approach keeps every peel byte-identical to the
baserom — there's no round-trip risk from the assembler picking a
different encoding than the original. The trade-off: pick_target.py
counts zero "instructions" for these functions until they're refined
into real mnemonics. That's a deliberate next step, not this tool's job.

For thumb peels, before writing the .s file, this script invokes
`tools/agent/ts/cmds/detect-fn-boundary.ts` to fact-check the proposed
range. It refuses to peel if the boundary detector flags interior `bl`
targets (the bug behind commit 0c989b1 — AgbMain peeled too wide,
swallowing sub_08000430). Pass `--force-boundary` to override after
manual review.

After running, you still need to:
  1. Shrink the surrounding INCBIN in asm/rom.s so the peeled bytes
     aren't included twice (.incbin "...", new_skip, new_count).
  2. Add the new .o entry to linker.ld in baserom address order.
  3. Run `make check` — must still report SHA1 match.

Usage:
    python3 tools/disasm/peel.py --start 0x080000c0 --end 0x080000f0 --mode thumb
    python3 tools/disasm/peel.py --start 0x08000000 --end 0x08000004 --mode arm \\
                                 --name entry_branch
"""
from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
ROM_BASE = 0x08000000

# objdump line: "    c0:    e3a0d3ff    mov  sp, #0x..."  (ARM)
#          or:  "    c0:    b500        push {lr}"        (Thumb)
_OBJDUMP_LINE = re.compile(
    r"^\s*([0-9a-f]+):\s+([0-9a-f ]+?)\s+(\S.*?)\s*$"
)


def _parse_addr(s: str) -> int:
    return int(s, 0)


def disassemble(start: int, end: int, mode: str) -> list[str]:
    """Return a list of formatted disassembly lines, one per instruction."""
    off_start = start - ROM_BASE
    off_end = end - ROM_BASE
    cmd = [
        "arm-none-eabi-objdump",
        "-D", "-b", "binary", "-m", "arm7tdmi", "-EL",
        f"--start-address={off_start}",
        f"--stop-address={off_end}",
        str(BASEROM),
    ]
    if mode == "thumb":
        cmd.append("-Mforce-thumb")
    proc = subprocess.run(cmd, capture_output=True, text=True, check=False)
    if proc.returncode != 0:
        raise RuntimeError(f"objdump failed:\n{proc.stderr}")

    out: list[str] = []
    for line in proc.stdout.splitlines():
        m = _OBJDUMP_LINE.match(line)
        if not m:
            continue
        rel = int(m.group(1), 16)
        raw = m.group(2).strip()
        # Strip the trailing PC-relative comment, e.g. "; (xxx <yyy>)"
        rest = re.split(r"\s*;\s*", m.group(3), maxsplit=1)[0].strip()
        out.append(f"{rel + ROM_BASE:#010x}: {raw:<10}  {rest}")
    return out


def _check_boundary(start: int, end: int, *, force: bool) -> bool:
    """Run detect-fn-boundary on the proposed range. Return True if peel may proceed.

    Refuses (returns False) if the detector reports interior-bl targets or a
    recommended end different from the proposed end, unless `force` is True.
    Falls back to permissive behavior if the TS tool isn't runnable (Node not
    installed yet) — prints a warning but doesn't block.
    """
    import json
    detector = ROOT / "tools/agent/ts/cmds/detect-fn-boundary.ts"
    if not detector.exists():
        print("note: detect-fn-boundary.ts not present; skipping pre-peel check.",
              file=sys.stderr)
        return True
    try:
        proc = subprocess.run(
            ["npx", "tsx", str(detector),
             f"0x{start:x}", "--proposed-end", f"0x{end:x}", "--json"],
            capture_output=True, text=True, check=False, cwd=str(ROOT),
        )
    except FileNotFoundError:
        print("note: npx not on PATH; skipping pre-peel boundary check. "
              "Install Node 22+ to enable.", file=sys.stderr)
        return True
    if proc.returncode not in (0, 2):
        print(f"WARNING: detect-fn-boundary failed (exit {proc.returncode}); "
              f"continuing without boundary validation.\n{proc.stderr}",
              file=sys.stderr)
        return True
    try:
        report = json.loads(proc.stdout)
    except json.JSONDecodeError:
        print("WARNING: detect-fn-boundary produced invalid JSON; "
              "continuing without boundary validation.", file=sys.stderr)
        return True

    rec_end = report.get("recommendedEnd")
    warnings = report.get("warnings", [])
    interior = [c for c in report.get("callTargets", [])
                if c.get("to", 0) > start and c.get("to", 0) < end]

    print(f"\nBoundary check:", file=sys.stderr)
    print(f"  proposed     = [0x{start:08x}, 0x{end:08x})  ({end - start} bytes)",
          file=sys.stderr)
    print(f"  recommended  = [0x{start:08x}, 0x{rec_end:08x})  "
          f"({rec_end - start} bytes)", file=sys.stderr)

    blocking = []
    if rec_end != end:
        blocking.append(
            f"proposed end 0x{end:08x} ≠ detected recommended end 0x{rec_end:08x}")
    if interior:
        for c in interior:
            blocking.append(
                f"interior bl: 0x{c['from']:08x} → 0x{c['to']:08x} "
                f"(target lies inside proposed range — peeling another function as part of this one)")

    if not blocking:
        print("  ✓ boundary check passed", file=sys.stderr)
        return True

    print(f"\n  ✗ boundary check has {len(blocking)} blocking issue(s):", file=sys.stderr)
    for b in blocking:
        print(f"    - {b}", file=sys.stderr)
    if warnings:
        print(f"\n  Additional detector warnings:", file=sys.stderr)
        for w in warnings:
            print(f"    ⚠ {w}", file=sys.stderr)

    if force:
        print("\n  --force-boundary set: proceeding despite issues.", file=sys.stderr)
        return True
    print(
        "\n  Refusing to peel. To override: re-run with --force-boundary "
        "(only after you've manually verified the range).",
        file=sys.stderr,
    )
    return False


def emit(start: int, end: int, mode: str, name: str, insns: list[str]) -> str:
    size = end - start
    file_off = start - ROM_BASE
    start_macro = "thumb_func_start" if mode == "thumb" else "arm_func_start"
    end_macro = "thumb_func_end" if mode == "thumb" else "arm_func_end"

    body = []
    body.append("@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.")
    body.append(f"@ Range:  [{start:#010x}, {end:#010x})  ({size} bytes, {mode} mode)")
    body.append(f"@ Re-peel:  python3 tools/disasm/peel.py "
                f"--start {start:#x} --end {end:#x} --mode {mode}")
    body.append("")
    body.append("        .include \"asm/macros.inc\"")
    body.append("        .syntax unified")
    body.append("")
    body.append("@ Disassembly preview (the bytes come from the INCBIN below):")
    for line in insns:
        body.append(f"@   {line}")
    body.append("")
    body.append(f"        {start_macro} {name}")
    body.append(f"{name}: @ {start:#010x}")
    body.append(f"        .incbin \"frog_us_baserom.gba\", {file_off:#x}, {size:#x}")
    body.append(f"        {end_macro} {name}")
    body.append("")
    return "\n".join(body)


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("--start", required=True, type=_parse_addr,
                   help="ROM address, inclusive (e.g. 0x080000c0)")
    p.add_argument("--end", required=True, type=_parse_addr,
                   help="ROM address, exclusive")
    p.add_argument("--mode", required=True, choices=["arm", "thumb"],
                   help="instruction set mode for the preview disassembly")
    p.add_argument("--name",
                   help="symbol name (default: sub_<addr>)")
    p.add_argument("--out",
                   help="output path (default: asm/disasm_0xADDR.s)")
    p.add_argument("--force-boundary", action="store_true",
                   help="skip the detect-fn-boundary pre-peel check (use only after manual review)")
    p.add_argument("--no-boundary-check", action="store_true",
                   help="don't even run the boundary detector (legacy/scratch peels only)")
    args = p.parse_args()

    if not BASEROM.exists():
        print(f"ERROR: {BASEROM} not present", file=sys.stderr)
        return 1
    if args.end <= args.start:
        print("ERROR: --end must be greater than --start", file=sys.stderr)
        return 1
    if args.start < ROM_BASE:
        print(f"ERROR: --start must be in ROM range (>= {ROM_BASE:#x})", file=sys.stderr)
        return 1
    if args.end > ROM_BASE + BASEROM.stat().st_size:
        print("ERROR: --end past end of baserom", file=sys.stderr)
        return 1

    name = args.name or f"sub_{args.start:08X}"
    out = Path(args.out) if args.out else ROOT / f"asm/disasm_{args.start:#010x}.s"

    if args.mode == "thumb" and not args.no_boundary_check:
        if not _check_boundary(args.start, args.end, force=args.force_boundary):
            return 2

    insns = disassemble(args.start, args.end, args.mode)
    if not insns:
        print("WARNING: objdump produced no decoded instructions", file=sys.stderr)

    body = emit(args.start, args.end, args.mode, name, insns)
    out.write_text(body)
    print(f"wrote {out.relative_to(ROOT)}  "
          f"({args.end - args.start} bytes, {len(insns)} instrs, name={name})",
          file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
