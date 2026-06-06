#!/usr/bin/env python3
"""Assemble deterministic naming-context packets from callgraph.db + source.

This is the *only* input the naming workflow's Sonnet agents see — they read a
packet and decide names. No LLM tool-roaming, no token spent on gathering. One
batch invocation writes all packets so per-function agents just read a file.

A packet answers, for one function: who calls me, what do I call (incl. BIOS /
libgcc), what data do I touch, what is my body, who are my file/SCC siblings,
and what do the subsystem docs already say about me.

Usage:
    python3 tools/agent/naming_context.py sub_0801CD0C            # one packet -> stdout
    python3 tools/agent/naming_context.py --scope withbody --out-dir .callgraph_packets
    python3 tools/agent/naming_context.py --scope all --out-dir .callgraph_packets
    python3 tools/agent/naming_context.py --names sub_a,sub_b --out-dir .callgraph_packets
    python3 tools/agent/naming_context.py --file src/engine/foo.c # packet for a whole file

Scopes (which functions get a packet):
    all       — every nameable=1 function (anonymous game/engine/system)
    withbody  — nameable=1 AND has_c_body=1 (strongest signal; the default batch)
"""
from __future__ import annotations

import argparse
import json
import re
import sqlite3
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
DB = ROOT / "callgraph.db"
SRC = ROOT / "src"
DOCS = ROOT / "docs"
SUBSYS_DOCS = ["subsystems.md", "sibling-map.md", "memory-map.md"]
MAX_BODY_LINES = 220

sys.path.insert(0, str(Path(__file__).resolve().parent))
from apply_renames import find_function_body_span  # noqa: E402


def region_of(addr: int) -> str:
    if 0x08000000 <= addr < 0x0A000000:
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


def build_body_index() -> dict[str, tuple[str, str]]:
    """name -> (rel_src_path, body_text). One scan of src/**.c. A function's
    C body may live in a different file than its object (e.g. a NON_MATCHING
    reference whose bytes come from an asm slice), so we search by content."""
    idx: dict[str, tuple[str, str]] = {}
    name_re = re.compile(r"^(?:[A-Za-z_]\w[\w \t\*\(\),]*?)\b([A-Za-z_]\w*)\s*\(", re.M)
    for c in sorted(SRC.rglob("*.c")):
        rel = str(c.relative_to(ROOT))
        text = c.read_text(errors="replace")
        for m in name_re.finditer(text):
            nm = m.group(1)
            if nm in idx or nm in ("if", "for", "while", "switch", "return", "sizeof"):
                continue
            span = find_function_body_span(text, nm)
            if span:
                idx[nm] = (rel, text[span[0]:span[1]])
    return idx


def subsystem_hints(name: str) -> list[str]:
    hits: list[str] = []
    for d in SUBSYS_DOCS:
        p = DOCS / d
        if not p.exists():
            continue
        for i, line in enumerate(p.read_text(errors="replace").splitlines()):
            if name in line:
                hits.append(f"{d}:{i+1}: {line.strip()[:160]}")
    return hits[:12]


def packet_for(con, name, body_idx, fnrow_cache) -> dict | None:
    cur = con.cursor()
    row = cur.execute(
        "SELECT name,addr,size,kind,status,src_file,has_c_body,fan_in,fan_out,"
        "scc_id,takes_fnptr,reachable_from_entry FROM functions WHERE name=?",
        (name,)).fetchone()
    if not row:
        return None
    cols = ["name", "addr", "size", "kind", "status", "src_file", "has_c_body",
            "fan_in", "fan_out", "scc_id", "takes_fnptr", "reachable_from_entry"]
    fn = dict(zip(cols, row))
    fn["addr"] = f"0x{fn['addr']:08x}"

    def kind_of(callee):
        if callee in fnrow_cache:
            return fnrow_cache[callee]
        if callee.startswith("Bios_"):
            return "bios"
        if callee.startswith("__") or callee.startswith("_call_via_"):
            return "libgcc"
        return "external"

    # callees (dedup by callee, collect edge kinds)
    callees: dict[str, set] = {}
    for callee, ek in cur.execute("SELECT callee,kind FROM edges WHERE caller=?", (name,)):
        callees.setdefault(callee, set()).add(ek)
    callees_out = [{"name": c, "kind": kind_of(c), "via": sorted(ks)}
                   for c, ks in sorted(callees.items())]

    # callers (only function nodes are callers)
    callers = sorted({c for (c,) in cur.execute("SELECT DISTINCT caller FROM edges WHERE callee=?", (name,))})
    callers_out = [{"name": c, "kind": fnrow_cache.get(c, "?")} for c in callers]

    # data refs
    data_refs = []
    for sym, addr, cnt in cur.execute(
            "SELECT data_sym,data_addr,ref_count FROM data_refs WHERE fn=? ORDER BY ref_count DESC", (name,)):
        data_refs.append({"sym": sym or None, "addr": f"0x{addr:08x}",
                          "region": region_of(addr), "count": cnt})

    # file siblings + SCC peers
    siblings = [r for (r,) in cur.execute(
        "SELECT name FROM functions WHERE src_file=? AND name!=? ORDER BY addr",
        (fn["src_file"], name))]
    scc_peers = []
    if fn["scc_id"] >= 0:
        scc_peers = [r for (r,) in cur.execute(
            "SELECT name FROM functions WHERE scc_id=? AND name!=?", (fn["scc_id"], name))]

    body = None
    if name in body_idx:
        rel, text = body_idx[name]
        fn["body_file"] = rel
        lines = text.splitlines()
        if len(lines) > MAX_BODY_LINES:
            text = "\n".join(lines[:MAX_BODY_LINES]) + f"\n/* ... ({len(lines)-MAX_BODY_LINES} more lines truncated) */"
        body = text

    return {
        "function": fn,
        "c_body": body,
        "callees": callees_out,
        "callers": callers_out,
        "data_refs": data_refs,
        "file_siblings": siblings,
        "scc_peers": scc_peers,
        "subsystem_hints": subsystem_hints(name),
    }


def select_names(con, scope: str) -> list[str]:
    cur = con.cursor()
    if scope == "all":
        q = "SELECT name FROM functions WHERE nameable=1 ORDER BY scc_id, addr"
    elif scope == "withbody":
        q = "SELECT name FROM functions WHERE nameable=1 AND has_c_body=1 ORDER BY scc_id, addr"
    else:
        raise SystemExit(f"unknown scope {scope}")
    return [r for (r,) in cur.execute(q)]


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("name", nargs="?", help="single function -> packet on stdout")
    ap.add_argument("--scope", choices=["all", "withbody"], help="batch: which functions")
    ap.add_argument("--names", help="batch: comma-separated explicit function names")
    ap.add_argument("--file", help="emit a FILE packet (its functions + collective context)")
    ap.add_argument("--out-dir", default=str(ROOT / ".callgraph_packets"))
    ap.add_argument("--db", default=str(DB))
    args = ap.parse_args()

    if not Path(args.db).exists():
        raise SystemExit(f"{args.db} missing — run build_callgraph.py first.")
    con = sqlite3.connect(args.db)
    cur = con.cursor()
    fnrow_cache = {n: k for n, k in cur.execute("SELECT name,kind FROM functions")}
    body_idx = build_body_index()

    if args.file:
        # file packet = the functions in that src_file + their union context.
        fns = [r for (r,) in cur.execute("SELECT name FROM functions WHERE src_file=? ORDER BY addr", (args.file,))]
        pkts = [packet_for(con, n, body_idx, fnrow_cache) for n in fns]
        out = {"file": args.file, "functions": [p for p in pkts if p]}
        print(json.dumps(out, indent=2))
        return 0

    if args.name:
        pkt = packet_for(con, args.name, body_idx, fnrow_cache)
        if not pkt:
            raise SystemExit(f"function {args.name} not in callgraph.db")
        print(json.dumps(pkt, indent=2))
        return 0

    # batch
    if args.names:
        names = [n.strip() for n in args.names.split(",") if n.strip()]
    elif args.scope:
        names = select_names(con, args.scope)
    else:
        raise SystemExit("give a name, or --scope, or --names, or --file")

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    written = 0
    for n in names:
        pkt = packet_for(con, n, body_idx, fnrow_cache)
        if pkt:
            (out_dir / f"{n}.json").write_text(json.dumps(pkt, indent=2))
            written += 1
    print(f"wrote {written} packet(s) to {out_dir}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
