#!/usr/bin/env python3
"""Generate the ObjDiff v2 progress report consumed by decomp.dev.

The normal report path is build-free: it reads a committed function inventory,
the linker layout, and the source tree.  `--update-inventory` is the maintainer
path; it requires a byte-identical local build and refreshes the inventory from
the ELF plus the committed baserom label map.

Progress means reconstructed source, not ROM equality:
  * ordinary C functions are 100%;
  * NAKED/NON_MATCHING fallbacks and remaining game assembly are 0%;
  * intentionally retained third-party GAX, SDK, and runtime assembly are kept
    in separate categories and treated as complete.
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

ROM_BASE = 0x08000000
CODE_END = 0x08036000
REPORT_VERSION = 2

OBJECT_RE = re.compile(r"^\s*(\S+?\.o)\(\.text\);(?:\s*/\*\s*(0x[0-9a-fA-F]+)\s*-)?")
ADDRESS_IN_NAME_RE = re.compile(r"(?:sub_|disasm_0x|text_0x)(080[0-9a-fA-F]+)", re.I)
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
              matched_functions: int, total_units: int = 1) -> dict:
    return {
        "fuzzy_match_percent": _percent(matched_code, total_code),
        "total_code": str(total_code),
        "matched_code": str(matched_code),
        "matched_code_percent": _percent(matched_code, total_code),
        "total_data": "0",
        "matched_data": "0",
        "matched_data_percent": 100.0,
        "total_functions": total_functions,
        "matched_functions": matched_functions,
        "matched_functions_percent": _percent(matched_functions, total_functions),
        "complete_code": "0",
        "complete_code_percent": 0.0 if total_code else 100.0,
        "complete_data": "0",
        "complete_data_percent": 100.0,
        "total_units": total_units,
        "complete_units": 0,
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


def _inventory_names(functions: list[Function]) -> dict[str, int]:
    return {function.name.lower(): function.address for function in functions}


def load_link_units(functions: list[Function]) -> list[LinkUnit]:
    names = _inventory_names(functions)
    units: list[LinkUnit] = []
    for order, line in enumerate(LINKER.read_text().splitlines()):
        match = OBJECT_RE.match(line)
        if not match:
            continue
        object_path, comment_address = match.groups()
        address = int(comment_address, 0) if comment_address else None
        if address is None:
            embedded = ADDRESS_IN_NAME_RE.search(object_path)
            if embedded:
                address = int(embedded.group(1), 16)
        if address is None:
            stem = Path(object_path.split(":")[-1]).stem.lower()
            address = names.get(stem)
        if address is not None and ROM_BASE <= address < CODE_END:
            units.append(LinkUnit(address, order, object_path))
    units.sort(key=lambda unit: (unit.address, unit.order))
    return units


def _source_path(object_path: str) -> str | None:
    if object_path.startswith("*") or ".a:" in object_path:
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
    if (
        "libgcc.a:" in object_path
        or object_path.startswith("asm/system/")
        or object_path == "asm/libagbsyscall.o"
        or object_path in {
            "asm/disasm_0x08000000.o",
            "asm/disasm_0x080000c0.o",
            "asm/disasm_0x080000fc.o",
        }
    ):
        return "runtime", "Runtime and SDK"
    return "game", "Game code"


def _is_matched(object_path: str, function_name: str, naked: set[str]) -> bool:
    category, _ = _category(object_path)
    if category in {"gax", "runtime"}:
        return True
    return object_path.startswith("src/") and function_name not in naked


def build_report(inventory_path: Path = INVENTORY) -> dict:
    functions = load_inventory(inventory_path)
    link_units = load_link_units(functions)
    naked = naked_function_names()
    report_units: list[dict] = []
    category_names: dict[str, str] = {}
    assigned: set[int] = set()

    for index, unit in enumerate(link_units):
        end = link_units[index + 1].address if index + 1 < len(link_units) else CODE_END
        if end <= unit.address:
            continue
        unit_functions = [
            function for function in functions
            if unit.address <= function.address < end
        ]
        if not unit_functions:
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
        assigned.update(function.address for function in unit_functions)
        report_units.append({
            "name": unit.object_path,
            "measures": _measures(
                total_code, matched_code, len(unit_functions), len(matched)
            ),
            "sections": [],
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
            total_code, matched_code, total_functions, matched_functions, len(units)
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
    for required in (BASEROM, BUILT_ROM, ELF):
        if not required.exists():
            raise ValueError(f"missing {required.name}; run `make` first")
    if _sha1(BASEROM) != _sha1(BUILT_ROM):
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

    output = [
        "# Generated by tools/agent/objdiff_report.py --update-inventory.",
        "# address\tsize\tname",
    ]
    for function in sorted(records.values(), key=lambda item: item.address):
        output.append(f"{function.address:#010x}\t{function.size:#x}\t{function.name}")
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(output) + "\n")
    print(f"wrote {len(records)} functions to {path.relative_to(ROOT)}")


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
        f"({measures['matched_code_percent']:.2f}%)"
    )
    if not args.check:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        # No leading whitespace or BOM: decomp.dev uses byte zero to select JSON.
        args.out.write_text(json.dumps(report, separators=(",", ":")) + "\n")
        print(f"wrote {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
