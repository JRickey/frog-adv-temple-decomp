#!/usr/bin/env python3
"""Build a relational call-graph + data-reference database for the decomp.

Produces `callgraph.db` (SQLite) from the LINKED binary (ground truth), so it
covers decompiled C, NAKED blocks, and still-`.incbin`'d asm slices alike — not
just the C source. The naming pipeline queries this DB to assemble per-function
context (who calls me, what I call, what data I touch) instead of guessing from
ROM/linker adjacency.

Pipeline (all deterministic — no LLM):
  1. Parse `frog_us.map`        -> symbol -> (addr, object_file); object sizes.
  2. Parse `linker.ld`          -> `NAME = 0xADDR;` data anchors.
  3. `objdump -d frog_us.elf`   -> every `bl`/`blx` (direct edges) + `svc`/`swi`
                                   (BIOS edges) + pc-relative `ldr` pool loads.
  4. Read pool values from the baserom -> data_refs (+ fn-pointer detection).
  5. Expand known ROM fn-pointer tables (src/data INCBIN_U32 arrays) into
     `indirect_table` edges (best-effort).
  6. Classify nodes (game/engine/system/data/libgcc/bios/asm/raw), derive status,
     `has_c_body`, `nameable`.
  7. Graph metrics in pure Python: reachability BFS from `entry`, Tarjan SCC,
     fan-in/fan-out.

Reuses the proven logic in tools/agent/check_relocations.py (ELF walk, map
parse, containing_function bisect).

Usage:
    python3 tools/agent/build_callgraph.py                 # build callgraph.db
    python3 tools/agent/build_callgraph.py --out /tmp/x.db
    python3 tools/agent/build_callgraph.py --self-check    # build + validate
    python3 tools/agent/build_callgraph.py --stats         # build + print summary
"""
from __future__ import annotations

import argparse
import bisect
import re
import sqlite3
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
ELF = ROOT / "frog_us.elf"
MAP = ROOT / "frog_us.map"
LINKER = ROOT / "linker.ld"
SRC = ROOT / "src"
DEFAULT_DB = ROOT / "callgraph.db"

ROM_BASE = 0x08000000
ROM_END = 0x0A000000

# libgcc helpers live in this contiguous tail (confirmed in linker.ld).
LIBGCC_LO = 0x08033CA4
LIBGCC_HI = 0x0803578C

# Standard GBA BIOS SWI number -> canonical name (ARM EABI / GBATEK).
BIOS_SWI = {
    0x00: "SoftReset", 0x01: "RegisterRamReset", 0x02: "Halt", 0x03: "Stop",
    0x04: "IntrWait", 0x05: "VBlankIntrWait", 0x06: "Div", 0x07: "DivArm",
    0x08: "Sqrt", 0x09: "ArcTan", 0x0A: "ArcTan2", 0x0B: "CpuSet",
    0x0C: "CpuFastSet", 0x0D: "GetBiosChecksum", 0x0E: "BgAffineSet",
    0x0F: "ObjAffineSet", 0x10: "BitUnPack", 0x11: "LZ77UnCompWram",
    0x12: "LZ77UnCompVram", 0x13: "HuffUnComp", 0x14: "RLUnCompWram",
    0x15: "RLUnCompVram", 0x16: "Diff8bitUnFilterWram",
    0x17: "Diff8bitUnFilterVram", 0x18: "Diff16bitUnFilter", 0x19: "SoundBias",
    0x1A: "SoundDriverInit", 0x1B: "SoundDriverMode", 0x1C: "SoundDriverMain",
    0x1D: "SoundDriverVSync", 0x1E: "SoundChannelClear", 0x1F: "MidiKey2Freq",
    0x20: "SoundWhatever0", 0x21: "SoundWhatever1", 0x22: "SoundWhatever2",
    0x23: "SoundWhatever3", 0x24: "SoundWhatever4", 0x25: "MultiBoot",
    0x26: "HardReset", 0x27: "CustomHalt", 0x28: "SoundDriverVSyncOff",
    0x29: "SoundDriverVSyncOn", 0x2A: "SoundGetJumpList",
}

ANON_FN_RE = re.compile(r"^sub_[0-9A-Fa-f]{8}$")
ANON_DATA_RE = re.compile(r"_[0-9A-Fa-f]{6,8}$")  # gIwram_5330, Foo_3953c8, etc.

FUNCTION_HEADER_RE = re.compile(r"^([0-9a-f]+)\s+<(\S+)>:\s*$")
INSN_RE = re.compile(r"^\s*([0-9a-f]+):\s+([0-9a-f][0-9a-f ]*?)\s*\t(\S+)(?:\s+(.*))?$")
HEX_RE = re.compile(r"(?:0x)?([0-9a-f]+)")
# objdump renders a pc-relative load's resolved pool slot in a trailing comment;
# ELF mode uses ";", binary/force-thumb mode uses "@".
POOL_SLOT_RE = re.compile(r"[;@]\s*\(?(?:0x)?([0-9a-f]+)")


# ---------------------------------------------------------------------------
# Map parsing: symbol -> addr, symbol -> object_file, object_file -> size.
# (Extends check_relocations.parse_map_addresses to also attribute objects.)
# ---------------------------------------------------------------------------
OBJ_LINE_RE = re.compile(
    r"^\s*\.(text|rodata|data|bss)\s+0x([0-9a-f]+)\s+0x([0-9a-f]+)\s+(\S+)\s*$",
    re.IGNORECASE,
)
SYM_LINE_RE = re.compile(r"^\s+0x([0-9a-f]+)\s+(\S+)\s*$")


def parse_map():
    """Return dicts:
        name_addr  : symbol -> addr (first wins)
        name_obj   : symbol -> object_file path string
        name_sect  : symbol -> section (text/rodata/data/bss)
        obj_size   : object_file -> byte size (of its latest section line)
    """
    if not MAP.exists():
        raise SystemExit(f"{MAP} not present — run `make -j8` first.")
    name_addr: dict[str, int] = {}
    name_obj: dict[str, str] = {}
    name_sect: dict[str, str] = {}
    obj_size: dict[str, int] = {}
    cur_obj = None
    cur_sect = None
    for line in MAP.read_text(errors="replace").splitlines():
        m = OBJ_LINE_RE.match(line)
        if m:
            cur_sect = m.group(1).lower()
            size = int(m.group(3), 16)
            cur_obj = m.group(4)
            if size:
                obj_size[cur_obj] = size
            continue
        s = SYM_LINE_RE.match(line)
        if s and cur_obj is not None:
            addr = int(s.group(1), 16)
            name = s.group(2).replace(".NON_MATCHING", "")
            # Skip non-symbol artifacts the regex can catch (e.g. 0x.. = expr).
            if "=" in name or name.startswith("0x"):
                continue
            name_addr.setdefault(name, addr)
            name_obj.setdefault(name, cur_obj)
            name_sect.setdefault(name, cur_sect)
    return name_addr, name_obj, name_sect, obj_size


LINKER_ASSIGN_RE = re.compile(r"^\s*([A-Za-z_]\w*)\s*=\s*0x([0-9A-Fa-f]+)\s*;")


def parse_linker_assignments() -> dict[str, int]:
    """`gFoo_08308028 = 0x08308028;` data anchors from linker.ld."""
    out: dict[str, int] = {}
    if not LINKER.exists():
        return out
    for line in LINKER.read_text(errors="replace").splitlines():
        m = LINKER_ASSIGN_RE.match(line)
        if m:
            out.setdefault(m.group(1), int(m.group(2), 16))
    return out


# ---------------------------------------------------------------------------
# Classification.
# ---------------------------------------------------------------------------
def obj_to_src(obj: str) -> str:
    """Map an object_file from the map to a source path (best-effort)."""
    if "libgcc.a" in obj:
        return obj  # keep the archive(member) form
    # src/game/foo.o -> src/game/foo.c ; asm/disasm_0x..o -> asm/disasm_0x..s
    if obj.endswith(".o"):
        base = obj[:-2]
        for ext in (".c", ".s"):
            if (ROOT / (base + ext)).exists():
                return base + ext
        return base + ".c"
    return obj


def classify_kind(name: str, obj: str, addr: int) -> str:
    if "libgcc.a" in obj or name.startswith("__") or name.startswith("_call_via_"):
        return "libgcc"
    if LIBGCC_LO <= addr < LIBGCC_HI:
        return "libgcc"
    # 64KB unpeeled ROM blobs (asm/text/text_0x*.o), asm/rom.o, header — raw,
    # not functions (the "black box until peeled" region).
    if obj.startswith("asm/rom") or obj.startswith("asm/header") or obj.startswith("asm/text"):
        return "raw"
    if obj.startswith("asm/disasm"):
        return "asm"
    if obj.startswith("src/data/"):
        return "data"
    if obj.startswith("src/game/"):
        return "game"
    if obj.startswith("src/engine/"):
        return "engine"
    if obj.startswith("src/system/"):
        return "system"
    return "asm" if obj.startswith("asm/") else "unknown"


def index_c_bodies() -> dict[str, str]:
    """name -> src/.c path that DEFINES it (even under #ifdef NON_MATCHING).
    A C definition is a line at column 0 like `T name(` / `NAKED T name(`."""
    out: dict[str, str] = {}
    def_re = re.compile(r"^[A-Za-z_][\w \t\*\(\),]*?\b([A-Za-z_]\w*)\s*\(")
    for c in SRC.rglob("*.c"):
        rel = str(c.relative_to(ROOT))
        try:
            for line in c.read_text(errors="replace").splitlines():
                if not line or line[0].isspace() or line.startswith(("#", "/", "*", "}")):
                    continue
                m = def_re.match(line)
                if m and "(" in line:
                    nm = m.group(1)
                    if nm not in ("if", "for", "while", "switch", "return", "sizeof"):
                        out.setdefault(nm, rel)
        except OSError:
            continue
    return out


def detect_naked(src_path: str, name: str) -> bool:
    """True if the C def for `name` uses NAKED / inline asm (a naked ship)."""
    p = ROOT / src_path
    if not p.exists():
        return False
    txt = p.read_text(errors="replace")
    # crude: a NAKED or `asm(` within ~40 lines after the definition line.
    lines = txt.splitlines()
    for i, line in enumerate(lines):
        if re.search(r"\b%s\s*\(" % re.escape(name), line) and (line[:1] and not line[:1].isspace()):
            window = "\n".join(lines[i:i + 60])
            return "NAKED" in window or re.search(r"\basm\s*\(", window) is not None
    return False


# ---------------------------------------------------------------------------
# Disassembly pass: edges + pool loads.
# ---------------------------------------------------------------------------
def find_baserom() -> Path:
    for cand in ("frog_us_baserom.gba", "baserom.gba", "frog_us.gba"):
        p = ROOT / cand
        if p.exists():
            return p
    raise SystemExit("no baserom/built ROM found")


def disassemble_thumb_rom(stop: int) -> str:
    """Disassemble [ROM_BASE, stop) of the baserom as raw Thumb. Unlike
    `objdump -d` on the ELF, this ignores ELF $t/$d mapping symbols, so it
    decodes the still-`.incbin`'d asm slices too (which the ELF renders as
    `.word` data). Cost: literal pools mis-decode as instructions, but real
    edges stay high-precision because we keep only `bl` targets that hit a
    known function start."""
    proc = subprocess.run(
        ["arm-none-eabi-objdump", "-D", "-b", "binary", "-m", "arm7tdmi",
         "-Mforce-thumb", f"--adjust-vma=0x{ROM_BASE:x}",
         f"--start-address=0x{ROM_BASE:x}", f"--stop-address=0x{stop:x}",
         str(find_baserom())],
        capture_output=True, text=True, check=False,
    )
    if proc.returncode != 0:
        raise SystemExit(f"objdump failed:\n{proc.stderr}")
    return proc.stdout


def load_baserom() -> bytes:
    return find_baserom().read_bytes()


def read_word(rom: bytes, addr: int) -> int | None:
    off = addr - ROM_BASE
    if 0 <= off + 4 <= len(rom):
        return int.from_bytes(rom[off:off + 4], "little")
    return None


def region_of(addr: int) -> str:
    if ROM_BASE <= addr < ROM_END:
        return "rom"
    if 0x02000000 <= addr < 0x02040000:
        return "ewram"
    if 0x03000000 <= addr < 0x03008000:
        return "iwram"
    if 0x04000000 <= addr < 0x04000400:
        return "mmio"
    if 0x05000000 <= addr < 0x05000400:
        return "pal"
    if 0x06000000 <= addr < 0x06018000:
        return "vram"
    if 0x07000000 <= addr < 0x07000400:
        return "oam"
    return "other"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--out", default=str(DEFAULT_DB), help="output SQLite path")
    ap.add_argument("--self-check", action="store_true", help="validate after build")
    ap.add_argument("--stats", action="store_true", help="print a summary after build")
    args = ap.parse_args()

    if not ELF.exists():
        raise SystemExit(f"{ELF} missing — run `make -j8` first.")

    name_addr, name_obj, name_sect, obj_size = parse_map()
    linker_syms = parse_linker_assignments()
    rom = load_baserom()

    # --- Function nodes: .text symbols in ROM range. -----------------------
    # addr -> primary name (first wins, mirrors check_relocations).
    addr_to_name: dict[int, str] = {}
    for nm, a in name_addr.items():
        addr_to_name.setdefault(a, nm)
    sorted_addrs = sorted(addr_to_name)

    def containing(addr: int):
        i = bisect.bisect_right(sorted_addrs, addr) - 1
        if i < 0:
            return None
        a = sorted_addrs[i]
        return a, addr_to_name[a]

    def fn_for_ptr(v):
        """Resolve a (possibly Thumb-tagged) code pointer to a function name.
        Thumb function pointers carry bit0=1, so try the masked address too."""
        for cand in (v, v & ~1):
            nm = addr_to_name.get(cand)
            if nm is not None and nm in functions:
                return nm
        return None

    c_bodies = index_c_bodies()

    # A symbol is a "function" if it sits in a .text object in ROM range.
    func_names: set[str] = set()
    functions: dict[str, dict] = {}
    for nm, a in name_addr.items():
        if not (ROM_BASE <= a < ROM_END):
            continue
        if name_sect.get(nm) not in (None, "text"):
            continue
        obj = name_obj.get(nm, "")
        kind = classify_kind(nm, obj, a)
        # raw 64KB blobs and data are not function nodes; the text_<hex> naming
        # convention also marks an unpeeled blob regardless of its object dir.
        if kind in ("data", "raw") or re.match(r"^text_[0-9a-f]+$", nm):
            continue
        func_names.add(nm)
        functions[nm] = {
            "name": nm, "addr": a, "object_file": obj,
            "src_file": obj_to_src(obj), "kind": kind,
        }

    # size = next text symbol - addr (within ROM), else object size.
    for nm, f in functions.items():
        i = bisect.bisect_right(sorted_addrs, f["addr"])
        nxt = sorted_addrs[i] if i < len(sorted_addrs) else f["addr"]
        sz = (nxt - f["addr"]) if nxt > f["addr"] else obj_size.get(f["object_file"], 0)
        f["size"] = sz
        # status + nameability
        body_src = c_bodies.get(nm)
        f["has_c_body"] = 1 if body_src else 0
        if f["kind"] == "libgcc":
            f["status"], f["nameable"] = "libgcc", 0
        elif f["kind"] == "raw":
            f["status"], f["nameable"] = "raw", 0
        elif f["kind"] == "asm":
            # bytes from an asm slice; may carry a NON_MATCHING C reference.
            f["status"] = "nonmatching" if body_src else "asm"
            f["nameable"] = 1 if ANON_FN_RE.match(nm) else 0
        else:  # game/engine/system compiled from C
            naked = detect_naked(body_src, nm) if body_src else False
            f["status"] = "naked" if naked else "matched"
            f["nameable"] = 1 if ANON_FN_RE.match(nm) else 0
        f["takes_fnptr"] = 0  # set during pool scan

    # --- Data symbols (for data_refs resolution + rename targets). ----------
    data_symbols: dict[str, dict] = {}
    data_addr_to_name: dict[int, str] = {}
    for nm, a in name_addr.items():
        if nm in func_names:
            continue
        sect = name_sect.get(nm)
        obj = name_obj.get(nm, "")
        if sect in ("rodata", "data", "bss") or not (ROM_BASE <= a < ROM_END) or obj.startswith("src/data/"):
            kind = "data"
            nameable = 1 if (ANON_DATA_RE.search(nm) or ANON_FN_RE.match(nm)) else 0
            data_symbols.setdefault(nm, {"name": nm, "addr": a, "kind": kind,
                                         "src_file": obj_to_src(obj) if obj else "",
                                         "nameable": nameable})
            data_addr_to_name.setdefault(a, nm)
    for nm, a in linker_syms.items():
        if nm not in data_symbols and nm not in func_names:
            data_symbols.setdefault(nm, {"name": nm, "addr": a, "kind": "data",
                                         "src_file": "", "nameable": 1 if ANON_DATA_RE.search(nm) else 0})
            data_addr_to_name.setdefault(a, nm)

    # --- Disassembly walk: direct edges, swi edges, pool loads. -------------
    # Whole-ROM force-thumb pass (covers asm slices). Attribute each insn to its
    # containing function by address (binary mode has no <symbol>: headers).
    fn_ranges = sorted((f["addr"], f["addr"] + max(f["size"], 2), n)
                       for n, f in functions.items())
    fn_starts = [r[0] for r in fn_ranges]
    max_end = max(r[1] for r in fn_ranges) if fn_ranges else ROM_BASE

    def fn_at(addr: int):
        i = bisect.bisect_right(fn_starts, addr) - 1
        if i < 0:
            return None
        lo, hi, nm = fn_ranges[i]
        return nm if lo <= addr < hi else None

    disasm = disassemble_thumb_rom(max_end)
    edges: list[tuple] = []          # (caller, callee, site, kind)
    bios_nodes: set[str] = set()
    data_refs: dict[tuple, int] = {} # (fn, data_addr, data_sym) -> count
    pool_loads_by_fn: dict[str, set] = {}  # fn -> set(value)

    for line in disasm.splitlines():
        m = INSN_RE.match(line)
        if not m:
            continue
        site = int(m.group(1), 16)
        cur_fn = fn_at(site)
        if cur_fn is None:
            continue
        mnem = m.group(3).lower()
        ops = m.group(4) or ""

        if mnem in ("bl", "blx"):
            tm = HEX_RE.search(ops)
            if not tm:
                continue
            tgt = int(tm.group(1), 16)
            callee = addr_to_name.get(tgt)
            if callee and callee in functions and callee != cur_fn:
                edges.append((cur_fn, callee, site, "direct"))
            continue

        if mnem in ("svc", "swi"):
            tm = re.search(r"#?(\d+)", ops)  # objdump prints the SWI immediate in DECIMAL
            if tm:
                n = int(tm.group(1), 10)
                # Only real BIOS numbers (0x00-0x2A). Higher values are pool data
                # mis-decoded as `svc` by the force-thumb pass over asm slices.
                if n in BIOS_SWI:
                    bname = "Bios_" + BIOS_SWI[n]
                    bios_nodes.add(bname)
                    edges.append((cur_fn, bname, site, "swi"))
            continue

        # pc-relative literal load: ldr rN, [pc, #imm] @ (0xPOOLADDR)
        if mnem.startswith("ldr") and "pc" in ops:
            sm = POOL_SLOT_RE.search(line)
            if sm:
                pool_addr = int(sm.group(1), 16)
                val = read_word(rom, pool_addr)
                if val is not None:
                    pool_loads_by_fn.setdefault(cur_fn, set()).add(val)

    # Resolve pool loads -> data_refs (and flag fn-pointer loads).
    for fn, vals in pool_loads_by_fn.items():
        for v in vals:
            if fn_for_ptr(v):
                functions[fn]["takes_fnptr"] = 1  # loads a code pointer
                continue
            sym = data_addr_to_name.get(v, "")
            if sym or region_of(v) != "rom" or (ROM_BASE <= v < ROM_END):
                key = (fn, v, sym)
                data_refs[key] = data_refs.get(key, 0) + 1

    # --- Indirect edges via known ROM fn-pointer tables (best-effort). ------
    # A table = a data symbol whose entries are mostly function addresses.
    indirect_count = 0
    table_re = re.compile(r"\bconst\s+\w+\s+(\w+)\s*\[\s*(\d+)\s*\]\s*=\s*INCBIN_U32")
    table_syms: dict[str, int] = {}
    for c in (SRC / "data").rglob("*.c") if (SRC / "data").exists() else []:
        for line in c.read_text(errors="replace").splitlines():
            tm = table_re.search(line)
            if tm and tm.group(1) in name_addr:
                table_syms[tm.group(1)] = int(tm.group(2))
    for tname, count in table_syms.items():
        base = name_addr[tname]
        entries = []
        ok = 0
        for k in range(count):
            v = read_word(rom, base + 4 * k)
            callee = fn_for_ptr(v) if v is not None else None
            entries.append(callee)
            if callee:
                ok += 1
        if count == 0 or ok < max(1, count // 2):
            continue  # not really a fn-pointer table
        # referencing functions = those that pool-load the table base.
        refs = [fn for fn, vals in pool_loads_by_fn.items() if base in vals]
        for fn in refs:
            functions[fn]["takes_fnptr"] = 1
            for callee in entries:
                if callee:
                    edges.append((fn, callee, base, "indirect_table"))
                    indirect_count += 1

    # --- Graph metrics: reachability, SCC, fan-in/out. ---------------------
    adj: dict[str, set] = {n: set() for n in functions}
    radj: dict[str, set] = {n: set() for n in functions}
    for a, b, _site, _k in edges:
        if a in functions and b in functions:
            adj[a].add(b)
            radj[b].add(a)
    fan_out = {n: len(adj[n]) for n in functions}
    fan_in = {n: len(radj[n]) for n in functions}

    # reachability BFS from the real boot roots. `entry` is a 4-byte ARM branch
    # (no bl edge), so seed from _start (boots Init1 + AgbMain) and the dispatcher
    # AgbMain; include any interrupt handler we know.
    roots = [r for r in ("_start", "AgbMain", "IntrMain", "entry") if r in functions]
    start = roots[0] if roots else None
    reachable: set[str] = set()
    stack = list(roots)
    reachable.update(roots)
    while stack:
        u = stack.pop()
        for w in adj[u]:
            if w not in reachable:
                reachable.add(w)
                stack.append(w)

    scc_id = tarjan_scc(functions.keys(), adj)

    # --- Write SQLite. -----------------------------------------------------
    out = Path(args.out)
    if out.exists():
        out.unlink()
    con = sqlite3.connect(out)
    cur = con.cursor()
    cur.executescript(
        """
        CREATE TABLE functions(
            name TEXT PRIMARY KEY, addr INTEGER, size INTEGER,
            object_file TEXT, src_file TEXT, kind TEXT, status TEXT,
            nameable INTEGER, has_c_body INTEGER, reachable_from_entry INTEGER,
            fan_in INTEGER, fan_out INTEGER, scc_id INTEGER, takes_fnptr INTEGER);
        CREATE TABLE edges(
            caller TEXT, callee TEXT, call_site_addr INTEGER, kind TEXT);
        CREATE TABLE data_refs(
            fn TEXT, data_addr INTEGER, data_sym TEXT, ref_count INTEGER);
        CREATE TABLE data_symbols(
            name TEXT PRIMARY KEY, addr INTEGER, kind TEXT, src_file TEXT, nameable INTEGER);
        CREATE TABLE meta(key TEXT PRIMARY KEY, value TEXT);
        CREATE INDEX idx_edges_caller ON edges(caller);
        CREATE INDEX idx_edges_callee ON edges(callee);
        CREATE INDEX idx_drefs_fn ON data_refs(fn);
        CREATE INDEX idx_drefs_sym ON data_refs(data_sym);
        """
    )
    for n, f in functions.items():
        cur.execute(
            "INSERT INTO functions VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
            (n, f["addr"], f["size"], f["object_file"], f["src_file"], f["kind"],
             f["status"], f["nameable"], f["has_c_body"], 1 if n in reachable else 0,
             fan_in[n], fan_out[n], scc_id.get(n, -1), f["takes_fnptr"]),
        )
    # de-dup identical edges (same caller/callee/site/kind)
    for e in sorted(set(edges)):
        cur.execute("INSERT INTO edges VALUES (?,?,?,?)", e)
    for (fn, addr, sym), cnt in data_refs.items():
        cur.execute("INSERT INTO data_refs VALUES (?,?,?,?)", (fn, addr, sym, cnt))
    for d in data_symbols.values():
        cur.execute("INSERT INTO data_symbols VALUES (?,?,?,?,?)",
                    (d["name"], d["addr"], d["kind"], d["src_file"], d["nameable"]))
    meta = {
        "functions": str(len(functions)),
        "edges": str(len(set(edges))),
        "indirect_edges": str(indirect_count),
        "bios_nodes": ",".join(sorted(bios_nodes)),
        "data_symbols": str(len(data_symbols)),
        "data_refs": str(len(data_refs)),
        "entry": start or "",
        "reachable": str(len(reachable)),
    }
    for k, v in meta.items():
        cur.execute("INSERT INTO meta VALUES (?,?)", (k, v))
    con.commit()

    print(f"wrote {out}")
    print(f"  functions={len(functions)} edges={len(set(edges))} "
          f"(indirect {indirect_count}) data_syms={len(data_symbols)} "
          f"data_refs={len(data_refs)} reachable={len(reachable)}/{len(functions)}")

    rc = 0
    if args.stats:
        print_stats(cur)
    if args.self_check:
        rc = self_check(cur, functions, set(edges), bios_nodes, start)
    con.close()
    return rc


def tarjan_scc(nodes, adj) -> dict:
    """Iterative Tarjan SCC -> {node: scc_id}."""
    index = {}
    low = {}
    onstack = {}
    stack = []
    sccs = {}
    counter = [0]
    sid = [0]
    for root in nodes:
        if root in index:
            continue
        work = [(root, iter(adj[root]))]
        index[root] = low[root] = counter[0]; counter[0] += 1
        stack.append(root); onstack[root] = True
        while work:
            v, it = work[-1]
            advanced = False
            for w in it:
                if w not in adj:  # skip non-function callees
                    continue
                if w not in index:
                    index[w] = low[w] = counter[0]; counter[0] += 1
                    stack.append(w); onstack[w] = True
                    work.append((w, iter(adj[w])))
                    advanced = True
                    break
                elif onstack.get(w):
                    low[v] = min(low[v], index[w])
            if advanced:
                continue
            if low[v] == index[v]:
                while True:
                    w = stack.pop(); onstack[w] = False
                    sccs[w] = sid[0]
                    if w == v:
                        break
                sid[0] += 1
            work.pop()
            if work:
                low[work[-1][0]] = min(low[work[-1][0]], low[v])
    return sccs


def print_stats(cur) -> None:
    print("\n-- by kind --")
    for k, c in cur.execute("SELECT kind, COUNT(*) FROM functions GROUP BY kind ORDER BY 2 DESC"):
        print(f"  {k:10s} {c}")
    print("-- by status --")
    for s, c in cur.execute("SELECT status, COUNT(*) FROM functions GROUP BY status ORDER BY 2 DESC"):
        print(f"  {s:12s} {c}")
    print("-- nameable (anonymous, game/engine/system) --")
    n = cur.execute("SELECT COUNT(*) FROM functions WHERE nameable=1").fetchone()[0]
    nb = cur.execute("SELECT COUNT(*) FROM functions WHERE nameable=1 AND has_c_body=1").fetchone()[0]
    print(f"  nameable={n}  (with C body={nb})")
    print("-- top fan-in (most-called) --")
    for nm, fi, k in cur.execute(
            "SELECT name, fan_in, kind FROM functions ORDER BY fan_in DESC LIMIT 8"):
        print(f"  {nm:24s} fan_in={fi} ({k})")


def self_check(cur, functions, edges, bios_nodes, start) -> int:
    problems = []
    # every direct/indirect edge callee resolves to a function; swi -> bios node
    func_set = set(functions)
    for a, b, _s, k in edges:
        if k == "swi":
            if b not in bios_nodes:
                problems.append(f"swi edge to unknown bios node {b}")
        elif b not in func_set:
            problems.append(f"edge {a}->{b} ({k}): callee not a function node")
    if start and start not in func_set:
        problems.append(f"root symbol {start} missing from functions")
    # reachability sanity: AgbMain reachable from the boot roots (core dispatcher)
    row = cur.execute("SELECT reachable_from_entry FROM functions WHERE name='AgbMain'").fetchone()
    if row and row[0] != 1:
        problems.append("AgbMain not reachable from boot roots (BFS suspect)")
    if problems:
        print("\nSELF-CHECK FAIL:")
        for p in problems[:30]:
            print("  -", p)
        print(f"  ({len(problems)} total)")
        return 1
    print("\nself-check: OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
