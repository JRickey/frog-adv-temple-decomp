#!/usr/bin/env python3
"""Run m2c against a baserom function and print the seed C.

m2c needs GNU-`as` Thumb mnemonics with literal pools resolved; it treats
`.incbin` as data only and will NOT disassemble raw bytes (see
vendor/m2c/m2c/asm_file.py:parse_incbin). The asm/disasm_*.s files in this
repo are `.incbin`-bodied (mnemonics live only in `@`-comments), and NAKED
functions ship as `.incbin` in src/. So neither source is directly
m2c-ingestible.

This tool bridges that gap: it resolves a function's baserom byte-range,
disassembles it as Thumb via arm-none-eabi-objdump, rewrites the objdump
output into m2c-parseable GNU-as (glabel + `.L` jump labels + `ldr rX,=val`
pool loads + symbol-resolved `bl`/`b` targets, literal-pool words skipped),
and runs m2c with --target arm and the project context file.

  python3 tools/agent/m2c_run.py <Fn> [<Fn> ...]
  python3 tools/agent/m2c_run.py --all-naked
  python3 tools/agent/m2c_run.py <Fn> --asm-only   # just print the .s
  python3 tools/agent/m2c_run.py <Fn> --no-context # skip --context

Context (the project's structs/types/signatures) is supplied to m2c
automatically: ctx.c is generated from include/ headers on first run and
refreshed when a header changes. Without it m2c emits raw `unk2`/`unkA`
field offsets; with it they resolve to named fields.

Outputs land in tools/agent/m2c_out/<Fn>.s and <Fn>.c (printed to stdout too).
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASEROM = ROOT / "frog_us_baserom.gba"
MAP = ROOT / "frog_us.map"
SRC = ROOT / "src"
OUTDIR = ROOT / "tools/agent/m2c_out"
ADDRESS_CACHE = ROOT / "tools/agent/.function_addresses.json"
CTX = OUTDIR / "ctx.c"
M2C_PY = ROOT / "vendor/m2c/.venv/bin/python"
M2C = ROOT / "vendor/m2c/m2c.py"
OBJDUMP = "arm-none-eabi-objdump"
ROM_BASE = 0x08000000

# Thumb branch mnemonics (after stripping .n/.w). Note blt/ble/bls start with
# "bl" but are conditional branches, NOT the bl/blx call — keep them here.
BRANCH_BASES = {
    "b", "beq", "bne", "bcs", "bhs", "bcc", "blo", "bmi", "bpl",
    "bvs", "bvc", "bhi", "bls", "bge", "blt", "bgt", "ble", "bal",
}

# `   8017364:\tb5f0      \tpush\t{r4, lr}`  (objdump -D on raw binary)
RE_INSN = re.compile(r"^\s*([0-9a-fA-F]+):\s+((?:[0-9a-fA-F]{4} ?)+)\s+(\S.*)$")
# A map symbol line: `                0x08017364                SaveLoad`
RE_MAPSYM = re.compile(r"^\s+0x0([0-9a-fA-F]{7,8})\s+([A-Za-z_]\w*)\s*$")
RE_PEELED_RANGE = re.compile(
    r"Range:\s*\[0x([0-9a-fA-F]+),\s*0x([0-9a-fA-F]+)\)"
)
RE_FUNCTION_START = re.compile(
    r"^\s*(?:thumb_func_start|arm_func_start)\s+([A-Za-z_]\w*)\b",
    re.MULTILINE,
)
RE_FUNCTION_LABEL = re.compile(
    r"^\s*([A-Za-z_]\w*):\s*@\s*0x([0-9a-fA-F]+)\b",
    re.MULTILINE,
)
C_FUNCTION_NAME = re.compile(
    r"(?m)^(?![ \t]*(?:#|if|for|while|switch|return|typedef)\b)"
    r"[ \t]*(?:[A-Za-z_]\w*[ \t*]+)+([A-Za-z_]\w*)\s*\("
)


def load_symbols() -> dict[int, str]:
    """addr -> name, with immutable cached function entries over live map data."""
    syms: dict[int, str] = {}
    if MAP.exists():
        for line in MAP.read_text(errors="replace").splitlines():
            m = RE_MAPSYM.match(line)
            if m:
                addr = int(m.group(1), 16)
                name = m.group(2)
                # Skip linker-internal and obvious non-code/data filler.
                if name in ("ABSOLUTE",):
                    continue
                syms[addr] = name

    cached_addrs = load_cached_addresses()
    function_names = known_function_names()
    cached_functions = {
        name: addr for name, addr in cached_addrs.items()
        if name in function_names
    }
    # A candidate build can move a function while its data symbols remain
    # correct. Remove only those stale function mappings, retain map-only data,
    # then restore each known function's matching-build baserom address.
    cached_names = set(cached_functions)
    syms = {addr: name for addr, name in syms.items() if name not in cached_names}
    syms.update({addr: name for name, addr in cached_functions.items()})
    return syms


def load_cached_addresses() -> dict[str, int]:
    """Read the matching-build baserom address snapshot, if available."""
    try:
        payload = json.loads(ADDRESS_CACHE.read_text())
        return {name: int(addr) for name, addr in payload["addresses"].items()}
    except (OSError, ValueError, KeyError, TypeError):
        return {}


def known_function_names() -> set[str]:
    """Names that are presently defined as code, rather than map-only data."""
    names: set[str] = set()
    for asm_path in (ROOT / "asm").glob("disasm_0x*.s"):
        names.update(RE_FUNCTION_START.findall(asm_path.read_text(errors="replace")))
    for cfile in SRC.rglob("*.c"):
        names.update(C_FUNCTION_NAME.findall(cfile.read_text(errors="replace")))
    return names


def peeled_range(fn: str, cached_addrs: dict[str, int]) -> tuple[int, int] | None:
    """Return `fn`'s exact extent from an auto-peel range header.

    A header can cover several functions. Their label comments (or the
    matching-build cache when a comment is unavailable) bound each member, so
    a first function never consumes the rest of a multi-function slice.
    """
    for asm_path in sorted((ROOT / "asm").glob("disasm_0x*.s")):
        text = asm_path.read_text(errors="replace")
        starts = set(RE_FUNCTION_START.findall(text))
        if fn not in starts:
            continue
        match = RE_PEELED_RANGE.search(text)
        if not match:
            continue
        start, end = (int(match.group(i), 16) for i in (1, 2))
        labels = {
            name: int(addr, 16)
            for name, addr in RE_FUNCTION_LABEL.findall(text)
            if name in starts
        }
        addresses = {
            name: labels.get(name, cached_addrs.get(name)) for name in starts
        }
        if any(addr is None for addr in addresses.values()):
            # An unlocated sibling could be the next boundary. Do not claim
            # the whole slice as an exact range or compare None to an address.
            continue
        fn_start = addresses.get(fn)
        if fn_start is None or not start <= fn_start < end:
            continue
        next_starts = [addr for name, addr in addresses.items()
                       if name != fn and fn_start < addr < end]
        fn_end = min(next_starts, default=end)
        return fn_start - ROM_BASE, fn_end - fn_start
    return None


def cached_range(fn: str, cached_addrs: dict[str, int]) -> tuple[int, int] | None:
    """Infer a reference extent from the matching-build address snapshot."""
    addr = cached_addrs.get(fn)
    if addr is None:
        return None
    higher = [other for other in cached_addrs.values() if other > addr]
    if not higher:
        return None
    end = min(higher)
    return addr - ROM_BASE, end - addr


def resolve_range(fn: str, syms: dict[int, str]) -> tuple[int, int]:
    """Return (rom_offset, size) for `fn`.

    Prefers immutable baserom records: a NAKED `.incbin "...", off, size`, an
    auto-peel range header, or the matching-build address snapshot. Falls back
    to the live map only when no reference record remains. The live map may
    contain a shorter nonmatching C candidate, so its next-symbol delta is not
    a valid m2c reference extent for frontier work.
    """
    # 1. NAKED incbin in src/ — exact offset+size.
    pat = re.compile(
        re.escape(fn) + r"\b.*?\.incbin\s+\"[^\"]*\",\s*(0x[0-9a-fA-F]+),\s*(0x[0-9a-fA-F]+)",
        re.DOTALL,
    )
    for cfile in SRC.rglob("*.c"):
        txt = cfile.read_text(errors="replace")
        idx = txt.find(fn)
        if idx == -1:
            continue
        m = pat.search(txt, idx)
        if m:
            return int(m.group(1), 16), int(m.group(2), 16)
    cached_addrs = load_cached_addresses()
    if result := peeled_range(fn, cached_addrs):
        return result
    if result := cached_range(fn, cached_addrs):
        return result
    # 2. Map: find addr, size from next symbol.
    addr = next((a for a, n in syms.items() if n == fn), None)
    if addr is None:
        raise SystemExit(f"Cannot resolve address for {fn} (not NAKED, not in map)")
    higher = sorted(a for a in syms if a > addr)
    if not higher:
        raise SystemExit(f"Cannot infer size for {fn} (no following symbol)")
    return addr - ROM_BASE, higher[0] - addr


def _objdump_region(data: bytes, vaddr: int, start: int, end: int) -> list[tuple[int, str, str]]:
    """objdump [start, end) of `data` (vaddr-based) as Thumb, realigned to start."""
    tmp = OUTDIR / "_slice.bin"
    tmp.write_bytes(data[start - vaddr:end - vaddr])
    out = subprocess.run(
        [OBJDUMP, "-D", "-b", "binary", "-m", "arm7tdmi", "-Mforce-thumb",
         f"--adjust-vma={start:#x}", str(tmp)],
        capture_output=True, text=True, check=True,
    ).stdout
    insns: list[tuple[int, str, str]] = []
    for line in out.splitlines():
        m = RE_INSN.match(line)
        if not m:
            continue
        addr = int(m.group(1), 16)
        rest = re.split(r"\s*[;@]\s*", m.group(3), maxsplit=1)[0].rstrip()
        parts = rest.split(None, 1)
        if not parts:
            continue
        insns.append((addr, parts[0], parts[1] if len(parts) > 1 else ""))
    return insns


def _merge_pool_ranges(pools: set[int]) -> list[tuple[int, int]]:
    """Merge 4-byte pool words into contiguous [start, end) ranges."""
    ranges: list[tuple[int, int]] = []
    for p in sorted(pools):
        if ranges and p <= ranges[-1][1]:
            ranges[-1] = (ranges[-1][0], max(ranges[-1][1], p + 4))
        else:
            ranges.append((p, p + 4))
    return ranges


def _read_jump_table(romdata: bytes, V: int, vaddr: int, end: int) -> list[int]:
    """Read a word jump table at V: consecutive in-range code targets. Stops at
    the lowest target seen (case bodies always follow the table) or an
    out-of-range word. Returns case-target addresses (thumb bit masked)."""
    entries: list[int] = []
    a, min_t = V, None
    while a + 4 <= end and len(entries) < 256:
        if min_t is not None and a >= min_t:
            break
        t = int.from_bytes(romdata[a - ROM_BASE:a - ROM_BASE + 4], "little") & ~1
        if not (vaddr <= t < end):
            break
        entries.append(t)
        min_t = t if min_t is None else min(min_t, t)
        a += 4
    return entries


def disassemble(data: bytes, vaddr: int, size: int,
                ) -> tuple[list[tuple[int, str, str]], set[int], dict[int, list[int]]]:
    """Pool-aware Thumb disassembly with jump-table carving.

    Embedded data (a literal pool, or a `mov pc`-style switch jump table)
    disassembles as garbage and desyncs objdump's linear instruction stream
    after it (real instruction boundaries vanish). We iterate to a fixpoint:
    find `ldr rX,[pc,#N]` pool words AND jump tables (pool values that point
    inside the function, when the function has a computed PC write), carve those
    byte ranges out, re-disassemble each code segment realigned, rescan.
    Returns (instructions, pool_word_addrs, {table_base: [case_targets]}).
    """
    end = vaddr + size
    romdata = BASEROM.read_bytes()
    pools: set[int] = set()
    jtables: dict[int, list[int]] = {}
    insns: list[tuple[int, str, str]] = []
    for _ in range(12):  # fixpoint; pools/tables rarely nest more than a couple deep
        insns = []
        # Carve both pool words (4B) and full table extents.
        carve = [(p, p + 4) for p in pools]
        carve += [(V, V + 4 * len(t)) for V, t in jtables.items()]
        carve.sort()
        merged: list[list[int]] = []
        for s, e in carve:
            if merged and s <= merged[-1][1]:
                merged[-1][1] = max(merged[-1][1], e)
            else:
                merged.append([s, e])
        cur = vaddr
        for rs, re_ in merged:
            if rs > cur:
                insns += _objdump_region(data, vaddr, cur, min(rs, end))
            cur = max(cur, re_)
        if cur < end:
            insns += _objdump_region(data, vaddr, cur, end)

        new_pools = set(pools)
        for addr, mnem, ops in insns:
            if mnem.split(".")[0].startswith("ldr"):
                mm = re.search(r"\[pc,\s*#(-?\d+)\]", ops)
                if mm:
                    pa = ((addr + 4) & ~3) + int(mm.group(1))
                    if vaddr <= pa < end:
                        new_pools.add(pa)
        # A switch needs a register PC write (mov pc,rX / ldr pc / add pc). Only
        # then treat in-range pool values as jump-table bases — keeps non-switch
        # functions (no computed jump) completely unaffected.
        has_switch = any(
            mnem.split(".")[0] in ("mov", "add", "ldr") and ops.split(",")[0].strip() == "pc"
            for _, mnem, ops in insns
        )
        new_jt = dict(jtables)
        if has_switch:
            for pa in new_pools:
                V = int.from_bytes(romdata[pa - ROM_BASE:pa - ROM_BASE + 4], "little")
                if vaddr < V < end and V % 2 == 0 and V not in new_jt:
                    ents = _read_jump_table(romdata, V, vaddr, end)
                    if ents:
                        new_jt[V] = ents
        if new_pools == pools and new_jt == jtables:
            break
        pools, jtables = new_pools, new_jt
    return insns, pools, jtables


def emit_asm(fn: str, rom_off: int, size: int, syms: dict[int, str]) -> str:
    vaddr = rom_off + ROM_BASE
    romdata = BASEROM.read_bytes()
    data = romdata[rom_off:rom_off + size]
    insns, pool_words, jtables = disassemble(data, vaddr, size)

    # Pool word values + in-function branch targets.
    pool: dict[int, int] = {}   # pool_addr -> 32-bit value
    for pa in pool_words:
        off = pa - ROM_BASE
        pool[pa] = int.from_bytes(romdata[off:off + 4], "little")
    branch_targets: set[int] = set()
    for addr, mnem, ops in insns:
        if mnem.split(".")[0] in BRANCH_BASES:  # blt/ble/bls start "bl" but ARE branches
            mm = re.match(r"^(0x[0-9a-fA-F]+)$", ops.strip())
            if mm:
                t = int(mm.group(1), 16)
                if vaddr <= t < vaddr + size:
                    branch_targets.add(t)
    # Every jump-table case target needs a code label m2c can resolve.
    for V, ents in jtables.items():
        branch_targets.update(ents)
    table_slots: dict[int, int] = {}  # pool-slot addr -> table base (filled while emitting)

    def label(addr: int) -> str:
        return f".L{addr:08X}"

    def sym_or_hex(value: int) -> str:
        if value in syms:
            return syms[value]
        return f"0x{value:08X}"

    lines = [
        "    .include \"macros.inc\"   @ harmless if absent; m2c ignores unknown",
        "    .text",
        "    .thumb",
        "    .syntax unified",
        f"glabel {fn}",
    ]
    for addr, mnem, ops in insns:
        if addr in branch_targets:
            lines.append(f"{label(addr)}:")
        base = mnem.split(".")[0]  # strip Thumb .n/.w width suffix
        # Pool load. Jump-table base -> ldr rX, lbl_p_<slot> (symbol load, so
        # m2c follows slot -> table -> cases). Otherwise -> ldr rX, =value.
        if mnem.startswith("ldr") and "[pc" in ops:
            mm = re.search(r"\[pc,\s*#(-?\d+)\]", ops)
            reg = ops.split(",")[0].strip()
            imm = int(mm.group(1))
            paddr = ((addr + 4) & ~3) + imm
            if pool[paddr] in jtables:
                table_slots[paddr] = pool[paddr]
                lines.append(f"    {base} {reg}, lbl_p_{paddr:08X}")
            else:
                lines.append(f"    {base} {reg}, ={sym_or_hex(pool[paddr])}")
            continue
        # bl / blx target -> symbol
        if base in ("bl", "blx"):
            mm = re.match(r"^(0x[0-9a-fA-F]+)$", ops.strip())
            if mm:
                t = int(mm.group(1), 16)
                name = syms.get(t, f"func_{t:08X}")
                lines.append(f"    {base} {name}")
                continue
        # local branch -> label
        if base in BRANCH_BASES:
            mm = re.match(r"^(0x[0-9a-fA-F]+)$", ops.strip())
            if mm:
                t = int(mm.group(1), 16)
                if vaddr <= t < vaddr + size:
                    lines.append(f"    {base} {label(t)}")
                    continue
                name = syms.get(t)
                if name:
                    lines.append(f"    {base} {name}")
                    continue
        lines.append(f"    {base} {ops}".rstrip())

    # Jump-table data (in .text so m2c sees is_text). Two levels, mirroring the
    # real layout: the literal-pool slot holds the table address; the table
    # holds the case targets. lbl_ prefix keeps these as data labels, not new
    # functions (m2c re_local_label).
    if jtables:
        lines.append("")
        for paddr, V in sorted(table_slots.items()):
            lines.append(f"lbl_p_{paddr:08X}:")
            lines.append(f"    .word lbl_{V:08X}")
        for V, ents in sorted(jtables.items()):
            lines.append(f"lbl_{V:08X}:")
            for t in ents:
                lines.append(f"    .word {label(t)}")
    return "\n".join(lines) + "\n"


# Public headers fed to m2c as type/struct/signature context. Mirrors what a
# typical NAKED .c #includes; extend as new subsystems get headers.
CTX_HEADERS = [
    "types.h", "macros.h", "gba/intr.h", "iwram.h", "save.h",
    "sound.h", "entity.h", "gfx.h", "game.h", "game_constants.h",
]


def ensure_context() -> bool:
    """(Re)generate ctx.c — the preprocessed project headers m2c reads via
    --context to resolve struct fields, types, and function signatures. Built
    with the build's cpp flags; agbcc-isms pycparser can't parse are neutered.
    Returns True if a usable ctx.c exists."""
    newest = max((( ROOT / "include" / h).stat().st_mtime
                  for h in CTX_HEADERS if (ROOT / "include" / h).exists()),
                 default=0.0)
    if CTX.exists() and CTX.stat().st_mtime >= newest:
        return True
    src = "".join(f'#include "{h}"\n' for h in CTX_HEADERS)
    tmp = OUTDIR / "_ctx_src.c"
    tmp.write_text(src)
    cpp = subprocess.run([str(ROOT / "tools/find_cpp.sh")], capture_output=True,
                         text=True).stdout.strip() or "cpp"
    proc = subprocess.run(
        [cpp, "-P", "-nostdinc", f"-I{ROOT/'include'}", f"-I{ROOT/'tools/agbcc/include'}",
         "-DREGION_US", "-D__attribute__(x)=", "-D__asm__(x)=", "-Dasm(x)=", "-Dvolatile=",
         str(tmp), "-o", str(CTX)],
        capture_output=True, text=True,
    )
    if proc.returncode != 0:
        print(f"(ctx.c generation failed: {proc.stderr.strip()})", file=sys.stderr)
        return CTX.exists()
    return True


def run_m2c(asm_path: Path, fn: str, use_context: bool) -> str:
    cmd = [str(M2C_PY), str(M2C), str(asm_path),
           "--target", "arm", "--function", fn, "--globals", "none"]
    if use_context and CTX.exists():
        cmd += ["--context", str(CTX)]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    out = proc.stdout
    if proc.returncode != 0 and not out.strip():
        out = f"/* m2c failed (exit {proc.returncode}):\n{proc.stderr}\n*/"
    return out


def naked_functions() -> list[str]:
    fns: list[str] = []
    pat = re.compile(r"^NAKED\s+\S[^\n]*?\b([A-Za-z_]\w*)\s*\(", re.MULTILINE)
    for cfile in sorted(SRC.rglob("*.c")):
        txt = cfile.read_text(errors="replace")
        if "NON_MATCHING" not in txt:
            continue
        for m in pat.finditer(txt):
            fns.append(m.group(1))
    return fns


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("functions", nargs="*")
    ap.add_argument("--all-naked", action="store_true")
    ap.add_argument("--asm-only", action="store_true")
    ap.add_argument("--no-context", action="store_true")
    args = ap.parse_args()

    OUTDIR.mkdir(parents=True, exist_ok=True)
    if not args.asm_only and not args.no_context:
        ensure_context()  # generate/refresh ctx.c so m2c gets project types
    syms = load_symbols()
    fns = list(args.functions)
    if args.all_naked:
        fns += naked_functions()
    if not fns:
        ap.error("no functions given (use names or --all-naked)")

    for fn in fns:
        try:
            rom_off, size = resolve_range(fn, syms)
            asm = emit_asm(fn, rom_off, size, syms)
        except (SystemExit, Exception) as e:  # keep batch going on any per-fn failure
            print(f"== {fn}: {type(e).__name__}: {e}", file=sys.stderr)
            continue
        asm_path = OUTDIR / f"{fn}.s"
        asm_path.write_text(asm)
        if args.asm_only:
            print(f"/* === {fn} (asm) === */")
            print(asm)
            continue
        c = run_m2c(asm_path, fn, not args.no_context)
        (OUTDIR / f"{fn}.c").write_text(c)
        print(f"/* ===================== {fn}  "
              f"(rom 0x{rom_off:x}, {size} bytes) ===================== */")
        print(c)


if __name__ == "__main__":
    main()
