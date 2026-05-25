#!/usr/bin/env python3
"""Compile the ROM and diff one function against the baserom.

Adapted from Mizuchi (https://github.com/macabeus/mizuchi),
specifically the compile_and_view_assembly MCP tool in
src/plugins/claude-runner/claude-runner-plugin.ts.
Copyright (c) 2025 macabeus, MIT License. See prompts/ATTRIBUTION.md.

Differences from upstream:
  - Builds the entire ROM incrementally (`make -j8`) rather than compiling
    one .c file to one .o in a sandbox. The decomp lives in the actual
    source tree; the tool just measures.
  - Diffs the function's byte range between the built ROM and the baserom
    using arm-none-eabi-objdump, then categorizes line-by-line.
  - No MCP server (yet) — this is a one-shot CLI returning JSON or human.

Usage:
    compile_and_view_assembly.py <FunctionName>
    compile_and_view_assembly.py <FunctionName> --human
    compile_and_view_assembly.py <FunctionName> --window 256  # extra bytes after

Output (JSON, default):
    {
      "function": "ZebesianAquaIdleInit",
      "build_ok": true,
      "build_errors": "",
      "addr": 0x804c8b4,
      "size": 40,
      "diff_count": 0,
      "byte_diff": 0,
      "mismatches": [
        {"offset_target": 4, "offset_built": 4, "kind": "OPCODE_MISMATCH",
         "target": "ldrb r0, [r2]", "built": "ldrh r0, [r2]"},
        ...
      ]
    }

Exit codes:
  0  function matches (diff_count == 0)
  1  built but nonmatching, OR function not in .map
  2  build failed
"""

from __future__ import annotations

import argparse
import difflib
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
BUILTROM = ROOT / "frog_us.gba"
MAP_FILE = ROOT / "frog_us.map"
ASM_DIR = ROOT / "asm"
ROM_BASE = 0x08000000

OBJDUMP = "arm-none-eabi-objdump"
MAKE = "make"

# .map symbol line: `   0x0804c8b4   ZebesianAquaIdleInit`
MAP_SYM_RE = re.compile(r"^\s+0x([0-9a-fA-F]{8,})\s+([A-Za-z_]\w*)\s*$")

# disasm marker line: `FunctionName: @ 0x0804C744`
DISASM_ADDR_RE = re.compile(r"^(\S+):\s*@\s*0x([0-9a-fA-F]{8})")

# objdump output line: "    8c:  4a02   ldr r2, [pc, #8]   ; (98 <...>)"
OBJDUMP_LINE_RE = re.compile(
    r"^\s*([0-9a-f]+):\s+([0-9a-f ]+?)\s+(\S+)(?:\s+(.*?))?\s*$"
)


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, cwd=ROOT, **kw)


def build_incremental() -> tuple[bool, str]:
    proc = run([MAKE, "-j8"])
    ok = proc.returncode == 0 and BUILTROM.exists()
    # agbcc + ld errors land on stderr; warnings on stdout
    errors = (proc.stderr + proc.stdout).strip() if not ok else ""
    return ok, errors


def find_in_map(name: str) -> tuple[int, int] | None:
    """Return (addr, size) for `name` from frog_us.map, or None if missing.

    Size is the distance to the next symbol in the same section. If `name`
    is the last symbol it returns 0 — caller should treat that as unknown.
    """
    if not MAP_FILE.exists():
        return None
    syms: list[tuple[int, str]] = []
    for line in MAP_FILE.read_text(errors="replace").splitlines():
        m = MAP_SYM_RE.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        if addr < ROM_BASE:
            continue
        syms.append((addr, m.group(2)))
    syms.sort()
    seen: set[tuple[int, str]] = set()
    uniq: list[tuple[int, str]] = []
    for s in syms:
        if s in seen:
            continue
        seen.add(s)
        uniq.append(s)

    for i, (addr, sym) in enumerate(uniq):
        if sym != name:
            continue
        if i + 1 < len(uniq):
            size = uniq[i + 1][0] - addr
        else:
            size = 0
        return addr, size
    return None


ADDRESS_CACHE = Path(__file__).parent / ".function_addresses.json"


def baserom_addr(name: str) -> int | None:
    """Return `name`'s baserom address as ground truth.

    Source of truth, in order:
      1. `tools/agent/.function_addresses.json` (snapshot from a matching
         build via `snapshot_addresses.py`). Includes both still-in-asm
         functions (from disasm @-comments) and already-decomped C
         functions (from the matching frog_us.map).
      2. Live `@ 0xADDR` comments in `asm/disasm_*.s`. Useful before the
         cache has been generated, but disappears as soon as an agent
         deletes the asm stub.

    Returns None if neither source has the address (likely a typo, or a
    newly-named function that doesn't exist in baserom).
    """
    if ADDRESS_CACHE.exists():
        try:
            cache = json.loads(ADDRESS_CACHE.read_text())
            addrs = cache.get("addresses", {})
            if name in addrs:
                return int(addrs[name])
        except Exception:
            pass
    for p in sorted(ASM_DIR.glob("disasm_*.s")):
        try:
            for line in p.read_text(errors="replace").splitlines():
                m = DISASM_ADDR_RE.match(line)
                if m and m.group(1) == name:
                    return int(m.group(2), 16)
        except Exception:
            continue
    return None


def disasm_slice(rom: Path, addr: int, size: int) -> list[tuple[int, str, str]]:
    """objdump the slice [addr, addr+size) from `rom` (as raw binary).

    Returns a list of (offset_within_slice, mnemonic, args). Offsets are
    bytes from the start of the slice (so two disassemblies of equal-length
    slices align on offset).
    """
    off = addr - ROM_BASE
    proc = run([
        OBJDUMP, "-D", "-b", "binary", "-m", "arm7tdmi", "-Mforce-thumb",
        f"--start-address={off}",
        f"--stop-address={off + size}",
        str(rom),
    ])
    if proc.returncode != 0:
        return []
    out: list[tuple[int, str, str]] = []
    for line in proc.stdout.splitlines():
        m = OBJDUMP_LINE_RE.match(line)
        if not m:
            continue
        line_off = int(m.group(1), 16) - off
        mnem = m.group(3)
        args = (m.group(4) or "").split(";")[0].strip()  # drop pc-rel comment
        if mnem.startswith("."):
            continue
        out.append((line_off, mnem, args))
    return out


def categorize(target_line: str, built_line: str) -> str:
    """Refine REPLACEMENT into OPCODE_MISMATCH / ARGUMENT_MISMATCH.

    Each *_line is already "mnem args" form. If mnemonics differ → opcode.
    If only args differ → argument. If both differ → REPLACEMENT (generic).
    """
    t_mnem, _, t_args = target_line.partition(" ")
    b_mnem, _, b_args = built_line.partition(" ")
    if t_mnem != b_mnem and t_args == b_args.strip():
        return "OPCODE_MISMATCH"
    if t_mnem == b_mnem and t_args != b_args.strip():
        return "ARGUMENT_MISMATCH"
    return "REPLACEMENT"


def diff_disasms(
    target: list[tuple[int, str, str]],
    built: list[tuple[int, str, str]],
) -> list[dict]:
    """Run an instruction-level diff and classify each mismatch."""
    target_lines = [f"{m} {a}".rstrip() for _, m, a in target]
    built_lines = [f"{m} {a}".rstrip() for _, m, a in built]

    sm = difflib.SequenceMatcher(a=target_lines, b=built_lines, autojunk=False)
    out: list[dict] = []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == "equal":
            continue
        if tag == "insert":
            for j in range(j1, j2):
                out.append({
                    "offset_target": target[min(i1, len(target) - 1)][0] if target else 0,
                    "offset_built": built[j][0],
                    "kind": "INSERTION",
                    "target": "",
                    "built": built_lines[j],
                })
        elif tag == "delete":
            for i in range(i1, i2):
                out.append({
                    "offset_target": target[i][0],
                    "offset_built": built[min(j1, len(built) - 1)][0] if built else 0,
                    "kind": "DELETION",
                    "target": target_lines[i],
                    "built": "",
                })
        elif tag == "replace":
            n = max(i2 - i1, j2 - j1)
            for k in range(n):
                ti = i1 + k
                bj = j1 + k
                if ti < i2 and bj < j2:
                    out.append({
                        "offset_target": target[ti][0],
                        "offset_built": built[bj][0],
                        "kind": categorize(target_lines[ti], built_lines[bj]),
                        "target": target_lines[ti],
                        "built": built_lines[bj],
                    })
                elif ti < i2:
                    out.append({
                        "offset_target": target[ti][0],
                        "offset_built": built[min(bj, len(built) - 1)][0] if built else 0,
                        "kind": "DELETION",
                        "target": target_lines[ti],
                        "built": "",
                    })
                else:
                    out.append({
                        "offset_target": target[min(ti, len(target) - 1)][0] if target else 0,
                        "offset_built": built[bj][0],
                        "kind": "INSERTION",
                        "target": "",
                        "built": built_lines[bj],
                    })
    return out


def byte_diff(addr: int, size: int) -> int:
    base = BASEROM.read_bytes()
    built = BUILTROM.read_bytes()
    off = addr - ROM_BASE
    a = base[off : off + size]
    b = built[off : off + size]
    n = min(len(a), len(b))
    return sum(1 for k in range(n) if a[k] != b[k]) + abs(len(a) - len(b))


def measure(name: str) -> dict:
    if not BASEROM.exists():
        return {"function": name, "build_ok": False,
                "build_errors": f"missing {BASEROM.name}"}

    ok, errors = build_incremental()
    if not ok:
        return {"function": name, "build_ok": False, "build_errors": errors}

    loc = find_in_map(name)
    if loc is None:
        return {"function": name, "build_ok": True, "build_errors": "",
                "error": f"symbol {name!r} not found in {MAP_FILE.name}; "
                         "did the C define it with external linkage?"}

    addr, size = loc
    if size == 0 or size > 1 << 14:
        return {"function": name, "build_ok": True, "build_errors": "",
                "addr": addr, "size": size,
                "error": f"could not determine reasonable size for {name!r} "
                         f"(got {size}); next-symbol lookup likely missed"}

    # Layout-drift check: if the function used to live in asm/disasm_*.s
    # with a known baserom address and the .map now reports a different
    # address, the C version is at the wrong offset — the per-function diff
    # would be measuring the wrong slice. Surface this explicitly so the
    # agent doesn't try to "fix" the codegen.
    original_addr = baserom_addr(name)
    layout_drift = (original_addr is not None and original_addr != addr)
    if layout_drift:
        # Diff at the BASEROM address — that's what the function *should* match.
        bd_built_pos = byte_diff(addr, size)  # built address — meaningless
        bd_target_pos = byte_diff(
            original_addr, size
        )  # baserom at original addr vs built at original addr
        return {
            "function": name,
            "build_ok": True,
            "build_errors": "",
            "addr": addr,
            "original_addr": original_addr,
            "size": size,
            "layout_drift": True,
            "byte_diff_at_built_addr": bd_built_pos,
            "byte_diff_at_original_addr": bd_target_pos,
            "error": (
                f"LAYOUT DRIFT: {name!r} now lives at {addr:#010x} but the "
                f"baserom has it at {original_addr:#010x}. The function moved "
                f"by {addr - original_addr:+#x} bytes. This is not a codegen "
                "bug — your C compiled fine, but it ended up in a C file "
                "that doesn't sit at the right position in linker.ld. To "
                "match, either (a) decompile the preceding functions in the "
                "same asm file first so this one lands in baserom order, or "
                "(b) create a new C file at the right linker.ld position. "
                "Revert your changes for this function and pick a legal "
                "target (see `tools/agent/pick_target.py`)."
            ),
        }

    target = disasm_slice(BASEROM, addr, size)
    built = disasm_slice(BUILTROM, addr, size)
    mismatches = diff_disasms(target, built)
    bd = byte_diff(addr, size)

    return {
        "function": name,
        "build_ok": True,
        "build_errors": "",
        "addr": addr,
        "size": size,
        "layout_drift": False,
        "diff_count": len(mismatches),
        "byte_diff": bd,
        "mismatches": mismatches,
    }


def print_human(r: dict) -> None:
    print(f"function:  {r['function']}")
    if not r.get("build_ok"):
        print(f"BUILD FAILED")
        if r.get("build_errors"):
            print("---")
            print(r["build_errors"])
        return
    if r.get("layout_drift"):
        print(f"LAYOUT DRIFT")
        print(f"  built at: {r['addr']:#010x}")
        print(f"  baserom:  {r['original_addr']:#010x}")
        print(f"  shift:    {r['addr'] - r['original_addr']:+#x} bytes")
        print(f"  byte_diff @ built_addr:    {r['byte_diff_at_built_addr']}")
        print(f"  byte_diff @ original_addr: {r['byte_diff_at_original_addr']}")
        print()
        print(r["error"])
        return
    if "error" in r:
        print(f"ERROR:     {r['error']}")
        return
    print(f"addr:      {r['addr']:#010x}  size: {r['size']} bytes")
    print(f"byte_diff: {r['byte_diff']}")
    print(f"diff_count: {r['diff_count']}  (Thumb instruction-level)")
    if r["diff_count"] == 0:
        print("MATCH ✓")
        return
    print("mismatches:")
    for m in r["mismatches"][:30]:
        ot = m["offset_target"]
        print(f"  +{ot:#06x}  {m['kind']:<18}  "
              f"target: {m['target']:<40}  built: {m['built']}")


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("name", help="function symbol to diff")
    p.add_argument("--human", action="store_true")
    args = p.parse_args()

    r = measure(args.name)
    if args.human:
        print_human(r)
    else:
        json.dump(r, sys.stdout, indent=2)
        sys.stdout.write("\n")

    if not r.get("build_ok"):
        return 2
    if "error" in r:
        return 1
    return 0 if r.get("diff_count") == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
