#!/usr/bin/env python3
"""Search GBA-decomp git histories for an *asm idiom*, then surface the C that
replaced it.

How agbcc decomps work: a function starts as disassembled asm in a `.s`/`.inc`
file; when it's matched, the commit DELETES the asm and ADDS the matching C.
So the git history pairs the exact asm (registers and all) with its known-good
C. To learn how others wrote C for an idiom we're stuck on, we don't need to
disassemble anything — we search commit diffs for the *removed* asm pattern
(register-agnostic) and read the C added in the same commit.

Operates on FULL mirror clones (blobs present), default
~/dev/aida/corpus/git-mirrors/*.git (override with --mirrors).

Default idiom = our sub_08017364 blocker: a pointer parked in a HIGH register
(r8/r9/sl/r10/fp) copied to low regs and dereferenced field-by-field — the
`mov rLOW, rHIGH` cluster. Tune with --mov-min / --high / --pattern.

Usage:
    corpus_asm_search.py                      # default idiom, all mirrors
    corpus_asm_search.py --mov-min 4          # stricter (>=4 high-reg copies)
    corpus_asm_search.py --repo metroid       # one repo substring
    corpus_asm_search.py --show <repo> <sha>  # full diff of one hit
"""
from __future__ import annotations
import argparse, re, subprocess, sys
from pathlib import Path
from collections import defaultdict

DEFAULT_MIRRORS = Path.home() / "dev" / "aida" / "corpus" / "git-mirrors"
ASM_GLOBS = ["*.s", "*.inc", "*.asm"]
# high-reg -> low-reg copy (the field-access prep): group(1)=low, group(2)=high.
# agbcc asm aliases r9=sb, r10=sl, r11=fp.
MOV_RE = re.compile(r"\bmov\s+(r[0-7]|ip),\s*(r8|r9|sb|r10|sl|fp)\b", re.I)


def git(mirror: Path, *args: str) -> str:
    # decode tolerantly: some diffs contain binary/non-utf8 blobs.
    r = subprocess.run(["git", f"--git-dir={mirror}", *args],
                       capture_output=True)
    return r.stdout.decode("utf-8", errors="replace")


def candidate_commits(mirror: Path) -> list[str]:
    """Commits whose diff changes a high-reg `mov` line in an asm file (pickaxe
    is fast); the match (removal) commit is among them."""
    # git -G uses ERE; no \s (literal spaces), aliases sb/sl/fp included.
    args = ["log", "--all", "--format=%H", "-G", r"mov +r[0-9]+, *(r8|r9|sb|r10|sl|fp)"]
    for g in ASM_GLOBS:
        args += ["--", g] if g == ASM_GLOBS[0] else [g]
    out = git(mirror, *args)
    return out.split()


def analyse_commit(mirror: Path, sha: str, mov_min: int):
    """Return (matched, removed_asm_snippet, added_c_files) if this commit
    REMOVES an asm block with >= mov_min high-reg copies."""
    diff = git(mirror, "show", "--no-color", "-U0", "--format=%s%n", sha,
               "--", *ASM_GLOBS_for(), *C_GLOBS)
    if not diff:
        return None
    subject = diff.splitlines()[0] if diff else ""
    cur_file = None
    removed_by_file = defaultdict(list)
    added_c = set()
    for ln in diff.splitlines():
        if ln.startswith("+++ b/") or ln.startswith("--- a/"):
            f = ln[6:]
            cur_file = f
            continue
        if ln.startswith("diff --git"):
            cur_file = None
            continue
        if cur_file is None:
            continue
        if ln.startswith("-") and not ln.startswith("---"):
            if cur_file.endswith((".s", ".inc", ".asm")):
                removed_by_file[cur_file].append(ln[1:])
        elif ln.startswith("+") and not ln.startswith("+++"):
            if cur_file.endswith((".c", ".cpp")):
                added_c.add(cur_file)
    # idiom: a `mov rLOW, rHIGH` whose rLOW is DEREFERENCED in the next ~2 lines
    # (`... [rLOW`). That excludes the prologue high-reg save (mov r5,r8 -> push).
    for f, lines in removed_by_file.items():
        deref_movs = []  # (mov_line, deref_line)
        lows = set()
        for i, l in enumerate(lines):
            m = MOV_RE.search(l)
            if not m:
                continue
            low = m.group(1)
            base_re = re.compile(r"\[" + re.escape(low) + r"\b", re.I)
            for j in range(i + 1, min(i + 3, len(lines))):
                if base_re.search(lines[j]):
                    deref_movs.append((l.strip(), lines[j].strip()))
                    lows.add(low.lower())
                    break
        if len(deref_movs) >= mov_min and len(lows) >= MIN_DISTINCT[0]:
            snippet = "\n".join(f"    {mv:22} {dr}" for mv, dr in deref_movs)[:1600]
            return {"subject": subject, "file": f, "n_mov": len(deref_movs),
                    "n_distinct": len(lows), "snippet": snippet,
                    "added_c": sorted(added_c),
                    "n_asm": sum(1 for ff in removed_by_file
                                 if ff.endswith((".s", ".inc", ".asm"))),
                    "n_c": len(added_c)}
    return None


MIN_DISTINCT = [1]  # set from args


def ASM_GLOBS_for():
    return ASM_GLOBS


C_GLOBS = ["*.c", "*.cpp"]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mirrors", type=Path, default=DEFAULT_MIRRORS)
    ap.add_argument("--repo", help="substring filter on mirror name")
    ap.add_argument("--mov-min", type=int, default=3,
                    help="min deref'd high-reg copies in the removed asm (default 3)")
    ap.add_argument("--min-distinct", type=int, default=1,
                    help="min DISTINCT low regs (>=2 => a spread, not a funnel)")
    ap.add_argument("--clean", action="store_true",
                    help="only single-function decompiles (1 asm file, <=3 C files)")
    ap.add_argument("--limit", type=int, default=40, help="max hits to print")
    ap.add_argument("--show", nargs=2, metavar=("REPO", "SHA"),
                    help="print the full diff of one hit and exit")
    a = ap.parse_args()

    mirrors = sorted(p for p in a.mirrors.glob("*.git") if p.is_dir())
    if a.repo:
        mirrors = [m for m in mirrors if a.repo.lower() in m.name.lower()]
    if not mirrors:
        sys.exit(f"no mirrors under {a.mirrors}")

    if a.show:
        m = next(p for p in mirrors if a.show[0].lower() in p.name.lower())
        print(git(m, "show", "--no-color", a.show[1]))
        return

    MIN_DISTINCT[0] = a.min_distinct
    hits = 0
    for m in mirrors:
        name = m.name[:-4]
        cands = candidate_commits(m)
        print(f"# {name}: {len(cands)} candidate commits", file=sys.stderr)
        for sha in cands:
            res = analyse_commit(m, sha, a.mov_min)
            if not res:
                continue
            if a.clean and (res["n_asm"] != 1 or res["n_c"] > 3):
                continue
            hits += 1
            print(f"\n=== {name} {sha[:10]}  [{res['n_mov']} derefs, "
                  f"{res['n_distinct']} distinct regs, {res['n_asm']} asm/{res['n_c']} C]  "
                  f"{res['subject'][:55]}")
            print(f"    asm: {res['file']}")
            print(f"    C added: {', '.join(res['added_c'][:4]) or '(none)'}")
            print(res["snippet"])
            if hits >= a.limit:
                print(f"\n[stopped at {a.limit} hits]")
                return
    print(f"\n# total hits: {hits}", file=sys.stderr)


if __name__ == "__main__":
    main()
