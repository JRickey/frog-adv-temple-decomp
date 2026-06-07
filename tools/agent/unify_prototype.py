#!/usr/bin/env python3
"""Centralize one function's prototype into a shared header and delete the ad-hoc
`extern` re-declarations from every caller .c, guarded by a CLEAN `make check`.

Canonical signature comes from the function's COMPILED in-tree definition
(NON_MATCHING reference bodies are skipped) unless --sig overrides it. Every
caller that had an ad-hoc extern gets the header #include instead, AND the
definition's own file is made to include the header too — so the compiler
verifies proto==definition (this is what catches NAKED functions whose real
signature is `void(void)` but whose callers pass args: that mismatch fails the
build and the whole transaction auto-reverts, instead of lurking as a latent
landmine that only surfaces when some unrelated file later includes the header).

The gate is `make tidy && make -j8 && make check` (CLEAN, not incremental):
adding a prototype to a shared header does not rebuild existing includers, so an
incremental build gives a false green when the new proto conflicts somewhere it
wasn't otherwise recompiled. On any non-green result every touched file is
reverted with `git checkout` and the run reports FAILED.

Only meant for COSMETIC drift (see data_model_inventory.py --externs): variants
differing only in param names / pointer-target types. ABI drift (scalar
return/arg type, arg count) and NAKED-vs-args mismatches fail the gate by design.

Usage:
  python3 tools/agent/unify_prototype.py ModeControl_SetBit --header include/iwram.h --dry-run
  python3 tools/agent/unify_prototype.py ModeControl_SetBit --header include/iwram.h --apply
  python3 tools/agent/unify_prototype.py Foo --header include/x.h --sig "u32 Foo(void *p, u32 n)" --apply
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SRC = REPO / "src"


def find_definition(func):
    """Return (sig, file, naked) for the function's COMPILED definition, skipping
    #ifdef NON_MATCHING true-branches. Leading NAKED/static is stripped from sig.
    (None, None, False) if no in-tree definition is found."""
    line_re = re.compile(
        r"^(?:static\s+)?(?:NAKED\s+)?[A-Za-z_][\w *]*?\b" + re.escape(func) + r"\s*\([^;{]*\)\s*\{?\s*$"
    )
    for f in sorted(SRC.rglob("*.c")):
        stack = []  # frames: [is_nm_conditional, is_dead_branch]
        for ln in f.read_text(errors="ignore").splitlines():
            s = ln.strip()
            if re.match(r"#\s*if", s):
                is_nm = "NON_MATCHING" in s
                dead = is_nm and (s.startswith("#ifdef") or s.startswith("#if NON_MATCHING")
                                  or "defined(NON_MATCHING)" in s)
                stack.append([is_nm, dead])
                continue
            if s.startswith("#else"):
                if stack and stack[-1][0]:
                    stack[-1][1] = not stack[-1][1]
                continue
            if s.startswith("#endif"):
                if stack:
                    stack.pop()
                continue
            if any(d for _, d in stack):
                continue
            if "extern" in ln or ";" in ln:
                continue
            if line_re.match(ln):
                naked = "NAKED" in ln
                sig = " ".join(ln.replace("NAKED", "").rstrip("{ ").split())
                return sig, str(f.relative_to(REPO)), naked
    return None, None, False


def _add_include(txt, inc):
    if inc in txt:
        return txt
    m = re.search(r"^#include[^\n]*\n", txt, re.M)
    if m:
        return txt[: m.end()] + inc + "\n" + txt[m.end():]
    return inc + "\n" + txt


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("func")
    ap.add_argument("--header", required=True, help="header to hold the canonical proto, e.g. include/iwram.h")
    ap.add_argument("--sig", help="canonical prototype WITHOUT trailing ; (overrides the in-tree definition)")
    g = ap.add_mutually_exclusive_group()
    g.add_argument("--apply", action="store_true")
    g.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    func = args.func
    header = (REPO / args.header).resolve()
    inc = '#include "%s"' % header.name

    defsig, deffile, naked = find_definition(func)
    sig = args.sig or defsig
    if not sig:
        print(f"FAIL: no compiled in-tree definition of {func} found; pass --sig", file=sys.stderr)
        sys.exit(2)
    src = "--sig" if args.sig else f"definition in {deffile}"
    print(f"canonical (from {src}): {sig}" + (f"   [definition is NAKED in {deffile}]" if naked else ""))

    extern_re = re.compile(r"[ \t]*extern\s+[^;{}]*\b" + re.escape(func) + r"\s*\([^;{}]*\)\s*;[ \t]*\n?")

    touched = []
    callers = []
    seen = set()
    for f in sorted(SRC.rglob("*.c")):
        txt = f.read_text(errors="ignore")
        if not extern_re.search(txt):
            continue
        new = _add_include(extern_re.sub("", txt), inc)
        callers.append(str(f.relative_to(REPO)))
        touched.append((f, txt, new))
        seen.add(f)

    # also make the definition file include the header, so proto==def is checked
    if deffile:
        dp = (REPO / deffile)
        if dp not in seen:
            dtxt = dp.read_text(errors="ignore")
            dnew = _add_include(dtxt, inc)
            if dnew != dtxt:
                touched.append((dp, dtxt, dnew))

    header_existed = header.exists()
    htxt = header.read_text(errors="ignore") if header_existed else ""
    decl_re = re.compile(r"^[^\n]*\b" + re.escape(func) + r"\s*\([^;{]*\)\s*;", re.M)
    header_needs = not decl_re.search(htxt)
    print(f"callers with ad-hoc extern: {len(callers)}")
    for c in callers:
        print(f"  {c}")
    print(f"definition file: {deffile or '(none — asm/--sig only)'}")
    print(f"header {args.header}: {'INSERT proto' if header_needs else 'proto already present'}")

    if args.dry_run or not args.apply:
        print("(dry-run; pass --apply to write + clean make check)")
        return

    if header_needs:
        m = re.search(r"\n#endif[^\n]*\s*$", htxt)
        ins = f"\n{sig};\n"
        header.write_text(htxt[: m.start()] + ins + htxt[m.start():] if m else htxt + ins)
    for f, _old, new in touched:
        f.write_text(new)

    # Format touched files FIRST so the clean-build gate validates exactly the
    # bytes that get committed (the pre-commit hook runs clang-format; validating
    # the pre-format version then committing the post-format version would be a
    # stale check, and clang-format can reorder includes -> change preproc output).
    fmt = [str(f) for f, _, _ in touched] + ([str(header)] if header_needs else [])
    subprocess.run(["clang-format", "-i"] + fmt, cwd=REPO, capture_output=True, text=True)

    print("running clang-format + make tidy && make -j8 && make check ...")
    subprocess.run(["make", "tidy"], cwd=REPO, capture_output=True, text=True)
    b = subprocess.run(["make", "-j8"], cwd=REPO, capture_output=True, text=True)
    ok = b.returncode == 0 and subprocess.run(["make", "check"], cwd=REPO, capture_output=True, text=True).returncode == 0
    if ok:
        print(f"GREEN: centralized {func} into {args.header}; {len(callers)} callers de-externed.")
        return
    print("RED: reverting all touched files (in-memory restore)", file=sys.stderr)
    for f, old, _new in touched:
        f.write_text(old)  # robust: works for tracked AND untracked files
    if header_needs:
        if header_existed:
            header.write_text(htxt)
        else:
            header.unlink()  # we created it this run
    print((b.stdout + b.stderr)[-1500:], file=sys.stderr)
    sys.exit(1)


if __name__ == "__main__":
    main()
