#!/usr/bin/env python3
"""corpus.py — query other agbcc-era GBA decomp repos cached locally.

Cache lives at ~/.cache/decomp-corpus/ (populated by scripts/corpus-sync.sh).
Each repo is a --filter=blob:none clone so we can walk commit history and
read text blobs on-demand. Subcommands:

    sync                          delegate to scripts/corpus-sync.sh
    grep PATTERN [--c|--h|--asm]  rg across all repos, optional type/repo filter
    decomps [--name X] [--repo R] list "Decompile <fn>" / "Match" commits
    show REPO@COMMIT              git show --stat + abbreviated diff
    status                        last sync, per-repo commit count, total disk

Design notes:
- No JSON commit-index. `git log` is fast enough; if it isn't, we add caching.
- No new dependencies — stdlib + rg + git.
- Respects --repo R (repeatable) to scope queries.
- Default repo filter for `grep` is toolchain=agbcc; pass --any-toolchain to
  include "other" repos.
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

CACHE_DIR = Path(os.environ.get("DECOMP_CORPUS_DIR", Path.home() / ".cache" / "decomp-corpus"))
METADATA = CACHE_DIR / ".metadata.json"
REPO_ROOT = Path(__file__).resolve().parent.parent.parent
SYNC_SCRIPT = REPO_ROOT / "scripts" / "corpus-sync.sh"


def die(msg: str, code: int = 1) -> None:
    print(f"corpus.py: {msg}", file=sys.stderr)
    sys.exit(code)


def require_tools() -> None:
    for t in ("rg", "git"):
        if shutil.which(t) is None:
            die(f"missing required tool: {t}")


def load_metadata() -> dict:
    if not METADATA.exists():
        die(f"no metadata at {METADATA}. Run: corpus.py sync")
    return json.loads(METADATA.read_text())


def select_repos(meta: dict, repo_filters: list[str], require_agbcc: bool) -> list[dict]:
    """Filter the repo list. repo_filters matches by slug substring."""
    repos = [r for r in meta["repos"] if r["status"] != "missing"]
    if repo_filters:
        out = []
        for r in repos:
            slug = r["slug"]
            short = slug.split("/", 1)[1]
            if any(f == slug or f == short or f in slug for f in repo_filters):
                out.append(r)
        repos = out
    if require_agbcc:
        repos = [r for r in repos if r["toolchain"] == "agbcc"]
    return repos


# ----------------------------------------------------------------------------
# sync
# ----------------------------------------------------------------------------
def cmd_sync(args: argparse.Namespace) -> int:
    if not SYNC_SCRIPT.exists():
        die(f"missing {SYNC_SCRIPT}")
    return subprocess.call(["bash", str(SYNC_SCRIPT)])


# ----------------------------------------------------------------------------
# grep
# ----------------------------------------------------------------------------
def cmd_grep(args: argparse.Namespace) -> int:
    meta = load_metadata()
    repos = select_repos(meta, args.repo, require_agbcc=not args.any_toolchain)
    if not repos:
        die("no repos match filter")

    rg_args = ["rg", "--no-heading", "--line-number", "--color=never"]
    if args.c:
        rg_args += ["-tc"]
    if args.h:
        # rg's "c" type includes .h.
        rg_args += ["-tc"]
    if args.asm:
        rg_args += ["-tasm"]
    rg_args += [args.pattern]

    any_hits = False
    for r in repos:
        path = r["path"]
        # Print as repo:path:line:content so output is paste-able.
        proc = subprocess.run(rg_args + [path], capture_output=True, text=True)
        if proc.returncode not in (0, 1):
            print(f"  (rg failed in {r['slug']}: {proc.stderr.strip()})", file=sys.stderr)
            continue
        if not proc.stdout:
            continue
        any_hits = True
        prefix = r["slug"]
        for line in proc.stdout.splitlines():
            # Strip the repo path prefix so output is relative.
            if line.startswith(path + "/"):
                line = line[len(path) + 1 :]
            print(f"{prefix}:{line}")
    return 0 if any_hits else 1


# ----------------------------------------------------------------------------
# decomps
# ----------------------------------------------------------------------------
DECOMP_RE = r"^(Decompile|Decompiled|Match(ed)?\b|Decomp\b)"


def cmd_decomps(args: argparse.Namespace) -> int:
    meta = load_metadata()
    repos = select_repos(meta, args.repo, require_agbcc=not args.any_toolchain)
    if not repos:
        die("no repos match filter")

    pattern = DECOMP_RE
    rows = []
    for r in repos:
        cmd = [
            "git", "-C", r["path"], "log",
            "--all",
            "--extended-regexp",
            f"--grep={pattern}",
            "-i",
            "--format=%H|%ad|%s",
            "--date=short",
        ]
        proc = subprocess.run(cmd, capture_output=True, text=True)
        if proc.returncode != 0:
            print(f"  (git log failed in {r['slug']}: {proc.stderr.strip()})", file=sys.stderr)
            continue
        for line in proc.stdout.splitlines():
            parts = line.split("|", 2)
            if len(parts) != 3:
                continue
            h, date, subject = parts
            if args.name:
                # Crude substring/regex check on subject.
                import re
                try:
                    if not re.search(args.name, subject):
                        continue
                except re.error:
                    if args.name not in subject:
                        continue
            rows.append((r["slug"], date, h, subject))

    if args.limit:
        rows = rows[: args.limit]

    # Default sort: repo then date.
    rows.sort(key=lambda t: (t[0], t[1]))
    if not rows:
        print("(no matching decomp commits)")
        return 1

    # Get changed-files count per commit only if --stat (it's expensive on cold caches).
    for slug, date, h, subject in rows:
        if args.stat:
            repo_path = next(r["path"] for r in repos if r["slug"] == slug)
            files_n = _count_files(repo_path, h)
            print(f"{slug}\t{date}\t{h[:8]}\t({files_n:>3} files) {subject}")
        else:
            print(f"{slug}\t{date}\t{h[:8]}\t{subject}")
    return 0


def _count_files(repo_path: str, commit: str) -> int:
    proc = subprocess.run(
        ["git", "-C", repo_path, "show", "--stat", "--format=", commit],
        capture_output=True, text=True,
    )
    if proc.returncode != 0:
        return 0
    # Last line of git show --stat is "N files changed, ..." — extract the N.
    last = [ln for ln in proc.stdout.splitlines() if "changed" in ln]
    if not last:
        return 0
    try:
        return int(last[-1].strip().split()[0])
    except (ValueError, IndexError):
        return 0


# ----------------------------------------------------------------------------
# show
# ----------------------------------------------------------------------------
def cmd_show(args: argparse.Namespace) -> int:
    meta = load_metadata()
    spec = args.target
    if "@" not in spec:
        die("REPO@COMMIT required (e.g. cvaos@deadbeef)")
    repo_token, commit = spec.split("@", 1)
    repos = select_repos(meta, [repo_token], require_agbcc=False)
    if not repos:
        die(f"no repo matching {repo_token!r}")
    r = repos[0]
    # git show with --stat header + truncated patch.
    cmd = ["git", "-C", r["path"], "show", "--stat", "--patch", commit]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        die(proc.stderr.strip() or f"git show {commit} failed")
    out = proc.stdout
    # Trim very long diffs.
    max_lines = args.max_lines
    lines = out.splitlines()
    if len(lines) > max_lines:
        print("\n".join(lines[:max_lines]))
        print(f"... ({len(lines) - max_lines} more lines; --max-lines to widen)")
    else:
        print(out)
    return 0


# ----------------------------------------------------------------------------
# status
# ----------------------------------------------------------------------------
def cmd_status(args: argparse.Namespace) -> int:
    if not METADATA.exists():
        die(f"no metadata at {METADATA}. Run: corpus.py sync")
    meta = load_metadata()
    print(f"synced_at: {meta.get('synced_at', '?')}")
    print(f"cache_dir: {meta.get('cache_dir', CACHE_DIR)}")
    print()
    print(f"{'slug':<35} {'toolchain':<10} {'commits':>8}  head")
    print("-" * 80)
    for r in meta["repos"]:
        path = r["path"]
        if r["status"] == "missing":
            print(f"{r['slug']:<35} {'?':<10} {'-':>8}  (missing)")
            continue
        proc = subprocess.run(
            ["git", "-C", path, "rev-list", "--count", "HEAD"],
            capture_output=True, text=True,
        )
        count = proc.stdout.strip() if proc.returncode == 0 else "?"
        print(f"{r['slug']:<35} {r['toolchain']:<10} {count:>8}  {r['head'][:10]}")
    print()
    proc = subprocess.run(["du", "-sh", str(CACHE_DIR)], capture_output=True, text=True)
    if proc.returncode == 0:
        print(f"disk: {proc.stdout.strip()}")
    return 0


# ----------------------------------------------------------------------------
# arg parsing
# ----------------------------------------------------------------------------
def main(argv: list[str] | None = None) -> int:
    require_tools()
    ap = argparse.ArgumentParser(prog="corpus.py", description=__doc__.splitlines()[0])
    sub = ap.add_subparsers(dest="cmd", required=True)

    sp = sub.add_parser("sync", help="run scripts/corpus-sync.sh")
    sp.set_defaults(func=cmd_sync)

    sp = sub.add_parser("grep", help="ripgrep across the corpus")
    sp.add_argument("pattern")
    sp.add_argument("--c", action="store_true", help="restrict to C files (and .h)")
    sp.add_argument("--h", action="store_true", help="restrict to C/.h files (alias for --c)")
    sp.add_argument("--asm", action="store_true", help="restrict to .s/.S files")
    sp.add_argument("--repo", action="append", default=[], help="match repo slug (repeatable)")
    sp.add_argument("--any-toolchain", action="store_true",
                    help="include non-agbcc repos (default: agbcc only)")
    sp.set_defaults(func=cmd_grep)

    sp = sub.add_parser("decomps", help="list Decompile/Match commits in the corpus")
    sp.add_argument("--name", help="regex/substring filter on commit subject")
    sp.add_argument("--repo", action="append", default=[], help="match repo slug (repeatable)")
    sp.add_argument("--limit", type=int, default=0, help="cap rows (0 = no limit)")
    sp.add_argument("--stat", action="store_true", help="include files-changed count (slower)")
    sp.add_argument("--any-toolchain", action="store_true",
                    help="include non-agbcc repos (default: agbcc only)")
    sp.set_defaults(func=cmd_decomps)

    sp = sub.add_parser("show", help="git show REPO@COMMIT --stat + diff (truncated)")
    sp.add_argument("target", help="REPO@COMMIT, e.g. cvaos@abc1234")
    sp.add_argument("--max-lines", type=int, default=400)
    sp.set_defaults(func=cmd_show)

    sp = sub.add_parser("status", help="cache status")
    sp.set_defaults(func=cmd_status)

    args = ap.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
