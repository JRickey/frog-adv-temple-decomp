#!/usr/bin/env python3
"""Per-function decomp STATUS index — derived (never hand-maintained, never drifts).

There is no stored per-function status file in this repo; progress_stats.py only
emits aggregate counts. This tool scans the source tree on demand and classifies
every function into exactly one status, so a future cleanup/reclaim pass can pull
its worklist with `--status <X>` instead of re-deriving it.

Statuses (one per function, in priority order):
  asm            — still an un-decompiled slice in asm/disasm_*.s. libgcc helpers
                   are excluded because they are linked from libgcc.a by design.
  deferred       — has a docs/deferred-analysis/<fn>.md stash (a full-effort attempt
                   that honestly left the asm slice in place; resume from the .md).
  naked          — defined in src but uses NAKED+NON_MATCHING (byte-matches via the
                   asm path, NOT pure C). Same definition progress_stats.py uses.
  register-heavy — a PURE-C match, but pinned with >= --pin-threshold (default 3)
                   `register T x asm("rN")` declarations. These match the bytes but
                   read like asm-with-register-hints rather than recovered source;
                   flagged for a future "de-pin" review pass to try a cleaner C
                   structure that needs fewer/zero pins. A register pin is a legit,
                   corpus-common matching lever (see docs/codegen-notes.md), NOT a
                   fake match — this status is a code-quality flag, not a correctness
                   one. The bar is intentionally low (3) so the punch-list is honest.
  matched        — a pure-C match with < threshold register pins. The gold standard.

A register-pin DECLARATION (`register u32 z asm("r6") = 0`) is pure C; it only
constrains register allocation and emits no instructions. It is NOT inline asm and
does NOT make a function NAKED — naked detection keys on the NAKED macro, exactly
like progress_stats.count_c_functions().

Usage:
  function_status.py                      # full table, all statuses
  function_status.py --status register-heavy   # just the de-pin worklist
  function_status.py --status register-heavy --with-commit   # + introducing commit
  function_status.py --counts             # one-line tally per status
  function_status.py --json
  function_status.py --pin-threshold 4    # raise the register-heavy bar
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from dataclasses import dataclass, asdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
SRC = ROOT / "src"
ASM_DIR = ROOT / "asm"
DEFERRED_DIR = ROOT / "docs" / "deferred-analysis"

DEFAULT_PIN_THRESHOLD = 3

# `register T x asm("rN")` — an explicit-register local. The [^;{}]* guard keeps
# the match inside a single declaration so an inline-asm statement two lines down
# can't be mistaken for a pin.
PIN_RE = re.compile(r'\bregister\b[^;{}]*\basm\s*\(\s*"(r\d+|sl|fp|ip|sb|lr)"', re.I)
# A function-definition header line (no trailing ';') — mirrors progress_stats.
FUNC_HEADER_RE = re.compile(r"^[A-Za-z_][\w\s\*]*\s+([A-Za-z_]\w*)\s*\([^;]*\)\s*$")
NAKED_RE = re.compile(r"\bNAKED\b")
THUMB_START_RE = re.compile(r"^\s*(?:thumb_func_start|arm_func_start)\s+(\S+)\s*$")

# Mirror pick_target.LIBGCC_SYMBOLS — these helpers are linked from libgcc.a, not work.
LIBGCC_SYMBOLS = frozenset({
    "__divsi3", "__udivsi3", "__umodsi3", "__ashldi3",
    "_call_via_r0", "_call_via_r1", "_call_via_r2", "_call_via_r3",
    "_call_via_r4", "_call_via_r5", "_call_via_r6", "_call_via_r7",
    "_call_via_r8", "_call_via_r9", "_call_via_sl", "_call_via_fp",
    "_call_via_ip", "_call_via_sp", "_call_via_lr",
})


@dataclass
class FnStatus:
    name: str
    status: str           # asm | deferred | naked | register-heavy | matched
    pins: int             # register-pin declarations (0 for asm/naked)
    file: str             # src/.../x.c or asm/disasm_*.s
    registers: str        # comma-joined pinned regs, for the de-pin worklist
    # Escalation ladder (deferred rows only): which model tiers have already
    # attempted this function, and which tier the next pass should use. Derived
    # from the deferred-analysis note — never stored. Empty for non-deferred rows.
    defer_tiers: str = ""  # "sonnet" or "sonnet,opus"
    next_tier: str = ""    # "opus" (sonnet-only so far) | "codex" (opus tried = firm-defer)


def _scan_src(pin_threshold: int) -> tuple[dict[str, FnStatus], set[str]]:
    """Classify every compiled function defined in src/**/*.c.

    Returns (by_name, defined_names). Skips the non-compiled readable branch of a
    `#ifdef NON_MATCHING … #else … #endif` pair so a NAKED fn is classified once
    (by its #else body), identically to progress_stats.count_c_functions().
    """
    out: dict[str, FnStatus] = {}
    for path in sorted(SRC.rglob("*.c")):
        try:
            lines = path.read_text(errors="replace").splitlines()
        except OSError:
            continue
        rel = str(path.relative_to(ROOT))
        in_nm_readable = False
        prev = ""
        i = 0
        while i < len(lines):
            s = lines[i].strip()
            if s.startswith("#ifdef NON_MATCHING"):
                in_nm_readable = True
                prev = ""
                i += 1
                continue
            if in_nm_readable and (s.startswith("#else") or s.startswith("#endif")):
                in_nm_readable = False
                prev = ""
                i += 1
                continue
            if in_nm_readable:
                i += 1
                continue

            m = FUNC_HEADER_RE.match(lines[i].rstrip())
            if m and "typedef" not in lines[i] and "#" not in lines[i]:
                name = m.group(1)
                is_naked = bool(NAKED_RE.search(lines[i]) or NAKED_RE.search(prev))
                # brace-match the body to count pins (and catch NAKED in-body).
                depth = 0
                started = False
                pins: list[str] = []
                j = i + 1
                while j < len(lines):
                    depth += lines[j].count("{") - lines[j].count("}")
                    started = started or "{" in lines[j]
                    if NAKED_RE.search(lines[j]):
                        is_naked = True
                    for pm in PIN_RE.finditer(lines[j]):
                        pins.append(pm.group(1))
                    if started and depth <= 0:
                        break
                    j += 1
                if is_naked:
                    status = "naked"
                elif len(pins) >= pin_threshold:
                    status = "register-heavy"
                else:
                    status = "matched"
                # First definition wins (the compiled one); ignore later dupes.
                out.setdefault(name, FnStatus(name, status, 0 if is_naked else len(pins), rel, ",".join(pins)))
                prev = lines[i]
                i = max(j, i + 1)
                continue
            if s:
                prev = lines[i]
            i += 1
    return out, set(out.keys())


def _scan_asm(defined: set[str]) -> list[FnStatus]:
    """Functions still living as un-decompiled asm/disasm_*.s slices."""
    out: list[FnStatus] = []
    for path in sorted(ASM_DIR.glob("disasm_*.s")):
        rel = str(path.relative_to(ROOT))
        for line in path.read_text(errors="replace").splitlines():
            m = THUMB_START_RE.match(line)
            if not m:
                continue
            name = m.group(1)
            if name in LIBGCC_SYMBOLS or name in defined:
                continue
            out.append(FnStatus(name, "asm", 0, rel, ""))
    return out


def _deferred_names() -> set[str]:
    if not DEFERRED_DIR.is_dir():
        return set()
    return {p.stem for p in DEFERRED_DIR.glob("*.md")}


# A re-attempt by a higher tier appends an "## Opus attempt" section to the note
# (the standalone Opus agents + finish-decomp's escalated defer step both do this).
# A note with no such marker was only attempted at the base (sonnet) tier.
_OPUS_ATTEMPT_RE = re.compile(r"opus[ _-]{0,3}attempt", re.I)


def _defer_tier(name: str) -> tuple[str, str]:
    """(defer_tiers, next_tier) for one deferred function, derived from its note.

    The escalation ladder: sonnet (auto-loop base) -> opus (next pass) -> codex
    (firm-defer, manual/rate-limited). 'next_tier' is what should attempt it next.
    """
    note = DEFERRED_DIR / f"{name}.md"
    try:
        text = note.read_text(errors="replace")
    except OSError:
        text = ""
    tiers = ["sonnet"]  # every auto-loop defer starts at the cheap tier
    if _OPUS_ATTEMPT_RE.search(text):
        tiers.append("opus")
    next_tier = "codex" if "opus" in tiers else "opus"
    return ",".join(tiers), next_tier


def collect(pin_threshold: int) -> list[FnStatus]:
    by_name, defined = _scan_src(pin_threshold)
    rows = list(by_name.values()) + _scan_asm(defined)
    deferred = _deferred_names()
    for r in rows:
        if r.name in deferred:
            r.status = "deferred"
            r.defer_tiers, r.next_tier = _defer_tier(r.name)
    return rows


def _introducing_commit(file_rel: str) -> str:
    try:
        out = subprocess.run(
            ["git", "-C", str(ROOT), "log", "-1", "--format=%h %s", "--", file_rel],
            capture_output=True, text=True, timeout=10,
        )
        return out.stdout.strip() or "(uncommitted)"
    except Exception:
        return "(?)"


STATUS_ORDER = ["register-heavy", "naked", "deferred", "asm", "matched"]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--status", help="filter to one status")
    ap.add_argument("--pin-threshold", type=int, default=DEFAULT_PIN_THRESHOLD,
                    help=f"register-heavy bar (default {DEFAULT_PIN_THRESHOLD})")
    ap.add_argument("--with-commit", action="store_true",
                    help="annotate each row with its file's latest commit")
    ap.add_argument("--counts", action="store_true", help="just the per-status tally")
    ap.add_argument("--next-tier", choices=["opus", "codex"],
                    help="filter to deferred functions whose next escalation tier is this "
                         "(opus = sonnet-only so far; codex = opus tried = firm-defer queue)")
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()

    rows = collect(args.pin_threshold)
    if args.status:
        rows = [r for r in rows if r.status == args.status]
    if args.next_tier:
        rows = [r for r in rows if r.status == "deferred" and r.next_tier == args.next_tier]

    # rank: status priority, then pins desc, then name
    rank = {s: i for i, s in enumerate(STATUS_ORDER)}
    rows.sort(key=lambda r: (rank.get(r.status, 99), -r.pins, r.name))

    if args.counts:
        tally: dict[str, int] = {}
        for r in collect(args.pin_threshold):
            tally[r.status] = tally.get(r.status, 0) + 1
        for s in STATUS_ORDER:
            if s in tally:
                print(f"  {s:<15} {tally[s]}")
        print(f"  {'TOTAL':<15} {sum(tally.values())}")
        return 0

    if args.json:
        data = [asdict(r) for r in rows]
        if args.with_commit:
            for d, r in zip(data, rows):
                d["commit"] = _introducing_commit(r.file)
        json.dump(data, sys.stdout, indent=2)
        sys.stdout.write("\n")
        return 0

    for r in rows:
        line = f"  [{r.status:<14}] {r.name:<18} pins={r.pins:<2} {r.registers:<26} {r.file}"
        if args.with_commit:
            line += f"\n      ↳ {_introducing_commit(r.file)}"
        print(line)
    return 0


if __name__ == "__main__":
    sys.exit(main())
