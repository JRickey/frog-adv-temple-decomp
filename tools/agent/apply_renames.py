#!/usr/bin/env python3
"""Apply a reviewed rename manifest to the tree, guarded by `make check`.

The naming workflow (.claude/workflows/name-cluster.js) produces a manifest of
*name decisions only* — function symbols, per-function locals/params, struct
field names, struct type names. This script is the deterministic applier: it
performs pure identifier substitution (which cannot change ROM bytes, since
identifiers don't appear in the ROM), runs `make check`, and reverts the whole
batch atomically if anything fails to match.

Why mechanical (not agent-rewritten bodies): an agent rewriting a function body
might "tidy" a matching-critical construct and silently break the byte match.
Renaming identifiers can only ever produce a compile error or an identical ROM —
never a different-but-valid ROM — so `make check` is a complete safety net.

Manifest schema (JSON):
{
  "cluster": "engine/sub_0800a710",         # label, for messages only
  "struct_types":  [{"old": "ClusterA710", "new": "Entity", ...}],
  "struct_fields": [{"old": "_field_34", "new": "flags", "type": "Entity", ...}],
  "functions":     [{"old": "sub_0800A710", "new": "Entity_Init",
                     "file": "src/engine/sub_0800a710.c", ...}],
  "data_symbols":  [{"old": "gFoo_08308028", "new": "gHandlerTable", ...}],
  "variables":     [{"function": "sub_0800A710", "old": "a", "new": "kind",
                     "file": "src/engine/sub_0800a710.c", ...}]
}
  - struct_types / functions / data_symbols: GLOBAL word-boundary identifier
    replace across all src + include sources AND linker.ld (data symbols are
    DEFINED there as `gFoo_08308028 = 0x...;` and used in C via extern; renaming
    must update both). Also updates call sites, extern decls, comments — desirable:
    keeps docs in sync. Safe because these identifiers are unique.
  - struct_fields: FILE-SCOPED word-boundary replace, restricted to the entry's
    `files` list (defaults to [header_file]). This is mandatory, not an
    optimization: `_field_NN` / `_unkNN` names are POSITIONAL placeholders reused
    across every anonymous struct in the tree (e.g. `_field_34` lives in 25+
    files for unrelated structs). A global field replace would silently rename
    all of them — and because field names don't affect codegen, `make check`
    would still PASS. So make check is NOT a backstop for field scoping; the
    manifest's `files` list (the accessor set, from the workflow's map pass) is.
    Assumes each scoped file uses the target struct as its only `_field_NN`-
    bearing struct; a file mixing two anonymous structs that share a field id
    needs type-aware scoping (not yet supported — split such a rename out).
  - variables: scoped to the *body* of the named function in `file` only.
    `function` is the OLD function name (variables are applied before the
    function rename). `file` is required so we don't scan the whole tree.

Order of operations: variables (scoped, by old fn name) -> struct_fields
(file-scoped) -> struct_types -> functions (global). Then `make -j8 && make
check`. On any failure the touched files are restored via `git checkout --`.

Usage:
    python3 tools/agent/apply_renames.py <manifest.json>
    python3 tools/agent/apply_renames.py <manifest.json> --dry-run   # show plan, touch nothing
    python3 tools/agent/apply_renames.py <manifest.json> --no-check  # apply, skip make check (NOT recommended)
"""
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SRC_GLOBS = ["src/**/*.c", "src/**/*.h", "include/**/*.h"]


def repo_sources():
    seen = {}
    for g in SRC_GLOBS:
        for p in REPO.glob(g):
            seen[p.resolve()] = p
    return list(seen.values())


def word_replace(text, old, new):
    """Word-boundary identifier replace. Returns (new_text, count)."""
    pat = re.compile(r"\b" + re.escape(old) + r"\b")
    return pat.subn(new, text)


def find_function_body_span(text, fn_name):
    """Return (start, end) char offsets covering `<fn_name>(...) { ... }`.

    Locates the definition (a `name(` followed, after the param list, by `{`
    rather than `;`) and brace-matches the body, skipping braces inside
    string/char literals and // and /* */ comments. Returns None if not found
    as a definition.
    """
    for m in re.finditer(r"\b" + re.escape(fn_name) + r"\s*\(", text):
        # Walk past the parameter list to the first '{' or ';'.
        i = m.end()
        depth = 0
        while i < len(text):
            ch = text[i]
            if ch == "(":
                depth += 1
            elif ch == ")":
                if depth == 0:
                    i += 1
                    break
                depth -= 1
            i += 1
        # Skip whitespace/newlines after the param list.
        while i < len(text) and text[i] in " \t\r\n":
            i += 1
        if i >= len(text) or text[i] != "{":
            continue  # a declaration or call, not a definition
        body_start = i
        # Brace-match the body.
        i += 1
        depth = 1
        in_line, in_block, in_str, in_chr = False, False, False, False
        while i < len(text) and depth > 0:
            ch = text[i]
            two = text[i : i + 2]
            if in_line:
                if ch == "\n":
                    in_line = False
            elif in_block:
                if two == "*/":
                    in_block = False
                    i += 1
            elif in_str:
                if ch == "\\":
                    i += 1
                elif ch == '"':
                    in_str = False
            elif in_chr:
                if ch == "\\":
                    i += 1
                elif ch == "'":
                    in_chr = False
            elif two == "//":
                in_line = True
                i += 1
            elif two == "/*":
                in_block = True
                i += 1
            elif ch == '"':
                in_str = True
            elif ch == "'":
                in_chr = True
            elif ch == "{":
                depth += 1
            elif ch == "}":
                depth -= 1
            i += 1
        if depth != 0:
            return None  # unbalanced — bail
        return (m.start(), i)
    return None


def apply_manifest(manifest, dry_run):
    """Mutate sources per the manifest. Returns dict path->new_text for changed files."""
    sources = repo_sources()
    contents = {p: p.read_text() for p in sources}
    # linker.ld + the asm slices participate in GLOBAL renames only. CRITICAL:
    # an asm-slice / NON_MATCHING function's REAL exported symbol is defined in
    # asm/disasm_*.s (`thumb_func_start sub_XXXX` / `sub_XXXX:`), NOT in the
    # (non-compiled) C body — so a function rename must update the .s too, or the
    # binary keeps the old symbol while the C references the new one. Renaming a
    # symbol in asm is byte-safe (names are not in the ROM). Scoped var/field
    # loops key off manifest file paths, so they never touch these.
    for extra in [REPO / "linker.ld", *REPO.glob("asm/**/*.s"), *REPO.glob("sound/**/*.s")]:
        rp = extra.resolve()
        if extra.exists() and rp not in contents:
            try:
                contents[rp] = extra.read_text(errors="replace")
            except OSError:
                pass
    touched = {}  # path -> count summary list

    def note(p, label):
        touched.setdefault(p, []).append(label)

    # 1. Variables — scoped to the named function's body in its file only.
    for v in manifest.get("variables", []):
        rel = v["file"]
        p = (REPO / rel).resolve()
        if p not in contents:
            print(f"  ! variable {v['old']}->{v['new']}: file {rel} not in source set, skipped")
            continue
        text = contents[p]
        span = find_function_body_span(text, v["function"])
        if span is None:
            print(f"  ! variable {v['old']}->{v['new']}: function {v['function']} body not found in {rel}, skipped")
            continue
        s, e = span
        body, n = word_replace(text[s:e], v["old"], v["new"])
        if n:
            contents[p] = text[:s] + body + text[e:]
            note(p, f"var {v['function']}:{v['old']}->{v['new']} x{n}")

    # 2. Struct field names — FILE-SCOPED (positional `_field_NN` ids collide
    #    across unrelated structs; see module docstring).
    for sf in manifest.get("struct_fields", []):
        scope = sf.get("files") or ([sf["header_file"]] if sf.get("header_file") else [])
        if not scope:
            print(f"  ! field {sf['old']}->{sf['new']}: no files/header_file scope given, skipped")
            continue
        for rel in scope:
            p = (REPO / rel).resolve()
            if p not in contents:
                print(f"  ! field {sf['old']}->{sf['new']}: scope file {rel} not in source set, skipped")
                continue
            new_text, n = word_replace(contents[p], sf["old"], sf["new"])
            if n:
                contents[p] = new_text
                note(p, f"field {sf.get('type','?')}.{sf['old']}->{sf['new']} x{n}")

    # 3. Struct types / 4. functions / 5. data symbols — global (unique ids).
    global_renames = []
    for st in manifest.get("struct_types", []):
        global_renames.append((st["old"], st["new"], f"type {st['old']}->{st['new']}"))
    for fn in manifest.get("functions", []):
        global_renames.append((fn["old"], fn["new"], f"fn {fn['old']}->{fn['new']}"))
    for ds in manifest.get("data_symbols", []):
        global_renames.append((ds["old"], ds["new"], f"data {ds['old']}->{ds['new']}"))

    for old, new, label in global_renames:
        for p in list(contents.keys()):
            text = contents[p]
            new_text, n = word_replace(text, old, new)
            if n:
                contents[p] = new_text
                note(p, f"{label} x{n}")

    changed = {p: contents[p] for p in touched}
    return changed, touched


def git_clean(paths):
    rels = [str(p.relative_to(REPO)) for p in paths]
    subprocess.run(["git", "-C", str(REPO), "checkout", "--"] + rels, check=False)


_CONF = {"high": 3, "medium": 2, "low": 1, "": 0, None: 0}


def merge_manifests(manifests):
    """Merge several fragment manifests into one, deterministically.

    The call-graph naming workflow fans out per-cluster fragments; this folds
    them. Dedup rules: function/data_symbol entries are keyed by `old` (keep the
    highest-confidence); a `new` name claimed by two different `old`s keeps the
    highest-confidence claimant and DROPS the rest (those stay unnamed — a
    collision is never silently applied). Variables/fields are scoped, so they
    just concatenate. Returns (merged_manifest, dropped_list)."""
    merged = {"cluster": "callgraph-merge", "functions": [], "variables": [],
              "struct_fields": [], "struct_types": [], "data_symbols": []}
    dropped = []
    for key in ("functions", "data_symbols", "struct_types"):
        by_old = {}
        for man in manifests:
            for e in man.get(key, []):
                old = e["old"]
                if old not in by_old or _CONF.get(e.get("confidence")) > _CONF.get(by_old[old].get("confidence")):
                    by_old[old] = e
        # resolve new-name collisions across distinct olds
        by_new = {}
        for old, e in sorted(by_old.items()):
            new = e["new"]
            if new in by_new:
                keep = by_new[new]
                loser = e if _CONF.get(e.get("confidence")) <= _CONF.get(keep.get("confidence")) else keep
                win = keep if loser is e else e
                by_new[new] = win
                dropped.append(f"{key}: {loser['old']}->{new} (collides with {win['old']})")
            else:
                by_new[new] = e
        merged[key] = sorted(by_new.values(), key=lambda x: x["old"])
    for key in ("variables", "struct_fields"):
        for man in manifests:
            merged[key].extend(man.get(key, []))
    return merged, dropped


def report_leftovers(manifest, changed_paths):
    """Grep changed files for old UNIQUE identifiers that survived the rename.
    make check only compiles live code, so a rename left dangling inside an
    `#ifdef NON_MATCHING` body (never compiled) passes silently — this catches
    it. Variables are skipped (short names like `a` are not unique). Returns a
    list of warning strings."""
    checks = []  # (old, scope_paths_or_None)  None => all changed files
    for key in ("functions", "struct_types", "data_symbols"):
        for e in manifest.get(key, []):
            checks.append((e["old"], None))
    for sf in manifest.get("struct_fields", []):
        scope = sf.get("files") or ([sf["header_file"]] if sf.get("header_file") else [])
        checks.append((sf["old"], [(REPO / r).resolve() for r in scope]))
    warnings = []
    for old, scope in checks:
        pat = re.compile(r"\b" + re.escape(old) + r"\b")
        for p in (scope if scope else list(changed_paths)):
            try:
                if pat.search(p.read_text(errors="replace")):
                    warnings.append(f"{old} still present in {p.relative_to(REPO)} "
                                    "(likely inside #ifdef NON_MATCHING — not compiled)")
            except OSError:
                continue
    return warnings


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("manifest", nargs="+", help="one manifest, or several fragments to merge")
    ap.add_argument("--dry-run", action="store_true", help="show the plan, modify nothing")
    ap.add_argument("--no-check", action="store_true", help="apply but skip make check (not recommended)")
    args = ap.parse_args()

    mans = [json.loads(Path(m).read_text()) for m in args.manifest]
    if len(mans) == 1:
        manifest = mans[0]
    else:
        manifest, dropped = merge_manifests(mans)
        print(f"merged {len(mans)} fragments; {len(dropped)} dropped on collision")
        for d in dropped[:30]:
            print("   drop:", d)
    cluster = manifest.get("cluster", "?")

    # Require a clean tree so revert-on-failure restores the committed state.
    if not args.dry_run:
        st = subprocess.run(["git", "-C", str(REPO), "status", "--porcelain"], capture_output=True, text=True)
        # Only tracked modifications matter: revert-on-failure uses `git checkout --`,
        # which restores tracked files and never touches untracked ones (e.g. the
        # manifest itself). Untracked files are therefore safe to leave in place.
        tracked = [ln for ln in st.stdout.splitlines() if not ln.startswith("??")]
        if tracked:
            print("error: tracked files have uncommitted changes. Commit or stash first "
                  "so a failed apply can be reverted cleanly.\n" + "\n".join(tracked), file=sys.stderr)
            return 2

    print(f"== rename manifest: {cluster} ==")
    print(f"   {len(manifest.get('functions', []))} functions, "
          f"{len(manifest.get('variables', []))} variables, "
          f"{len(manifest.get('struct_fields', []))} struct fields, "
          f"{len(manifest.get('struct_types', []))} struct types, "
          f"{len(manifest.get('data_symbols', []))} data symbols")

    changed, touched = apply_manifest(manifest, args.dry_run)

    if not changed:
        print("nothing to change (no identifiers matched).")
        return 0

    print(f"\n{len(changed)} file(s) to change:")
    for p in sorted(changed, key=lambda x: str(x)):
        rel = p.relative_to(REPO)
        print(f"  {rel}")
        for lbl in touched[p]:
            print(f"      - {lbl}")

    if args.dry_run:
        print("\n(dry run — no files written)")
        return 0

    for p, text in changed.items():
        p.write_text(text)
    print(f"\nwrote {len(changed)} file(s).")

    if args.no_check:
        print("skipping make check (--no-check). Remember to verify before committing.")
        return 0

    print("\nrunning make -j8 && make check ...")
    build = subprocess.run(["make", "-j8"], cwd=REPO)
    check = subprocess.run(["make", "check"], cwd=REPO) if build.returncode == 0 else build
    if build.returncode != 0 or check.returncode != 0:
        print("\n*** make check FAILED — reverting all renamed files ***", file=sys.stderr)
        git_clean(list(changed.keys()))
        print("reverted. The manifest contains a name collision or scoping error; "
              "inspect the failing function and fix the offending entry.", file=sys.stderr)
        return 1

    leftovers = report_leftovers(manifest, list(changed.keys()))
    if leftovers:
        print("\n⚠  leftover old identifiers (make check could not see these — verify manually):",
              file=sys.stderr)
        for w in leftovers[:40]:
            print("   -", w, file=sys.stderr)

    print("\nmake check PASSED — rename is byte-identical. Refreshing caches ...")
    subprocess.run(["python3", "tools/agent/snapshot_addresses.py"], cwd=REPO, check=False)
    subprocess.run(["python3", "tools/agent/progress_stats.py", "--update-readme"], cwd=REPO, check=False)
    print("done. Review the diff, then commit when ready.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
