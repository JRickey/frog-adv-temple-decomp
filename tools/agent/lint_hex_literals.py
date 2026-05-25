#!/usr/bin/env python3
"""Lint hex literals wider than 32 bits.

GAS and ld silently truncate over-long hex literals rather than erroring.
Commit fa09acf burned ~1h on `0x080020bc1` (9 hex chars = 36 bits) being
silently truncated to `0x80020bc1` — the load address shifted, all
downstream pointers were wrong.

This script scans .s, .c, .h, .ld, .inc files for hex literals with more
than 8 hex digits after `0x` and exits nonzero if any are found.

Whitelist: `.8byte` / `.quad` directives (which legitimately take 64-bit
values) and `0xFFFFFFFF` ULL/LL suffixed literals.

Usage:
    python3 tools/agent/lint_hex_literals.py                 # scan repo
    python3 tools/agent/lint_hex_literals.py path/to/file.s  # scan one file
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent

# Match hex literals with 9+ digits after 0x. Capture the literal itself for
# the report.
HEX_RE = re.compile(r"\b0x([0-9a-fA-F]{9,})\b")

# Match malformed `sub_<9+ hex>` symbol names — the same 36-bit / 9-digit
# bug as raw hex literals, but in symbol-name form. Convention is exactly
# 8 hex digits (the full ROM address); 9 means someone accidentally wrote
# `sub_080020B30` for what is really `sub_08020B30`. The symbol itself
# doesn't truncate at link time (it's just a name), but every reader
# misinterprets the address and propagates the bug downstream.
SUB_NAME_RE = re.compile(r"\bsub_([0-9a-fA-F]{9,})\b")

# Lines containing these tokens may legitimately have 64-bit hex literals.
# (We still report them, but they don't fail the lint.)
ALLOW_DIRECTIVES = (".8byte", ".quad")

# Extensions to scan by default.
DEFAULT_EXTENSIONS = {".s", ".c", ".h", ".ld", ".inc"}

# Directories to skip even when scanning the repo broadly.
SKIP_DIRS = {
    "node_modules",
    ".git",
    "build",
    "vendor",
    "tools/agbcc",
    "tools/agbcc-src",
    "data",  # extracted binary blobs
    "asm",   # disassembly previews contain addresses as comments — see special handling below
}


def is_allowed(line: str, lit: str) -> bool:
    """Return True if `lit` in `line` is whitelisted."""
    # 64-bit-typed directives
    for d in ALLOW_DIRECTIVES:
        if d in line:
            return True
    # Common 64-bit C suffixes
    pos = line.find(lit)
    if pos >= 0:
        tail = line[pos + len(lit) : pos + len(lit) + 3].upper()
        if tail.startswith(("ULL", "LL")):
            return True
    # `0x` in a comment after the actual code? Skip — the lexer never sees it.
    code_part = line.split("//")[0].split("@")[0].split("/*")[0]
    if lit not in code_part:
        return True
    return False


def scan_file(path: Path) -> list[tuple[int, str, str]]:
    """Return list of (line_no, full_line, offending_literal) for violations."""
    out: list[tuple[int, str, str]] = []
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return out
    for lineno, line in enumerate(text.splitlines(), start=1):
        # asm/disasm_*.s files have @-comments that include >32-bit-looking
        # bl target addresses; skip @-comment portions explicitly so we don't
        # cry wolf on objdump-preview text.
        # (Code on the same line BEFORE @ is still scanned.)
        scan_part = line.split("@", 1)[0]
        for m in HEX_RE.finditer(scan_part):
            lit = "0x" + m.group(1)
            if is_allowed(line, lit):
                continue
            out.append((lineno, line.rstrip(), lit))
        # Symbol-name form: catches `sub_080020B30` (9 hex digits) which is
        # a misnamed reference to `sub_08020B30`. Symbol names show up in
        # both code and comments, so scan the whole line (no @ split).
        for m in SUB_NAME_RE.finditer(line):
            lit = "sub_" + m.group(1)
            out.append((lineno, line.rstrip(), lit))
    return out


def iter_files(roots: list[Path]) -> list[Path]:
    files: list[Path] = []
    for root in roots:
        if root.is_file():
            files.append(root)
            continue
        for path in root.rglob("*"):
            if not path.is_file():
                continue
            rel = path.relative_to(ROOT) if path.is_absolute() else path
            rel_str = str(rel)
            if any(rel_str.startswith(d + "/") or rel_str == d for d in SKIP_DIRS):
                continue
            if path.suffix not in DEFAULT_EXTENSIONS:
                continue
            files.append(path)
    return files


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("paths", nargs="*", help="files or directories to scan (default: repo root)")
    p.add_argument("--quiet", action="store_true", help="report only violations, no summary")
    args = p.parse_args()

    roots = [Path(p).resolve() for p in args.paths] if args.paths else [ROOT]
    files = iter_files(roots)

    total = 0
    for path in files:
        violations = scan_file(path)
        if not violations:
            continue
        rel = path.relative_to(ROOT) if str(path).startswith(str(ROOT)) else path
        for lineno, line, lit in violations:
            if lit.startswith("sub_"):
                digits = len(lit) - 4
                print(f"{rel}:{lineno}: symbol name {lit} ({digits} hex digits — "
                      f"convention is 8; this is the same 36-bit bug as 0x-literals)")
            else:
                digits = len(lit) - 2
                print(f"{rel}:{lineno}: hex literal {lit} ({digits} digits, "
                      f"would silently truncate to {digits * 4}-bit value)")
            print(f"  | {line}")
            total += 1

    if not args.quiet:
        if total == 0:
            print(f"OK: scanned {len(files)} files, no over-wide hex literals.")
        else:
            print(f"\nFAIL: {total} over-wide hex literal(s) in {len(files)} scanned files.")

    return 0 if total == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
