#!/usr/bin/env python3
"""Pre-commit guard: reject apostrophes inside C comments in INCBIN-using files.

Discovered the hard way (see docs/codegen-notes.md): `tools/preproc` tracks
single-quote (`'`) characters as string delimiters but does NOT skip C
comments. A lone `'s`, `don't`, etc. inside a `/* */` (or `//`) block in any
C file that goes through `preproc` will silently swallow every subsequent
`INCBIN_*` directive until the next apostrophe, turning the affected typed
arrays into `.comm` symbols — leaving you with a build that links cleanly,
fails `make check` mysteriously, and reads as a "data extraction is wrong"
mystery for hours.

This script scans staged C files. For each file that contains an `INCBIN_*`
macro call OR sits under `src/data/`, it flags every apostrophe found
inside a `/* */` or `//` comment. Strings are skipped properly. Exit code
3 on any finding; 0 otherwise.

Run via the pre-commit hook (scripts/pre-commit); standalone usage:

    python3 tools/agent/lint_incbin_apostrophes.py [path...]

Run with no args to scan the staged set; pass paths to scan specific files.
"""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent


def staged_files() -> list[Path]:
    """Return staged-for-commit C files (added/copied/modified)."""
    try:
        out = subprocess.check_output(
            ["git", "diff", "--cached", "--name-only", "--diff-filter=ACM"],
            cwd=ROOT,
            text=True,
        )
    except subprocess.CalledProcessError:
        return []
    paths = []
    for line in out.splitlines():
        p = (ROOT / line).resolve()
        if p.suffix in (".c", ".h") and p.is_file():
            paths.append(p)
    return paths


def is_incbin_user(text: str, path: Path) -> bool:
    """Heuristic for "this file goes through preproc and uses INCBIN".

    True if the file's path is under src/data/ (where every file uses INCBIN
    by convention) OR if the file body contains an INCBIN_* macro call.
    """
    try:
        rel = path.relative_to(ROOT)
    except ValueError:
        rel = path
    if rel.parts[:2] == ("src", "data"):
        return True
    return any(tok in text for tok in ("INCBIN_U", "INCBIN_S", "INCBIN("))


def find_comment_apostrophes(text: str) -> list[tuple[int, int, str]]:
    """Walk `text` byte-by-byte tracking string/char/comment state.

    Returns list of (line, col, line_text) for every apostrophe found inside
    a /* */ or // comment. State machine handles:
      - "..."   string literals (apostrophes inside are fine, but they're
                quotes too — preproc treats `"` as a string delimiter, so
                inside a string the parser is already in the right state)
      - '\\''   char literals (legal C, allowed)
      - /* */   block comments
      - //...   line comments
    """
    findings: list[tuple[int, int, str]] = []
    lines = text.split("\n")
    line_no = 1
    col = 1
    i = 0
    n = len(text)

    # State: 'code', 'string', 'char', 'line_comment', 'block_comment'
    state = "code"

    def advance(c: str) -> None:
        nonlocal line_no, col
        if c == "\n":
            line_no += 1
            col = 1
        else:
            col += 1

    while i < n:
        c = text[i]
        nxt = text[i + 1] if i + 1 < n else ""

        if state == "code":
            if c == "/" and nxt == "/":
                state = "line_comment"
                i += 2
                col += 2
                continue
            if c == "/" and nxt == "*":
                state = "block_comment"
                i += 2
                col += 2
                continue
            if c == '"':
                state = "string"
            elif c == "'":
                state = "char"
        elif state == "string":
            if c == "\\" and nxt:
                # Skip escaped char
                advance(c)
                i += 1
                advance(nxt)
                i += 1
                continue
            if c == '"':
                state = "code"
        elif state == "char":
            if c == "\\" and nxt:
                advance(c)
                i += 1
                advance(nxt)
                i += 1
                continue
            if c == "'":
                state = "code"
        elif state == "line_comment":
            if c == "'":
                findings.append((line_no, col, lines[line_no - 1]))
            if c == "\n":
                state = "code"
        elif state == "block_comment":
            if c == "'":
                findings.append((line_no, col, lines[line_no - 1]))
            if c == "*" and nxt == "/":
                state = "code"
                i += 2
                col += 2
                continue

        advance(c)
        i += 1
    return findings


def lint(paths: list[Path]) -> int:
    failures: list[tuple[Path, list[tuple[int, int, str]]]] = []
    for p in paths:
        try:
            text = p.read_text()
        except (UnicodeDecodeError, OSError):
            continue
        if not is_incbin_user(text, p):
            continue
        hits = find_comment_apostrophes(text)
        if hits:
            failures.append((p, hits))

    if not failures:
        return 0

    print("ERROR: apostrophe found inside a C comment in an INCBIN-using file.", file=sys.stderr)
    print(file=sys.stderr)
    print("This will silently break tools/preproc — the apostrophe is treated", file=sys.stderr)
    print("as a string delimiter, swallowing every subsequent INCBIN macro until", file=sys.stderr)
    print("the next `'`. See docs/codegen-notes.md \"Apostrophes in C comments\".", file=sys.stderr)
    print(file=sys.stderr)
    for path, hits in failures:
        try:
            rel = path.relative_to(ROOT)
        except ValueError:
            rel = path
        for line_no, col, line_text in hits:
            print(f"  {rel}:{line_no}:{col}:  {line_text.rstrip()}", file=sys.stderr)
    print(file=sys.stderr)
    print("Fix: replace `'` with a typographic apostrophe (’), or just remove it.", file=sys.stderr)
    return 3


def main() -> int:
    if len(sys.argv) > 1:
        paths = [Path(a).resolve() for a in sys.argv[1:]]
    else:
        paths = staged_files()
    return lint(paths)


if __name__ == "__main__":
    sys.exit(main())
