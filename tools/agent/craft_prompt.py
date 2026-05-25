#!/usr/bin/env python3
"""Build the per-function decomp prompt for the Claude loop.

Adapted from Mizuchi (https://github.com/macabeus/mizuchi),
src/shared/prompt-builder/craft-prompt.ts.
Copyright (c) 2025 macabeus, MIT License. See prompts/ATTRIBUTION.md.

Usage:
    craft_prompt.py <FunctionName>

Output: rendered prompt on stdout. Pipe into your agent runner of choice.

What it does, given a function name from `pick_target.py`:
  1. Locates the asm block in `asm/disasm_0x*.s` (uses pick_target's parser).
  2. Finds the destination `src/*.c` from `linker.ld` (the disasm file sits
     between two named .o entries; the function belongs to one of them — we
     pick the next named C file as a heuristic, agent should confirm).
  3. Extracts the called functions (`bl Name`) from the target asm.
  4. Pulls C declarations for those callees from `include/`.
  5. Samples up to 5 already-decomped functions from the same destination
     C file as in-context examples (no embeddings yet — first-come).
  6. Renders `prompts/task_template.md` with those slots filled.

This is the rough first cut. Real retrieval (embeddings, similarity-to-matched
scheduling) is tier-2 in the Mizuchi adoption plan; this version exists so the
loop has a real prompt today.
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
ASM_DIR = ROOT / "asm"
SRC_DIR = ROOT / "src"
INCLUDE_DIR = ROOT / "include"
LINKER = ROOT / "linker.ld"
TEMPLATE = Path(__file__).parent / "prompts" / "task_template.md"

FUNC_START_RE = re.compile(
    r"^\s*(thumb_func_start|arm_func_start)\s+(\S+)\s*$"
)
BL_RE = re.compile(r"^\s*bl\s+([A-Za-z_]\w+)")
LINKER_OBJ_RE = re.compile(r"\s*(\S+\.o)\(\.text\)")

PLATFORM_NAME = "Game Boy Advance"
ASM_LANG = "ARMv4T (Thumb)"


@dataclass
class AsmBlock:
    file: Path
    name: str
    start_line: int  # 0-indexed
    end_line: int    # exclusive
    body: str        # raw asm text from `thumb_func_start` through end


def find_target(name: str) -> AsmBlock | None:
    """Locate `name`'s asm block across all `asm/disasm_*.s`."""
    for p in sorted(ASM_DIR.glob("disasm_*.s")):
        lines = p.read_text(errors="replace").splitlines(keepends=True)
        starts = [
            (i, m.group(2))
            for i, line in enumerate(lines)
            if (m := FUNC_START_RE.match(line))
        ]
        for idx, (line_no, fname) in enumerate(starts):
            if fname != name:
                continue
            end = starts[idx + 1][0] if idx + 1 < len(starts) else len(lines)
            return AsmBlock(
                file=p,
                name=name,
                start_line=line_no,
                end_line=end,
                body="".join(lines[line_no:end]),
            )
    return None


def _neighbour_c_files(asm_file: Path) -> tuple[Path | None, Path | None]:
    """Return (previous, next) src/*.c files surrounding `asm_file` in
    linker.ld order. Either may be None."""
    asm_obj = f"{asm_file.stem}.o(.text)"
    lines = LINKER.read_text(errors="replace").splitlines()
    hit = next((i for i, l in enumerate(lines) if asm_obj in l), None)
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


def _name_score(target: str, c_file: Path) -> int:
    """How well does `c_file`'s existing function names match `target`?
    Returns the length of the longest shared prefix across any function
    declared in the file. Higher = better fit.
    """
    if not c_file.exists():
        return 0
    text = c_file.read_text(errors="replace")
    func_re = re.compile(
        r"^(?:static\s+)?[A-Za-z_]\w*[\s\*]+([A-Za-z_]\w+)\s*\(",
        re.MULTILINE,
    )
    best = 0
    for m in func_re.finditer(text):
        name = m.group(1)
        n = 0
        while n < len(name) and n < len(target) and name[n] == target[n]:
            n += 1
        if n > best:
            best = n
    return best


def destination_c_file(asm_file: Path, target_name: str) -> Path | None:
    """Pick the destination C file for `target_name` from the asm file.

    Looks at the C files immediately before and after the asm in linker.ld;
    picks whichever has functions whose names share the longest prefix with
    the target. Falls back to the next C file (legacy heuristic) when both
    score 0. Returns None only if linker.ld has no surrounding C file at all.
    """
    prev, nxt = _neighbour_c_files(asm_file)
    prev_score = _name_score(target_name, prev) if prev else 0
    nxt_score = _name_score(target_name, nxt) if nxt else 0
    if prev_score == 0 and nxt_score == 0:
        return nxt or prev
    return prev if prev_score >= nxt_score else nxt


def extract_callees(asm_body: str) -> list[str]:
    callees: list[str] = []
    seen: set[str] = set()
    for line in asm_body.splitlines():
        m = BL_RE.match(line)
        if not m:
            continue
        name = m.group(1)
        if name.startswith("_"):
            continue
        if name in seen:
            continue
        seen.add(name)
        callees.append(name)
    return callees


def find_declaration(name: str) -> str | None:
    """Best-effort: grep `include/` for `... name(...)` and return the
    matching line stripped. Doesn't try to parse C — just surfaces the prototype.
    """
    pat = re.compile(rf"\b{re.escape(name)}\s*\(")
    for header in sorted(INCLUDE_DIR.rglob("*.h")):
        try:
            for line in header.read_text(errors="replace").splitlines():
                stripped = line.strip()
                if not pat.search(stripped):
                    continue
                if stripped.startswith(("//", "*", "/*", "#define")):
                    continue
                if ";" not in stripped:
                    continue
                return stripped
        except Exception:
            continue
    return None


def sample_examples(dest_c: Path | None, limit: int = 3) -> list[tuple[str, str]]:
    """Pull up to `limit` small already-decomped functions from `dest_c` as
    in-context examples. Returns list of (name, C body).

    No embeddings yet — picks the first N short functions in the file. Good
    enough to convey local style; refine later with ASM-normalized similarity.
    """
    if dest_c is None or not dest_c.exists():
        return []
    text = dest_c.read_text(errors="replace")
    # Match function definitions (rough): line starts with non-keyword identifier
    # followed by other identifiers and `(`, then balanced braces.
    func_re = re.compile(
        r"^(?:static\s+)?[A-Za-z_]\w*[\s\*]+([A-Za-z_]\w+)\s*\([^;]*?\)\s*\{",
        re.MULTILINE,
    )
    out: list[tuple[str, str]] = []
    for m in func_re.finditer(text):
        name = m.group(1)
        start = m.start()
        # Find matching brace
        depth = 0
        i = m.end() - 1
        while i < len(text):
            if text[i] == "{":
                depth += 1
            elif text[i] == "}":
                depth -= 1
                if depth == 0:
                    body = text[start : i + 1]
                    if 50 < len(body) < 1200:
                        out.append((name, body))
                    break
            i += 1
        if len(out) >= limit:
            break
    return out


def render(target: AsmBlock) -> str:
    dest_c = destination_c_file(target.file, target.name)
    callees = extract_callees(target.body)
    callee_decls = {n: d for n in callees if (d := find_declaration(n))}
    examples = sample_examples(dest_c)
    target_decl = find_declaration(target.name)

    template = TEMPLATE.read_text()

    def fill(slot: str, content: str) -> None:
        nonlocal template
        template = template.replace("{{" + slot + "}}", content)

    example_block = ""
    if examples:
        example_block = "# Examples (already-decompiled functions in the same file)\n\n"
        for name, body in examples:
            example_block += f"## `{name}`\n\n```c\n{body}\n```\n\n"
        example_block = example_block.rstrip()

    target_decl_block = ""
    if target_decl:
        target_decl_block = (
            f"# Function declaration for the target\n\n`{target_decl}`"
        )

    callee_decl_block = ""
    if callee_decls:
        callee_decl_block = "# Declarations for functions called from the target\n\n"
        callee_decl_block += "\n".join(f"- `{d}`" for d in callee_decls.values())

    fill("assemblyFunctionName", target.name)
    fill("assemblyLanguage", ASM_LANG)
    fill("platformName", PLATFORM_NAME)
    fill("modulePath", str(target.file.relative_to(ROOT)))
    fill("destinationCFile",
         str(dest_c.relative_to(ROOT)) if dest_c else "src/<unknown>.c")
    fill("assemblyFile", str(target.file.relative_to(ROOT)))
    fill("assemblyCode", target.body.rstrip())
    fill("examplePrompts", example_block)
    fill("functionsCallingTargetPrompt", "")  # tier 2: requires call-graph
    fill("targetAssemblyDeclarationPrompt", target_decl_block)
    fill("functionDeclarationsPrompt", callee_decl_block)
    fill("typeDefinitionsPrompt", "")  # tier 2: requires type-use analysis

    # Collapse runs of 3+ blank lines left by empty slots.
    template = re.sub(r"\n{3,}", "\n\n", template)
    return template


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("name", help="function name (must exist in asm/disasm_*.s)")
    args = p.parse_args()

    target = find_target(args.name)
    if target is None:
        print(f"no asm block found for {args.name!r} in asm/disasm_*.s",
              file=sys.stderr)
        return 1

    sys.stdout.write(render(target))
    return 0


if __name__ == "__main__":
    sys.exit(main())
