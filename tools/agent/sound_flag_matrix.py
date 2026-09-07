#!/usr/bin/env python3
"""Try compiler/flag variants for the remaining sound NON_MATCHING bodies.

The script compiles the existing readable C bodies with NON_MATCHING enabled
into temporary objects, then compares each target function against its baserom
slice. It does not edit the source tree.
"""

from __future__ import annotations

import argparse
import csv
import difflib
import os
import re
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
sys.path.insert(0, str(ROOT / "tools" / "agent"))

from compile_and_view_assembly import baserom_addr, find_in_map  # noqa: E402

ROM_BASE = 0x08000000
OBJDUMP = "arm-none-eabi-objdump"
AS = "arm-none-eabi-as"

TARGETS = {
    "sub_0802E5D8": "src/system/sound_pitch.c",
    "sub_0802E934": "src/system/sound_envelope_dual.c",
    "sub_0802EC7C": "src/system/sound_channel_envelope_a.c",
    "sub_0802EDF0": "src/system/sound_channel_stream.c",
    "sub_0802F054": "src/system/sound_envelope_slide.c",
    "sub_0802F2FC": "src/system/sound_pan.c",
    "sub_0802F4B0": "src/system/sound_mixer.c",
    "sub_080301C4": "src/system/sound_period.c",
    "sub_080325B0": "src/system/sound_mixer_tail.c",
    "sub_08032904": "src/system/sound_channel_state.c",
}

REMAINING_NONMATCHING = (
    "sub_0802E5D8",
    "sub_0802E934",
    "sub_0802EC7C",
    "sub_0802EDF0",
    "sub_0802F054",
    "sub_0802F4B0",
    "sub_080325B0",
    "sub_08032904",
)

VARIANTS = [
    ("O2", ["-O2"]),
    ("O1", ["-O1"]),
    ("O2_force_addr", ["-O2", "-fforce-addr"]),
    ("O2_no_gcse", ["-O2", "-fno-gcse"]),
    ("O2_no_strength", ["-O2", "-fno-strength-reduce"]),
    ("O2_no_expensive", ["-O2", "-fno-expensive-optimizations"]),
    ("O2_force_no_gcse", ["-O2", "-fforce-addr", "-fno-gcse"]),
    ("O2_force_no_gcse_no_cse_follow", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-cse-follow-jumps"]),
    ("O2_force_no_expensive", ["-O2", "-fforce-addr", "-fno-expensive-optimizations"]),
    ("O2_no_gcse_no_expensive", ["-O2", "-fno-gcse", "-fno-expensive-optimizations"]),
    (
        "O2_force_no_gcse_no_expensive",
        ["-O2", "-fforce-addr", "-fno-gcse", "-fno-expensive-optimizations"],
    ),
    ("O2_no_rerun_cse", ["-O2", "-fno-rerun-cse-after-loop"]),
]

DIAGNOSTIC_VARIANTS = [
    ("O2_fixed_r3", ["-O2", "-ffixed-r3"]),
    ("O2_force_no_gcse_caller_saves", ["-O2", "-fforce-addr", "-fno-gcse", "-fcaller-saves"]),
    ("O2_no_caller_saves", ["-O2", "-fno-caller-saves"]),
    ("O2_no_defer_pop", ["-O2", "-fno-defer-pop"]),
    ("O2_no_inline", ["-O2", "-fno-inline"]),
    ("O2_no_omit_frame_pointer", ["-O2", "-fno-omit-frame-pointer"]),
    ("O2_volatile", ["-O2", "-fvolatile"]),
    ("O2_force_no_gcse_no_caller_saves", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-caller-saves"]),
    ("O2_force_no_gcse_no_defer_pop", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-defer-pop"]),
    ("O2_force_no_gcse_no_inline", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-inline"]),
    ("O2_force_no_gcse_regmove", ["-O2", "-fforce-addr", "-fno-gcse", "-fregmove"]),
    ("O2_force_no_gcse_opt_regmove", ["-O2", "-fforce-addr", "-fno-gcse", "-foptimize-register-move"]),
    ("O2_force_no_gcse_force_mem", ["-O2", "-fforce-addr", "-fno-gcse", "-fforce-mem"]),
    ("O2_force_no_gcse_long_calls", ["-O2", "-fforce-addr", "-fno-gcse", "-mlong-calls"]),
    ("O2_force_no_gcse_no_builtin", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-builtin"]),
    ("O2_force_no_gcse_argument_alias", ["-O2", "-fforce-addr", "-fno-gcse", "-fargument-alias"]),
    ("O2_no_peephole", ["-O2", "-fno-peephole"]),
    ("O2_force_no_gcse_no_peephole", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-peephole"]),
    ("O2_no_function_cse", ["-O2", "-fno-function-cse"]),
    ("O2_force_no_gcse_no_function_cse", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-function-cse"]),
    ("O2_no_thread_jumps", ["-O2", "-fno-thread-jumps"]),
    ("O2_force_no_gcse_no_thread_jumps", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-thread-jumps"]),
    ("O2_no_branch_count", ["-O2", "-fno-branch-count-reg"]),
    ("O2_force_no_gcse_no_branch_count", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-branch-count-reg"]),
    ("O2_no_cse_skip", ["-O2", "-fno-cse-skip-blocks"]),
    ("O2_force_no_gcse_no_cse_skip", ["-O2", "-fforce-addr", "-fno-gcse", "-fno-cse-skip-blocks"]),
    (
        "O2_force_no_gcse_no_exp_no_peephole",
        ["-O2", "-fforce-addr", "-fno-gcse", "-fno-expensive-optimizations", "-fno-peephole"],
    ),
]


@dataclass
class Disasm:
    bytes_: bytes
    lines: list[str]


def run(cmd: list[str], *, input_text: str | None = None) -> subprocess.CompletedProcess:
    return subprocess.run(
        cmd,
        input=input_text,
        text=True,
        capture_output=True,
        cwd=ROOT,
    )


def tool_path(name: str) -> str:
    p = ROOT / "tools" / "agbcc" / "bin" / name
    if p.exists():
        return str(p)
    return name


def cpp_path() -> str:
    proc = run(["sh", "tools/find_cpp.sh"])
    return proc.stdout.strip() or "cpp"


def preprocess(source: Path) -> str:
    preproc = ROOT / "tools" / "preproc" / "preproc"
    proc = run([str(preproc), str(source), "charmap.txt"])
    if proc.returncode != 0:
        raise RuntimeError(proc.stderr + proc.stdout)
    return proc.stdout


def compile_obj(source: Path, compiler: str, opt_flags: list[str], tmpdir: Path, symbol: str) -> tuple[Path | None, str]:
    cpp = run(
        [cpp_path(), "-P", "-nostdinc", "-Iinclude/", f"-DNON_MATCHING_{symbol}"],
        input_text=preprocess(source),
    )
    if cpp.returncode != 0:
        return None, cpp.stderr + cpp.stdout

    out_s = tmpdir / f"{source.stem}.{compiler}.{'.'.join(opt_flags).replace('-', '')}.s"
    out_o = out_s.with_suffix(".o")
    cc_flags = ["-Werror", *opt_flags, "-mthumb-interwork", "-fhex-asm"]
    cc = run([tool_path(compiler), "-o", str(out_s), *cc_flags], input_text=cpp.stdout)
    if cc.returncode != 0:
        return None, cc.stderr + cc.stdout

    with out_s.open("a") as f:
        f.write("\t.align 2, 0 @ dont insert nops\n")

    assembled = run([AS, "-mcpu=arm7tdmi", str(out_s), "-o", str(out_o)])
    if assembled.returncode != 0:
        return None, assembled.stderr + assembled.stdout
    return out_o, ""


OBJ_LINE_RE = re.compile(r"^\s*([0-9a-f]+):\s+([0-9a-f ]+?)\s+(\S+)(?:\s+(.*?))?\s*$")
OBJ_LABEL_RE = re.compile(r"^[0-9a-f]+ <([^>]+)>:")


def parse_instruction(line: str) -> tuple[bytes, str] | None:
    m = OBJ_LINE_RE.match(line)
    if not m:
        return None
    byte_text = "".join(m.group(2).split())
    if len(byte_text) % 2 != 0:
        return None
    try:
        encoded = bytes.fromhex(byte_text)
    except ValueError:
        return None
    mnem = m.group(3)
    if mnem.startswith("."):
        return None
    args = (m.group(4) or "").split(";")[0].strip()
    return encoded, f"{mnem} {args}".rstrip()


def object_disasm(obj: Path, symbol: str) -> Disasm | None:
    proc = run([OBJDUMP, "-dr", str(obj)])
    if proc.returncode != 0:
        return None

    in_symbol = False
    data = bytearray()
    lines: list[str] = []
    for line in proc.stdout.splitlines():
        label = OBJ_LABEL_RE.match(line)
        if label:
            if in_symbol:
                break
            in_symbol = label.group(1) == symbol
            continue
        if not in_symbol:
            continue
        parsed = parse_instruction(line)
        if parsed is None:
            continue
        encoded, insn = parsed
        data.extend(encoded)
        lines.append(insn)
    if not lines:
        return None
    return Disasm(bytes(data), lines)


def baserom_disasm(symbol: str) -> Disasm | None:
    addr = baserom_addr(symbol)
    mapped = find_in_map(symbol)
    if addr is None or mapped is None:
        return None
    size = mapped[1]
    off = addr - ROM_BASE
    proc = run(
        [
            OBJDUMP,
            "-D",
            "-b",
            "binary",
            "-m",
            "arm7tdmi",
            "-Mforce-thumb",
            f"--start-address={off}",
            f"--stop-address={off + size}",
            "frog_us_baserom.gba",
        ]
    )
    if proc.returncode != 0:
        return None

    data = bytearray()
    lines: list[str] = []
    for line in proc.stdout.splitlines():
        parsed = parse_instruction(line)
        if parsed is None:
            continue
        encoded, insn = parsed
        data.extend(encoded)
        lines.append(insn)
    return Disasm(bytes(data), lines)


def byte_diff(a: bytes, b: bytes) -> int:
    n = min(len(a), len(b))
    return sum(1 for i in range(n) if a[i] != b[i]) + abs(len(a) - len(b))


def insn_diff(a: list[str], b: list[str]) -> int:
    sm = difflib.SequenceMatcher(a=a, b=b, autojunk=False)
    return sum(max(i2 - i1, j2 - j1) for tag, i1, i2, j1, j2 in sm.get_opcodes() if tag != "equal")


def first_mismatch(a: list[str], b: list[str]) -> str:
    sm = difflib.SequenceMatcher(a=a, b=b, autojunk=False)
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == "equal":
            continue
        lhs = a[i1] if i1 < len(a) else ""
        rhs = b[j1] if j1 < len(b) else ""
        return f"{lhs} -> {rhs}"
    return ""


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("functions", nargs="*")
    ap.add_argument("--csv", type=Path, help="Write full matrix to CSV")
    ap.add_argument("--diagnostic", action="store_true", help="Include slower compiler-behavior probe variants")
    ap.add_argument("--prefer-exact-size", action="store_true", help="Sort matching-size rows before smaller byte diffs")
    ap.add_argument("--remaining", action="store_true", help="Only test remaining sound NON_MATCHING targets")
    ap.add_argument("--top", type=int, default=3, help="Rows to print per function")
    args = ap.parse_args()
    if args.remaining:
        if args.functions:
            unknown = sorted(set(args.functions) - set(REMAINING_NONMATCHING))
            if unknown:
                ap.error("--remaining target is already matching or unknown: " + ", ".join(unknown))
        else:
            args.functions = list(REMAINING_NONMATCHING)
    elif not args.functions:
        args.functions = sorted(TARGETS)
    variants = VARIANTS + (DIAGNOSTIC_VARIANTS if args.diagnostic else [])

    expected = {fn: baserom_disasm(fn) for fn in args.functions}
    rows: list[dict[str, str | int]] = []

    with tempfile.TemporaryDirectory(prefix="frog-sound-matrix-") as td:
        tmpdir = Path(td)
        obj_cache: dict[tuple[str, str, str], tuple[Path | None, str]] = {}
        for fn in args.functions:
            source = ROOT / TARGETS[fn]
            if expected[fn] is None:
                rows.append({"function": fn, "status": "missing_expected"})
                continue
            for compiler in ("old_agbcc", "agbcc"):
                for variant, flags in variants:
                    key = (fn, str(source), compiler, variant)
                    if key not in obj_cache:
                        obj_cache[key] = compile_obj(source, compiler, flags, tmpdir, fn)
                    obj, err = obj_cache[key]
                    if obj is None:
                        rows.append(
                            {
                                "function": fn,
                                "source": str(source.relative_to(ROOT)),
                                "compiler": compiler,
                                "variant": variant,
                                "status": "compile_failed",
                                "error": " ".join(err.split())[:180],
                            }
                        )
                        continue
                    built = object_disasm(obj, fn)
                    if built is None:
                        rows.append(
                            {
                                "function": fn,
                                "source": str(source.relative_to(ROOT)),
                                "compiler": compiler,
                                "variant": variant,
                                "status": "missing_symbol",
                            }
                        )
                        continue
                    exp = expected[fn]
                    assert exp is not None
                    rows.append(
                        {
                            "function": fn,
                            "source": str(source.relative_to(ROOT)),
                            "compiler": compiler,
                            "variant": variant,
                            "status": "ok",
                            "byte_diff": byte_diff(exp.bytes_, built.bytes_),
                            "insn_diff": insn_diff(exp.lines, built.lines),
                            "expected_bytes": len(exp.bytes_),
                            "built_bytes": len(built.bytes_),
                            "first_mismatch": first_mismatch(exp.lines, built.lines),
                        }
                    )

    if args.csv:
        fieldnames = [
            "function",
            "source",
            "compiler",
            "variant",
            "status",
            "byte_diff",
            "insn_diff",
            "expected_bytes",
            "built_bytes",
            "first_mismatch",
            "error",
        ]
        with args.csv.open("w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
            writer.writeheader()
            writer.writerows(rows)

    for fn in args.functions:
        ok_rows = [r for r in rows if r.get("function") == fn and r.get("status") == "ok"]
        if args.prefer_exact_size:
            ok_rows.sort(
                key=lambda r: (
                    int(r["built_bytes"]) != int(r["expected_bytes"]),
                    int(r["byte_diff"]),
                    int(r["insn_diff"]),
                    str(r["compiler"]),
                    str(r["variant"]),
                )
            )
        else:
            ok_rows.sort(key=lambda r: (int(r["byte_diff"]), int(r["insn_diff"]), str(r["compiler"]), str(r["variant"])))
        print(fn)
        if not ok_rows:
            failures = [r for r in rows if r.get("function") == fn][:3]
            for row in failures:
                print(f"  {row.get('status')}: {row.get('error', '')}")
            continue
        for row in ok_rows[: args.top]:
            print(
                "  {compiler:10s} {variant:28s} byte_diff={byte_diff:4d} "
                "insn_diff={insn_diff:4d} size={built_bytes}/{expected_bytes} first={first_mismatch}".format(**row)
            )

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
