#!/usr/bin/env python3
"""Pick the next decomp target function from asm/disasm_*.s — layout-aware.

Per-function decomp must proceed in baserom address order within each
compilation unit, otherwise the new C-defined function lands at the wrong
ROM offset and the build no longer matches. (We verified this the hard way
in the first agent-loop smoke test — see commit history.)

So the *legal* next target for each `asm/disasm_*.s` file is the **first**
thumb_func_start in that file (lowest address), and the destination is the
**previous** `src/*.o(.text)` line in `linker.ld` — that C file will receive
the new function appended at its end, exactly where the bytes need to land.

A target is "legal" when:
  1. It is the first function in its asm file (line order = address order).
  2. The previous neighbour in linker.ld is an existing `src/*.c` file.
  3. That C file already contains at least one function whose name shares a
     non-trivial prefix with the target (heuristic that the cluster belongs
     to that file, not a new one). Threshold defaults to 3 characters.

Without --all, only legal targets are returned. With --all, every "first-in-
file" function appears, with a `legal` flag in JSON or a marker in human
output, so you can see which clusters need a new C file (and a linker.ld
edit) before they're decomp-tractable.

Usage:
  pick_target.py                      # legal targets, ranked by instr count
  pick_target.py --all                # also include cluster-needs-new-file
  pick_target.py --max-size 40        # cap instruction count
  pick_target.py --limit 50
  pick_target.py --json
  pick_target.py --name FunctionName  # inspect a specific function's legality
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from dataclasses import dataclass, asdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
ASM_DIR = ROOT / "asm"
LINKER = ROOT / "linker.ld"

FUNC_START_RE = re.compile(
    r"^\s*(thumb_func_start|arm_func_start)\s+(\S+)\s*$"
)
LINKER_OBJ_RE = re.compile(r"\s*(\S+\.o)\(\.text\)")
ADDR_COMMENT_RE = re.compile(r"@\s*0x([0-9a-fA-F]{8})")
DEFAULT_NAME_PREFIX_MIN = 3


@dataclass
class Target:
    file: str             # asm file containing the function
    name: str
    start_line: int       # 1-indexed for editor jumps
    end_line: int
    line_count: int
    instr_count: int
    addr: int             # baserom address of the function (from @ 0xADDR)
    is_first_in_file: bool
    destination: str | None   # previous src/*.c in linker order, or None
    legal: bool
    legality_note: str    # short explanation

    @property
    def addr_hex(self) -> str:
        return f"{self.addr:#010x}"


# ---------- asm parsing ----------

def parse_asm_file(path: Path) -> list[Target]:
    """Walk asm file, slice by thumb_func_start. addr comes from the next
    `@ 0xADDR` comment after the label; instr count is non-directive,
    non-label, non-blank lines until the next function start.
    """
    lines = path.read_text(errors="replace").splitlines()
    starts: list[tuple[int, str]] = []
    for i, line in enumerate(lines):
        m = FUNC_START_RE.match(line)
        if m:
            starts.append((i, m.group(2)))

    out: list[Target] = []
    for idx, (line_no, name) in enumerate(starts):
        end_line = starts[idx + 1][0] if idx + 1 < len(starts) else len(lines)
        body = lines[line_no + 1 : end_line]

        instr = 0
        addr = 0
        for raw in body:
            stripped = raw.strip()
            if not stripped or stripped.startswith("@"):
                if addr == 0 and (m := ADDR_COMMENT_RE.search(raw)):
                    addr = int(m.group(1), 16)
                continue
            if stripped.startswith("."):
                continue
            if stripped.endswith(":"):
                continue
            instr += 1
            if addr == 0 and (m := ADDR_COMMENT_RE.search(raw)):
                addr = int(m.group(1), 16)

        out.append(Target(
            file=str(path.relative_to(ROOT)),
            name=name,
            start_line=line_no + 1,
            end_line=end_line,
            line_count=end_line - line_no,
            instr_count=instr,
            addr=addr,
            is_first_in_file=(idx == 0),
            destination=None,
            legal=False,
            legality_note="",
        ))
    return out


# ---------- linker.ld neighbour lookup ----------

def _neighbour_c_files(asm_file: str) -> tuple[Path | None, Path | None]:
    """Return (previous, next) src/*.c surrounding `asm_file` in linker order."""
    asm_obj = Path(asm_file).with_suffix(".o").name
    needle = f"{Path(asm_file).parent.as_posix()}/{asm_obj}(.text)"
    lines = LINKER.read_text(errors="replace").splitlines()
    hit = next((i for i, l in enumerate(lines) if needle in l), None)
    if hit is None:
        return None, None
    prev: Path | None = None
    for line in reversed(lines[:hit]):
        m = LINKER_OBJ_RE.search(line)
        if m and m.group(1).startswith("src/"):
            prev = ROOT / m.group(1).replace(".o", ".c")
            break
    nxt: Path | None = None
    for line in lines[hit + 1 :]:
        m = LINKER_OBJ_RE.search(line)
        if m and m.group(1).startswith("src/"):
            nxt = ROOT / m.group(1).replace(".o", ".c")
            break
    return prev, nxt


def _name_prefix_score(target_name: str, c_file: Path) -> int:
    """Longest prefix shared between target_name and (a) any function in
    c_file, or (b) the file's own snake_cased basename interpreted as a
    PascalCase prefix. The latter catches freshly-scaffolded empty files
    like `status_screen.c` ↔ `StatusScreen*`.
    """
    best = _filename_affinity(target_name, c_file)
    if not c_file.exists():
        return best
    text = c_file.read_text(errors="replace")
    func_re = re.compile(
        r"^(?:static\s+)?[A-Za-z_]\w*[\s\*]+([A-Za-z_]\w+)\s*\(",
        re.MULTILINE,
    )
    for m in func_re.finditer(text):
        name = m.group(1)
        n = 0
        while n < len(name) and n < len(target_name) and name[n] == target_name[n]:
            n += 1
        if n > best:
            best = n
    return best


def _filename_affinity(target_name: str, c_file: Path) -> int:
    """If `c_file` is named e.g. `status_screen.c`, the implied PascalCase
    prefix is `StatusScreen`. Return the longest shared prefix between
    that and `target_name`, or 0 if the file's name has no obvious mapping.
    """
    stem = c_file.stem  # `status_screen`
    parts = stem.split("_")
    pascal = "".join(p[:1].upper() + p[1:] for p in parts)
    n = 0
    while n < len(pascal) and n < len(target_name) and pascal[n] == target_name[n]:
        n += 1
    return n


# ---------- legality classification ----------

_FUNC_DEF_RE = re.compile(r"^[A-Za-z_]\w*[\s\*]+([A-Za-z_]\w+)\s*\(", re.MULTILINE)


def _existing_c_definition(target_name: str) -> tuple[Path, bool] | None:
    """Scan every src/**/*.c (linked AND unwired scaffolds) for a definition
    of `target_name`. Returns (path, is_empty) if found, else None.

    `is_empty` is True when the function body is `{ }` (whitespace only) —
    a scaffold stub the agent should *fill in* rather than re-scaffold in a
    new file. `is_empty` is False when there's a real body — duplicate-work
    risk.

    Catches two failure modes:
      - PR #58: PR #13 left src/status_screen.c as an unwired scaffold with
        matching implementations of StatusScreenHandler/DrawEverything; we
        duplicated that work into a new file before noticing.
      - PR #59: src/menus/status_screen.c was scaffolded as a new file even
        though src/status_screen.c had empty-body stubs of the same names —
        the original guard only fired on non-empty bodies, missing this.
    """
    for path in sorted((ROOT / "src").rglob("*.c")):
        try:
            text = path.read_text(errors="replace")
        except Exception:
            continue
        for m in _FUNC_DEF_RE.finditer(text):
            if m.group(1) != target_name:
                continue
            brace = text.find("{", m.end())
            if brace == -1:
                continue
            depth = 1
            i = brace + 1
            while i < len(text) and depth:
                if text[i] == "{":
                    depth += 1
                elif text[i] == "}":
                    depth -= 1
                i += 1
            body = text[brace + 1 : i - 1].strip()
            return path, (body == "")
    return None


def _sheet_status(addr: int) -> tuple[str, str] | None:
    """Look up `addr` in the progress sheet. Returns (status, name) or None."""
    try:
        sys.path.insert(0, str(Path(__file__).parent))
        from sheet import find as sheet_find  # type: ignore
    except Exception:
        return None
    try:
        row = sheet_find(addr=addr)
    except Exception:
        return None
    if row is None:
        return None
    return row.status, row.name


def classify(t: Target, min_prefix: int) -> Target:
    # Guard 1: another src/*.c already defines this function (linked or not).
    existing = _existing_c_definition(t.name)
    if existing is not None:
        existing_path, is_empty = existing
        rel = existing_path.relative_to(ROOT)
        if is_empty:
            t.legality_note = (
                f"blocked: {rel} has an empty stub for {t.name}. Fill it in "
                "there rather than scaffolding a new file. (And add the .c "
                "to linker.ld if it isn't wired.)"
            )
        else:
            t.legality_note = (
                f"blocked: {rel} already defines {t.name} with a non-empty "
                "body — duplicate work risk. Investigate before decomping "
                "(the existing C may be matching and just need to be wired "
                "into linker.ld)."
            )
        return t

    # Guard 2: the project progress sheet marks this address as Complete.
    sheet = _sheet_status(t.addr)
    if sheet is not None and sheet[0].lower() == "complete":
        sheet_name = sheet[1] if sheet[1] != t.name else t.name
        t.legality_note = (
            f"blocked: progress sheet marks {sheet_name} ({t.addr:#010x}) "
            "as Complete — work likely exists in an unwired scaffold or a "
            "PR branch. Verify before decomping."
        )
        return t

    if not t.is_first_in_file:
        t.legality_note = (
            "blocked: not first in asm file — preceding function(s) must "
            "be decompiled first to preserve baserom address order"
        )
        return t

    prev, _ = _neighbour_c_files(t.file)
    if prev is None:
        t.legality_note = "blocked: no src/*.c neighbour in linker.ld"
        return t
    t.destination = str(prev.relative_to(ROOT))

    if not prev.exists():
        t.legality_note = (
            f"blocked: destination {t.destination} doesn't exist yet "
            "— need to create it and add it to linker.ld"
        )
        return t

    score = _name_prefix_score(t.name, prev)
    if score < min_prefix:
        t.legality_note = (
            f"blocked: weak name affinity with {t.destination} "
            f"(longest shared prefix: {score} chars) — likely needs a new "
            "C file inserted in linker.ld"
        )
        return t

    t.legal = True
    t.legality_note = f"OK: appends to {t.destination} (prefix match {score})"
    return t


# ---------- main ----------

def collect(min_prefix: int) -> list[Target]:
    out: list[Target] = []
    for p in sorted(ASM_DIR.glob("disasm_*.s")):
        out.extend(parse_asm_file(p))
    return [classify(t, min_prefix) for t in out]


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("--max-size", type=int, default=None,
                   help="max instruction count")
    p.add_argument("--limit", type=int, default=20,
                   help="max number of targets to print (default: 20)")
    p.add_argument("--json", action="store_true")
    p.add_argument("--name", help="show one function by exact name")
    p.add_argument("--all", action="store_true",
                   help="include non-legal candidates (with reason)")
    p.add_argument("--min-prefix", type=int, default=DEFAULT_NAME_PREFIX_MIN,
                   help=f"min name-prefix match (default: {DEFAULT_NAME_PREFIX_MIN})")
    args = p.parse_args()

    targets = collect(args.min_prefix)

    if args.name:
        targets = [t for t in targets if t.name == args.name]
        if not targets:
            print(f"no such function: {args.name}", file=sys.stderr)
            return 1
    else:
        if not args.all:
            targets = [t for t in targets if t.legal]
        if args.max_size is not None:
            targets = [t for t in targets if t.instr_count <= args.max_size]
        targets.sort(key=lambda t: (not t.legal, t.instr_count, t.name))
        targets = targets[: args.limit]

    if args.json:
        json.dump([asdict(t) for t in targets], sys.stdout, indent=2)
        sys.stdout.write("\n")
    else:
        for t in targets:
            mark = "✓" if t.legal else "✗"
            print(
                f"{mark} {t.file}:{t.start_line:<6}  {t.name:<48}"
                f"  {t.instr_count:>4} instr  {t.addr_hex}"
            )
            print(f"   → {t.legality_note}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
