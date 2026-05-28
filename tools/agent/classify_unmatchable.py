#!/usr/bin/env python3
"""classify_unmatchable.py — deterministic up-front triage for the decomp loop.

Given a function (by name or address), disassemble its bytes straight from the
baserom (ground truth — independent of whether it's been decompiled yet) and look
for STRONG, near-zero-false-positive signatures that agbcc 2.x provably cannot
reproduce from pure C. The point is to let the decomp agent skip the match grind
on the clearly-unmatchable functions WITHOUT ever falsely condemning a function
that was matchable.

Design contract (matters — read before tuning):
  * Two-sided error costs are ASYMMETRIC. A false "STRONG_UNMATCHABLE" leads to a
    NAKED ship that is a permanent regression. A false "ATTEMPT_MATCH" only costs a
    wasted match attempt. So this tool is deliberately CONSERVATIVE: it stays SILENT
    (verdict ATTEMPT_MATCH) on anything fuzzy and only flags signatures with a
    validated near-zero false-positive rate.
  * It does NOT replace the corpus check. The agent still corpus-confirms a STRONG
    verdict before shipping NAKED. This tool removes LLM variance from the cheap
    structural part of the decision; the corpus confirms the empirical part.

Signatures flagged STRONG_UNMATCHABLE:
  class4-movpc  : `mov pc, rN` (computed jump / inline jump table). agbcc cannot
                  emit this from C at all.
  class1-hireg  : a value loaded into a callee-saved HIGH register (r8/r9/sl/fp)
                  and read back AFTER an intervening `bl` — agbcc 2.x will not
                  promote a local/pointer into a high reg across a call.
  class3-libgcc : a WIDE prologue (`push {…, r4, r5, r6, r7, lr}`) whose every `bl`
                  target is a libgcc helper. agbcc emits a narrower prologue because
                  it knows libgcc helpers preserve r4-r7. (Narrow prologues do NOT
                  qualify — that is the sub_0800A214 false-alarm guard.)

Everything else → ATTEMPT_MATCH.

Usage:
  python3 tools/agent/classify_unmatchable.py sub_0800B7B0
  python3 tools/agent/classify_unmatchable.py 0x0800b7b0
  python3 tools/agent/classify_unmatchable.py sub_0800B7B0 --json
  python3 tools/agent/classify_unmatchable.py --selftest        # validate vs known cases
"""
import argparse
import json
import os
import re
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
ADDR_JSON = REPO / "tools" / "agent" / ".function_addresses.json"
ROM_BASE = 0x08000000
OBJDUMP = os.environ.get("OBJDUMP", "arm-none-eabi-objdump")

# High callee-saved registers agbcc 2.x will not promote a value into across a call.
# (ip/r12 is caller-saved scratch and agbcc DOES use it transiently → excluded to
#  avoid false positives.)
HIGH_REGS = {"r8", "r9", "sl", "fp"}
# Thumb return / terminator mnemonics — we stop scanning for signals after the LAST
# of these, so a trailing literal pool misdecoded by objdump can't create a false hit.
TERMINATORS = ("pop", "bx ", "mov pc, lr")


def _baserom_path() -> Path:
    for cand in ("frog_us_baserom.gba", "baserom.gba"):
        p = REPO / cand
        if p.exists():
            return p
    sys.exit("error: baserom not found (expected frog_us_baserom.gba or baserom.gba)")


def _load_addrs() -> dict:
    if not ADDR_JSON.exists():
        sys.exit(f"error: {ADDR_JSON} not found — run tools/agent/snapshot_addresses.py")
    return json.load(open(ADDR_JSON))["addresses"]


def _resolve(target: str, addrs: dict):
    """Return (name, start_addr). Accepts a symbol name or a 0x address."""
    if target.lower().startswith("0x") or re.fullmatch(r"[0-9a-fA-F]{6,8}", target):
        start = int(target, 16)
        name = next((n for n, a in addrs.items() if a == start), f"sub_{start:08X}")
        return name, start
    if target in addrs:
        return target, addrs[target]
    # case-insensitive fallback (pick_target prints names like sub_0800B7B0)
    low = {n.lower(): n for n in addrs}
    if target.lower() in low:
        n = low[target.lower()]
        return n, addrs[n]
    sys.exit(f"error: unknown function '{target}' (not in {ADDR_JSON.name})")


def _next_addr(start: int, addrs: dict) -> int:
    later = sorted(a for a in addrs.values() if a > start)
    return later[0] if later else start + 0x400  # fallback window


def _is_libgcc(name: str) -> bool:
    return name.startswith("__") or name.startswith("_call_via_")


def _disasm(start: int, end: int) -> list:
    """Disassemble [start, end) of the baserom as Thumb. Returns list of
    (addr:int, mnemonic_text:str)."""
    rom = _baserom_path().read_bytes()
    off = start - ROM_BASE
    blob = rom[off : end - ROM_BASE]
    tmp = REPO / f".classify_tmp_{start:08x}.bin"
    tmp.write_bytes(blob)
    try:
        out = subprocess.run(
            [OBJDUMP, "-D", "-b", "binary", "-m", "arm7tdmi", "-Mforce-thumb", str(tmp)],
            capture_output=True, text=True, check=True,
        ).stdout
    finally:
        tmp.unlink(missing_ok=True)
    insns = []
    for line in out.splitlines():
        m = re.match(r"\s*([0-9a-f]+):\s+[0-9a-f ]+\t(.*)", line)
        if m:
            insns.append((start + int(m.group(1), 16), m.group(2).strip()))
    return insns


def _trim_to_body(insns: list) -> list:
    """Keep instructions up to and including the LAST terminator, so a trailing
    literal pool (data misdecoded as code) cannot produce a false signal."""
    last = -1
    for i, (_, txt) in enumerate(insns):
        if any(txt.startswith(t) or t in txt for t in TERMINATORS):
            last = i
    return insns[: last + 1] if last >= 0 else insns


def classify(target: str) -> dict:
    addrs = _load_addrs()
    name, start = _resolve(target, addrs)
    end = _next_addr(start, addrs)
    raw = _disasm(start, end)
    insns = _trim_to_body(raw)
    texts = [t for _, t in insns]
    evidence = []
    advisories = []
    classes = []  # ONLY structural-impossibility signatures go here → STRONG verdict

    # --- class4-movpc: computed jump / inline jump table -------------------
    for a, t in insns:
        if re.match(r"mov\s+pc,\s*(r\d+|sl|fp|ip)\b", t):
            classes.append("class4-movpc")
            evidence.append(f"{t}  @ 0x{a:08x}  (computed jump — agbcc cannot emit `mov pc,rN` from C)")
            break

    # --- class3-libgcc: WIDE r4-r7 prologue + every bl is a libgcc helper ---
    if texts:
        prologue = texts[0]
        pm = re.match(r"push\s*\{([^}]*)\}", prologue)
        if pm:
            saved = {r.strip() for r in pm.group(1).split(",")}
            wide = {"r4", "r5", "r6", "r7"}.issubset(saved)
            bl_targets = []
            all_libgcc = True
            for a, t in insns:
                mb = re.match(r"bl\s+0x([0-9a-f]+)", t)
                if mb:
                    tgt = int(mb.group(1), 16)
                    # objdump renders bl target relative to the tmp blob (base 0); the
                    # printed value is already the in-blob offset → real addr = start+off
                    real = start + tgt
                    tname = next((n for n, av in addrs.items() if av == real), None)
                    bl_targets.append(tname or f"0x{real:08x}")
                    if not (tname and _is_libgcc(tname)):
                        all_libgcc = False
            if wide and bl_targets and all_libgcc:
                classes.append("class3-libgcc")
                evidence.append(
                    f"wide prologue `{prologue}` + all {len(bl_targets)} bl target(s) are libgcc "
                    f"helpers ({', '.join(bl_targets)}) — agbcc emits a narrower prologue"
                )

    # --- class1-hireg: values pinned in HIGH regs ACROSS a bl (ADVISORY ONLY) -
    # NOT a STRONG verdict. High-reg pins are FUZZY: the `register T x asm("rN")`
    # lever matches many of them — validated counterexample sub_08004508 holds BOTH
    # r8 and r9 across a bl and still byte-matches via register pins. So we never
    # auto-NAKED on a high-reg pin; we only HINT the agent to reach for the lever
    # first and NAKED (corpus-gated) only if it fails. This is the asymmetric-cost
    # boundary: structural impossibility → STRONG; register-allocation drift → ATTEMPT.
    pinned = {}  # hr -> (write_addr, bl_addr, read_addr)
    for hr in HIGH_REGS:
        write_idx = None
        for i, (a, t) in enumerate(insns):
            if re.match(rf"(mov|movs|add|adds|sub|subs|ldr|lsl|lsls)\s+{hr}\b", t):
                write_idx = i
                continue
            if write_idx is not None and t.startswith("bl"):
                for j in range(i + 1, len(insns)):
                    tj = insns[j][1]
                    if re.search(rf"\b{hr}\b", tj) and not re.match(
                        rf"(mov|movs|ldr|add|adds|sub|subs|lsl|lsls)\s+{hr},", tj
                    ):
                        pinned[hr] = (insns[write_idx][0], insns[i][0], insns[j][0])
                        break
                if hr in pinned:
                    break
    if pinned:
        regs = ", ".join(sorted(pinned))
        advisories.append(
            f"{len(pinned)} high reg(s) ({regs}) pinned across a `bl` — POSSIBLE Class-1. "
            f"Not auto-NAKED (the register-asm lever matches some of these, e.g. sub_08004508). "
            f"ATTEMPT with `register T x asm(\"rN\")` pins; NAKED only if levers + corpus fail."
        )

    verdict = "STRONG_UNMATCHABLE" if classes else "ATTEMPT_MATCH"
    return {
        "name": name,
        "addr": f"0x{start:08x}",
        "end": f"0x{end:08x}",
        "size": end - start,
        "verdict": verdict,
        "classes": classes,
        "prologue": texts[0] if texts else "",
        "evidence": evidence,
        "advisories": advisories,
    }


# --- validation set: (name, expected_verdict) drawn from the playbook -------
# STRONG = confirmed NAKED ships; ATTEMPT = confirmed true byte-matches (incl. the
# critical libgcc-calling / look-classy false-alarm cases).
SELFTEST = [
    # STRONG = structural impossibility (mov pc, rN). agbcc cannot emit these from C.
    ("sub_0802090C", "STRONG_UNMATCHABLE"),   # class4 mov pc,r0 jump table
    ("sub_0800A580", "STRONG_UNMATCHABLE"),   # class4 mov pc + dispatch
    ("sub_08000918", "STRONG_UNMATCHABLE"),   # class4 mov pc,r0 — the mislabeled smoke-test NAKED
    ("sub_08001214", "STRONG_UNMATCHABLE"),   # class4 mov pc,r0 — the mislabeled smoke-test NAKED
    # ATTEMPT = confirmed true byte-matches (the false-positive guards).
    ("sub_0800A214", "ATTEMPT_MATCH"),        # looked class3 but prologue push {r4,r5,lr}
    ("sub_0800A540", "ATTEMPT_MATCH"),        # matched once split from dispatcher
    ("sub_0800E048", "ATTEMPT_MATCH"),        # calls __divsi3 but narrow prologue → matched
    ("sub_08004508", "ATTEMPT_MATCH"),        # holds r8+r9 across bl yet matched via register asm
    ("sub_0800D028", "ATTEMPT_MATCH"),        # AABB proximity leaf, matched
    # ATTEMPT (with advisory) = high-reg-pin NAKEDs. Deliberately NOT auto-NAKED — the
    # classifier hints "try register-asm; NAKED if it fails" but defers the verdict, since
    # high-reg pins are fuzzy (some match). The corpus-gated agent path NAKEDs them.
    ("sub_0800B7B0", "ATTEMPT_MATCH"),        # class1 r8/r9/sl pins → advisory, agent NAKEDs
    ("sub_08007874", "ATTEMPT_MATCH"),        # class1 sl/r8/r9 pins → advisory
    ("sub_08006D24", "ATTEMPT_MATCH"),        # class1 r8/r9/sl pins → advisory
    ("sub_08008F98", "ATTEMPT_MATCH"),        # class1 r8/r9/sl/ip pins → advisory
    ("sub_0800A05C", "ATTEMPT_MATCH"),        # lone r8 pin → advisory
    ("sub_08006A74", "ATTEMPT_MATCH"),        # lone r8 pin → advisory
]


def selftest() -> int:
    ok = 0
    fails = []
    for nm, want in SELFTEST:
        try:
            got = classify(nm)["verdict"]
        except SystemExit as e:
            got = f"ERROR({e})"
        mark = "✓" if got == want else "✗"
        if got == want:
            ok += 1
        else:
            fails.append((nm, want, got))
        print(f"  {mark} {nm:16s} want={want:18s} got={got}")
    print(f"\n{ok}/{len(SELFTEST)} correct.")
    if fails:
        print("FAILURES:")
        for nm, want, got in fails:
            ev = classify(nm)
            print(f"  {nm}: wanted {want}, got {got}; classes={ev['classes']}; prologue='{ev['prologue']}'")
            for e in ev["evidence"]:
                print(f"      - {e}")
    return 0 if not fails else 1


def main():
    ap = argparse.ArgumentParser(description="Deterministic up-front unmatchable triage.")
    ap.add_argument("target", nargs="?", help="function name (sub_XXXX) or 0x address")
    ap.add_argument("--json", action="store_true", help="machine-readable output")
    ap.add_argument("--selftest", action="store_true", help="validate against known cases")
    a = ap.parse_args()
    if a.selftest:
        sys.exit(selftest())
    if not a.target:
        ap.error("target required (or use --selftest)")
    r = classify(a.target)
    if a.json:
        print(json.dumps(r, indent=2))
        return
    print(f"{r['name']}  {r['addr']}..{r['end']}  ({r['size']} bytes)")
    print(f"  prologue: {r['prologue']}")
    print(f"  VERDICT:  {r['verdict']}" + (f"  [{', '.join(r['classes'])}]" if r["classes"] else ""))
    for e in r["evidence"]:
        print(f"    - {e}")
    for adv in r["advisories"]:
        print(f"    ⚐ advisory: {adv}")
    if r["verdict"] == "STRONG_UNMATCHABLE":
        print("  → corpus-confirm the idiom has no pure-C precedent, then ship NAKED+NON_MATCHING.")
    else:
        print("  → no structural-impossibility signature; ATTEMPT the C match (heed advisories if present).")


if __name__ == "__main__":
    main()
