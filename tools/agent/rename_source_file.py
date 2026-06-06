#!/usr/bin/env python3
"""Rename a source file (and its dir) to a semantic name, byte-neutrally.

Sources are wildcard-discovered by the Makefile, so a `.c` rename only needs:
  1. `git mv` the file (creating the destination dir).
  2. Patch `linker.ld`: the `src/<dir>/<old>.o(...)` object reference -> new path,
     kept at the SAME address slot (the byte layout is unchanged — only the file
     name changes). The address-range comment is preserved as-is.
  3. Patch the `Makefile` per-TU rules that target the derived `.s`
     (e.g. `src/game/sub_08003254.s: CFLAGS += -ffixed-r3`). Missing one would
     silently drop a compiler flag and send that function NON-MATCHING.
Then `make -j8 && make check`; revert atomically on any failure.

Requires a CLEAN tree (so the revert is a safe `git reset --hard`). Leaves the
rename staged + edits unstaged for the caller to inspect and commit.

Usage:
    python3 tools/agent/rename_source_file.py src/engine/sub_0801cd0c.c src/engine/ui_window.c
    python3 tools/agent/rename_source_file.py <old> <new> --no-check   # skip make check
"""
from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
LINKER = REPO / "linker.ld"
MAKEFILE = REPO / "Makefile"


def git(*a, check=True):
    return subprocess.run(["git", "-C", str(REPO), *a], capture_output=True, text=True, check=check)


def tree_dirty() -> list[str]:
    out = git("status", "--porcelain").stdout.splitlines()
    return [ln for ln in out if not ln.startswith("??")]


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("old", help="existing source path, e.g. src/engine/sub_0801cd0c.c")
    ap.add_argument("new", help="new source path, e.g. src/engine/ui_window.c")
    ap.add_argument("--no-check", action="store_true", help="skip make check (not recommended)")
    ap.add_argument("--batch", action="store_true",
                    help="batch mode: tolerate a dirty tree (prior uncommitted renames) and, on "
                         "make-check failure, SCOPED-revert only THIS rename (not the whole tree) "
                         "so the caller can land many renames in one commit")
    args = ap.parse_args()

    old = Path(args.old)
    new = Path(args.new)
    old_abs = (REPO / old).resolve()
    new_abs = (REPO / new).resolve()

    if not old_abs.exists():
        raise SystemExit(f"source {old} does not exist")
    if new_abs.exists():
        raise SystemExit(f"destination {new} already exists")
    if old.suffix != new.suffix:
        raise SystemExit("old and new must share an extension (.c/.h)")
    if not args.batch and (dirty := tree_dirty()):
        raise SystemExit("tree has uncommitted tracked changes — commit/stash first so a "
                         "failed rename reverts cleanly (or use --batch):\n" + "\n".join(dirty))

    old_rel, new_rel = str(old), str(new)
    old_obj, new_obj = old_rel[:-2] + ".o", new_rel[:-2] + ".o"      # src/.../x.o token
    old_s, new_s = old_rel[:-2] + ".s", new_rel[:-2] + ".s"          # per-TU .s token

    # Capture pre-edit copies for a scoped revert (batch mode).
    linker_txt = LINKER.read_text()
    make_txt = MAKEFILE.read_text()
    edited_originals = {}  # path -> original text
    if old_obj not in linker_txt:
        print(f"warning: {old_obj} not found in linker.ld (file may be unwired)", file=sys.stderr)
    has_make_rule = (old_s + ":") in make_txt

    # 1. git mv (mkdir the destination dir).
    (REPO / new).parent.mkdir(parents=True, exist_ok=True)
    git("mv", old_rel, new_rel)

    # 2. linker.ld — swap the object path token (covers .text/.rodata/.data/.bss).
    if old_obj in linker_txt:
        edited_originals[LINKER] = linker_txt
        LINKER.write_text(linker_txt.replace(old_obj, new_obj))

    # 3. Makefile — swap the derived .s token in per-TU rules.
    if has_make_rule:
        edited_originals[MAKEFILE] = make_txt
        MAKEFILE.write_text(make_txt.replace(old_s, new_s))

    # 4. header includes (only when renaming a .h).
    include_updates = 0
    if old.suffix == ".h":
        inc_old, inc_new = f'"{old.name}"', f'"{new.name}"'
        for p in list(REPO.glob("src/**/*.c")) + list(REPO.glob("src/**/*.h")) + list(REPO.glob("include/**/*.h")):
            t = p.read_text(errors="replace")
            if inc_old in t:
                edited_originals[p] = t
                p.write_text(t.replace(inc_old, inc_new))
                include_updates += 1

    print(f"renamed {old_rel} -> {new_rel}")
    print(f"  linker.ld: {'patched' if old_obj in linker_txt else 'no entry'}; "
          f"Makefile per-TU rule: {'patched' if has_make_rule else 'none'}; "
          f"header includes updated: {include_updates}")

    if args.no_check:
        print("skipping make check (--no-check). Verify before committing.")
        return 0

    print("running make -j8 && make check ...")
    build = subprocess.run(["make", "-j8"], cwd=REPO)
    check = subprocess.run(["make", "check"], cwd=REPO) if build.returncode == 0 else build
    if build.returncode != 0 or check.returncode != 0:
        print("\n*** make check FAILED — reverting the rename ***", file=sys.stderr)
        if args.batch:
            # Scoped revert: undo ONLY this rename, preserving prior batch renames.
            for p, txt in edited_originals.items():
                p.write_text(txt)
            if new_abs.exists() and not old_abs.exists():
                git("mv", new_rel, old_rel, check=False)
        else:
            git("reset", "--hard", "HEAD", check=False)   # safe: tree was clean at start
            git("clean", "-fd", "--", new_rel, check=False)
        print("reverted. Likely a missed Makefile per-TU rule or a linker slot mismatch.",
              file=sys.stderr)
        return 1

    print("\nmake check PASSED — rename is byte-identical. Stage + commit when ready "
          "(git add -A && git commit).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
