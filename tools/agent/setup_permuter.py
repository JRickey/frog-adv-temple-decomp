#!/usr/bin/env python3
"""Scaffold a decomp-permuter scratch dir for one function, end to end.

Given a near-match C base (a .c that compiles to a small byte_diff from the
baserom function), this writes nonmatchings/<fn>/ with:
  - base.c      : the near-match C (may #include project headers; the patched
                  permuter preprocess.py handles -Iinclude)
  - compile.sh  : the project compile pipeline (old_agbcc by default)
  - settings.toml
  - target.o    : baserom bytes with $t/$d mapping + relocs mirrored from the
                  real built object when available (so a true match scores 0)

It compiles the base once for the permuter candidate, builds target.o via
make_permuter_target.py, and prints the run command + the base score. For
#ifdef NON_MATCHING / #else asm functions, target layout comes from the normal
project build by default; the readable C candidate may be shorter or have calls
and pools shifted, which would make a corrupt target oracle.

Usage:
    python3 tools/agent/setup_permuter.py <Fn> --base <near_match.c> [--addr 0xXXXX] [--agbcc-new]

--addr defaults to the address in frog_us.map (works for asm-only deferred
functions too). --agbcc-new selects the newer agbcc for the ~4 exception TUs.
"""
import argparse
import os
import re
import shlex
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def sh(*cmd, **kw):
    return subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, **kw)


def func_address(fn: str) -> str:
    import re
    mp = (ROOT / "frog_us.map").read_text()
    for line in mp.splitlines():
        m = re.search(r"0x([0-9a-fA-F]+)\s+" + re.escape(fn) + r"\b", line)
        if m:
            return "0x" + m.group(1)
    sys.exit(f"{fn} not in frog_us.map")


def add_permuter_helper_decls(source: str) -> str:
    helpers = []
    for name in ("__divsi3", "__modsi3", "__udivsi3", "__umodsi3"):
        has_call = re.search(r"\b" + re.escape(name) + r"\s*\(", source) is not None
        has_decl = re.search(r"^\s*extern\s+[^;\n]*\b" + re.escape(name) + r"\s*\(", source, re.MULTILINE)
        if has_call and not has_decl:
            helpers.append(f"extern int {name}(int, int);")
    if not helpers:
        return source

    lines = source.splitlines()
    insert_at = 0
    while insert_at < len(lines) and lines[insert_at].startswith("#include "):
        insert_at += 1
    lines[insert_at:insert_at] = [""] + helpers
    return "\n".join(lines) + ("\n" if source.endswith("\n") else "")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("fn")
    ap.add_argument("--base", required=True, help="path to the near-match .c")
    ap.add_argument("--addr", help="baserom address hex (default frog_us.map)")
    ap.add_argument("--target-candidate",
                    help="explicit built .o to use for target $t/$d + relocation layout "
                    "(default: search src/**/*.o, fallback to compiled base)")
    ap.add_argument("--target-from-base", action="store_true",
                    help="use the compiled base.c as the target $t/$d+reloc candidate. "
                    "Correct for NAKED / #ifdef NON_MATCHING functions: the shipped .o "
                    "(NAKED) has absolute-literal pools, but a C body references the same "
                    "addresses as relocations, so the default src/*.o candidate yields a "
                    "mismatched-reloc target and a corrupt score.")
    ap.add_argument("--agbcc-new", action="store_true",
                    help="use the newer agbcc (only for the ~4 exception TUs)")
    ap.add_argument("--extra-cflags", default="",
                    help="per-TU CFLAGS the Makefile applies to this function "
                    "(e.g. '-fno-expensive-optimizations'); baked into compile.sh "
                    "so the permuter matches the real build")
    args = ap.parse_args()
    fn = args.fn
    outdir = ROOT / "nonmatchings" / fn
    outdir.mkdir(parents=True, exist_ok=True)

    base_dst = outdir / "base.c"
    base_dst.write_text(add_permuter_helper_decls(Path(args.base).read_text()))

    agbcc = "tools/agbcc/bin/agbcc" if args.agbcc_new else "tools/agbcc/bin/old_agbcc"

    # per-dir compile.sh (selects compiler via AGBCC env consumed by permuter_compile.sh)
    (outdir / "compile.sh").write_text(
        "#!/usr/bin/env bash\n"
        'INPUT="$(realpath "$1")"\n'
        'OUTPUT="$(cd "$(dirname "$3")" && pwd)/$(basename "$3")"\n'
        f"cd {ROOT}\n"
        f"PERMUTER_EXTRA_CFLAGS={shlex.quote(args.extra_cflags)} "
        f'AGBCC={agbcc} tools/permuter_compile.sh -DREGION_US -nostdinc -Iinclude/ "$INPUT" -o "$OUTPUT"\n'
    )
    os.chmod(outdir / "compile.sh", 0o755)
    (outdir / "settings.toml").write_text(
        f'func_name = "{fn}"\ncompiler_type = "gcc"\n'
    )

    # compile the base once -> candidate .o (layout reference for target.o)
    cand = outdir / "_cand.o"
    r = sh("bash", str(outdir / "compile.sh"), str(base_dst), "-o", str(cand))
    if r.returncode != 0 or not cand.exists():
        sys.exit(f"base.c failed to compile:\n{r.stderr}")

    addr = args.addr or func_address(fn)
    make_target_cmd = ["python3", "tools/agent/make_permuter_target.py", fn,
                       "--addr", addr, "--out", str(outdir)]
    if args.target_candidate:
        make_target_cmd.extend(["--candidate", args.target_candidate])
    elif args.target_from_base:
        make_target_cmd.extend(["--candidate", str(cand)])

    r = sh(*make_target_cmd)
    if r.returncode != 0 and not args.target_candidate and not args.target_from_base:
        make_target_cmd.extend(["--candidate", str(cand)])
        r = sh(*make_target_cmd)
    print(r.stdout.strip() or r.stderr.strip())
    if r.returncode != 0:
        return 1

    # base score (sanity): run the permuter's real candidate path. Directly
    # scoring _cand.o is misleading when base.c contains helper/context funcs.
    score = subprocess.run(
        ["vendor/decomp-permuter/.venv/bin/python", "vendor/decomp-permuter/permuter.py",
         str(outdir), "--debug", "--best-only"],
        cwd=ROOT, capture_output=True, text=True)
    m = re.search(r"\[" + re.escape(fn) + r"\] base score = (\d+)", score.stdout)
    print(f"base score: {m.group(1)}" if m else (score.stderr.strip() or "base score: unknown"))
    for debug_path in (ROOT / "debug_source.c", ROOT / "debug_compiled_object.o"):
        try:
            debug_path.unlink()
        except FileNotFoundError:
            pass

    print(f"\nrun: PERMUTER_PROJECT_ROOT=$PWD vendor/decomp-permuter/.venv/bin/python "
          f"vendor/decomp-permuter/permuter.py {outdir.relative_to(ROOT)} -j2 --stop-on-zero")
    return 0


if __name__ == "__main__":
    sys.exit(main())
