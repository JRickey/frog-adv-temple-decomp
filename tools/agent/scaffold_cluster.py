#!/usr/bin/env python3
"""Scaffold a new src/*.c (and optional header) for a function cluster.

When `pick_target.py` reports a disasm whose first/last functions don't
have name-affinity with the adjacent src C files, the cluster needs a NEW
C file inserted at the right `linker.ld` position before any decomp can
proceed legally (see CLAUDE.md "Layout invariant"). This tool does the
mechanical setup so the agent can start decomping from the next iteration.

What this script DOES NOT do:
  - Move any function bodies from the asm file into the new C file. The
    agent does that one function at a time, in baserom address order, so
    each step is verifiable with `compile_and_view_assembly.py`.
  - Modify any existing source file.

What it DOES do (atomically, on --apply):
  - Create `src/<dir>/<name>.c` with #includes cribbed from a sibling file.
  - Create `include/<dir>/<name>.h` with forward decls for the cluster.
  - Insert a single line into `linker.ld` (and another into the .rodata
    section if the sibling file has one).
  - Add the new `<name>.c` source to git so it's tracked.
  - Refresh `tools/agent/.function_addresses.json`.

Usage:
    scaffold_cluster.py StatusScreen --asm asm/disasm_0x0807e678.s
    scaffold_cluster.py GunshipEnd   --asm asm/disasm_0x080519AC.s --end
    scaffold_cluster.py StatusScreen --asm asm/disasm_0x0807e678.s --apply

Without `--apply`, prints a dry-run plan and exits.

By default the cluster is extracted from the HEAD of the asm (new file
goes BEFORE the asm in linker.ld). Pass `--end` for tail extraction.
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
SRC_DIR = ROOT / "src"
INC_DIR = ROOT / "include"
LINKER = ROOT / "linker.ld"

FUNC_START_RE = re.compile(
    r"^\s*(thumb_func_start|arm_func_start)\s+(\S+)\s*$"
)
LINKER_OBJ_RE = re.compile(r"^(\s*)(\S+\.o)\((\.text|\.rodata)\);")


@dataclass
class Cluster:
    prefix: str
    functions: list[str]
    asm_file: Path
    at_end: bool


def find_cluster(asm_file: Path, prefix: str, at_end: bool) -> Cluster:
    text = asm_file.read_text(errors="replace").splitlines()
    func_names = [m.group(2) for line in text if (m := FUNC_START_RE.match(line))]
    if not func_names:
        raise SystemExit(f"no functions found in {asm_file}")

    if at_end:
        # collect a tail contiguous run matching the prefix
        matched: list[str] = []
        for name in reversed(func_names):
            if name.startswith(prefix):
                matched.append(name)
            else:
                break
        matched.reverse()
    else:
        matched = []
        for name in func_names:
            if name.startswith(prefix):
                matched.append(name)
            else:
                break

    if not matched:
        raise SystemExit(
            f"no contiguous {'tail' if at_end else 'head'} cluster with "
            f"prefix {prefix!r} found in {asm_file.relative_to(ROOT)}"
        )
    return Cluster(prefix=prefix, functions=matched,
                   asm_file=asm_file, at_end=at_end)


def neighbour_in_linker(asm_file: Path, before: bool) -> tuple[int, str, str] | None:
    """Return (line_idx, indent, neighbour_path) for the closest preceding
    (before=True) or following (before=False) `src/*.o(.text)` entry to the
    given asm file in linker.ld. None if not found."""
    asm_obj = f"{asm_file.parent.name}/{asm_file.with_suffix('.o').name}(.text)"
    lines = LINKER.read_text(errors="replace").splitlines()
    hit = next((i for i, l in enumerate(lines) if asm_obj in l), None)
    if hit is None:
        return None
    rng = reversed(range(0, hit)) if before else range(hit + 1, len(lines))
    for i in rng:
        m = LINKER_OBJ_RE.match(lines[i])
        if not m:
            continue
        indent, obj, section = m.group(1), m.group(2), m.group(3)
        if section == ".text" and obj.startswith("src/"):
            return i, indent, obj
    return None


def derive_paths(cluster: Cluster, sibling_obj: str) -> tuple[Path, Path]:
    """Decide src/.../<name>.c + include/.../<name>.h from sibling + prefix."""
    # snake_case the prefix
    snake = re.sub(r"(?<!^)(?=[A-Z])", "_", cluster.prefix).lower()
    sibling_dir = Path(sibling_obj).parent.relative_to(Path("src"))
    src_path = SRC_DIR / sibling_dir / f"{snake}.c"
    inc_path = INC_DIR / sibling_dir / f"{snake}.h"
    return src_path, inc_path


def scaffold_c_body(prefix: str, header_rel: str, sibling: Path,
                    functions: list[str]) -> str:
    """Build the new .c file body. Copy the #include block from a sibling
    file so the agent doesn't fight project conventions."""
    sibling_text = sibling.read_text(errors="replace")
    include_block: list[str] = []
    for line in sibling_text.splitlines():
        stripped = line.strip()
        if stripped.startswith("#include"):
            include_block.append(line)
        elif include_block and stripped == "":
            include_block.append(line)
        elif include_block and not stripped.startswith("#include"):
            break
    # Ensure our own header is first
    own = f'#include "{header_rel}"'
    if own not in include_block:
        include_block.insert(0, own)
        include_block.insert(1, "")

    body = "\n".join(include_block).rstrip() + "\n\n"
    body += (
        f"/*\n"
        f" * Scaffold for the {prefix}* cluster.\n"
        f" * Decompiled functions land here, one at a time, in baserom\n"
        f" * address order. Each function added must also be removed from\n"
        f" * the corresponding asm/disasm_*.s and verified with\n"
        f" * tools/agent/compile_and_view_assembly.py before commit.\n"
        f" */\n"
    )
    return body


def scaffold_h_body(prefix: str, functions: list[str]) -> str:
    guard = f"{prefix.upper()}_H"
    # snake_case for guard
    guard = re.sub(r"(?<!^)(?=[A-Z])", "_", prefix).upper() + "_H"
    decls = "\n".join(f"// extern <return_type> {f}(<params>);" for f in functions)
    return (
        f"#ifndef {guard}\n"
        f"#define {guard}\n"
        f"\n"
        f"#include \"types.h\"\n"
        f"\n"
        f"// Forward declarations for the {prefix}* cluster.\n"
        f"// Uncomment and fill in the correct signature as each function is\n"
        f"// decompiled into the matching .c file.\n"
        f"{decls}\n"
        f"\n"
        f"#endif // {guard}\n"
    )


def linker_insertion(asm_file: Path, at_end: bool) -> tuple[int, str]:
    """Return (insert_at_line_idx, indent) for the new entry. We insert
    immediately AFTER the asm file's text entry when at_end, and immediately
    BEFORE when at_head — that way the new C file sits at the right
    section-of-text within the original asm's address range."""
    asm_obj = f"{asm_file.parent.name}/{asm_file.with_suffix('.o').name}(.text)"
    lines = LINKER.read_text(errors="replace").splitlines()
    hit = next((i for i, l in enumerate(lines) if asm_obj in l), None)
    if hit is None:
        raise SystemExit(f"asm file {asm_file} not found in linker.ld .text")
    indent_match = re.match(r"^(\s*)", lines[hit])
    indent = indent_match.group(1) if indent_match else "        "
    if at_end:
        # insert after asm's .text line (skipping the blank line that follows)
        return hit + 1, indent
    else:
        # insert before asm's .text line
        return hit, indent


def linker_rodata_insertion(sibling_obj: str) -> tuple[int, str, str] | None:
    """Find a sensible spot to add a `.rodata` line for the new file, next
    to the sibling's own `.rodata` line in the .rodata SECTION of linker.ld.

    Returns (idx, indent, sibling_rodata_full_line) or None when the sibling
    has no `.rodata` entry (most C files don't, since agbcc emits no
    `.rodata` for code-only sources — the new scaffold is the same way and
    we just skip the insertion).
    """
    sibling_ro = f"{sibling_obj.replace('.o', '.o(.rodata)')}"
    lines = LINKER.read_text(errors="replace").splitlines()
    for i, line in enumerate(lines):
        # Match the exact .rodata token to avoid hitting .text lines that
        # share the same .o prefix.
        if sibling_ro in line and ".o(.rodata)" in line:
            indent = re.match(r"^(\s*)", line).group(1)
            return i + 1, indent, sibling_ro
    return None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("prefix", help="function-name prefix, e.g. StatusScreen")
    ap.add_argument("--asm", required=True,
                    help="asm/disasm_0x*.s containing the cluster")
    ap.add_argument("--end", action="store_true",
                    help="extract from the END of the asm (insert new C file "
                         "AFTER the asm in linker.ld); default is HEAD")
    ap.add_argument("--apply", action="store_true",
                    help="actually write changes (default: dry-run)")
    args = ap.parse_args()

    asm = (ROOT / args.asm).resolve()
    if not asm.exists():
        print(f"no such asm file: {args.asm}", file=sys.stderr)
        return 1

    cluster = find_cluster(asm, args.prefix, args.end)
    sibling = neighbour_in_linker(asm, before=not args.end)
    if sibling is None:
        print(f"no neighbouring src/*.c found in linker.ld near {asm.name}",
              file=sys.stderr)
        return 1
    sibling_idx, sibling_indent, sibling_obj = sibling

    src_path, inc_path = derive_paths(cluster, sibling_obj)
    rel_src = src_path.relative_to(ROOT)
    rel_inc = inc_path.relative_to(ROOT)

    sibling_c = ROOT / sibling_obj.replace(".o", ".c")
    if not sibling_c.exists():
        print(f"sibling .c file {sibling_c} doesn't exist; can't crib includes",
              file=sys.stderr)
        return 1

    insert_idx, insert_indent = linker_insertion(asm, args.end)
    new_obj_line = (
        f"{insert_indent}{rel_src.with_suffix('.o').as_posix()}(.text);"
    )
    rodata = linker_rodata_insertion(sibling_obj)

    header_rel = (
        rel_inc.relative_to("include").as_posix()
        if rel_inc.is_relative_to(INC_DIR.relative_to(ROOT))
        else rel_inc.as_posix()
    )

    c_body = scaffold_c_body(cluster.prefix, header_rel, sibling_c,
                             cluster.functions)
    h_body = scaffold_h_body(cluster.prefix, cluster.functions)

    print(f"Cluster: {cluster.prefix}* ({len(cluster.functions)} functions, "
          f"{'tail' if args.end else 'head'} of {asm.name})")
    for name in cluster.functions[:8]:
        print(f"  - {name}")
    if len(cluster.functions) > 8:
        print(f"  ... and {len(cluster.functions) - 8} more")
    print()
    print(f"Will create: {rel_src}")
    print(f"Will create: {rel_inc}")
    print(f"Will insert into linker.ld@{insert_idx + 1}:  {new_obj_line.strip()}")
    if rodata:
        ro_idx, ro_indent, ro_obj = rodata
        new_ro = f"{ro_indent}{rel_src.with_suffix('.o').as_posix()}(.rodata);"
        print(f"Will insert into linker.ld@{ro_idx + 1}:  {new_ro.strip()}")
    else:
        print("(no sibling .rodata entry — skipping .rodata insertion)")
    print()
    print("After scaffold, next steps for the agent:")
    print(f"  1. python3 tools/agent/snapshot_addresses.py")
    print(f"  2. make -j8 && make check  # MUST still match — empty file changes nothing")
    print(f"  3. Decomp {cluster.functions[0]} into {rel_src}, ")
    print(f"     remove from {asm.relative_to(ROOT)}, verify with compile_and_view_assembly.py")

    if not args.apply:
        print()
        print("(dry-run — re-run with --apply to write)")
        return 0

    # --- apply ---
    if src_path.exists():
        print(f"ERROR: {rel_src} already exists; aborting.", file=sys.stderr)
        return 2
    if inc_path.exists():
        print(f"ERROR: {rel_inc} already exists; aborting.", file=sys.stderr)
        return 2

    src_path.parent.mkdir(parents=True, exist_ok=True)
    inc_path.parent.mkdir(parents=True, exist_ok=True)
    src_path.write_text(c_body)
    inc_path.write_text(h_body)

    lines = LINKER.read_text(errors="replace").splitlines()
    if rodata:
        ro_idx, ro_indent, _ = rodata
        new_ro = f"{ro_indent}{rel_src.with_suffix('.o').as_posix()}(.rodata);"
        lines.insert(ro_idx, new_ro)
        # account for the shift if .rodata insertion was before .text insertion
        if ro_idx <= insert_idx:
            insert_idx += 1
    lines.insert(insert_idx, new_obj_line)
    LINKER.write_text("\n".join(lines) + "\n")

    print(f"\n✓ wrote {rel_src}")
    print(f"✓ wrote {rel_inc}")
    print(f"✓ updated linker.ld")

    # Rebuild and verify it still matches (scaffold should add nothing).
    print()
    print("Rebuilding to verify scaffold is byte-neutral…")
    proc = subprocess.run(["make", "-j8"], cwd=ROOT, capture_output=True,
                          text=True)
    if proc.returncode != 0:
        print("BUILD FAILED:", file=sys.stderr)
        print(proc.stderr[-2000:], file=sys.stderr)
        return 3
    check = subprocess.run(["make", "check"], cwd=ROOT, capture_output=True,
                           text=True)
    if check.returncode != 0:
        print("MATCH CHECK FAILED — scaffold introduced layout drift:",
              file=sys.stderr)
        print(check.stdout[-1000:], file=sys.stderr)
        print(check.stderr[-1000:], file=sys.stderr)
        return 4
    print("✓ make check still passes")

    print()
    print("Snapshotting addresses…")
    snap = subprocess.run(
        ["python3", "tools/agent/snapshot_addresses.py"],
        cwd=ROOT, capture_output=True, text=True,
    )
    print(snap.stdout.strip())
    if snap.returncode != 0:
        print(snap.stderr, file=sys.stderr)

    print()
    print(f"Ready. Next: decomp {cluster.functions[0]} into {rel_src}.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
