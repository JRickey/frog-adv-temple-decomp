import json
import tempfile
import unittest
from pathlib import Path

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
            {"game", "gax", "runtime"},
        )
        encoded = json.dumps(report, separators=(",", ":")).encode()
        self.assertEqual(encoded[:1], b"{")

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
