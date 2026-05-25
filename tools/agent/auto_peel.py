#!/usr/bin/env python3
"""Auto-peel a function (or every callee of a function) into its own slice.

The bottleneck for C decomp on this title is **cross-region Thumb BL
relocations**: a function that calls anything outside its own slice
can't be matched in C because neither `PROVIDE()` nor `.thumb_set` give
ld enough info to encode the BL without a veneer (see
`docs/codegen-notes.md`, "Cross-region Thumb BL targets"). The only
robust fix is to give every BL target a real Thumb-typed symbol — i.e.
peel it, even just as `.incbin`. This script automates that.

Two modes:

  python3 tools/agent/auto_peel.py --addr 0x08020B30                 [--apply]
  python3 tools/agent/auto_peel.py --callees-of sub_08000430         [--apply]

Without `--apply`, prints a dry-run plan and exits 0.
With `--apply`, performs each peel sequentially:

  1. Run `detect-fn-boundary` to get [start, end).
  2. Run `tools/disasm/peel.py` to write asm/disasm_0xSTART.s.
  3. Locate the asm/text/text_0xBUCKET.s bucket file containing [start, end).
  4. Split the bucket: replace its single .incbin with pre/post buckets,
     remove the old bucket .s if fully consumed.
  5. Update linker.ld: replace the bucket's .text entry with
     [pre-bucket, new disasm, post-bucket], in baserom address order.
  6. Run `make check`. On any failure, revert via `git restore .` and
     `git clean -fd`, then bail out with a diagnostic.
  7. Refresh `tools/agent/.function_addresses.json`.

Exit codes:
  0  every requested peel succeeded (or dry-run printed cleanly)
  1  some peel failed; repo restored to pre-tool state
  2  invalid input (target not found, addr out of range, etc.)

No commit is created — leave each peel as an unstaged change so the
user can review and decide whether to land it as one commit per peel
or as one bundled commit per `--callees-of` invocation.
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
BASEROM = ROOT / "frog_us_baserom.gba"
LINKER = ROOT / "linker.ld"
TEXT_DIR = ROOT / "asm" / "text"
DISASM_DIR = ROOT / "asm"

ROM_BASE = 0x08000000

# Match a linker.ld line for an asm/text bucket or asm/disasm slice. Captures
# the full path so we can dispatch.
LD_TEXT_RE = re.compile(
    r'^(\s*)asm/text/text_(?P<addr>0x[0-9a-fA-F]+)\.o\(\.text\);'
    r'\s*/\*\s*0x(?P<lo>[0-9a-fA-F]+)\s*-\s*0x(?P<hi>[0-9a-fA-F]+)\s*,'
    r'\s*raw bytes\s*\*/.*$'
)

# Match `.incbin "frog_us_baserom.gba", 0xOFFSET, 0xSIZE` inside a bucket .s.
INCBIN_RE = re.compile(
    r'^(?P<indent>\s*)\.incbin\s+"frog_us_baserom\.gba",\s*'
    r'(?P<off>0x[0-9a-fA-F]+|\d+)\s*,\s*'
    r'(?P<size>0x[0-9a-fA-F]+|\d+)\s*$'
)


def hex8(addr: int) -> str:
    return f"0x{addr:08x}"


@dataclass
class PeelPlan:
    addr: int                # start ROM address
    end: int                 # exclusive end ROM address
    bucket_path: Path        # current bucket .s
    bucket_lo: int           # bucket's current VA range
    bucket_hi: int
    pre_size: int            # bytes in [bucket_lo, addr)  — 0 means peel from bucket head
    post_size: int           # bytes in [end, bucket_hi)   — 0 means peel to bucket tail


def parse_addr(s: str) -> int:
    return int(s, 0)


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, cwd=ROOT, **kw)


# --------------------------------------------------------------------------
# Discovery helpers
# --------------------------------------------------------------------------

def existing_disasm_starts() -> set[int]:
    """Return the set of start-addresses already peeled into asm/disasm_*.s."""
    addrs: set[int] = set()
    for p in DISASM_DIR.glob("disasm_0x*.s"):
        m = re.match(r"disasm_(0x[0-9a-fA-F]+)\.s", p.name)
        if m:
            addrs.add(int(m.group(1), 16))
    return addrs


def existing_disasm_ranges() -> list[tuple[int, int, Path]]:
    """Return (start, end, path) for every asm/disasm_0x*.s by parsing its
    `Range:` header comment. Falls back to file-size based end if missing."""
    out: list[tuple[int, int, Path]] = []
    for p in DISASM_DIR.glob("disasm_0x*.s"):
        text = p.read_text(errors="replace")
        m = re.search(r"Range:\s*\[0x([0-9a-fA-F]+),\s*0x([0-9a-fA-F]+)\)", text)
        if not m:
            continue
        out.append((int(m.group(1), 16), int(m.group(2), 16), p))
    return out


def find_bucket_for(addr: int, end: int) -> tuple[int, int, Path] | None:
    """Return (bucket_lo, bucket_hi, path) for the text bucket containing
    [addr, end), or None if not found."""
    for line in LINKER.read_text().splitlines():
        m = LD_TEXT_RE.match(line)
        if not m:
            continue
        lo = int(m.group("lo"), 16)
        hi = int(m.group("hi"), 16)
        if lo <= addr and end <= hi:
            path = TEXT_DIR / f"text_{m.group('addr').lower()}.s"
            return lo, hi, path
    return None


def call_targets(start: int, end: int) -> list[int]:
    """Run objdump on [start, end) (assumed Thumb) and return BL target
    addresses that lie OUTSIDE [start, end)."""
    proc = run([
        "arm-none-eabi-objdump",
        "-D", "-b", "binary", "-m", "arm7tdmi", "-Mforce-thumb",
        f"--adjust-vma=0x{ROM_BASE:x}",
        f"--start-address=0x{start:x}",
        f"--stop-address=0x{end:x}",
        str(BASEROM),
    ])
    if proc.returncode != 0:
        raise RuntimeError(f"objdump failed: {proc.stderr}")

    targets: list[int] = []
    bl_re = re.compile(r"^\s*[0-9a-f]+:\s+[0-9a-f]+\s+[0-9a-f]+\s+bl\s+0x([0-9a-f]+)")
    for line in proc.stdout.splitlines():
        m = bl_re.match(line)
        if not m:
            continue
        t = int(m.group(1), 16)
        if t < start or t >= end:
            targets.append(t)
    # Dedup, preserve order.
    seen: set[int] = set()
    unique: list[int] = []
    for t in targets:
        if t not in seen:
            seen.add(t)
            unique.append(t)
    return unique


def resolve_target(name_or_addr: str) -> tuple[int, int]:
    """Return (start, end) for a function name (in any asm/disasm_*.s) or
    a raw address (then end is unknown; caller should run boundary detect).
    """
    # Numeric?
    try:
        addr = int(name_or_addr, 0)
    except ValueError:
        addr = None

    if addr is None:
        # Name lookup — scan all disasm .s files.
        for path in DISASM_DIR.glob("disasm_0x*.s"):
            text = path.read_text(errors="replace")
            mstart = re.search(
                rf"thumb_func_start\s+{re.escape(name_or_addr)}\b", text)
            if not mstart:
                continue
            mrange = re.search(
                r"Range:\s*\[0x([0-9a-fA-F]+),\s*0x([0-9a-fA-F]+)\)", text)
            if mrange:
                return int(mrange.group(1), 16), int(mrange.group(2), 16)
            mfn = re.match(r"disasm_(0x[0-9a-fA-F]+)\.s", path.name)
            if mfn:
                start = int(mfn.group(1), 16)
                return start, start  # unknown end
        raise SystemExit(f"target {name_or_addr!r} not found in asm/disasm_*.s")

    # Address — caller must derive end via boundary detect.
    return addr, addr


# --------------------------------------------------------------------------
# Boundary detect (delegates to the TS tool)
# --------------------------------------------------------------------------

def detect_end(start: int) -> int:
    """Run detect-fn-boundary.ts and return its recommended end address."""
    detector = ROOT / "tools/agent/ts/cmds/detect-fn-boundary.ts"
    proc = run(
        ["npx", "tsx", str(detector), f"0x{start:08x}", "--json"]
    )
    if proc.returncode not in (0, 2):
        raise RuntimeError(
            f"detect-fn-boundary failed (exit {proc.returncode}): {proc.stderr}"
        )
    report = json.loads(proc.stdout)
    return int(report["recommendedEnd"])


# --------------------------------------------------------------------------
# The peel itself
# --------------------------------------------------------------------------

def build_plan(addr: int, end: int) -> PeelPlan:
    if addr % 2 != 0:
        raise SystemExit(f"address 0x{addr:08x} is not halfword-aligned (Thumb)")
    if end <= addr:
        raise SystemExit(f"end 0x{end:08x} not after start 0x{addr:08x}")
    bucket = find_bucket_for(addr, end)
    if bucket is None:
        raise SystemExit(
            f"no asm/text bucket covers [0x{addr:08x}, 0x{end:08x}) — "
            f"is the address inside an already-peeled function?"
        )
    lo, hi, path = bucket
    return PeelPlan(
        addr=addr, end=end,
        bucket_path=path, bucket_lo=lo, bucket_hi=hi,
        pre_size=addr - lo, post_size=hi - end,
    )


def emit_bucket(va_lo: int, va_hi: int, note: str = "") -> str:
    """Render a bucket .s file body in the project's canonical format."""
    file_off = va_lo - ROM_BASE
    size = va_hi - va_lo
    label = f"text_{va_lo - ROM_BASE + ROM_BASE:08x}"  # 8-digit, no 0x prefix
    label = f"text_{va_lo:08x}"
    body = []
    body.append("@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.")
    body.append("@ Address-aligned bucket of unparsed baserom bytes.")
    body.append(f"@ Range:  [0x{va_lo:08x}, 0x{va_hi:08x})  (0x{size:x} bytes)")
    if note:
        body.append("@")
        body.append(f"@ {note}")
    body.append("@")
    body.append("@ This file holds raw bytes only; no instructions are assembled here.")
    body.append("")
    body.append('        .section .text, "ax", %progbits')
    body.append("        .align  2")
    body.append(f"        .global {label}")
    body.append(f"        .type   {label}, %object")
    body.append(f"{label}:")
    body.append(f'        .incbin "frog_us_baserom.gba", 0x{file_off:08x}, 0x{size:08x}')
    body.append(f"        .size   {label}, . - {label}")
    body.append("")
    return "\n".join(body)


def perform_peel(plan: PeelPlan) -> list[Path]:
    """Apply a single peel. Returns list of files touched.

    Steps in order:
      1. Run peel.py to write asm/disasm_0xSTART.s (with boundary check).
      2. Emit pre-bucket (if non-empty) and post-bucket (if non-empty).
      3. Remove the original bucket file (always — it'll be replaced by
         0, 1, or 2 new buckets).
      4. Update linker.ld: replace the old bucket .text line with the
         new entries in baserom address order.
    """
    touched: list[Path] = []

    # 1. peel.py — writes asm/disasm_0xSTART.s
    peel = ROOT / "tools" / "disasm" / "peel.py"
    proc = run([
        "python3", str(peel),
        "--start", f"0x{plan.addr:08x}",
        "--end",   f"0x{plan.end:08x}",
        "--mode", "thumb",
    ])
    if proc.returncode != 0:
        raise RuntimeError(
            f"peel.py failed:\n{proc.stderr}\n{proc.stdout}"
        )
    disasm_path = ROOT / f"asm/disasm_0x{plan.addr:08x}.s"
    if not disasm_path.exists():
        raise RuntimeError(f"peel.py exited 0 but {disasm_path.name} missing")
    touched.append(disasm_path)

    # 2. Pre/post buckets.
    pre_path = (
        TEXT_DIR / f"text_0x{plan.bucket_lo:08x}.s"
    ) if plan.pre_size else None
    post_path = (
        TEXT_DIR / f"text_0x{plan.end:08x}.s"
    ) if plan.post_size else None

    if pre_path is not None:
        pre_path.write_text(emit_bucket(
            plan.bucket_lo, plan.addr,
            note=f"Pre-peel chunk before sub_{plan.addr:08X}.",
        ))
        touched.append(pre_path)

    if post_path is not None:
        post_path.write_text(emit_bucket(
            plan.end, plan.bucket_hi,
            note=f"Post-peel chunk after sub_{plan.addr:08X}.",
        ))
        touched.append(post_path)

    # 3. Remove the old bucket file IFF it's not also the pre_path
    # (which only happens when bucket_lo == addr).
    if plan.bucket_path != pre_path and plan.bucket_path.exists():
        # Also remove the matching .o so make doesn't pick up stale.
        plan.bucket_path.unlink()
        old_o = plan.bucket_path.with_suffix(".o")
        if old_o.exists():
            old_o.unlink()
        touched.append(plan.bucket_path)

    # 4. linker.ld.
    update_linker(plan, pre_path, disasm_path, post_path)
    touched.append(LINKER)
    return touched


def update_linker(
    plan: PeelPlan,
    pre_path: Path | None,
    disasm_path: Path,
    post_path: Path | None,
) -> None:
    text = LINKER.read_text()
    lines = text.splitlines(keepends=True)

    # Find the line for the OLD bucket.
    target_rel = f"asm/text/text_0x{plan.bucket_lo:08x}.o(.text)"
    hit_idx = None
    indent = ""
    for i, line in enumerate(lines):
        if target_rel in line:
            hit_idx = i
            m = re.match(r"^(\s*)", line)
            indent = m.group(1) if m else "        "
            break
    if hit_idx is None:
        raise RuntimeError(
            f"linker.ld has no entry for {target_rel}; aborting before damage."
        )

    new_lines: list[str] = []
    if pre_path is not None:
        new_lines.append(
            f"{indent}asm/text/text_0x{plan.bucket_lo:08x}.o(.text);"
            f"  /* 0x{plan.bucket_lo:08x} - 0x{plan.addr:08x}, raw bytes */\n"
        )
    new_lines.append(
        f"{indent}asm/disasm_0x{plan.addr:08x}.o(.text);"
        f"  /* 0x{plan.addr:08x} - 0x{plan.end:08x}, sub_{plan.addr:08X} (auto-peeled) */\n"
    )
    if post_path is not None:
        new_lines.append(
            f"{indent}asm/text/text_0x{plan.end:08x}.o(.text);"
            f"  /* 0x{plan.end:08x} - 0x{plan.bucket_hi:08x}, raw bytes */\n"
        )

    lines[hit_idx : hit_idx + 1] = new_lines
    LINKER.write_text("".join(lines))


# --------------------------------------------------------------------------
# Orchestration
# --------------------------------------------------------------------------

def make_check() -> tuple[bool, str]:
    """Build + verify. Returns (matched, message)."""
    proc = run(["make", "-j8"])
    if proc.returncode != 0:
        return False, f"make failed:\n{(proc.stderr + proc.stdout)[-2000:]}"
    chk = run(["make", "check"])
    if chk.returncode != 0:
        return False, f"make check failed:\n{(chk.stderr + chk.stdout)[-1000:]}"
    return True, ""


def git_clean_revert() -> None:
    """Restore working tree to HEAD; remove any new files this script wrote."""
    run(["git", "restore", "."])
    run(["git", "clean", "-fd"])


def refresh_address_cache() -> None:
    snap = ROOT / "tools/agent/snapshot_addresses.py"
    if snap.exists():
        run(["python3", str(snap)])


def peel_address(addr: int, dry_run: bool) -> bool:
    """Peel one address. Returns True on success."""
    if addr in existing_disasm_starts():
        print(f"  skip: 0x{addr:08x} already peeled")
        return True

    print(f"\n== peel 0x{addr:08x} ==")
    try:
        end = detect_end(addr)
    except Exception as e:
        print(f"  boundary detect failed: {e}", file=sys.stderr)
        return False
    print(f"  boundary: [0x{addr:08x}, 0x{end:08x})  ({end - addr} bytes)")

    try:
        plan = build_plan(addr, end)
    except SystemExit as e:
        print(f"  {e}", file=sys.stderr)
        return False

    print(f"  bucket: {plan.bucket_path.relative_to(ROOT)} "
          f"[0x{plan.bucket_lo:08x}, 0x{plan.bucket_hi:08x})")
    print(f"  pre={plan.pre_size:#x} bytes, post={plan.post_size:#x} bytes")

    if dry_run:
        print("  (dry-run; no changes)")
        return True

    try:
        perform_peel(plan)
    except Exception as e:
        print(f"  peel write failed: {e}", file=sys.stderr)
        git_clean_revert()
        return False

    ok, msg = make_check()
    if not ok:
        print(f"  build/check failed; reverting.\n{msg}", file=sys.stderr)
        git_clean_revert()
        return False

    refresh_address_cache()
    print(f"  ✓ peeled; make check still matches")
    return True


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("--addr", type=parse_addr,
                   help="single ROM address to peel (e.g. 0x08020B30)")
    p.add_argument("--callees-of",
                   help="name or address of a function; peel every cross-slice "
                        "BL target it makes")
    p.add_argument("--apply", action="store_true",
                   help="actually run the peels (default: dry-run)")
    args = p.parse_args()

    if not (args.addr or args.callees_of):
        p.error("specify --addr or --callees-of")

    addrs: list[int] = []

    if args.callees_of is not None:
        try:
            tstart, tend = resolve_target(args.callees_of)
        except SystemExit as e:
            print(e, file=sys.stderr)
            return 2
        if tend <= tstart:
            print(f"can't enumerate calls without a known body — "
                  f"{args.callees_of} has no Range header", file=sys.stderr)
            return 2
        addrs = call_targets(tstart, tend)
        if not addrs:
            print(f"no cross-slice BLs from {args.callees_of}")
            return 0
        print(f"callees of {args.callees_of}: " +
              ", ".join(f"0x{a:08x}" for a in addrs))

    if args.addr is not None:
        addrs.append(args.addr)

    # Filter out already-peeled targets.
    peeled = existing_disasm_starts()
    pending = [a for a in addrs if a not in peeled]
    already = [a for a in addrs if a in peeled]
    if already:
        print(f"already peeled (skip): " + ", ".join(f"0x{a:08x}" for a in already))
    if not pending:
        return 0

    failures = 0
    for a in pending:
        if not peel_address(a, dry_run=not args.apply):
            failures += 1
            # Don't continue once a peel has broken the build.
            if args.apply:
                break

    return 0 if failures == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
