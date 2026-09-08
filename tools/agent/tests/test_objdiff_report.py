import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from tools.agent import objdiff_report


class ObjdiffReportTests(unittest.TestCase):
    def test_repository_report_is_valid_v2_json_shape(self) -> None:
        report = objdiff_report.build_report()
        self.assertEqual(report["version"], 2)
        self.assertGreater(report["measures"]["total_functions"], 0)
        self.assertIsInstance(report["measures"]["total_code"], str)
        self.assertEqual(
            report["measures"]["total_functions"],
            sum(unit["measures"]["total_functions"] for unit in report["units"]),
        )
        self.assertEqual(
            {category["id"] for category in report["categories"]},
            {"game", "gax", "runtime", "sdk", "libgcc"},
        )
        encoded = json.dumps(report, separators=(",", ":")).encode()
        self.assertEqual(encoded[:1], b"{")

    def test_binary_dependencies_are_not_decompiled(self) -> None:
        report = objdiff_report.build_report()
        for category in report["categories"]:
            if category["id"] in {"gax", "sdk", "libgcc"}:
                self.assertEqual(category["measures"]["matched_code"], "0")
        self.assertGreater(int(report["measures"]["total_data"]), 0)
        self.assertGreater(int(report["measures"]["matched_data"]), 0)
        self.assertLess(int(report["measures"]["matched_data"]),
                        int(report["measures"]["total_data"]))

    def test_map_ownership_uses_extents_and_named_objects(self) -> None:
        sections = objdiff_report.parse_map_sections(
            " .text 0x00000000 0x20 discarded.o\n"
            " .text 0x08000000 0x10 src/semantic_name.o\n"
            " .rodata\n                0x08000010 0x4 src/table.o\n"
            " .text 0x08000014 0x8 tools/libgcc.a(_div.o)\n")
        self.assertEqual([section["size"] for section in sections], [16, 4, 8])
        self.assertEqual(sections[0]["object"], "src/semantic_name.o")

    def test_verified_libgcc_is_complete_not_reconstructed(self) -> None:
        report = objdiff_report.build_report()
        library = next(c["measures"] for c in report["categories"] if c["id"] == "libgcc")
        self.assertEqual(library["matched_code"], "0")
        self.assertEqual(library["complete_code"], library["total_code"])
        self.assertEqual(library["complete_units"], 13)
        self.assertEqual(int(report["measures"]["complete_code"]), sum(
            int(c["measures"]["complete_code"]) for c in report["categories"]))

    def test_unverified_library_does_not_receive_completion_credit(self) -> None:
        layout = objdiff_report.load_layout()
        layout["libgcc_sha256"] = "unknown-archive"
        with patch.object(objdiff_report, "load_layout", return_value=layout):
            report = objdiff_report.build_report()
        library = next(c["measures"] for c in report["categories"] if c["id"] == "libgcc")
        self.assertEqual(library["complete_code"], "0")
        self.assertEqual(library["complete_units"], 0)

    def test_system_directory_does_not_imply_runtime(self) -> None:
        for obj in ("sub_08000918", "sub_08000eb8", "sub_08001508",
                    "sub_08020b60", "sub_08020e98", "agb_main", "init1", "init"):
            self.assertEqual(objdiff_report._category(f"src/system/{obj}.o")[0], "game")
        self.assertEqual(objdiff_report._category("src/system/vblank.o")[0], "runtime")
        self.assertEqual(objdiff_report._category("asm/system/intr_main.o")[0], "runtime")

    def test_map_rejects_overlapping_sections(self) -> None:
        with self.assertRaisesRegex(ValueError, "overlapping"):
            objdiff_report.parse_map_sections(
                " .text 0x08000000 0x10 one.o\n"
                " .text 0x08000008 0x10 two.o\n")

    def test_extraction_and_comments_do_not_receive_data_credit(self) -> None:
        names = objdiff_report.explicit_data_names(
            'const u8 raw[4] = INCBIN_U8("raw.bin");\n'
            '/* const u8 fake[1] = {0}; */\n'
            'const void *table[2] = { Fn, Fn2 };\n'
            'const u16 values[] = { 1, 2 };\n')
        self.assertEqual(names, {"table", "values"})

    def test_brace_initialized_struct_is_a_data_candidate(self) -> None:
        names = objdiff_report.explicit_data_names(
            'const DmaCycleConfig config = { 8, 8, 0, sources, destination, 0x480, 0 };\n'
            'extern const DmaCycleConfig declared;\n'
            'const u32 extracted[4] = INCBIN_U32("config.bin");\n'
            'const u32 scalar = 8;\n')
        self.assertEqual(names, {"config"})

    def test_changed_source_invalidates_snapshot(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "layout.json").write_text(json.dumps({
                "source_sha256": {"unit.c": "old-digest"}}))
            (root / "unit.c").write_text("int changed;\n")
            with patch.object(objdiff_report, "ROOT", root), patch.object(
                    objdiff_report, "LAYOUT", root / "layout.json"):
                with self.assertRaisesRegex(ValueError, "stale decomp.dev snapshot"):
                    objdiff_report.load_layout()

    def test_inline_assembly_is_checked_per_function(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "mixed.c").write_text(
                'int ordinary(void) { register int value asm("r4"); return 1; }\n'
                'void fallback(void) { asm("nop"); }\n')
            with patch.object(objdiff_report, "ROOT", root):
                self.assertTrue(objdiff_report._is_matched("mixed.o", "ordinary", set()))
                self.assertFalse(objdiff_report._is_matched("mixed.o", "fallback", set()))

    def test_neighboring_conditional_fallback_does_not_disqualify_c(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "mixed.c").write_text(
                '#ifdef NON_MATCHING\nvoid fallback(void) {}\n#else\n'
                'NAKED void fallback(void) { asm("nop"); }\n#endif\n'
                'int ordinary(void) { return 1; }\n')
            with patch.object(objdiff_report, "ROOT", root):
                self.assertTrue(objdiff_report._is_matched("mixed.o", "ordinary", {"fallback"}))
                self.assertFalse(objdiff_report._is_matched("mixed.o", "fallback", {"fallback"}))
                self.assertFalse(objdiff_report._is_matched("mixed.o", "fallback", set()))

    def test_file_scope_assembly_fallback_is_not_reconstructed_c(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "mixed.c").write_text(
                '#ifdef NON_MATCHING\nvoid fallback(void) {}\n#else\n'
                'asm(".global fallback\\n" "fallback:\\n" ".incbin \\\"rom\\\"\\n");\n'
                '#endif\nint ordinary(void) { return 1; }\n')
            with patch.object(objdiff_report, "ROOT", root):
                self.assertFalse(objdiff_report._is_matched("mixed.o", "fallback", set()))
                self.assertTrue(objdiff_report._is_matched("mixed.o", "ordinary", set()))

    def test_inventory_rejects_duplicate_addresses(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "inventory.tsv"
            path.write_text("0x08000000\t0x4\tone\n0x08000000\t0x4\ttwo\n")
            with self.assertRaisesRegex(ValueError, "duplicate address"):
                objdiff_report.load_inventory(path)

    def test_uint64_fields_are_decimal_strings(self) -> None:
        report = objdiff_report.build_report()
        for measures in [report["measures"], *[u["measures"] for u in report["units"]]]:
            for field in (
                "total_code", "matched_code", "total_data", "matched_data",
                "complete_code", "complete_data",
            ):
                self.assertRegex(measures[field], r"^\d+$")
        for unit in report["units"]:
            for function in unit["functions"]:
                self.assertRegex(function["size"], r"^\d+$")
                self.assertRegex(function["address"], r"^\d+$")
                self.assertRegex(function["metadata"]["virtual_address"], r"^\d+$")


if __name__ == "__main__":
    unittest.main()
