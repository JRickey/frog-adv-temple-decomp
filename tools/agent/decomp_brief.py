#!/usr/bin/env python3
"""Bundle everything an agent needs to start a C decomp of one function.

Composes the existing tools (extract-function-bytes, dump_pool,
struct_xref, m2c) and reports any blockers (unpeeled callees, missing
scaffold) up front, so the C author doesn't waste time discovering
them mid-iteration.

Sections:
  1. Function header — name, address range, byte size.
  2. Callee table — for each cross-slice BL, whether it's peeled
     (callable from C) or not (would need `auto_peel.py --addr 0x...`
     before the C decomp can match).
  3. Pool table — every `ldr [pc, #N]` site with the resolved address
     and human label (REG_IE, gGameStuff, IWRAM 0x...).
  4. Struct cross-ref — for each unique IWRAM/EWRAM pool base, the
     full read/write site map from `tools/agent/struct_xref.py`.
  5. m2c seed C — the pseudo-C m2c generates from the asm. Not the
     final answer — m2c misses cross-region BLs (they're `.4byte`
     raw) and may pick weird shapes — but it's a fast starting point.
  6. Suggested destination — where in `src/` the .c file should land
     per `linker.ld` adjacency.

Usage:
    python3 tools/agent/decomp_brief.py sub_08000430
    python3 tools/agent/decomp_brief.py sub_08000430 --json
    python3 tools/agent/decomp_brief.py sub_08000430 --seed-only > scratch.c
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

import evidence

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
ROM_BASE = 0x08000000


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, cwd=ROOT, **kw)


def resolve_range(name: str) -> tuple[int, int, Path]:
    """Find a function by `thumb_func_start NAME` across asm/disasm_0x*.s.
    Returns (start, end, asm_path)."""
    for path in (ROOT / "asm").glob("disasm_0x*.s"):
        text = path.read_text(errors="replace")
        if not re.search(rf"thumb_func_start\s+{re.escape(name)}\b", text):
            continue
        m = re.search(
            r"Range:\s*\[0x([0-9a-fA-F]+),\s*0x([0-9a-fA-F]+)\)", text)
        if m:
            return int(m.group(1), 16), int(m.group(2), 16), path
        # Fall back to filename → start, file size → end.
        fm = re.match(r"disasm_(0x[0-9a-fA-F]+)\.s", path.name)
        if fm:
            start = int(fm.group(1), 16)
            # Last resort: ask the boundary detector.
            return start, _detect_end(start), path
    raise SystemExit(f"function {name!r} not found in asm/disasm_*.s")


def _detect_end(start: int) -> int:
    detector = ROOT / "tools/agent/ts/cmds/detect-fn-boundary.ts"
    proc = run(["npx", "tsx", str(detector), f"0x{start:08x}", "--json"])
    rep = json.loads(proc.stdout)
    return int(rep["recommendedEnd"])


def list_callees(start: int, end: int) -> list[int]:
    """All cross-slice BL targets from [start, end), in source order."""
    proc = run([
        "arm-none-eabi-objdump",
        "-D", "-b", "binary", "-m", "arm7tdmi", "-Mforce-thumb",
        f"--adjust-vma=0x{ROM_BASE:x}",
        f"--start-address=0x{start:x}",
        f"--stop-address=0x{end:x}",
        str(BASEROM),
    ])
    bl_re = re.compile(r"^\s*[0-9a-f]+:\s+[0-9a-f]+\s+[0-9a-f]+\s+bl\s+0x([0-9a-f]+)")
    seen: set[int] = set()
    out: list[int] = []
    for line in proc.stdout.splitlines():
        m = bl_re.match(line)
        if not m:
            continue
        t = int(m.group(1), 16)
        if t < start or t >= end:
            if t not in seen:
                seen.add(t)
                out.append(t)
    return out


def peeled_starts() -> set[int]:
    """All addresses considered already-resolved for BL relocations.

    A callee is "resolved" — i.e., NOT a blocker for C decomp — when it
    has a real symbol that ld will pick up at link time. That covers:

      1. `asm/disasm_0x<ADDR>.s` exists (the file is named after the
         function's start address). The original peel discipline.
      2. ANY `asm/disasm_0x*.s` file contains `thumb_func_start
         sub_<HEX>` for the address — catches PAIRED peels where one .s
         holds two named functions (the iter-18 hidden-fn pattern).
      3. `src/**/*.c` contains a function with the address-named symbol
         (or, 4., `frog_us.map` places any symbol at the address — renamed C)
         (`sub_<HEX>(`). Catches callees already lifted to C — this
         was the iter-22/23/25/26 false-positive class that burned 4+
         iters of effort before this fix.

    Without this, agents waste time peeling functions that already have
    real symbols, or worse, auto_peel.py hangs trying to peel bytes that
    already live in src/.
    """
    addrs: set[int] = set()

    # (1) filename-derived addresses
    for p in (ROOT / "asm").glob("disasm_0x*.s"):
        m = re.match(r"disasm_(0x[0-9a-fA-F]+)\.s", p.name)
        if m:
            addrs.add(int(m.group(1), 16))

    # (2) every `thumb_func_start sub_HEX` label across all disasm files
    label_re = re.compile(r"thumb_func_start\s+sub_([0-9a-fA-F]{6,8})\b")
    for p in (ROOT / "asm").glob("disasm_0x*.s"):
        try:
            for m in label_re.finditer(p.read_text()):
                addrs.add(int(m.group(1), 16))
        except OSError:
            pass

    # (3) `sub_HEX(` definitions in any src/**/*.c
    # Lightweight scan: open-paren or whitespace after the name to avoid
    # matching cross-references in comments. False negatives are fine;
    # false positives here would cause the OPPOSITE bug (silently miss
    # a real blocker), so be strict.
    c_def_re = re.compile(r"\b(?:NAKED\s+)?(?:void|u\d+|s\d+|int|bool)\s+"
                          r"sub_([0-9a-fA-F]{6,8})\s*\(")
    for p in (ROOT / "src").rglob("*.c"):
        try:
            for m in c_def_re.finditer(p.read_text()):
                addrs.add(int(m.group(1), 16))
        except OSError:
            pass

    # (4) every symbol ld actually placed in .text, from the link map.
    # Catches renamed C functions (Input_Poll, Sound_Play, ...) which (3)
    # can't see because they no longer carry an address-derived name.
    map_path = ROOT / "frog_us.map"
    sym_re = re.compile(r"^\s+0x0*(8[0-9a-fA-F]{6})\s+[A-Za-z_]\w*\s*$", re.M)
    if map_path.exists():
        try:
            for m in sym_re.finditer(map_path.read_text()):
                addrs.add(int(m.group(1), 16))
        except OSError:
            pass

    return addrs


def pool_labels(name: str) -> str:
    """Run dump_pool and return its human-formatted output (or empty)."""
    proc = run(["python3", str(ROOT / "tools/agent/dump_pool.py"), name])
    return proc.stdout if proc.returncode == 0 else ""


def pool_iwram_bases(name: str) -> list[int]:
    """Just the unique IWRAM/EWRAM addresses from dump_pool's JSON."""
    proc = run(["python3", str(ROOT / "tools/agent/dump_pool.py"), name, "--json"])
    if proc.returncode != 0:
        return []
    rep = json.loads(proc.stdout)
    bases: list[int] = []
    seen: set[int] = set()
    for e in rep.get("entries", []):
        v = e["value"]
        if (0x02000000 <= v < 0x02040000 or 0x03000000 <= v < 0x03008000) and v not in seen:
            seen.add(v)
            bases.append(v)
    return bases


def struct_xref(addr: int) -> str:
    proc = run(["python3", str(ROOT / "tools/agent/struct_xref.py"),
                f"0x{addr:08x}"])
    return proc.stdout if proc.returncode == 0 else ""


def m2c_seed(asm_path: Path, fn: str) -> str:
    m2c = ROOT / "vendor/m2c/.venv/bin/python"
    script = ROOT / "vendor/m2c/m2c.py"
    if not m2c.exists() or not script.exists():
        return "(m2c not installed — run scripts/setup-m2c.sh)\n"
    cmd = [str(m2c), str(script), str(asm_path),
           "--target", "arm", "--function", fn, "--globals", "none"]
    # Feed m2c the project's structs/types/signatures so field accesses resolve
    # to names instead of raw unkNN offsets. ctx.c is generated/refreshed by
    # m2c_run (shared helper); failure is non-fatal (m2c still seeds untyped).
    try:
        sys.path.insert(0, str(ROOT / "tools/agent"))
        import m2c_run
        if m2c_run.ensure_context() and m2c_run.CTX.exists():
            cmd += ["--context", str(m2c_run.CTX)]
    except Exception:
        pass
    proc = run(cmd)
    # The "function is still .incbin" case: m2c can't parse raw bytes, so
    # it reports the failure as a /* ... */ comment in stdout. Surface
    # that explicitly — it's the most common failure mode and a peel-state
    # issue, not a m2c bug. Check this BEFORE the returncode branch since
    # m2c may exit 0 or 1 in this case depending on version.
    if "Skipping .incbin directive" in proc.stdout or \
       "contains no instructions" in proc.stdout:
        return (
            "(m2c can't seed this function — its body is still .incbin'd.\n"
            " Refine the asm to mnemonics first (see CLAUDE.md \n"
            " 'Refining a peeled chunk into real Thumb/ARM mnemonics'),\n"
            " or fall back to writing C against the raw disassembly via\n"
            " tools/agent/dump_pool.py + objdump -Mforce-thumb.)\n"
        )
    # Other failures: m2c writes most errors to stdout (as /* ... */
    # comments) and may exit 0 or non-zero depending on the error. Fall
    # back to stdout when stderr is empty.
    if proc.returncode != 0:
        msg = (proc.stderr.strip() or proc.stdout.strip()
               or f"exit code {proc.returncode}, no output")
        return f"(m2c failed: {msg})\n"
    return proc.stdout


def suggest_destination(start: int) -> str:
    """Read linker.ld and report which neighbour C file the new src/ should
    land next to. Mirrors pick_target.py's rules without re-importing."""
    text = (ROOT / "linker.ld").read_text()
    obj_re = re.compile(
        r"^\s*(\S+\.o)\(\.text\);\s*/\*\s*0x([0-9a-fA-F]+)\s*-\s*0x([0-9a-fA-F]+)")
    target_obj = f"asm/disasm_0x{start:08x}.o"
    prev_src: str | None = None
    next_src: str | None = None
    found = False
    for line in text.splitlines():
        m = obj_re.match(line)
        if not m:
            continue
        obj = m.group(1)
        if obj == target_obj:
            found = True
            continue
        if not found and obj.startswith("src/"):
            prev_src = obj
        elif found and obj.startswith("src/"):
            next_src = obj
            break
    if not found:
        return f"(target asm at 0x{start:08x} not currently in linker.ld)"
    if prev_src:
        return f"adjacent src C file (prev neighbour): {prev_src.replace('.o', '.c')}"
    if next_src:
        return f"adjacent src C file (next neighbour): {next_src.replace('.o', '.c')}"
    return "no adjacent src/*.c — scaffold a new file (e.g., src/system/<name>.c)"


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("target", help="function name (e.g. sub_08000430)")
    p.add_argument("--json", action="store_true")
    p.add_argument("--seed-only", action="store_true",
                   help="print only the m2c seed C (no other sections)")
    p.add_argument("--evidence-limit", type=int, default=8,
                   help="maximum relevant evidence records to include")
    args = p.parse_args()

    start, end, asm_path = resolve_range(args.target)
    callees = list_callees(start, end)
    peeled = peeled_starts()

    if args.seed_only:
        sys.stdout.write(m2c_seed(asm_path, args.target))
        return 0

    if args.json:
        bases = pool_iwram_bases(args.target)
        try:
            evidence_records = evidence.brief_data(
                evidence.load_records(ROOT / "docs/evidence"), args.target,
                ROOT, args.evidence_limit, ROOT / "tools/agent/callgraph.db")
            evidence_error = None
        except evidence.EvidenceError as exc:
            evidence_records = []
            evidence_error = str(exc)
        json.dump({
            "function": args.target,
            "range": [start, end],
            "asm_path": str(asm_path.relative_to(ROOT)),
            "callees": [
                {"addr": c, "peeled": c in peeled} for c in callees
            ],
            "iwram_bases": bases,
            "destination_hint": suggest_destination(start),
            "m2c_seed": m2c_seed(asm_path, args.target),
            "evidence": evidence_records,
            "evidence_error": evidence_error,
        }, sys.stdout, indent=2)
        sys.stdout.write("\n")
        return 0

    print(f"== Function ==")
    print(f"  name:   {args.target}")
    print(f"  range:  [0x{start:08x}, 0x{end:08x})  ({end - start} bytes)")
    print(f"  asm:    {asm_path.relative_to(ROOT)}")
    print()

    print(f"== Callees ({len(callees)}) ==")
    if not callees:
        print("  (none — pure leaf function)")
    else:
        for c in callees:
            tag = "peeled ✓" if c in peeled else "UNPEELED ✗  (block C decomp)"
            print(f"  0x{c:08x}  {tag}")
        unpeeled = [c for c in callees if c not in peeled]
        if unpeeled:
            cmd = " ".join(f"--addr 0x{c:08x}" for c in unpeeled)
            print(f"\n  → before C decomp, run:")
            print(f"    python3 tools/agent/auto_peel.py "
                  f"--callees-of {args.target} --apply")
            print(f"    (or per-address: tools/agent/auto_peel.py {cmd} --apply)")
    print()

    print("== Evidence ==")
    try:
        evidence_records = evidence.brief_data(
            evidence.load_records(ROOT / "docs/evidence"), args.target,
            ROOT, args.evidence_limit, ROOT / "tools/agent/callgraph.db")
        sys.stdout.write(evidence.format_records(evidence_records, ROOT, compact=True))
    except evidence.EvidenceError as exc:
        print(f"  (evidence unavailable: {exc})")
    print()

    print(f"== Pool ==")
    out = pool_labels(args.target).strip()
    if out:
        print("\n".join("  " + ln for ln in out.splitlines()))
    else:
        print("  (no PC-relative loads found)")
    print()

    bases = pool_iwram_bases(args.target)
    print(f"== Struct cross-ref ({len(bases)} unique IWRAM/EWRAM bases) ==")
    for b in bases:
        print(f"\n  -- base 0x{b:08x} --")
        text = struct_xref(b).strip()
        if not text:
            print("    (struct_xref returned nothing)")
            continue
        for line in text.splitlines():
            print(f"    {line}")
    print()

    print(f"== m2c seed C ==")
    seed = m2c_seed(asm_path, args.target).rstrip()
    if seed:
        print("\n".join("  " + ln for ln in seed.splitlines()))
    print()

    print(f"== Destination ==")
    print(f"  {suggest_destination(start)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
