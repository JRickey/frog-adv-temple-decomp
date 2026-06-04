#!/usr/bin/env python3
"""Scaffold a decomp-permuter scratch dir for one function, end to end.

Given a near-match C base (a .c that compiles to a small byte_diff from the
baserom function), this writes nonmatchings/<fn>/ with:
  - base.c      : the near-match C (may #include project headers; the patched
                  permuter preprocess.py handles -Iinclude)
  - compile.sh  : the project compile pipeline (old_agbcc by default)
  - settings.toml
  - target.o    : baserom bytes with $t/$d mapping + relocs mirrored from the
                  compiled candidate (so a true match scores 0)

It compiles the base once to derive the candidate layout, builds target.o via
make_permuter_target.py, and prints the run command + the base score.

Usage:
    python3 tools/agent/setup_permuter.py <Fn> --base <near_match.c> [--addr 0xXXXX] [--agbcc-new]

--addr defaults to the address in frog_us.map (works for asm-only deferred
functions too). --agbcc-new selects the newer agbcc for the ~4 exception TUs.
"""
import argparse
import os
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


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("fn")
    ap.add_argument("--base", required=True, help="path to the near-match .c")
    ap.add_argument("--addr", help="baserom address hex (default frog_us.map)")
    ap.add_argument("--agbcc-new", action="store_true",
                    help="use the newer agbcc (only for the ~4 exception TUs)")
    args = ap.parse_args()
    fn = args.fn
    outdir = ROOT / "nonmatchings" / fn
    outdir.mkdir(parents=True, exist_ok=True)

    base_dst = outdir / "base.c"
    base_dst.write_text(Path(args.base).read_text())

    agbcc = "tools/agbcc/bin/agbcc" if args.agbcc_new else "tools/agbcc/bin/old_agbcc"

    # per-dir compile.sh (selects compiler via AGBCC env consumed by permuter_compile.sh)
    (outdir / "compile.sh").write_text(
        "#!/usr/bin/env bash\n"
        'INPUT="$(realpath "$1")"\n'
        'OUTPUT="$(cd "$(dirname "$3")" && pwd)/$(basename "$3")"\n'
        f"cd {ROOT}\n"
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
    r = sh("python3", "tools/agent/make_permuter_target.py", fn,
           "--candidate", str(cand), "--addr", addr, "--out", str(outdir))
    print(r.stdout.strip() or r.stderr.strip())
    if r.returncode != 0:
        return 1

    # base score (sanity): real match -> 0; near-match -> ~5 * instr-diffs
    score = subprocess.run(
        ["vendor/decomp-permuter/.venv/bin/python", "-c",
         "import sys;sys.path.insert(0,'vendor/decomp-permuter');"
         "from src.scorer import Scorer;"
         f"print('base score:',Scorer('{outdir/'target.o'}',stack_differences=False,"
         "algorithm='difflib',debug_mode=False,ign_branch_targets=False,objdump_command=None)"
         f".score('{cand}')[0])"],
        cwd=ROOT, capture_output=True, text=True)
    print(score.stdout.strip() or score.stderr.strip())

    print(f"\nrun: PERMUTER_PROJECT_ROOT=$PWD vendor/decomp-permuter/.venv/bin/python "
          f"vendor/decomp-permuter/permuter.py {outdir.relative_to(ROOT)} -j2 --stop-on-zero")
    return 0


if __name__ == "__main__":
    sys.exit(main())
