#!/usr/bin/env python3
"""agbcc register-allocation oracle.

agbcc is gcc 2.x, which ships built-in RTL pass dumps (`-da`). No rebuild or
printf instrumentation is needed to see *why* the register allocator colours
the way it does — the `.greg` (global alloc) dump carries the allocation
priority order, the pseudo->hard-reg dispositions, and the conflict info, and
the per-pass dumps (`.rtl .jump .cse .loop .gcse .cse2 .flow .combine .regmove
.lreg .greg .mach`) let you trace a pseudo from generation through reload.

Use this when a function is structurally matched but the register *colouring*
diverges from the baserom (e.g. a loop index lands in r6 not r5, or a block
move picks {r2,r3,r7} not {r4,r6,r7}). The dispositions + sorted priority tell
you which pseudo won which register and why (refs * live_length), so you can
reshape the C to change a pseudo's priority instead of guessing.

Pseudos are anonymous in the RTL (no source names survive), so map by
structure: the defining insn of a pseudo (its first `(set (reg N) ...)`) tells
you which source value it is.

Usage:
    agbcc_oracle.py <fn> [--src src/<rel>/<fn>.c]   # dispositions + priority
    agbcc_oracle.py <fn> --pass greg                # dump one pass for the fn
    agbcc_oracle.py <fn> --trace 27                 # follow pseudo 27 across passes
    agbcc_oracle.py <fn> --keep                     # leave dumps in /tmp/agbcc-oracle
"""
from __future__ import annotations
import argparse, re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
AGBCC = ROOT / "tools/agbcc/bin/old_agbcc"
PREPROC = ROOT / "tools/preproc/preproc"
CHARMAP = ROOT / "charmap.txt"
DUMPDIR = Path("/tmp/agbcc-oracle")
PASSES = ["rtl", "jump", "cse", "loop", "gcse", "cse2", "flow", "combine",
          "regmove", "lreg", "greg", "mach", "jump2"]


def find_src(fn: str, override: str | None) -> Path:
    if override:
        return ROOT / override
    hits = list(ROOT.glob(f"src/**/{fn}.c"))
    # fall back: grep for the definition
    if not hits:
        r = subprocess.run(["grep", "-rl", rf"\b{fn}\s*(", str(ROOT / "src")],
                           capture_output=True, text=True)
        hits = [Path(p) for p in r.stdout.split() if p.endswith(".c")]
    if not hits:
        sys.exit(f"no src/*.c defines {fn} (pass --src)")
    return hits[0]


def compile_with_dumps(src: Path) -> Path:
    DUMPDIR.mkdir(exist_ok=True)
    for f in DUMPDIR.glob("pp.i*"):
        f.unlink()
    pp = DUMPDIR / "pp.i"
    p1 = subprocess.run([str(PREPROC), str(src), str(CHARMAP)],
                        capture_output=True, text=True, cwd=ROOT)
    p2 = subprocess.run(["cpp-15", "-P", "-DREGION_US", "-nostdinc", "-Iinclude/"],
                        input=p1.stdout, capture_output=True, text=True, cwd=ROOT)
    pp.write_text(p2.stdout)
    r = subprocess.run([str(AGBCC), "-o", str(DUMPDIR / "out.s"), "-O2",
                        "-mthumb-interwork", "-fhex-asm", "-da", str(pp)],
                       capture_output=True, text=True, cwd=ROOT)
    if r.returncode != 0:
        sys.exit(f"agbcc failed:\n{r.stderr}")
    return pp


def fn_section(path: Path, fn: str) -> str:
    """Return only the `;; Function <fn>` block of a dump (dumps can hold many)."""
    if not path.exists():
        return ""
    txt = path.read_text(errors="replace")
    blocks = re.split(r"\n;; Function ", txt)
    for b in blocks:
        if b.startswith(fn) or f" {fn}\n" in b[:80] or b.lstrip().startswith(fn):
            return ";; Function " + b
    return txt  # single-function dump


def cmd_summary(pp: Path, fn: str):
    greg = fn_section(Path(str(pp) + ".greg"), fn)
    if not greg:
        sys.exit("no .greg dump — did the compile succeed?")
    # sorted priority
    m = re.search(r"Registers to be allocated in sorted order:(.*?)\n\n", greg, re.S)
    print("=== allocation priority (pseudo, refs, live_length) — earlier = first pick ===")
    if m:
        for ln in m.group(1).strip().splitlines()[:24]:
            print("  " + ln.strip())
    print("\n=== register dispositions (pseudo -> hard reg; r0..r10, r13=sp) ===")
    md = re.search(r";; Register dispositions:(.*?)\n\n", greg, re.S)
    if md:
        print(md.group(1).strip())
    mh = re.search(r";; Hard regs used:.*", greg)
    if mh:
        print("\n" + mh.group(0))
    print("\nTip: map a pseudo to its source value via its defining insn:")
    print(f"     agbcc_oracle.py {fn} --trace <pseudo>")


def cmd_pass(pp: Path, fn: str, passname: str):
    sec = fn_section(Path(f"{pp}.{passname}"), fn)
    if not sec:
        sys.exit(f"no .{passname} dump (passes: {', '.join(PASSES)})")
    print(sec)


def cmd_trace(pp: Path, fn: str, pseudo: str):
    pat = re.compile(rf"\breg(?:/[vsfu]+)?:[A-Z]+ {pseudo}\b")
    for ps in PASSES:
        sec = fn_section(Path(f"{pp}.{ps}"), fn)
        if not sec:
            continue
        hits = [ln for ln in sec.splitlines() if pat.search(ln)]
        if hits:
            print(f"--- .{ps} ({len(hits)} refs) ---")
            for h in hits[:12]:
                print("  " + h.strip()[:150])


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("fn")
    ap.add_argument("--src")
    ap.add_argument("--pass", dest="passname")
    ap.add_argument("--trace")
    ap.add_argument("--keep", action="store_true")
    a = ap.parse_args()
    src = find_src(a.fn, a.src)
    pp = compile_with_dumps(src)
    if a.passname:
        cmd_pass(pp, a.fn, a.passname)
    elif a.trace:
        cmd_trace(pp, a.fn, a.trace)
    else:
        cmd_summary(pp, a.fn)
    if not a.keep:
        print(f"\n(dumps in {DUMPDIR}/pp.i.* — rerun with --pass/--trace, or --keep)")


if __name__ == "__main__":
    main()
