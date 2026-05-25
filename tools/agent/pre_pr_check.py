#!/usr/bin/env python3
"""Pre-PR style checker — heuristic catches for the common LLM-translated-asm
tells that reviewers reject. Adapted from the mf project; the project-specific
checks (samusCollision, ParticleSet, MultiSpriteData, OAM extraction, etc.)
were stripped — extend this script with Frogger-specific rules as they emerge.

Usage:
    python3 tools/agent/pre_pr_check.py <commit-range>
    python3 tools/agent/pre_pr_check.py HEAD~5..HEAD
    python3 tools/agent/pre_pr_check.py <single-sha>          # treated as <sha>^..<sha>

Exit codes:
    0 — no findings (the heuristic is happy; still read the diff)
    1 — findings (block the PR until fixed or explicitly waived)
    2 — script error (bad args, git failure)
"""
from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent.parent


def sh(*cmd: str) -> str:
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    if r.returncode != 0:
        print(f"git failed ({' '.join(cmd)}): {r.stderr}", file=sys.stderr)
        sys.exit(2)
    return r.stdout


def diff_added_lines(rev_range: str) -> dict[str, list[tuple[int, str]]]:
    """Returns {path: [(line_no, line_text), ...]} for added lines only."""
    raw = sh("git", "diff", "--unified=0", rev_range)
    out: dict[str, list[tuple[int, str]]] = {}
    cur_path: str | None = None
    cur_line = 0
    for line in raw.splitlines():
        if line.startswith("+++ b/"):
            cur_path = line[6:]
            out.setdefault(cur_path, [])
        elif line.startswith("@@"):
            m = re.match(r"@@ -\d+(?:,\d+)? \+(\d+)(?:,(\d+))? @@", line)
            if m:
                cur_line = int(m.group(1))
        elif line.startswith("+") and not line.startswith("+++"):
            if cur_path:
                out[cur_path].append((cur_line, line[1:]))
            cur_line += 1
        elif not line.startswith("-"):
            cur_line += 1
    return out


# --- checks -----------------------------------------------------------------

_FINDINGS: list[tuple[str, int, str, str]] = []


def report(path: str, lineno: int, rule: str, msg: str) -> None:
    _FINDINGS.append((path, lineno, rule, msg))


def is_c_or_h(path: str) -> bool:
    return path.endswith((".c", ".h")) and not path.startswith("asm/")


def in_src(path: str) -> bool:
    return path.startswith("src/") and is_c_or_h(path)


# Header placeholder leftover (`// extern <return_type> Foo(<params>);`)
_HEADER_PLACEHOLDER = re.compile(r"^//\s*extern\s+<return_type>\s+\w+\s*\(<params>\)")
# Address-named symbol (e.g. sFoo_3953c8 or Foo_080abcde)
_ADDR_NAMED = re.compile(r"\b[a-zA-Z]\w*_[0-9a-f]{5,8}\b")
# `} else {` after a `return;` in the if body
_ELSE_AFTER_RETURN = re.compile(r"^\s*\}\s*else\s*[\{\s]")
# Side effect in if condition: `if (++x == ...)`, `if (--x ...)`, `if ((x = ...))`
_SIDE_EFFECT_IF = re.compile(r"\bif\s*\([^)]*?(\+\+|--|(?<![<>=!])=(?!=))[^)]*\)")
# Process / explanation comments in code (heuristic)
_PROCESS_COMMENT = re.compile(
    r"(lives here because|will migrate|non-static so|TODO permuter)", re.I
)


def check_lines(path: str, lines: list[tuple[int, str]]) -> None:
    for lineno, text in lines:
        s = text.rstrip("\n")

        if in_src(path) and path.endswith(".c"):
            if _ELSE_AFTER_RETURN.search(s):
                report(path, lineno, "else-after-return",
                       "`} else {` after an `if` that returned — flatten with early return")
            if _SIDE_EFFECT_IF.search(s):
                report(path, lineno, "side-effect-if",
                       "side effect in if-condition — split into two statements")

        if path.startswith("include/") and path.endswith(".h"):
            if _HEADER_PLACEHOLDER.search(s):
                report(path, lineno, "header-placeholder",
                       "// extern <return_type> ... placeholder — replace with real prototype or delete")

        # Address-named symbols in any new .h or .c
        if is_c_or_h(path):
            for m in _ADDR_NAMED.finditer(s):
                name = m.group(0)
                # whitelist baserom-blob filenames and a few common prefixes
                if name.startswith(("sBlob_", "Blob_", "_080", "_0x080", "_0x081", "_0x082", "_0x083")):
                    continue
                report(path, lineno, "addr-named",
                       f"address-named symbol '{name}' — give it a semantic name")
                break  # one per line

        # Process comments
        if in_src(path) and _PROCESS_COMMENT.search(s) and s.lstrip().startswith(("/*", "//", "*")):
            report(path, lineno, "process-comment",
                   "process/explanation comment — move to PR description")


# --- main -------------------------------------------------------------------


_C_FUNC_DEF = re.compile(r"^(?:static\s+)?(?:const\s+)?[A-Za-z_]\w*[\s\*]+([A-Za-z_]\w+)\s*\([^;]*$")


def added_c_functions(diff: dict[str, list[tuple[int, str]]]) -> list[tuple[str, str]]:
    out: list[tuple[str, str]] = []
    for path, lines in diff.items():
        if not (path.startswith("src/") and path.endswith(".c")):
            continue
        for _, text in lines:
            m = _C_FUNC_DEF.match(text)
            if m:
                out.append((path, m.group(1)))
    return out


def asm_functions_remaining() -> list[tuple[str, str]]:
    out: list[tuple[str, str]] = []
    asm_dir = ROOT / "asm"
    if not asm_dir.exists():
        return out
    for p in sorted(asm_dir.glob("disasm_*.s")):
        for line in p.read_text(errors="replace").splitlines():
            m = re.match(r"\s*thumb_func_start\s+(\w+)", line)
            if m:
                out.append((str(p.relative_to(ROOT)), m.group(1)))
    return out


def _common_prefix_len(a: str, b: str) -> int:
    n = min(len(a), len(b))
    for i in range(n):
        if a[i].lower() != b[i].lower():
            return i
    return n


def check_cluster_completeness(diff: dict[str, list[tuple[int, str]]]) -> None:
    """Flag if the diff decompiles part of a function cluster but leaves
    siblings in asm. Heuristic: any remaining thumb_func_start sharing a
    4+ char prefix with a decompiled function is a likely sibling.
    """
    decomped = added_c_functions(diff)
    if not decomped:
        return
    remaining = asm_functions_remaining()
    if not remaining:
        return

    flagged: dict[str, list[str]] = {}
    for _, decomp_name in decomped:
        for asm_file, rem_name in remaining:
            if _common_prefix_len(decomp_name, rem_name) >= 4:
                flagged.setdefault(asm_file, []).append(rem_name)

    for asm_file, names in flagged.items():
        unique = sorted(set(names))
        report(
            asm_file, 1, "cluster-incomplete",
            f"{len(unique)} sibling function(s) of decompiled work still in asm: "
            + ", ".join(unique[:6])
            + (f", ... (+{len(unique)-6} more)" if len(unique) > 6 else "")
            + " — finish the cluster before PR'ing.",
        )


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print(__doc__, file=sys.stderr)
        return 2
    arg = argv[1]
    rev_range = arg if ".." in arg else f"{arg}^..{arg}"

    diff = diff_added_lines(rev_range)
    for path, lines in diff.items():
        check_lines(path, lines)
    check_cluster_completeness(diff)

    if not _FINDINGS:
        print(f"pre_pr_check: no style findings on {rev_range}")
        print("(this is a heuristic — read the diff against CLAUDE.md too)")
        return 0

    print(f"pre_pr_check: {len(_FINDINGS)} findings on {rev_range}\n")
    last_path = None
    for path, lineno, rule, msg in sorted(_FINDINGS):
        if path != last_path:
            print(f"\n{path}:")
            last_path = path
        print(f"  {lineno:5}: [{rule}] {msg}")
    print(
        "\nFix or explicitly waive each finding (in a commit message) before opening a PR.\n"
        "See CLAUDE.md for the full style rules."
    )
    return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
