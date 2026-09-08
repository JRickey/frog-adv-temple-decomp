#!/usr/bin/env python3
"""Content fingerprints used to keep the decomp build oracle honest."""

from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path


def file_digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()


def manifest(paths: list[Path], root: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    for path in sorted(set(paths)):
        if path.is_file():
            try:
                key = str(path.relative_to(root))
            except ValueError:
                key = f"@external:{path}"
            result[key] = file_digest(path)
    return result


def load_state(path: Path) -> dict:
    try:
        value = json.loads(path.read_text())
        return value if isinstance(value, dict) else {}
    except (OSError, ValueError):
        return {}


def save_state(path: Path, value: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(f".{path.name}.{os.getpid()}.tmp")
    tmp.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n")
    os.replace(tmp, path)


def changed_keys(old: dict[str, str], new: dict[str, str]) -> set[str]:
    return {key for key in old.keys() | new.keys() if old.get(key) != new.get(key)}


def manifest_digest(value: dict[str, str]) -> str:
    encoded = json.dumps(value, sort_keys=True, separators=(",", ":")).encode()
    return hashlib.sha256(encoded).hexdigest()
