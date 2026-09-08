from pathlib import Path
import json
import sys
import tempfile
import unittest
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import m2c_run


class RangeResolutionTests(unittest.TestCase):
    def test_unlocated_sibling_does_not_supply_an_exact_extent(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "asm").mkdir()
            (root / "asm/disasm_0x08010000.s").write_text(
                "@ Range: [0x08010000, 0x08010100)\n"
                "thumb_func_start Target\nTarget: @ 0x08010000\n"
                "thumb_func_start Unknown\nUnknown:\n"
            )
            with mock.patch.object(m2c_run, "ROOT", root):
                self.assertIsNone(m2c_run.peeled_range("Target", {}))

    def test_peeled_header_beats_shorter_candidate_map_extent(self):
        """m2c must keep the original reference range during C trials."""
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            src = root / "src"
            asm = root / "asm"
            tools = root / "tools" / "agent"
            src.mkdir(parents=True)
            asm.mkdir()
            tools.mkdir(parents=True)
            (src / "candidate.c").write_text("void Target(void) {}\n")
            (asm / "disasm_0x0801025c.s").write_text(
                "@ Range:  [0x0801025c, 0x080105b0)  (852 bytes, thumb mode)\n"
                "        thumb_func_start Target\n"
                "Target: @ 0x0801025c\n"
            )
            cache = tools / ".function_addresses.json"
            cache.write_text(json.dumps({"addresses": {
                "Target": 0x0801025C,
                "OriginalNext": 0x080105B0,
            }}))
            candidate_map = root / "frog_us.map"
            candidate_map.write_text(
                "                0x0801025c                Target\n"
                "                0x080104ac                CandidateNext\n"
            )
            with mock.patch.object(m2c_run, "ROOT", root), \
                 mock.patch.object(m2c_run, "SRC", src), \
                 mock.patch.object(m2c_run, "MAP", candidate_map), \
                 mock.patch.object(m2c_run, "ADDRESS_CACHE", cache):
                self.assertEqual(
                    m2c_run.resolve_range("Target", m2c_run.load_symbols()),
                    (0x1025C, 0x354),
                )

    def test_peeled_header_splits_first_and_later_functions(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            src = root / "src"
            asm = root / "asm"
            src.mkdir()
            asm.mkdir()
            (asm / "disasm_0x0801025c.s").write_text(
                "@ Range:  [0x0801025c, 0x080105b0)\n"
                "        thumb_func_start First\n"
                "First: @ 0x0801025c\n"
                "        thumb_func_start Later\n"
                "Later: @ 0x080104ac\n"
            )
            cached = {"First": 0x0801025C, "Later": 0x080104AC}
            with mock.patch.object(m2c_run, "ROOT", root), \
                 mock.patch.object(m2c_run, "SRC", src):
                self.assertEqual(m2c_run.peeled_range("First", cached),
                                 (0x1025C, 0x250))
                self.assertEqual(m2c_run.peeled_range("Later", cached),
                                 (0x104AC, 0x104))


class SymbolResolutionTests(unittest.TestCase):
    def test_cached_function_address_beats_shifted_map_but_data_stays_live(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            src = root / "src"
            asm = root / "asm"
            tools = root / "tools" / "agent"
            src.mkdir(parents=True)
            asm.mkdir()
            tools.mkdir(parents=True)
            (asm / "disasm_0x08010020.s").write_text(
                "        thumb_func_start Callee\nCallee: @ 0x08010020\n"
            )
            cache = tools / ".function_addresses.json"
            cache.write_text(json.dumps({"addresses": {"Callee": 0x08010020}}))
            candidate_map = root / "frog_us.map"
            candidate_map.write_text(
                "                0x08010100                Callee\n"
                "                0x08300000                DataOnly\n"
            )
            with mock.patch.object(m2c_run, "ROOT", root), \
                 mock.patch.object(m2c_run, "SRC", src), \
                 mock.patch.object(m2c_run, "MAP", candidate_map), \
                 mock.patch.object(m2c_run, "ADDRESS_CACHE", cache):
                symbols = m2c_run.load_symbols()
                self.assertEqual(symbols[0x08010020], "Callee")
                self.assertNotIn(0x08010100, symbols)
                self.assertEqual(symbols[0x08300000], "DataOnly")

    def test_snapshot_beats_shorter_candidate_map_when_peel_is_gone(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            src = root / "src"
            src.mkdir()
            (src / "candidate.c").write_text("void Target(void) {}\n")
            cache = root / ".function_addresses.json"
            cache.write_text(json.dumps({"addresses": {
                "Target": 0x0801025C,
                "OriginalNext": 0x080105B0,
            }}))
            candidate_map = root / "frog_us.map"
            candidate_map.write_text(
                "                0x0801025c                Target\n"
                "                0x080104ac                CandidateNext\n"
            )
            with mock.patch.object(m2c_run, "ROOT", root), \
                 mock.patch.object(m2c_run, "SRC", src), \
                 mock.patch.object(m2c_run, "MAP", candidate_map), \
                 mock.patch.object(m2c_run, "ADDRESS_CACHE", cache):
                self.assertEqual(
                    m2c_run.resolve_range("Target", m2c_run.load_symbols()),
                    (0x1025C, 0x354),
                )
