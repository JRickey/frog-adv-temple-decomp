#!/usr/bin/env python3
"""Propose a C struct based on observed accesses to a base address.

Wraps `tools/agent/struct_xref.py --json` and converts the offset/width
map into a typed C struct, sized appropriately (u8 / u16 / u32 / padding
arrays) so every observed access lands at the expected field. Use it
when a new function surfaces accesses to an unnamed IWRAM/EWRAM base —
the alternative is reading raw `[r0, #16]` in the matching C, which
loses meaning and breaks the moment a field gets renamed.

Output is print-only by default — copy-paste into the appropriate
header. With `--apply --header PATH --name NAME`, the proposed struct
replaces an existing `typedef struct { … } NAME;` definition in that
header (creates it if missing).

Usage:
    python3 tools/agent/struct_grow.py 0x03005330
    python3 tools/agent/struct_grow.py 0x03005330 --name GameStuff
    python3 tools/agent/struct_grow.py 0x03005330 --name GameStuff \\
        --header include/game.h --apply
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent

SIZE_OF = {
    "ldr": 4, "str": 4,
    "ldrh": 2, "strh": 2, "ldrsh": 2,
    "ldrb": 1, "strb": 1, "ldrsb": 1,
}
TYPE_FOR = {1: "u8", 2: "u16", 4: "u32"}


def parse_addr(s: str) -> int:
    return int(s, 0)


def collect_widths(base: int) -> dict[int, int]:
    """Run struct_xref and reduce to {offset: max-observed-width}."""
    proc = subprocess.run(
        ["python3", str(ROOT / "tools/agent/struct_xref.py"),
         f"0x{base:08x}", "--json"],
        capture_output=True, text=True, cwd=ROOT, check=True,
    )
    rep = json.loads(proc.stdout)
    widths: dict[int, int] = {}
    for off_key, info in rep.get("byOffset", {}).items():
        off = int(off_key, 0) if isinstance(off_key, str) else off_key
        for acc in (info.get("readers", []) + info.get("writers", [])):
            mnemonic = acc.get("mnemonic", "")
            w = SIZE_OF.get(mnemonic, 0)
            if w:
                widths[off] = max(widths.get(off, 0), w)
    return widths


def build_layout(widths: dict[int, int]) -> list[tuple[int, int, str]]:
    """Turn {offset: width} into a sequence of (offset, width, type-name)
    field entries, filling padding gaps with `u8 _padNN[N]`-style runs.
    """
    if not widths:
        return []
    fields: list[tuple[int, int, str]] = []
    cursor = 0
    end = max(off + widths[off] for off in widths)
    sorted_offs = sorted(widths)
    i = 0
    while cursor < end:
        if i < len(sorted_offs) and sorted_offs[i] == cursor:
            off = sorted_offs[i]
            w = widths[off]
            # Align cursor for u16/u32: if a 4-byte field appears at a
            # non-4-aligned address (it does happen for some packed
            # subsystems), keep it as u32 anyway and let the C compiler
            # warn; we don't currently support __attribute__((packed)).
            fields.append((off, w, TYPE_FOR[w]))
            cursor = off + w
            i += 1
        else:
            # Padding run.
            nxt = sorted_offs[i] if i < len(sorted_offs) else end
            pad_size = nxt - cursor
            fields.append((cursor, pad_size, f"u8[{pad_size}]"))
            cursor = nxt
    return fields


def render_struct(name: str, base: int, fields: list[tuple[int, int, str]]) -> str:
    lines = []
    lines.append("/*")
    lines.append(f" * {name} at 0x{base:08x}.")
    lines.append(" * Auto-proposed by tools/agent/struct_grow.py from observed accesses.")
    lines.append(" * Fields named _unkNN are inferred from access width; rename as their")
    lines.append(" * purpose is identified. Padding gaps are placeholder u8 arrays.")
    lines.append(" */")
    lines.append(f"typedef struct {name} {{")
    for off, size, ty in fields:
        if ty.startswith("u8["):
            lines.append(f"    u8 _pad{off:02X}[{size}];")
        else:
            lines.append(f"    {ty} _unk{off:02X};")
    lines.append(f"}} {name};")
    lines.append("")
    lines.append(f"#define g{name} (*({name} *)0x{base:08x})")
    return "\n".join(lines)


def apply_to_header(header: Path, name: str, struct_src: str) -> None:
    """Replace an existing `typedef struct ... } NAME;` block with the new
    struct, or insert after the last #include if not present."""
    if not header.exists():
        print(f"creating {header.relative_to(ROOT)}")
        header.parent.mkdir(parents=True, exist_ok=True)
        guard = f"GUARD_{header.stem.upper()}_H"
        text = (
            f"#ifndef {guard}\n#define {guard}\n\n"
            f'#include "types.h"\n\n{struct_src}\n\n#endif /* {guard} */\n'
        )
        header.write_text(text)
        return

    text = header.read_text()
    # Existing typedef? Match `typedef struct OPTNAME { ... } NAME;`.
    pat = re.compile(
        r"typedef\s+struct(?:\s+\w+)?\s*\{[^{}]*?\}\s*" + re.escape(name) + r"\s*;",
        re.DOTALL,
    )
    m = pat.search(text)
    if m:
        # Replace it, and also drop any existing `#define gNAME ...` line.
        new_text = text[: m.start()] + struct_src.rstrip() + text[m.end() :]
        macro_re = re.compile(
            rf"^#define\s+g{re.escape(name)}\b.*?\n", re.MULTILINE
        )
        # The new struct_src already includes its own macro at the bottom;
        # remove any stale ones elsewhere in the file.
        new_text = macro_re.sub("", new_text, count=2)
        # Re-append macro after struct (it's inside struct_src already; the
        # sub above only removed stale duplicates).
        header.write_text(new_text)
        return

    # Otherwise append after the last #include.
    include_pat = re.compile(r"^#include\b.*$", re.MULTILINE)
    last = None
    for m in include_pat.finditer(text):
        last = m
    if last is None:
        header.write_text(struct_src + "\n\n" + text)
    else:
        insert_at = last.end()
        header.write_text(
            text[:insert_at] + "\n\n" + struct_src + "\n" + text[insert_at:]
        )


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("base", type=parse_addr, help="struct base address")
    p.add_argument("--name", help="struct typedef name (defaults to "
                                  "`StructAtNNNN` from the address)")
    p.add_argument("--header", help="if --apply, the header file to edit")
    p.add_argument("--apply", action="store_true",
                   help="write the proposed struct into --header instead of "
                        "printing to stdout")
    args = p.parse_args()

    name = args.name or f"StructAt{args.base:08X}"
    widths = collect_widths(args.base)
    if not widths:
        print(f"no accesses found for base 0x{args.base:08x}", file=sys.stderr)
        return 2
    fields = build_layout(widths)
    src = render_struct(name, args.base, fields)

    if args.apply:
        if not args.header:
            print("--apply requires --header PATH", file=sys.stderr)
            return 2
        apply_to_header(Path(args.header), name, src)
        print(f"updated {args.header}")
    else:
        print(src)
    return 0


if __name__ == "__main__":
    sys.exit(main())
