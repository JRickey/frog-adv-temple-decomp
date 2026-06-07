#!/usr/bin/env python3
"""Inventory the data model across src/**/*.c: find every struct type defined in
more than one translation unit (and classify whether the copies agree), and every
function declared with more than one signature.

This is the scalable engine for data-model unification: it produces the ROM-wide
worklist so a dedup/reconciliation pass "doesn't miss anything". It is read-only.

Classification for a struct defined in >=2 files:
  IDENTICAL       - every copy has the same fields (types+names+arrays). Safe to
                    dedup into a shared header byte-neutrally.
  NAME_CONFLICT   - same layout (types+arrays+signedness) but different field
                    names. Byte-safe to unify; pick canonical names.
  LAYOUT_CONFLICT - the layouts differ (signedness, field count, widths). Needs
                    resolution; per-def compiled-vs-NON_MATCHING status is shown
                    because a conflict that only differs in an uncompiled
                    NON_MATCHING branch resolves to whatever the compiled copies use.

A def is "compiled" unless it sits inside an `#ifdef NON_MATCHING` true-branch
(NON_MATCHING is never defined in the build; the `#else` side IS compiled).

Usage:
  python3 tools/agent/data_model_inventory.py            # human summary
  python3 tools/agent/data_model_inventory.py --structs  # struct dups only
  python3 tools/agent/data_model_inventory.py --externs  # extern drift only
  python3 tools/agent/data_model_inventory.py --json     # machine-readable
"""
import argparse
import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SRC = REPO / "src"

# --- comment stripping -------------------------------------------------------
_BLOCK = re.compile(r"/\*.*?\*/", re.DOTALL)
_LINE = re.compile(r"//[^\n]*")


def strip_comments(text):
    return _LINE.sub("", _BLOCK.sub("", text))


# --- NON_MATCHING dead-branch mask ------------------------------------------
def deadness_mask(lines):
    """Return a list[bool], True where the line sits in an uncompiled
    `#ifdef NON_MATCHING` true-branch. Tracks nested conditionals."""
    mask = [False] * len(lines)
    # stack of (is_nm_ifdef, in_dead_branch)
    stack = []
    for i, ln in enumerate(lines):
        s = ln.strip()
        m_if = re.match(r"#\s*if(n?def)?\b(.*)", s)
        if s.startswith("#if") and ("NON_MATCHING" in s) and not s.startswith("#endif"):
            # #ifdef NON_MATCHING  -> true branch is dead (NON_MATCHING undefined)
            # #ifndef NON_MATCHING -> true branch is live
            dead = s.startswith("#ifdef") or re.match(r"#\s*if\s+defined", s) or s.startswith("#if NON_MATCHING")
            stack.append(["nm", bool(dead)])
            mask[i] = any(fr[1] for fr in stack)
            continue
        if s.startswith("#if"):
            stack.append(["other", False])
            mask[i] = any(fr[1] for fr in stack)
            continue
        if s.startswith("#else"):
            if stack:
                top = stack[-1]
                if top[0] == "nm":
                    top[1] = not top[1]
            mask[i] = any(fr[1] for fr in stack)
            continue
        if s.startswith("#elif"):
            mask[i] = any(fr[1] for fr in stack)
            continue
        if s.startswith("#endif"):
            if stack:
                stack.pop()
            mask[i] = any(fr[1] for fr in stack)
            continue
        mask[i] = any(fr[1] for fr in stack)
    return mask


# --- field parsing -----------------------------------------------------------
_TYPE_RE = re.compile(r"^(?P<type>.+?)(?P<name>\b[A-Za-z_]\w*)\s*(?P<arr>(\[[^\]]*\])*)\s*$")


def parse_fields(body):
    """body = struct body text (no braces, comments stripped). Returns list of
    (type_norm, name, arr_norm)."""
    fields = []
    for decl in body.split(";"):
        decl = " ".join(decl.split())
        if not decl:
            continue
        m = _TYPE_RE.match(decl)
        if not m:
            fields.append((decl, "", ""))  # unparseable; keep raw for compare
            continue
        t = " ".join(m.group("type").split())
        arr = m.group("arr").replace(" ", "")
        fields.append((t, m.group("name"), arr))
    return fields


# --- struct extraction (brace-matched) --------------------------------------
_STRUCT_START = re.compile(r"(typedef\s+)?struct\s+(?P<tag>[A-Za-z_]\w*)?\s*\{")


def extract_structs(path):
    raw = path.read_text(errors="ignore")
    lines = raw.splitlines()
    dead = deadness_mask(lines)
    # offset->line map for dead lookup
    line_starts = []
    off = 0
    for ln in lines:
        line_starts.append(off)
        off += len(ln) + 1

    def line_of(pos):
        lo, hi = 0, len(line_starts) - 1
        while lo < hi:
            mid = (lo + hi + 1) // 2
            if line_starts[mid] <= pos:
                lo = mid
            else:
                hi = mid - 1
        return lo

    text = strip_comments(raw)
    out = []
    for m in _STRUCT_START.finditer(text):
        tag = m.group("tag")
        # brace match
        depth = 0
        i = m.end() - 1
        while i < len(text):
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
                if depth == 0:
                    break
            i += 1
        if i >= len(text):
            continue
        body = text[m.end():i]
        # trailing alias name before ;
        tail = text[i + 1:i + 80]
        am = re.match(r"\s*([A-Za-z_]\w*)?\s*;", tail)
        alias = am.group(1) if am and am.group(1) else None
        name = tag or alias
        if not name:
            continue
        fields = parse_fields(body)
        layout_sig = tuple((t, a) for (t, n, a) in fields)
        full_sig = tuple(fields)
        out.append({
            "name": name,
            "file": str(path.relative_to(REPO)),
            "dead": dead[line_of(m.start())],
            "layout_sig": layout_sig,
            "full_sig": full_sig,
            "nfields": len(fields),
        })
    return out


# --- extern extraction -------------------------------------------------------
_EXTERN_RE = re.compile(r"\bextern\s+([^;{]*?\b([A-Za-z_]\w*)\s*\([^;{]*\))\s*;")


def extract_externs(path):
    text = strip_comments(path.read_text(errors="ignore"))
    out = []
    for m in _EXTERN_RE.finditer(text):
        sig = " ".join(m.group(1).split())
        name = m.group(2)
        # normalize: drop param names, keep types — crude: collapse spaces only
        out.append({"name": name, "file": str(path.relative_to(REPO)), "sig": sig})
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--structs", action="store_true")
    ap.add_argument("--externs", action="store_true")
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()
    do_structs = args.structs or not args.externs
    do_externs = args.externs or not args.structs

    files = sorted(SRC.rglob("*.c"))
    struct_defs = {}
    extern_defs = {}
    for f in files:
        if do_structs:
            for s in extract_structs(f):
                struct_defs.setdefault(s["name"], []).append(s)
        if do_externs:
            for e in extract_externs(f):
                extern_defs.setdefault(e["name"], []).append(e)

    # classify struct dups
    dups = {}
    for name, defs in struct_defs.items():
        if len({d["file"] for d in defs}) < 2:
            continue
        layouts = {d["layout_sig"] for d in defs}
        fulls = {d["full_sig"] for d in defs}
        if len(fulls) == 1:
            cls = "IDENTICAL"
        elif len(layouts) == 1:
            cls = "NAME_CONFLICT"
        else:
            cls = "LAYOUT_CONFLICT"
        compiled = sum(1 for d in defs if not d["dead"])
        dups[name] = {
            "class": cls,
            "ndefs": len(defs),
            "nfiles": len({d["file"] for d in defs}),
            "compiled_defs": compiled,
            "dead_defs": len(defs) - compiled,
            "files": sorted({d["file"] for d in defs}),
        }

    # classify extern drift
    drift = {}
    for name, defs in extern_defs.items():
        sigs = {d["sig"] for d in defs}
        if len(sigs) < 2:
            continue
        drift[name] = {
            "nsigs": len(sigs),
            "ndecls": len(defs),
            "sigs": sorted(sigs),
            "files": sorted({d["file"] for d in defs}),
        }

    if args.json:
        print(json.dumps({"struct_dups": dups, "extern_drift": drift}, indent=2))
        return

    if do_structs:
        order = {"IDENTICAL": 0, "NAME_CONFLICT": 1, "LAYOUT_CONFLICT": 2}
        rows = sorted(dups.items(), key=lambda kv: (order[kv[1]["class"]], -kv[1]["nfiles"]))
        nid = sum(1 for _, v in rows if v["class"] == "IDENTICAL")
        nnc = sum(1 for _, v in rows if v["class"] == "NAME_CONFLICT")
        nlc = sum(1 for _, v in rows if v["class"] == "LAYOUT_CONFLICT")
        print(f"=== Struct types defined in >=2 files: {len(rows)} "
              f"(IDENTICAL={nid} safe-dedup, NAME_CONFLICT={nnc}, LAYOUT_CONFLICT={nlc}) ===")
        for name, v in rows:
            tag = v["class"]
            extra = "" if v["dead_defs"] == 0 else f"  [{v['compiled_defs']} compiled / {v['dead_defs']} NON_MATCHING]"
            print(f"  [{tag:15}] {name:28} x{v['nfiles']}{extra}")
            print(f"      {' '.join(v['files'])}")

    if do_externs:
        rows = sorted(drift.items(), key=lambda kv: -kv[1]["nsigs"])
        print(f"\n=== Functions declared with >=2 distinct signatures: {len(rows)} ===")
        for name, v in rows[:40]:
            print(f"  {name:28} {v['nsigs']} sigs across {len(v['files'])} files")


if __name__ == "__main__":
    main()
