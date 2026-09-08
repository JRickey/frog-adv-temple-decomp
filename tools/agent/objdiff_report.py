#!/usr/bin/env python3
"""Generate the ObjDiff v2 progress report consumed by decomp.dev.

The normal report path is build-free: it reads a committed function inventory,
the linker layout, and the source tree.  `--update-inventory` is the maintainer
path; it requires a byte-identical local build and refreshes the inventory from
the ELF plus the committed baserom label map.

Progress means reconstructed source, not ROM equality:
  * ordinary C functions are 100%;
  * NAKED/NON_MATCHING fallbacks and remaining game assembly are 0%;
  * retained third-party binaries and assembly receive no C reconstruction credit;
  * data credit requires linked, explicit C initializers (not binary extraction).
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
import tomllib
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
INVENTORY = ROOT / "config" / "decompdev_functions.us.tsv"
LABELS = ROOT / "frog_us_baserom.labels.toml"
LINKER = ROOT / "linker.ld"
BASEROM = ROOT / "frog_us_baserom.gba"
BUILT_ROM = ROOT / "frog_us.gba"
ELF = ROOT / "frog_us.elf"
LAYOUT = ROOT / "config" / "decompdev_layout.us.json"
MAP = ROOT / "frog_us.map"
EXPECTED_SHA1 = "7b4c27009198df18555e63fb5dcad223eaf09815"
# Rebuilt pret/agbcc da598c1d918402c42c0c0d7128ba14567f3175e9 archive.
# See docs/decompdev.md for provenance; this is not a binary-blob exemption.
EXPECTED_LIBGCC_SHA256 = "5086cf015e316b4dcef8952305e2e6364d835bd9a11e7328db13027359635ef9"
DATA_START = 0x08035D9C
ROM_END = 0x08400000

ROM_BASE = 0x08000000
CODE_END = 0x08036000
REPORT_VERSION = 2

ASM_FUNCTION_RE = re.compile(r"^\s*(?:thumb_func_start|arm_func_start)\s+(\w+)", re.M)
IDENT_CALL_RE = re.compile(r"\b([A-Za-z_]\w*)\s*\(")
NAKED_FUNCTION_RE = re.compile(
    r"\bNAKED\b\s+(?:[A-Za-z_]\w*[\s*]+)+([A-Za-z_]\w*)\s*\([^;{}]*\)\s*\{",
    re.S,
)
COMMENT_RE = re.compile(r"/\*.*?\*/|//[^\n]*", re.S)


@dataclass(frozen=True)
class Function:
    address: int
    size: int
    name: str


@dataclass(frozen=True)
class LinkUnit:
    address: int
    order: int
    object_path: str


def _sha1(path: Path) -> str:
    digest = hashlib.sha1()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 16), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _percent(part: int, total: int) -> float:
    return part / total * 100.0 if total else 100.0


def _measures(total_code: int, matched_code: int, total_functions: int,
              matched_functions: int, total_units: int = 1,
              total_data: int = 0, matched_data: int = 0,
              complete_code: int | None = None, complete_units: int = 0) -> dict:
    if complete_code is None:
        complete_code = matched_code
    return {
        "fuzzy_match_percent": _percent(matched_code + matched_data, total_code + total_data),
        "total_code": str(total_code),
        "matched_code": str(matched_code),
        "matched_code_percent": _percent(matched_code, total_code),
        "total_data": str(total_data),
        "matched_data": str(matched_data),
        "matched_data_percent": _percent(matched_data, total_data),
        "total_functions": total_functions,
        "matched_functions": matched_functions,
        "matched_functions_percent": _percent(matched_functions, total_functions),
        "complete_code": str(complete_code),
        "complete_code_percent": _percent(complete_code, total_code),
        "complete_data": str(matched_data),
        "complete_data_percent": _percent(matched_data, total_data),
        "total_units": total_units,
        "complete_units": complete_units,
    }


def load_inventory(path: Path = INVENTORY) -> list[Function]:
    functions: list[Function] = []
    seen_addresses: set[int] = set()
    for line_no, line in enumerate(path.read_text().splitlines(), 1):
        if not line or line.startswith("#"):
            continue
        fields = line.split("\t")
        if len(fields) != 3:
            raise ValueError(f"{path}:{line_no}: expected address<TAB>size<TAB>name")
        address, size, name = int(fields[0], 0), int(fields[1], 0), fields[2]
        if address in seen_addresses:
            raise ValueError(f"{path}:{line_no}: duplicate address {address:#010x}")
        if not (ROM_BASE <= address < CODE_END) or size <= 0 or address + size > CODE_END:
            raise ValueError(f"{path}:{line_no}: invalid function range")
        seen_addresses.add(address)
        functions.append(Function(address, size, name))
    functions.sort(key=lambda function: function.address)
    return functions


def load_layout() -> dict:
    layout = json.loads(LAYOUT.read_text())
    for name, digest in layout["source_sha256"].items():
        path = ROOT / name
        if not path.exists() or hashlib.sha256(path.read_bytes()).hexdigest() != digest:
            raise ValueError(f"stale decomp.dev snapshot: {name}; rebuild, make check, "
                             "then --update-inventory")
    return layout


def parse_map_sections(text: str) -> list[dict]:
    """Read actual input extents, including split lines and archive members."""
    pattern = re.compile(r"^ (\.[\w.]+)\s+\n?\s*(0x[\da-f]+)\s+"
                         r"(0x[\da-f]+)\s+(\S+\.o(?:\))?)$", re.M)
    sections = []
    for match in pattern.finditer(text):
        name, address, size, obj = match.groups()
        address, size = int(address, 16), int(size, 16)
        if size and ROM_BASE <= address < ROM_END:
            sections.append(dict(name=name, address=address, size=size, object=obj))
    sections.sort(key=lambda section: section["address"])
    for left, right in zip(sections, sections[1:]):
        if left["address"] + left["size"] > right["address"]:
            raise ValueError("overlapping linked input sections")
    if not sections:
        raise ValueError("no linked ROM input sections found")
    return sections


def _source_path(object_path: str) -> str | None:
    if object_path.startswith("*") or ".a:" in object_path or ".a(" in object_path:
        return None
    base = object_path[:-2]
    for suffix in (".c", ".s"):
        candidate = ROOT / f"{base}{suffix}"
        if candidate.exists():
            return str(candidate.relative_to(ROOT))
    return None


def _strip_comments(text: str) -> str:
    return COMMENT_RE.sub("", text)


def naked_function_names() -> set[str]:
    names: set[str] = set()
    for base in (ROOT / "src", ROOT / "lib"):
        for path in base.rglob("*.c"):
            text = _strip_comments(path.read_text(errors="replace"))
            names.update(NAKED_FUNCTION_RE.findall(text))
    return names


def _category(object_path: str) -> tuple[str, str]:
    if object_path.startswith("lib/gax/"):
        return "gax", "GAX sound library"
    if "libgcc.a" in object_path:
        return "libgcc", "Compiler support (libgcc; reproduced dependency)"
    if object_path == "asm/libagbsyscall.o":
        return "sdk", "GBA BIOS call wrappers"
    # Directory placement still reflects historical peeling, not semantics.
    # In particular src/system contains scenes, attract input and game audio.
    if object_path in {
            "asm/disasm_0x08000000.o",
            "asm/disasm_0x080000c0.o",
            "asm/disasm_0x080000fc.o",
            "asm/system/intr_disable.o",
            "asm/system/intr_main.o",
            "asm/system/sub_08000240.o",
            "src/system/vblank.o",
        }:
        return "runtime", "Startup, interrupts and VBlank support"
    return "game", "Game code"


def _is_matched(object_path: str, function_name: str, naked: set[str]) -> bool:
    source = _source_path(object_path)
    if not source or not source.endswith(".c") or function_name in naked:
        return False
    text = _strip_comments((ROOT / source).read_text())
    # Fail closed for conditional fallback implementations and inline assembly.
    if re.search(r"\bNON_MATCHING\b", text):
        return False
    definition = re.search(r"\b" + re.escape(function_name) + r"\s*\([^;{}]*\)\s*\{", text)
    if not definition:
        return False
    depth, end = 1, definition.end()
    while depth and end < len(text):
        depth += (text[end] == "{") - (text[end] == "}")
        end += 1
    body = text[definition.end():end]
    # Register allocation constraints are existing matching C, not instruction
    # replacement. Keep the separate pin census responsible for their quality.
    body = re.sub(r'\bregister\b[^;{}]*?\b(?:asm|__asm__)\s*\("(?:r\d+|sl|fp|ip)"\)',
                  "", body)
    return not re.search(r"\b(?:INCBIN|asm|__asm__)\b", body)


def build_report(inventory_path: Path = INVENTORY) -> dict:
    functions = load_inventory(inventory_path)
    layout = load_layout()
    naked = naked_function_names()
    report_units: list[dict] = []
    category_names: dict[str, str] = {}
    assigned: set[int] = set()

    for section in layout["sections"]:
        unit = LinkUnit(section["address"], 0, section["object"])
        end = unit.address + section["size"]
        unit_functions = [
            function for function in functions
            if unit.address <= function.address < end
        ]
        for function in unit_functions:
            if function.address + function.size > end:
                raise ValueError(f"{function.name} extends past linked owner {unit.object_path}")
        data_size = max(0, end - max(unit.address, DATA_START))
        if not unit_functions and not data_size:
            continue
        category_id, category_name = _category(unit.object_path)
        category_names[category_id] = category_name
        matched = [
            function for function in unit_functions
            if _is_matched(unit.object_path, function.name, naked)
        ]
        total_code = sum(function.size for function in unit_functions)
        matched_code = sum(function.size for function in matched)
        matched_addresses = {function.address for function in matched}
        dependency_complete = (
            category_id == "libgcc"
            and layout.get("libgcc_sha256") == EXPECTED_LIBGCC_SHA256
        )
        matched_data = section.get("matched_data", 0)
        if matched_data > data_size:
            raise ValueError(f"data credit exceeds section size: {unit.object_path}")
        assigned.update(function.address for function in unit_functions)
        report_units.append({
            "name": unit.object_path,
            "measures": _measures(
                total_code, matched_code, len(unit_functions), len(matched),
                total_data=data_size, matched_data=matched_data,
                complete_code=total_code if dependency_complete else matched_code,
                complete_units=int(dependency_complete),
            ),
            "sections": [{"name": section["name"], "size": str(data_size),
                          "fuzzy_match_percent": _percent(matched_data, data_size),
                          "address": "0", "metadata": {
                              "virtual_address": str(unit.address)}}] if data_size else [],
            "functions": [
                {
                    "name": function.name,
                    "size": str(function.size),
                    "fuzzy_match_percent": (
                        100.0 if function.address in matched_addresses else 0.0
                    ),
                    "metadata": {
                        "virtual_address": str(function.address),
                    },
                    "address": str(function.address - unit.address),
                }
                for function in unit_functions
            ],
            "metadata": {
                "complete": dependency_complete,
                "source_path": _source_path(unit.object_path),
                "progress_categories": [category_id],
            },
        })

    missing = [function for function in functions if function.address not in assigned]
    if missing:
        detail = ", ".join(f"{fn.name}@{fn.address:#010x}" for fn in missing[:8])
        raise ValueError(f"function inventory entries are not covered by linker units: {detail}")

    def sum_measures(units: list[dict]) -> dict:
        total_code = sum(int(unit["measures"]["total_code"]) for unit in units)
        matched_code = sum(int(unit["measures"]["matched_code"]) for unit in units)
        total_functions = sum(unit["measures"]["total_functions"] for unit in units)
        matched_functions = sum(unit["measures"]["matched_functions"] for unit in units)
        return _measures(
            total_code, matched_code, total_functions, matched_functions, len(units),
            sum(int(unit["measures"]["total_data"]) for unit in units),
            sum(int(unit["measures"]["matched_data"]) for unit in units),
            complete_code=sum(int(unit["measures"]["complete_code"]) for unit in units),
            complete_units=sum(unit["measures"]["complete_units"] for unit in units),
        )

    categories = []
    for category_id, category_name in category_names.items():
        members = [
            unit for unit in report_units
            if category_id in unit["metadata"]["progress_categories"]
        ]
        categories.append({
            "id": category_id,
            "name": category_name,
            "measures": sum_measures(members),
        })
    return {
        "measures": sum_measures(report_units),
        "units": report_units,
        "version": REPORT_VERSION,
        "categories": categories,
    }


def _source_identifiers() -> set[str]:
    names: set[str] = set()
    for pattern in ("src/**/*.c", "lib/**/*.c", "asm/**/*.s", "lib/**/*.s"):
        for path in ROOT.glob(pattern):
            text = _strip_comments(path.read_text(errors="replace"))
            names.update(IDENT_CALL_RE.findall(text))
            names.update(ASM_FUNCTION_RE.findall(text))
    return names


def _nm_functions(names: set[str]) -> dict[int, Function]:
    result = subprocess.run(
        ["arm-none-eabi-nm", "-S", "--defined-only", str(ELF)],
        check=True,
        capture_output=True,
        text=True,
    )
    functions: dict[int, Function] = {}
    for line in result.stdout.splitlines():
        fields = line.split()
        if len(fields) != 4 or fields[2] not in {"T", "t", "W", "w"}:
            continue
        address, size, name = int(fields[0], 16), int(fields[1], 16), fields[3]
        if name in names and ROM_BASE <= address < CODE_END and size > 0:
            functions[address] = Function(address, size, name)
    return functions


def update_inventory(path: Path = INVENTORY) -> None:
    for required in (BASEROM, BUILT_ROM, ELF, MAP):
        if not required.exists():
            raise ValueError(f"missing {required.name}; run `make` first")
    if _sha1(BASEROM) != EXPECTED_SHA1 or _sha1(BUILT_ROM) != EXPECTED_SHA1:
        raise ValueError("built ROM does not match baserom; refusing to refresh inventory")

    label_data = tomllib.loads(LABELS.read_text())["functions"]
    source_names = _source_identifiers()
    label_names = {record["name"] for record in label_data}
    nm_functions = _nm_functions(source_names | label_names)
    records: dict[int, Function] = {}
    ordered_labels = sorted(label_data, key=lambda record: record["address"])
    for index, record in enumerate(ordered_labels):
        address = record["address"]
        next_address = (
            ordered_labels[index + 1]["address"]
            if index + 1 < len(ordered_labels)
            else CODE_END
        )
        end = record.get("end", next_address)
        records[address] = Function(address, end - address, record["name"])
    records.update(nm_functions)
    # Historical label ends can span functions peeled since the label export.
    # Clip only these fallback extents against current function/section starts.
    sections = parse_map_sections(MAP.read_text())
    ordered = sorted(records)
    for index, address in enumerate(ordered):
        if address in nm_functions:
            continue
        function = records[address]
        owner = next((section for section in sections
                      if section["address"] <= address < section["address"] + section["size"]), None)
        if owner is None:
            raise ValueError(f"no linked owner for {function.name}")
        end = min(address + function.size, owner["address"] + owner["size"],
                  ordered[index + 1] if index + 1 < len(ordered) else DATA_START)
        records[address] = Function(address, end - address, function.name)

    output = [
        "# Generated by tools/agent/objdiff_report.py --update-inventory.",
        "# address\tsize\tname",
    ]
    for function in sorted(records.values(), key=lambda item: item.address):
        output.append(f"{function.address:#010x}\t{function.size:#x}\t{function.name}")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(output) + "\n")
    update_layout(path)
    print(f"wrote {len(records)} functions to {path.relative_to(ROOT)}")


def explicit_data_names(text: str) -> set[str]:
    """Only credit C initializer definitions; INCBIN arrays are extraction."""
    text = _strip_comments(text)
    return set(re.findall(r"\b(\w+)\s*(?:\[[^;{}]*?\]\s*)*=\s*\{", text))


def update_layout(inventory_path: Path) -> None:
    sections = parse_map_sections(MAP.read_text())
    archive_paths = {section["object"].split("(")[0] for section in sections
                     if "libgcc.a(" in section["object"]}
    library_verified = bool(archive_paths) and all(
        hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == EXPECTED_LIBGCC_SHA256
        for path in archive_paths
    )
    result = subprocess.run(["arm-none-eabi-objdump", "-t", str(ELF)],
                            check=True, capture_output=True, text=True)
    symbols = []
    for line in result.stdout.splitlines():
        match = re.match(r"^([\da-f]{8})\s+\w*\s+O\s+\S+\s+([\da-f]+)\s+(\w+)$", line)
        if match:
            address, size, name = match.groups()
            symbols.append((int(address, 16), int(size, 16), name))
    inputs = {LINKER, ROOT / "Makefile", inventory_path}
    inputs.update((ROOT / "include").rglob("*.h"))
    for section in sections:
        source = _source_path(section["object"])
        if source:
            inputs.add(ROOT / source)
        names = explicit_data_names((ROOT / source).read_text()) if source and source.endswith(".c") else set()
        start, end = max(DATA_START, section["address"]), section["address"] + section["size"]
        credited = []
        for address, size, name in symbols:
            if name in names and start <= address < end and address + size <= end:
                credited.append((address, address + size))
        # Union symbol ranges: aliases must never receive duplicate credit.
        cursor, total = start, 0
        for left, right in sorted(credited):
            total += max(0, right - max(left, cursor))
            cursor = max(cursor, right)
        section["matched_data"] = total
    stale = [str(p.relative_to(ROOT)) for p in inputs
             if p != inventory_path and p.stat().st_mtime > ELF.stat().st_mtime]
    if stale:
        raise ValueError(f"build is older than source inputs: {', '.join(stale[:8])}; rebuild first")
    snapshot = {"version": 1, "rom_sha1": EXPECTED_SHA1,
                "libgcc_sha256": EXPECTED_LIBGCC_SHA256 if library_verified else None,
                "elf_sha256": hashlib.sha256(ELF.read_bytes()).hexdigest(),
                "map_sha256": hashlib.sha256(MAP.read_bytes()).hexdigest(),
                "source_sha256": {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                                  for p in sorted(inputs)},
                "sections": sections}
    LAYOUT.write_text(json.dumps(snapshot, indent=2) + "\n")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, default=ROOT / ".scratch/decompdev/report.json")
    parser.add_argument("--inventory", type=Path, default=INVENTORY)
    parser.add_argument("--update-inventory", action="store_true")
    parser.add_argument("--check", action="store_true", help="validate without writing a report")
    args = parser.parse_args()
    try:
        if args.update_inventory:
            update_inventory(args.inventory)
        report = build_report(args.inventory)
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        return 1

    measures = report["measures"]
    print(
        f"decomp.dev report: {measures['matched_functions']}/{measures['total_functions']} "
        f"functions, {measures['matched_code']}/{measures['total_code']} code bytes "
        f"({measures['matched_code_percent']:.2f}%), "
        f"{measures['matched_data']}/{measures['total_data']} data bytes "
        f"({measures['matched_data_percent']:.3f}%)"
    )
    if not args.check:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        # No leading whitespace or BOM: decomp.dev uses byte zero to select JSON.
        args.out.write_text(json.dumps(report, separators=(",", ":")) + "\n")
        print(f"wrote {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
