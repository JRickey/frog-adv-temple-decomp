#!/usr/bin/env python3
"""Centralize one function's prototype into a shared header and delete the ad-hoc
`extern` re-declarations from every caller .c, guarded by a CLEAN `make check`.

Canonical signature must be acknowledged with --sig or --use-definition.
The latter reads the function's COMPILED in-tree definition (NON_MATCHING
reference bodies are skipped). Every
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
                sig = " ".join(re.sub(r"\b(?:NAKED|static)\b", "", ln).rstrip("{ ").split())
                return sig, str(f.relative_to(REPO)), naked
    return None, None, False


def _add_include(txt, inc):
    if inc in txt:
        return txt
    m = re.search(r"^#include[^\n]*\n", txt, re.M)
    if m:
        return txt[: m.end()] + inc + "\n" + txt[m.end():]
    return inc + "\n" + txt


def _signature_key(sig):
    return " ".join(sig.strip().rstrip(";").split())


def _prototype_shape(sig, func):
    """Compare ordinary prototypes while ignoring parameter names.

    Deliberately conservative: complex declarators fall back to their normalized
    text and will require manual review rather than being declared equivalent.
    """
    clean = _signature_key(sig)
    match = re.match(r"(?P<ret>.*?)\b" + re.escape(func) + r"\s*\((?P<args>.*)\)$", clean)
    if not match:
        return clean
    ret = " ".join(re.sub(r"\b(?:extern|static|inline|NAKED)\b", "", match.group("ret")).split())
    args = match.group("args").strip()
    if not args or args == "void":
        return ret, ()
    shaped = []
    for arg in args.split(","):
        arg = " ".join(arg.split())
        # A trailing identifier is a parameter name when something type-like
        # precedes it. Preserve pointer stars and every signed/width token.
        tail = re.match(r"^(.*?)([A-Za-z_]\w*)$", arg)
        type_words = {"void", "char", "short", "int", "long", "signed", "unsigned",
                      "const", "volatile", "restrict"}
        if tail and tail.group(1) and tail.group(2) not in type_words \
                and not tail.group(1).rstrip().endswith(("struct", "union", "enum")):
            arg = tail.group(1).rstrip()
        shaped.append(arg)
    return ret, tuple(shaped)


def _restore(touched, header, header_existed, header_bytes):
    for f, old, _new in touched:
        f.write_bytes(old)
    if header_existed:
        header.write_bytes(header_bytes)
    elif header.exists():
        header.unlink()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("func")
    ap.add_argument("--header", required=True, help="header to hold the canonical proto, e.g. include/iwram.h")
    canon = ap.add_mutually_exclusive_group(required=True)
    canon.add_argument("--sig", help="canonical prototype WITHOUT trailing ;")
    canon.add_argument("--use-definition", action="store_true",
                       help="explicitly acknowledge the compiled definition as canonical")
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
    if args.sig and not re.search(r"\b" + re.escape(func) + r"\s*\(", args.sig):
        print(f"FAIL: --sig does not declare {func}", file=sys.stderr)
        sys.exit(2)
    src = "--sig" if args.sig else f"explicit --use-definition ({deffile})"
    print(f"canonical (from {src}): {sig}" + (f"   [definition is NAKED in {deffile}]" if naked else ""))
    if args.sig and defsig and _prototype_shape(args.sig, func) != _prototype_shape(defsig, func):
        print(f"NOTE: requested --sig differs from compiled definition in {deffile}; "
              "the compiler/build gate may reject this mechanical consolidation.")

    extern_re = re.compile(r"[ \t]*extern\s+[^;{}]*\b" + re.escape(func) + r"\s*\([^;{}]*\)\s*;[ \t]*\n?")

    touched = []
    callers = []
    seen = set()
    for f in sorted(SRC.rglob("*.c")):
        old_bytes = f.read_bytes()
        txt = old_bytes.decode(errors="surrogateescape")
        if not extern_re.search(txt):
            continue
        new = _add_include(extern_re.sub("", txt), inc)
        callers.append(str(f.relative_to(REPO)))
        touched.append((f, old_bytes, new))
        seen.add(f)

    # also make the definition file include the header, so proto==def is checked
    if deffile:
        dp = (REPO / deffile)
        if dp not in seen:
            old_bytes = dp.read_bytes()
            dtxt = old_bytes.decode(errors="surrogateescape")
            dnew = _add_include(dtxt, inc)
            if dnew != dtxt:
                touched.append((dp, old_bytes, dnew))

    header_existed = header.exists()
    header_bytes = header.read_bytes() if header_existed else b""
    htxt = header_bytes.decode(errors="surrogateescape") if header_existed else ""
    decl_re = re.compile(r"^[^\n]*\b" + re.escape(func) + r"\s*\([^;{]*\)\s*;", re.M)
    existing_decl = decl_re.search(htxt)
    header_needs = existing_decl is None
    if existing_decl and _prototype_shape(existing_decl.group(0), func) != _prototype_shape(sig, func):
        print(f"FAIL: {args.header} already declares {func} with a conflicting signature:\n"
              f"  existing: {_signature_key(existing_decl.group(0))}\n"
              f"  requested: {_signature_key(sig)}", file=sys.stderr)
        sys.exit(2)
    print(f"callers with ad-hoc extern: {len(callers)}")
    for c in callers:
        print(f"  {c}")
    print(f"definition file: {deffile or '(none — asm/--sig only)'}")
    print(f"header {args.header}: {'INSERT proto' if header_needs else 'proto already present'}")

    if args.dry_run or not args.apply:
        print("(dry-run; pass --apply to write + clean make check)")
        return

    # Format touched files FIRST so the clean-build gate validates exactly the
    # bytes that get committed (the pre-commit hook runs clang-format; validating
    # the pre-format version then committing the post-format version would be a
    # stale check, and clang-format can reorder includes -> change preproc output).
    fmt = [str(f) for f, _, _ in touched] + ([str(header)] if header_needs else [])
    if not fmt:
        print(f"NO-OP: {func} is already centralized in {args.header}; no files changed.")
        return
    print("running clang-format + make tidy && make -j8 && make check ...")
    failure = None
    output = ""
    interrupted = None
    try:
        if header_needs:
            m = re.search(r"\n#endif[^\n]*\s*$", htxt)
            ins = f"\n{sig};\n"
            header.write_text(htxt[: m.start()] + ins + htxt[m.start():] if m else htxt + ins,
                              errors="surrogateescape")
        for f, _old, new in touched:
            f.write_text(new, errors="surrogateescape")

        fmt_result = subprocess.run(["clang-format", "-i"] + fmt, cwd=REPO, capture_output=True, text=True)
        if fmt_result.returncode != 0:
            failure, output = "clang-format", fmt_result.stdout + fmt_result.stderr
        if not failure:
            tidy = subprocess.run(["make", "tidy"], cwd=REPO, capture_output=True, text=True)
            if tidy.returncode != 0:
                failure, output = "make tidy", tidy.stdout + tidy.stderr
        if not failure:
            build = subprocess.run(["make", "-j8"], cwd=REPO, capture_output=True, text=True)
            if build.returncode != 0:
                failure, output = "make -j8", build.stdout + build.stderr
        if not failure:
            check = subprocess.run(["make", "check"], cwd=REPO, capture_output=True, text=True)
            if check.returncode != 0:
                failure, output = "make check", check.stdout + check.stderr
    except BaseException as exc:
        failure, output = "tool invocation", repr(exc)
        interrupted = exc
    ok = failure is None
    if ok:
        print(f"GREEN: centralized {func} into {args.header}; {len(callers)} callers de-externed.")
        return
    _restore(touched, header, header_existed, header_bytes)
    print(f"RED: {failure} failed; restored exact pre-existing bytes for all touched files", file=sys.stderr)
    print("Build artifacts are unverified after rollback; run a clean rebuild before relying on them.",
          file=sys.stderr)
    print(output[-1500:], file=sys.stderr)
    if isinstance(interrupted, (KeyboardInterrupt, SystemExit)):
        raise interrupted
    sys.exit(1)


if __name__ == "__main__":
    main()
