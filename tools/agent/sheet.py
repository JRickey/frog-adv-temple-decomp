#!/usr/bin/env python3
"""Stub for an external progress sheet — no-op until one exists.

In the mf decomp this module pulled a public Google Sheet that tracked
per-function decomp status, so pick_target.py could refuse to surface a
function already marked Complete. Frogger has no such sheet yet.

The API (`find(name=..., addr=...) -> Row | None`) is preserved so
pick_target.py keeps working — `find` just always returns None, which
short-circuits the "already done in sheet" blocker.

If/when a public progress tracker comes online for this decomp, set
SHEET_URL below to the CSV-export URL and re-enable the loader.
"""

from __future__ import annotations

import argparse
import sys
from dataclasses import dataclass


SHEET_URL: str | None = None  # set to a CSV-export URL to enable


@dataclass
class Row:
    address: int
    size: int
    name: str
    file: str
    status: str
    claimed_by: str
    notes: str


def load(refresh: bool = False) -> list[Row]:
    return []


def find(name: str | None = None, addr: int | None = None,
         refresh: bool = False) -> Row | None:
    return None


def main() -> int:
    p = argparse.ArgumentParser()
    sub = p.add_subparsers(dest="cmd")
    sub.add_parser("refresh")
    p_status = sub.add_parser("status")
    p_status.add_argument("name", nargs="?")
    p_status.add_argument("--addr")
    p_check = sub.add_parser("is-complete")
    p_check.add_argument("name", nargs="?")
    p_check.add_argument("--addr")
    p.parse_args()

    print("sheet.py: no external progress sheet configured for this decomp.",
          file=sys.stderr)
    print("Set SHEET_URL in tools/agent/sheet.py to enable.", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
