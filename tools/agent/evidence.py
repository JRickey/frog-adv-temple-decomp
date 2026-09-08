#!/usr/bin/env python3
"""Validate and query the reviewable evidence graph in docs/evidence/*.json."""

from __future__ import annotations

import argparse
import json
import re
import sqlite3
import subprocess
import sys
from pathlib import Path, PurePosixPath
from typing import Any, Iterable

ROOT = Path(__file__).resolve().parents[2]
KINDS = {"behavior", "layout", "compiler", "dependency", "data", "workflow"}
STATUSES = {"observed", "hypothesized", "verified", "superseded"}
VALIDATION_STATES = {"unvalidated", "confirmed", "contradicted"}
ID_RE = re.compile(r"^[a-z0-9][a-z0-9._-]*$")
SUBJECT_RE = re.compile(r"^[a-z][a-z0-9_-]*:[A-Za-z0-9@._:-]+$")
COMMIT_RE = re.compile(r"^[0-9a-f]{40}$")


class EvidenceError(ValueError):
    pass


def _strings(value: Any, field: str) -> list[str]:
    if not isinstance(value, list) or not all(isinstance(x, str) and x for x in value):
        raise EvidenceError(f"{field} must be an array of non-empty strings")
    return value


def _repo_path(value: Any, field: str) -> str:
    if not isinstance(value, str) or not value:
        raise EvidenceError(f"{field} must be a non-empty string")
    path = PurePosixPath(value)
    if path.is_absolute() or ".." in path.parts or value.startswith("~"):
        raise EvidenceError(f"{field} must be a repository-relative path")
    return value


def validate_record(record: Any, source: str) -> dict[str, Any]:
    if not isinstance(record, dict):
        raise EvidenceError(f"{source}: record must be an object")
    required = ("schema_version", "id", "kind", "title", "status", "claim", "subjects", "provenance")
    missing = [key for key in required if key not in record]
    if missing:
        raise EvidenceError(f"{source}: missing {', '.join(missing)}")
    if record["schema_version"] != 1:
        raise EvidenceError(f"{source}: schema_version must be 1")
    rid = record["id"]
    if not isinstance(rid, str) or not ID_RE.fullmatch(rid):
        raise EvidenceError(f"{source}: invalid id {rid!r}")
    if record["kind"] not in KINDS:
        raise EvidenceError(f"{source}: invalid kind {record['kind']!r}")
    if record["status"] not in STATUSES:
        raise EvidenceError(f"{source}: invalid status {record['status']!r}")
    for field in ("title", "claim"):
        if not isinstance(record[field], str) or not record[field].strip():
            raise EvidenceError(f"{source}: {field} must be a non-empty string")
    subjects = _strings(record["subjects"], f"{source}: subjects")
    if not subjects or any(not SUBJECT_RE.fullmatch(x) for x in subjects):
        raise EvidenceError(f"{source}: subjects must contain stable typed IDs")
    provenance = record["provenance"]
    if not isinstance(provenance, list) or not provenance:
        raise EvidenceError(f"{source}: provenance must be a non-empty array")
    for i, item in enumerate(provenance):
        where = f"{source}: provenance[{i}]"
        if not isinstance(item, dict):
            raise EvidenceError(f"{where} must be an object")
        _repo_path(item.get("path"), f"{where}.path")
        if "commit" in item and (not isinstance(item["commit"], str) or not COMMIT_RE.fullmatch(item["commit"])):
            raise EvidenceError(f"{where}.commit must be a 40-character lowercase hex commit")
        for key in ("location", "note"):
            if key in item and not isinstance(item[key], str):
                raise EvidenceError(f"{where}.{key} must be a string")
    for field in ("prerequisites", "tags"):
        if field in record:
            _strings(record[field], f"{source}: {field}")
    relations = record.get("relations", [])
    if not isinstance(relations, list):
        raise EvidenceError(f"{source}: relations must be an array")
    for i, relation in enumerate(relations):
        if not isinstance(relation, dict) or not ID_RE.fullmatch(str(relation.get("type", ""))) or not ID_RE.fullmatch(str(relation.get("target", ""))):
            raise EvidenceError(f"{source}: relations[{i}] needs slug type and evidence target")
    validation = record.get("current_validation")
    if validation is not None:
        if not isinstance(validation, dict) or validation.get("state") not in VALIDATION_STATES:
            raise EvidenceError(f"{source}: current_validation has invalid state")
        commit = validation.get("commit")
        if commit is not None and (not isinstance(commit, str) or not COMMIT_RE.fullmatch(commit)):
            raise EvidenceError(f"{source}: current_validation.commit must be 40-character lowercase hex")
        if "note" in validation and not isinstance(validation["note"], str):
            raise EvidenceError(f"{source}: current_validation.note must be a string")
    if "confidence" in record and (isinstance(record["confidence"], bool) or not isinstance(record["confidence"], (int, float)) or not 0 <= record["confidence"] <= 1):
        raise EvidenceError(f"{source}: confidence must be between 0 and 1")
    if "superseded_by" in record and not ID_RE.fullmatch(str(record["superseded_by"])):
        raise EvidenceError(f"{source}: superseded_by must be an evidence ID")
    return record


def load_records(evidence_dir: Path) -> list[dict[str, Any]]:
    records: list[dict[str, Any]] = []
    seen: dict[str, str] = {}
    for path in sorted(evidence_dir.glob("*.json")) if evidence_dir.exists() else []:
        display_path = f"docs/evidence/{path.name}"
        try:
            payload = json.loads(path.read_text())
        except (OSError, json.JSONDecodeError) as exc:
            raise EvidenceError(f"{display_path}: {exc}") from exc
        items = payload if isinstance(payload, list) else [payload]
        for index, item in enumerate(items):
            source = f"{display_path}[{index}]"
            record = validate_record(item, source)
            if record["id"] in seen:
                raise EvidenceError(f"{source}: duplicate id {record['id']!r} (first in {seen[record['id']]})")
            seen[record["id"]] = source
            records.append(record)
    ids = set(seen)
    for record in records:
        refs = list(record.get("prerequisites", []))
        refs += [x["target"] for x in record.get("relations", [])]
        if record.get("superseded_by"):
            refs.append(record["superseded_by"])
        for ref in refs:
            if ref not in ids:
                raise EvidenceError(f"{record['id']}: unknown evidence reference {ref!r}")
    _check_prerequisite_dag(records)
    return sorted(records, key=lambda x: x["id"])


def validate_sources(records: Iterable[dict[str, Any]], root: Path) -> list[str]:
    """Check cited files locally or in their cited commit.

    `location` is intentionally descriptive and is not interpreted or claimed
    to be machine-verified by this check.
    """
    errors: list[str] = []
    for record in records:
        for index, provenance in enumerate(record["provenance"]):
            path = provenance["path"]
            commit = provenance.get("commit")
            if commit:
                proc = subprocess.run(["git", "cat-file", "-e", f"{commit}:{path}"],
                                      cwd=root, text=True, capture_output=True)
                if proc.returncode != 0:
                    errors.append(f"{record['id']}: provenance[{index}] missing at {commit[:12]}:{path}")
            elif not (root / path).is_file():
                errors.append(f"{record['id']}: provenance[{index}] local path does not exist: {path}")
    return errors


def _check_prerequisite_dag(records: list[dict[str, Any]]) -> None:
    graph = {r["id"]: r.get("prerequisites", []) for r in records}
    active: list[str] = []
    done: set[str] = set()
    def visit(node: str) -> None:
        if node in active:
            cycle = active[active.index(node):] + [node]
            raise EvidenceError("prerequisite cycle: " + " -> ".join(cycle))
        if node in done:
            return
        active.append(node)
        for dependency in graph[node]:
            visit(dependency)
        active.pop()
        done.add(node)
    for node in sorted(graph):
        visit(node)


def git_head(root: Path) -> str | None:
    proc = subprocess.run(["git", "rev-parse", "HEAD"], cwd=root, text=True, capture_output=True)
    value = proc.stdout.strip()
    return value if proc.returncode == 0 and COMMIT_RE.fullmatch(value) else None


def validation_label(record: dict[str, Any], head: str | None) -> str:
    validation = record.get("current_validation")
    if not validation or validation["state"] == "unvalidated":
        return "current checkout: unvalidated"
    commit = validation.get("commit")
    state = validation["state"]
    if commit:
        return f"recorded {state} at {commit[:12]}; current checkout unvalidated"
    return f"recorded {state}; current checkout unvalidated"


def _terms(text: str) -> list[str]:
    return re.findall(r"[a-z0-9]+", text.lower())


def _record_text(record: dict[str, Any]) -> str:
    values: list[str] = [record["id"], record["kind"], record["title"], record["claim"], record["status"]]
    values += record["subjects"] + record.get("tags", [])
    return " ".join(values).lower()


def search(records: Iterable[dict[str, Any]], query: str, limit: int = 10, aliases: Iterable[str] = ()) -> list[dict[str, Any]]:
    needles = sorted(set(_terms(query) + [x.lower() for x in aliases if x]))
    ranked: list[tuple[int, str, dict[str, Any]]] = []
    for record in records:
        text = _record_text(record)
        score = sum(8 if n in " ".join(record["subjects"]).lower() else 4 if n in record["id"] else 2 if n in record["title"].lower() else 1 for n in needles if n in text)
        if score:
            ranked.append((-score, record["id"], record))
    return [x[2] for x in sorted(ranked)[:max(0, limit)]]


def target_aliases(target: str, root: Path, db_path: Path | None = None) -> list[str]:
    aliases = {target, target.lower()}
    match = re.search(r"(?:0x|sub_)?(08[0-9a-fA-F]{6})", target)
    address = int(match.group(1), 16) if match else None
    map_path = root / "frog_us.map"
    map_pairs: list[tuple[int, str]] = []
    if map_path.exists():
        pair_re = re.compile(r"^\s*0x0*(8[0-9a-fA-F]{6})\s+([A-Za-z_]\w*)\s*$", re.M)
        map_pairs = [(int(addr, 16), name)
                     for addr, name in pair_re.findall(map_path.read_text(errors="replace"))]
        if address is None:
            reverse = [addr for addr, name in map_pairs if name.lower() == target.lower()]
            if reverse:
                address = reverse[0]
    if db_path and db_path.exists():
        try:
            con = sqlite3.connect(f"file:{db_path}?mode=ro", uri=True)
            for table, in con.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"):
                cols = [row[1] for row in con.execute(f'PRAGMA table_info("{table}")')]
                name_col = next((x for x in cols if x.lower() in {"name", "symbol", "function"}), None)
                addr_col = next((x for x in cols if x.lower() in {"address", "addr", "start"}), None)
                if address is None and name_col and addr_col:
                    sql = f'SELECT "{addr_col}" FROM "{table}" WHERE lower("{name_col}") = lower(?) LIMIT 1'
                    row = con.execute(sql, (target,)).fetchone()
                    if row:
                        try:
                            address = int(str(row[0]), 0)
                        except ValueError:
                            pass
                if address is not None and name_col and addr_col:
                    sql = f'SELECT "{name_col}" FROM "{table}" WHERE "{addr_col}" IN (?, ?) LIMIT 20'
                    aliases.update(str(row[0]) for row in con.execute(sql, (address, f"0x{address:08x}")) if row[0])
            con.close()
        except sqlite3.Error:
            pass
    if address is not None:
        aliases.update({f"fn:{address:08x}", f"sub_{address:08X}",
                        f"sub_{address:08x}", f"0x{address:08x}"})
        aliases.update(name for addr, name in map_pairs if addr == address)
    return sorted(aliases)


def brief_data(records: list[dict[str, Any]], target: str, root: Path, limit: int, db_path: Path | None) -> list[dict[str, Any]]:
    aliases = target_aliases(target, root, db_path)
    return search(records, target, limit, aliases)


def dependency_plan(records: list[dict[str, Any]], seeds: Iterable[str] | None = None) -> dict[str, Any]:
    """Return the prerequisite closure in deterministic dependency-first order."""
    by_id = {record["id"]: record for record in records}
    chosen = set(by_id) if seeds is None else set(seeds)
    unknown = sorted(chosen - set(by_id))
    if unknown:
        raise EvidenceError("unknown plan seed(s): " + ", ".join(unknown))
    closure: set[str] = set()
    def collect(rid: str) -> None:
        if rid in closure:
            return
        closure.add(rid)
        for dependency in by_id[rid].get("prerequisites", []):
            collect(dependency)
    for rid in sorted(chosen):
        collect(rid)
    ordered: list[str] = []
    seen: set[str] = set()
    def emit(rid: str) -> None:
        if rid in seen:
            return
        for dependency in sorted(by_id[rid].get("prerequisites", [])):
            emit(dependency)
        seen.add(rid)
        ordered.append(rid)
    for rid in sorted(chosen):
        emit(rid)
    nodes = [{
        "id": rid,
        "kind": by_id[rid]["kind"],
        "status": by_id[rid]["status"],
        "validation": validation_label(by_id[rid], None),
    } for rid in ordered]
    edges = [{"prerequisite": dep, "dependent": rid}
             for rid in sorted(closure)
             for dep in sorted(by_id[rid].get("prerequisites", []))]
    unresolved = [node["id"] for node in nodes
                  if node["status"] != "verified"
                  or by_id[node["id"]].get("current_validation", {}).get("state") == "contradicted"]
    return {"seeds": sorted(chosen), "order": ordered, "edges": edges,
            "nodes": nodes, "unresolved": unresolved}


def _bounded(text: str, length: int) -> str:
    clean = " ".join(text.split())
    return clean if len(clean) <= length else clean[:length - 1].rstrip() + "…"


def format_records(records: list[dict[str, Any]], root: Path, compact: bool = False) -> str:
    if not records:
        return "  (no matching evidence)\n"
    head = git_head(root)
    lines: list[str] = []
    for record in records:
        lines.append(f"  [{record['status']}/{record['kind']}] {record['id']}: {record['title']}")
        lines.append(f"    {_bounded(record['claim'], 280 if compact else 500)}")
        lines.append(f"    validation: {validation_label(record, head)}")
        for provenance in record["provenance"][:2]:
            ref = provenance["path"]
            if provenance.get("location"):
                ref += ":" + _bounded(provenance["location"], 80)
            if provenance.get("commit"):
                ref += " @ " + provenance["commit"][:12]
            lines.append(f"    source: {ref}")
        if not compact and record.get("prerequisites"):
            lines.append("    prerequisites: " + ", ".join(record["prerequisites"]))
    return "\n".join(lines) + "\n"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--evidence-dir", type=Path)
    parser.add_argument("--callgraph-db", type=Path)
    sub = parser.add_subparsers(dest="command", required=True)
    validate = sub.add_parser("validate")
    validate.add_argument("--sources", action="store_true",
                          help="check cited paths locally or with git cat-file at cited commits")
    find = sub.add_parser("search")
    find.add_argument("query")
    find.add_argument("--limit", type=int, default=10)
    find.add_argument("--json", action="store_true")
    brief = sub.add_parser("brief")
    brief.add_argument("target")
    brief.add_argument("--limit", type=int, default=8)
    brief.add_argument("--json", action="store_true")
    plan = sub.add_parser("plan")
    plan.add_argument("query", nargs="?", help="search query; omit for the complete graph")
    plan.add_argument("--limit", type=int, default=10, help="maximum query seed records")
    plan.add_argument("--json", action="store_true")
    args = parser.parse_args(argv)
    root = args.root.resolve()
    evidence_dir = args.evidence_dir or root / "docs/evidence"
    db_path = args.callgraph_db or root / "tools/agent/callgraph.db"
    try:
        records = load_records(evidence_dir)
    except EvidenceError as exc:
        print(f"evidence: error: {exc}", file=sys.stderr)
        return 2
    if args.command == "validate":
        if args.sources:
            source_errors = validate_sources(records, root)
            if source_errors:
                for error in source_errors:
                    print(f"evidence: source error: {error}", file=sys.stderr)
                print("evidence: source locations are descriptive and were not machine-checked",
                      file=sys.stderr)
                return 2
            print("evidence: cited source paths exist; location strings were not machine-checked")
        print(f"evidence: valid ({len(records)} records)")
        return 0
    if args.command == "plan":
        seeds = None if not args.query else [x["id"] for x in search(records, args.query, args.limit)]
        try:
            result = dependency_plan(records, seeds)
        except EvidenceError as exc:
            print(f"evidence: error: {exc}", file=sys.stderr)
            return 2
        if args.json:
            json.dump(result, sys.stdout, indent=2, sort_keys=True)
            sys.stdout.write("\n")
        else:
            print("Dependency order:")
            if not result["nodes"]:
                print("  (empty)")
            for node in result["nodes"]:
                marker = "historically-verified" if node["id"] not in result["unresolved"] else "unresolved"
                print(f"  {node['id']} [{node['status']}/{marker}] — {node['validation']}")
        return 0
    if args.command == "search":
        result = search(records, args.query, args.limit)
    else:
        result = brief_data(records, args.target, root, args.limit, db_path)
    if args.json:
        json.dump(result, sys.stdout, indent=2, sort_keys=True)
        sys.stdout.write("\n")
    else:
        sys.stdout.write(format_records(result, root))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
