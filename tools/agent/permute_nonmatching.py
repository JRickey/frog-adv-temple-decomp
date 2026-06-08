#!/usr/bin/env python3
"""One-command permuter run for a NON_MATCHING / NAKED function.

An agent that wants to throw the permuter at a function shipped behind
`#ifdef NON_MATCHING` (with a NAKED/asm `#else`) should not have to know any
of the permuter's setup frictions. This wraps all of them:

  F5  base.c construction   — auto-extracts the readable `#ifdef NON_MATCHING`
                              reference body from the function's src/*.c and
                              drops every `#else`/NAKED branch (pycparser
                              chokes on inline-asm operands, so the asm must
                              not survive). Aborts if `asm(` remains.
  F1  stale scratch         — a re-run leaves thousands of `output-*` dirs in
                              nonmatchings/<fn>/ whose scores aren't comparable
                              to a fresh run. Archives the single best, wipes
                              the rest before launching.
  F2  target.o candidate    — the shipped object for a NAKED function has
                              absolute-literal pools (few relocs); a C body
                              references the same addresses as relocations, so
                              make_permuter_target's default src/*.o candidate
                              builds a mismatched-reloc target and a corrupt
                              oracle. Forces the compiled C body as the target
                              candidate (setup_permuter --target-from-base) so a
                              true match scores 0.
  F3  no `timeout` on macOS — runs the permuter as a managed subprocess in its
                              own session with a wall-clock budget, then SIGTERMs
                              the whole -j worker group. No `timeout`/`gtimeout`.
  F4  score != byte_diff    — reports base score, best score, and the best
                              output dir to harvest from. A score-0 hit is
                              flagged as a MATCH CANDIDATE to verify (harvest the
                              essential mutation into src, then `make check`).

Usage:
    python3 tools/agent/permute_nonmatching.py <Fn>
    python3 tools/agent/permute_nonmatching.py <Fn> --minutes 30 -j 5
    python3 tools/agent/permute_nonmatching.py <Fn> --json

For budgets beyond ~8 min, launch this via the Bash tool's run_in_background
(it blocks for the whole budget). It self-stops early on score 0.

Exit codes:
  0  ran clean (see `matched` in the result for whether a 0-score was found)
  1  setup/usage error (no NON_MATCHING body, asm survived, setup failed)
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import signal
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
SRC_DIR = ROOT / "src"
NONMATCH = ROOT / "nonmatchings"
PERMUTER = ROOT / "vendor" / "decomp-permuter"
PYBIN = PERMUTER / ".venv" / "bin" / "python"


def find_defining_file(name: str) -> Path | None:
    """src/**/*.c that *defines* `name` (a `... name(args) {`, not a call/decl)."""
    def_re = re.compile(rf"\b{re.escape(name)}\s*\([^;)]*\)\s*\n?\s*\{{")
    for p in sorted(SRC_DIR.rglob("*.c")):
        if def_re.search(p.read_text(errors="replace")):
            return p
    return None


def nonmatching_true_branch(src_text: str) -> str:
    """Concatenate every `#ifdef NON_MATCHING` true-branch (the readable bodies),
    excluding `#else`/NAKED branches and code outside any NON_MATCHING block."""
    out: list[str] = []
    state = 0
    for line in src_text.splitlines(keepends=True):
        s = line.strip()
        if state == 0:
            if re.match(r"#\s*ifdef\s+NON_MATCHING\b", s):
                state = 1
        elif state == 1:
            if re.match(r"#\s*else\b", s):
                state = 2
            elif re.match(r"#\s*endif\b", s):
                state = 0
            else:
                out.append(line)
        elif state == 2:
            if re.match(r"#\s*endif\b", s):
                state = 0
    return "".join(out)


def build_base_c(src_text: str) -> str:
    """Return the TU with every `#ifdef NON_MATCHING` true-branch kept live and
    every `#else`/NAKED branch removed, so pycparser sees only readable C.

    A small state machine handles one or more NON_MATCHING blocks. Lines outside
    any NON_MATCHING conditional pass through unchanged (includes, externs,
    already-matched neighbours).
    """
    out: list[str] = []
    # state: 0 = outside, 1 = inside NON_MATCHING true-branch (keep),
    #        2 = inside the #else branch (skip)
    state = 0
    for line in src_text.splitlines(keepends=True):
        s = line.strip()
        if state == 0:
            if re.match(r"#\s*ifdef\s+NON_MATCHING\b", s):
                state = 1
                continue  # drop the #ifdef line
            out.append(line)
        elif state == 1:
            if re.match(r"#\s*else\b", s):
                state = 2
                continue  # drop the #else line
            if re.match(r"#\s*endif\b", s):
                state = 0
                continue  # block had no #else; drop #endif, resume
            out.append(line)
        elif state == 2:
            if re.match(r"#\s*endif\b", s):
                state = 0
                continue  # drop the #endif line
            # skip the NAKED/asm body
    return "".join(out)


def archive_and_clean(outdir: Path) -> str:
    """Move the best prior output aside, delete all `output-*` scratch dirs."""
    if not outdir.exists():
        return "fresh dir"
    outs = sorted(outdir.glob("output-*"))
    if not outs:
        return "no prior outputs"

    def score_of(p: Path) -> int:
        m = re.match(r"output-(\d+)-", p.name)
        return int(m.group(1)) if m else 1 << 30

    best = min(outs, key=score_of)
    archive = outdir / ".prior-best"
    if archive.exists():
        shutil.rmtree(archive, ignore_errors=True)
    shutil.copytree(best, archive)
    n = 0
    for p in outs:
        shutil.rmtree(p, ignore_errors=True)
        n += 1
    return f"archived best ({best.name}) to .prior-best, removed {n} stale output dirs"


def best_output(outdir: Path) -> tuple[int, Path] | None:
    outs = sorted(outdir.glob("output-*"))
    if not outs:
        return None
    scored = []
    for p in outs:
        m = re.match(r"output-(\d+)-", p.name)
        if m:
            scored.append((int(m.group(1)), p))
    if not scored:
        return None
    return min(scored, key=lambda t: t[0])


def run_permuter(outdir: Path, jobs: int, budget_s: float, log: Path) -> str:
    """Launch the permuter in its own process group; stop on score 0 or when
    the wall-clock budget expires. Kills the whole -j worker group on expiry."""
    env = dict(os.environ, PERMUTER_PROJECT_ROOT=str(ROOT))
    cmd = [str(PYBIN), str(PERMUTER / "permuter.py"), str(outdir),
           f"-j{jobs}", "--stop-on-zero"]
    with log.open("w") as lf:
        proc = subprocess.Popen(
            cmd, cwd=ROOT, env=env, stdout=lf, stderr=subprocess.STDOUT,
            start_new_session=True,  # own process group → killpg reaches workers
        )
    try:
        proc.wait(timeout=budget_s)
        return "stopped early (score 0 or exhausted search space)"
    except subprocess.TimeoutExpired:
        # SIGTERM the group, give it a moment, then SIGKILL.
        try:
            os.killpg(os.getpgid(proc.pid), signal.SIGTERM)
            proc.wait(timeout=10)
        except (ProcessLookupError, subprocess.TimeoutExpired):
            try:
                os.killpg(os.getpgid(proc.pid), signal.SIGKILL)
            except ProcessLookupError:
                pass
        return f"budget reached ({budget_s/60:.1f} min) — stopped"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("fn")
    ap.add_argument("--minutes", type=float, default=20.0,
                    help="wall-clock budget (default 20). Self-stops early on score 0.")
    ap.add_argument("-j", "--jobs", type=int, default=5,
                    help="permuter worker count (default 5)")
    ap.add_argument("--addr", help="baserom address hex (default frog_us.map)")
    ap.add_argument("--keep-outputs", action="store_true",
                    help="don't wipe prior output-* dirs before running")
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()
    fn = args.fn

    def emit(result: dict, rc: int) -> int:
        if args.json:
            json.dump(result, sys.stdout, indent=2)
            sys.stdout.write("\n")
        else:
            print_human(result)
        return rc

    if not PYBIN.exists():
        return emit({"fn": fn, "error": f"permuter venv missing at {PYBIN} — "
                     "run scripts/setup-permuter.sh"}, 1)

    srcfile = find_defining_file(fn)
    if srcfile is None:
        return emit({"fn": fn, "error": f"no src/**/*.c defines {fn!r}"}, 1)
    src_text = srcfile.read_text(errors="replace")
    # The TARGET function must have its OWN #ifdef NON_MATCHING body — not just
    # share a file with one (e.g. an already-matched neighbour in the same TU).
    def_re = re.compile(rf"\b{re.escape(fn)}\s*\([^;)]*\)\s*\n?\s*\{{")
    if def_re.search(nonmatching_true_branch(src_text)) is None:
        reason = ("has no #ifdef NON_MATCHING body in any src file"
                  if "NON_MATCHING" not in src_text
                  else f"is defined in {srcfile.relative_to(ROOT)} but NOT inside a "
                       "#ifdef NON_MATCHING block (already matched, or it's a "
                       "neighbour of the NAKED function — nothing to permute)")
        return emit({"fn": fn, "error": f"{fn} {reason}"}, 1)

    base_text = build_base_c(src_text)
    if "asm(" in base_text or "asm (" in base_text:
        return emit({"fn": fn, "error": "inline asm survived base.c extraction "
                     "(pycparser will choke) — the NON_MATCHING body itself "
                     "contains asm; hand-author a base.c instead"}, 1)
    if re.search(rf"\b{re.escape(fn)}\s*\([^;)]*\)\s*\n?\s*\{{", base_text) is None:
        return emit({"fn": fn, "error": f"{fn} not found as a definition in the "
                     "extracted NON_MATCHING body"}, 1)

    outdir = NONMATCH / fn
    outdir.mkdir(parents=True, exist_ok=True)

    # Refuse if a permuter is already grinding this function — two runs in the
    # same scratch dir wipe/archive each other's outputs and corrupt results.
    probe = subprocess.run(["pgrep", "-f", f"permuter.py .*nonmatchings/{fn}\\b"],
                           capture_output=True, text=True)
    if probe.stdout.strip():
        return emit({"fn": fn, "error": f"a permuter run for {fn} is already active "
                     f"(pids {probe.stdout.split()}); kill it before relaunching "
                     "(pkill -f 'permuter.py .*nonmatchings/" + fn + "')"}, 1)

    clean_note = "kept prior outputs" if args.keep_outputs else archive_and_clean(outdir)

    autobase = outdir / "_autobase.c"
    autobase.write_text(base_text)

    # Scaffold via setup_permuter, forcing the compiled C body as the target
    # candidate so the relocation layout matches a real C match (F2).
    setup_cmd = ["python3", "tools/agent/setup_permuter.py", fn,
                 "--base", str(autobase), "--target-from-base"]
    if args.addr:
        setup_cmd += ["--addr", args.addr]
    setup = subprocess.run(setup_cmd, cwd=ROOT, capture_output=True, text=True)
    if setup.returncode != 0:
        return emit({"fn": fn, "error": "setup_permuter failed",
                     "setup_stderr": setup.stderr[-2000:],
                     "setup_stdout": setup.stdout[-2000:]}, 1)
    m = re.search(r"base score:\s*(\d+)", setup.stdout)
    base_score = int(m.group(1)) if m else None
    m = re.search(r"relocs (\d+)", setup.stdout)
    relocs = int(m.group(1)) if m else None

    log = outdir / "permuter.log"
    t0 = time.monotonic()
    stop_reason = run_permuter(outdir, args.jobs, args.minutes * 60, log)
    elapsed = time.monotonic() - t0

    best = best_output(outdir)
    best_score = best[0] if best else None
    best_dir = str(best[1].relative_to(ROOT)) if best else None
    matched = best_score == 0

    return emit({
        "fn": fn,
        "src_file": str(srcfile.relative_to(ROOT)),
        "base_score": base_score,
        "target_relocs": relocs,
        "best_score": best_score,
        "best_output": best_dir,
        "matched": matched,
        "elapsed_min": round(elapsed / 60, 1),
        "stop_reason": stop_reason,
        "scratch": clean_note,
        "log": str(log.relative_to(ROOT)),
    }, 0)


def print_human(r: dict) -> None:
    print(f"function:    {r['fn']}")
    if "error" in r:
        print(f"ERROR:       {r['error']}")
        if r.get("setup_stderr"):
            print("--- setup stderr ---")
            print(r["setup_stderr"])
        return
    print(f"src_file:    {r['src_file']}")
    print(f"scratch:     {r['scratch']}")
    print(f"target relocs: {r['target_relocs']}")
    print(f"base_score:  {r['base_score']}")
    print(f"best_score:  {r['best_score']}   (NOT byte_diff — structural diffs ~100 each)")
    print(f"best_output: {r['best_output']}")
    print(f"elapsed:     {r['elapsed_min']} min  ({r['stop_reason']})")
    print(f"log:         {r['log']}")
    print()
    if r["matched"]:
        print("MATCH CANDIDATE (score 0) ✓ — verify it:")
        print(f"  1. harvest the essential mutation from {r['best_output']}/source.c")
        print("     (it's pycparser-expanded; diff vs the NON_MATCHING body, take")
        print("      the ONE real change — a volatile/type flip, a split assign)")
        print(f"  2. apply it to the NON_MATCHING body in {r['src_file']}, flip it live")
        print("  3. make tidy && make -j8 && make check")
    elif r["best_score"] is not None and r["base_score"] is not None \
            and r["best_score"] < r["base_score"]:
        print("Improved but no match. Options:")
        print(f"  - fold the structural insight from {r['best_output']}/source.c into")
        print("    the NON_MATCHING body, then re-run (iterate the base).")
        print("  - re-run with a larger --minutes (permuter runs LONG, 35k+ iters).")
    else:
        print("No improvement — likely a sharp coloring local minimum. Consider")
        print("hand-seeding structure (corpus history search) before more iterations.")


if __name__ == "__main__":
    sys.exit(main())
