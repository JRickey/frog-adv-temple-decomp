#!/usr/bin/env python3
"""corpus_asm_search.py — learn how other agbcc decomps matched an asm idiom.

WHY THIS EXISTS
  In an agbcc decomp, a function lands as disassembled asm first; the commit
  that MATCHES it DELETES the asm and ADDS the matching C. So every match
  commit in git history is an exact (asm, known-good C) pair. When you are
  stuck on a fold / register-coloring / addressing idiom that agbcc emits in
  a shape you cannot reproduce, the answer is almost always already in some
  other decomp's history. This tool finds the commit that REMOVED asm
  matching your pattern and shows the C it ADDED in the same commit.

  This is DIFFERENT from `corpus.py grep`, which greps the CURRENT tree of
  blob:none clones and so cannot read historical diffs. This tool operates on
  FULL mirror clones (blobs present) and walks the whole history.

CORPUS LOCATION
  Full mirrors live at tools/agent/corpus-mirrors/<owner>__<repo>.git
  (gitignored, ~1.4G). Override with --mirrors PATH or $CORPUS_MIRRORS.
  Populate / refresh from an existing set of bare mirrors with:
      corpus_asm_search.py sync --from <src-mirrors-dir>

THE ANALYSIS STEP (do this when stuck on agbcc codegen you can't match)
  1. Take the target asm idiom you can't reproduce, e.g. the baserom spreads
     `mov rLOW, r8; ldrb` across distinct low regs but agbcc funnels them all
     to r0.
  2. Reduce it to a register-agnostic regex over asm lines:
         corpus_asm_search.py search --asm 'mov\\s+r[0-7],\\s*(r8|r9|sl)'
  3. Read the hits: each prints repo, sha, subject, the removed-asm snippet,
     and the C files the same commit added.
  4. Pull the full pairing for the most relevant hit and read how their C
     produced that asm:
         corpus_asm_search.py show <repo>@<sha>

  `search` hits ALL mirrors by default — cast the widest net; do NOT scope to
  one repo unless you have a reason. Every mirror is agbcc, so any repo's C is
  usable. Repos are swept MOST-COMPLETE-FIRST (by on-disk size), so the
  highest-leverage matches (pret pokeemerald/firered/ruby, the metroid/FE/tmc
  decomps — the ones with the most matched code) surface before the smaller,
  less-complete imports run down the --limit. `--repo SUB` only narrows for
  speed; same-publisher repos (cvaos = Konami) help with publisher conventions
  but cvaos is incomplete, so it is a tiebreaker, not the primary source.

USAGE
  corpus_asm_search.py search --asm REGEX [--repo SUB] [--require-c] [--limit N]
  corpus_asm_search.py search --idiom highreg-spread [...]   # named presets
  corpus_asm_search.py show  REPO@SHA
  corpus_asm_search.py list                                  # mirrors + commits
  corpus_asm_search.py sync  [--from PATH]                   # (re)populate mirrors
"""
from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent.parent
DEFAULT_MIRRORS = Path(
    os.environ.get("CORPUS_MIRRORS", REPO_ROOT / "tools" / "agent" / "corpus-mirrors")
)
ASM_GLOBS = ["*.s", "*.inc", "*.asm"]
C_GLOBS = ["*.c", "*.cpp"]
ASM_EXTS = (".s", ".inc", ".asm")
C_EXTS = (".c", ".cpp")

# Named idiom presets: (pickaxe ERE for `git log -G`, python asm-line regex).
# The pickaxe is fast and coarse; the python regex is the precise filter.
IDIOMS = {
    # A struct pointer parked in a HIGH reg (r8/r9/sl/...) copied to a low reg
    # and dereferenced field-by-field — the `mov rLOW, rHIGH; ... [rLOW` cluster.
    # The classic funnel-vs-spread register-coloring case (sub_08017364).
    "highreg-spread": (
        r"mov +r[0-9]+, *(r8|r9|sb|r10|sl|fp)",
        r"\bmov\s+(r[0-7]|ip),\s*(r8|r9|sb|r10|sl|fp)\b",
    ),
}


def die(msg: str, code: int = 1) -> None:
    print(f"corpus_asm_search.py: {msg}", file=sys.stderr)
    sys.exit(code)


def git(mirror: Path, *args: str) -> str:
    """Run git against a bare mirror; decode tolerantly (diffs hold non-utf8)."""
    r = subprocess.run(
        ["git", f"--git-dir={mirror}", *args], capture_output=True
    )
    return r.stdout.decode("utf-8", errors="replace")


def mirror_weight(m: Path) -> int:
    """On-disk pack size — a zero-cost proxy for how COMPLETE a decomp is
    (more matched code => bigger history). Used to search the most complete
    repos first so a broad sweep's --limit isn't eaten by tiny imports."""
    packs = list((m / "objects" / "pack").glob("*.pack"))
    if packs:
        return sum(p.stat().st_size for p in packs)
    try:
        return sum(f.stat().st_size for f in m.rglob("*") if f.is_file())
    except OSError:
        return 0


def iter_mirrors(mirrors: Path, repo_filter: str | None, *, by_weight: bool = False):
    """Yield (name, path) for each mirror. Default order is alphabetical; with
    by_weight=True, most-complete-first (so broad searches surface the
    highest-leverage hits before the --limit runs out). No toolchain filter is
    needed — every curated mirror is agbcc (verified via corpus-sync metadata)."""
    if not mirrors.is_dir():
        die(
            f"no mirrors at {mirrors}\n"
            f"  populate with: {Path(__file__).name} sync --from <src-mirrors-dir>"
        )
    found = [p for p in mirrors.glob("*.git") if p.is_dir()]
    if repo_filter:
        found = [m for m in found if repo_filter.lower() in m.name.lower()]
    if not found:
        die(f"no mirrors under {mirrors}" + (f" matching {repo_filter!r}" if repo_filter else ""))
    found.sort(key=mirror_weight, reverse=True) if by_weight else found.sort()
    for m in found:
        yield m.name[:-4], m


# --------------------------------------------------------------------------- #
# search
# --------------------------------------------------------------------------- #
def candidate_commits(mirror: Path, pickaxe_ere: str) -> list[str]:
    """Commits whose diff adds/removes an asm line matching the ERE pickaxe."""
    args = ["log", "--all", "--format=%H", "-G", pickaxe_ere, "--", *ASM_GLOBS]
    return git(mirror, *args).split()


def analyse_commit(mirror: Path, sha: str, asm_re: re.Pattern, *,
                   idiom: str | None, mov_min: int, min_distinct: int,
                   context: int):
    """Return a hit dict if this commit REMOVES asm matching asm_re. For the
    'highreg-spread' idiom, also require >= min_distinct distinct low regs
    derived from one high reg (a spread, not a funnel)."""
    diff = git(mirror, "show", "--no-color", f"-U{context}", "--format=%s%n",
               sha, "--", *ASM_GLOBS, *C_GLOBS)
    if not diff:
        return None
    lines = diff.splitlines()
    subject = lines[0] if lines else ""
    cur = None
    removed_by_file: dict[str, list[str]] = defaultdict(list)
    added_c: set[str] = set()
    for ln in lines[1:]:
        if ln.startswith("+++ b/") or ln.startswith("--- a/"):
            cur = ln[6:]
            continue
        if ln.startswith("diff --git"):
            cur = None
            continue
        if cur is None:
            continue
        if ln.startswith("-") and not ln.startswith("---"):
            if cur.endswith(ASM_EXTS):
                removed_by_file[cur].append(ln[1:])
        elif ln.startswith("+") and not ln.startswith("+++"):
            if cur.endswith(C_EXTS):
                added_c.add(cur)

    n_asm = sum(1 for f in removed_by_file)
    for f, body in removed_by_file.items():
        hits = [l for l in body if asm_re.search(l)]
        if not hits:
            continue
        if idiom == "highreg-spread":
            res = _spread_metrics(body, asm_re, mov_min, min_distinct)
            if res is None:
                continue
            snippet, n_mov, n_distinct, high, cmps = res
        else:
            if len(hits) < mov_min:
                continue
            snippet = "\n".join(f"    {l.strip()}" for l in hits[:30])[:1800]
            n_mov, n_distinct, high, cmps = len(hits), 0, "", 0
        return {
            "subject": subject, "asm_file": f, "snippet": snippet,
            "n_mov": n_mov, "n_distinct": n_distinct, "high": high, "cmps": cmps,
            "added_c": sorted(added_c), "n_asm": n_asm, "n_c": len(added_c),
        }
    return None


def _spread_metrics(body: list[str], mov_re: re.Pattern, mov_min: int, min_distinct: int):
    """For the highreg-spread idiom: count distinct low regs that are copied
    from a high reg AND dereferenced within the next ~2 lines (excludes the
    prologue high-reg save). Returns None unless it looks like a spread."""
    deref_movs = []
    by_high: dict[str, set] = defaultdict(set)
    for i, l in enumerate(body):
        m = mov_re.search(l)
        if not m:
            continue
        low, high = m.group(1).lower(), m.group(2).lower()
        base_re = re.compile(r"\[" + re.escape(low) + r"\b", re.I)
        for j in range(i + 1, min(i + 3, len(body))):
            if base_re.search(body[j]):
                deref_movs.append((l.strip(), body[j].strip()))
                by_high[high].add(low)
                break
    if not by_high:
        return None
    best = max(by_high, key=lambda h: len(by_high[h]))
    n_distinct = len(by_high[best])
    if len(deref_movs) < mov_min or n_distinct < min_distinct:
        return None
    cmps = sum(1 for l in body if re.search(r"\bcmp\b", l))
    snippet = "\n".join(f"    {mv:22} {dr}" for mv, dr in deref_movs)[:1800]
    return snippet, len(deref_movs), n_distinct, best, cmps


def cmd_search(a: argparse.Namespace) -> None:
    if a.idiom:
        if a.idiom not in IDIOMS:
            die(f"unknown idiom {a.idiom!r}; known: {', '.join(IDIOMS)}")
        pickaxe, asm_pat = IDIOMS[a.idiom]
    elif a.asm:
        pickaxe, asm_pat = a.asm, a.asm
    else:
        die("give --asm REGEX or --idiom NAME (known: " + ", ".join(IDIOMS) + ")")
    asm_re = re.compile(asm_pat, re.I)

    hits = 0
    for name, m in iter_mirrors(a.mirrors, a.repo, by_weight=True):
        cands = candidate_commits(m, pickaxe)
        print(f"# {name}: {len(cands)} candidate commits", file=sys.stderr)
        for sha in cands:
            res = analyse_commit(
                m, sha, asm_re, idiom=a.idiom, mov_min=a.min_hits,
                min_distinct=a.min_distinct, context=a.context,
            )
            if not res:
                continue
            if a.require_c and res["n_c"] == 0:
                continue
            if a.clean and (res["n_asm"] != 1 or res["n_c"] > 3):
                continue
            hits += 1
            extra = (f"{res['n_distinct']} distinct copies of {res['high']}, "
                     f"{res['cmps']} cmp, " if a.idiom == "highreg-spread" else "")
            print(f"\n=== {name} {sha[:10]}  [{extra}{res['n_mov']} asm hits, "
                  f"{res['n_asm']} asm/{res['n_c']} C files]  {res['subject'][:60]}")
            print(f"    show: {Path(__file__).name} show {name}@{sha[:10]}")
            print(f"    asm removed: {res['asm_file']}")
            print(f"    C added: {', '.join(res['added_c'][:5]) or '(none)'}")
            print(res["snippet"])
            if hits >= a.limit:
                print(f"\n[stopped at {a.limit} hits — raise with --limit]")
                return
    print(f"\n# total hits: {hits}", file=sys.stderr)


# --------------------------------------------------------------------------- #
# show / list / sync
# --------------------------------------------------------------------------- #
def cmd_show(a: argparse.Namespace) -> None:
    if "@" not in a.ref:
        die("show takes REPO@SHA, e.g. cvaos@1a2b3c4")
    repo_sub, sha = a.ref.split("@", 1)
    m = next((p for _, p in iter_mirrors(a.mirrors, repo_sub)), None)
    print(git(m, "show", "--no-color", sha))


def cmd_list(a: argparse.Namespace) -> None:
    # most-complete-first, the same order `search` sweeps them in.
    for name, m in iter_mirrors(a.mirrors, a.repo, by_weight=True):
        n = git(m, "rev-list", "--all", "--count").strip() or "?"
        mb = mirror_weight(m) / 1e6
        head = git(m, "log", "-1", "--format=%h %s", "--all").strip()[:56]
        print(f"{name:42} {mb:6.0f}MB {n:>7} commits   {head}")


def cmd_sync(a: argparse.Namespace) -> None:
    src = Path(a.from_path).expanduser()
    if not src.is_dir():
        die(f"--from {src} is not a directory")
    dst = a.mirrors
    dst.mkdir(parents=True, exist_ok=True)
    bare = sorted(p for p in src.glob("*.git") if p.is_dir())
    if not bare:
        die(f"no *.git bare mirrors under {src}")
    print(f"copying {len(bare)} mirrors {src} -> {dst}")
    for p in bare:
        target = dst / p.name
        if target.exists():
            shutil.rmtree(target)
        shutil.copytree(p, target)
        print(f"  {p.name}")
    print("done. (gitignored — never committed)")


def main(argv: list[str]) -> None:
    ap = argparse.ArgumentParser(
        description="Search agbcc-decomp git histories for an asm idiom + its matching C.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="See the module docstring for the full analysis-step workflow.",
    )
    ap.add_argument("--mirrors", type=Path, default=DEFAULT_MIRRORS,
                    help=f"mirror dir (default {DEFAULT_MIRRORS}, or $CORPUS_MIRRORS)")
    sub = ap.add_subparsers(dest="cmd", required=True)

    s = sub.add_parser("search", help="find commits that removed asm matching a pattern")
    g = s.add_mutually_exclusive_group()
    g.add_argument("--asm", metavar="REGEX", help="asm-line regex (also used as the git pickaxe)")
    g.add_argument("--idiom", choices=sorted(IDIOMS), help="named idiom preset")
    s.add_argument("--repo", help="substring filter on mirror name")
    s.add_argument("--min-hits", type=int, default=3,
                   help="min asm lines matching REGEX in the removed block (default 3)")
    s.add_argument("--min-distinct", type=int, default=2,
                   help="[highreg-spread] min DISTINCT low regs (>=2 => spread, not funnel)")
    s.add_argument("--require-c", action="store_true", help="only commits that also added C")
    s.add_argument("--clean", action="store_true",
                   help="only single-function decompiles (1 asm file, <=3 C files)")
    s.add_argument("--context", type=int, default=0, help="diff -U context lines (default 0)")
    s.add_argument("--limit", type=int, default=40, help="max hits to print")
    s.set_defaults(func=cmd_search)

    sh = sub.add_parser("show", help="full git show of one hit (REPO@SHA)")
    sh.add_argument("ref", help="REPO@SHA, e.g. cvaos@1a2b3c4")
    sh.set_defaults(func=cmd_show)

    li = sub.add_parser("list", help="list mirrors + commit counts")
    li.add_argument("--repo", help="substring filter on mirror name")
    li.set_defaults(func=cmd_list)

    sy = sub.add_parser("sync", help="(re)populate mirrors from a source dir of bare *.git clones")
    sy.add_argument("--from", dest="from_path",
                    default=str(Path.home() / "dev" / "aida" / "corpus" / "git-mirrors"),
                    help="source dir of bare mirrors (default ~/dev/aida/corpus/git-mirrors)")
    sy.set_defaults(func=cmd_sync)

    a = ap.parse_args(argv)
    a.func(a)


if __name__ == "__main__":
    main(sys.argv[1:])
