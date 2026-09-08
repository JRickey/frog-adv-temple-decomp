from __future__ import annotations

import importlib.util
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

AGENT_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(AGENT_DIR))
SPEC = importlib.util.spec_from_file_location(
    "compile_and_view_assembly", AGENT_DIR / "compile_and_view_assembly.py"
)
assert SPEC and SPEC.loader
oracle = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(oracle)


class BuildReliabilityTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)
        for directory in ("src", "include", "asm", ".scratch"):
            (self.root / directory).mkdir()
        self.source = self.root / "src/test.c"
        self.header = self.root / "include/test.h"
        self.source.write_text("int Test(void) { return VALUE; }\n")
        self.header.write_text("#define VALUE 1\n")
        (self.root / "Makefile").write_text("all:\n\t@true\n")
        self.asm = self.source.with_suffix(".s")
        self.obj = self.source.with_suffix(".o")
        self.rom = self.root / "frog_us.gba"
        self.baserom = self.root / "frog_us_baserom.gba"
        self.map = self.root / "frog_us.map"
        self.elf = self.root / "frog_us.elf"
        for path in (self.asm, self.obj, self.rom, self.map, self.elf):
            path.write_text("old")
        self.baserom.write_text("baseline")
        self.patchers = [
            mock.patch.object(oracle, "ROOT", self.root),
            mock.patch.object(oracle, "SRC_DIR", self.root / "src"),
            mock.patch.object(oracle, "BUILTROM", self.rom),
            mock.patch.object(oracle, "MAP_FILE", self.map),
            mock.patch.object(oracle, "BUILD_STATE", self.root / ".scratch/state.json"),
            mock.patch.object(oracle, "BASEROM", self.baserom),
        ]
        for patcher in self.patchers:
            patcher.start()

    def tearDown(self):
        for patcher in reversed(self.patchers):
            patcher.stop()
        self.tmp.cleanup()

    def _record_state(self):
        inputs = oracle._fingerprints()
        outputs = oracle.manifest(oracle._output_paths(), self.root)
        oracle.save_state(oracle.BUILD_STATE, {"inputs": inputs, "outputs": outputs})

    def test_makeflags_distinguishes_long_options_and_short_override_clusters(self):
        for flags in ("", "w --no-print-directory", "--jobserver-fds=3,4 -j",
                      "--warn-undefined-variables", "r --no-builtin-rules"):
            with self.subTest(flags=flags):
                self.assertFalse(oracle._make_environment_overrides(flags))
        for flags in ("e", "er --no-print-directory", "-e", "-ke",
                      "--environment-overrides"):
            with self.subTest(flags=flags):
                self.assertTrue(oracle._make_environment_overrides(flags))

    def test_same_timestamp_source_edit_invalidates_full_chain(self):
        self._record_state()
        stamp = self.source.stat().st_mtime_ns
        self.source.write_text("int Test(void) { return VALUE + 1; }\n")
        os.utime(self.source, ns=(stamp, stamp))
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("sources:src/test.c", changed)
        for path in (self.asm, self.obj, self.rom, self.map, self.elf):
            self.assertFalse(path.exists(), path)

    def test_same_timestamp_header_edit_invalidates_all_c_outputs(self):
        self._record_state()
        stamp = self.header.stat().st_mtime_ns
        self.header.write_text("#define VALUE 2\n")
        os.utime(self.header, ns=(stamp, stamp))
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("headers:include/test.h", changed)
        self.assertFalse(self.asm.exists())
        self.assertFalse(self.obj.exists())

    def test_same_timestamp_source_local_header_is_broad(self):
        local_header = self.root / "src/local.h"
        local_header.write_text("#define LOCAL 1\n")
        asm_object = self.root / "asm/test.o"
        asm_object.write_text("old")
        self._record_state()
        stamp = local_header.stat().st_mtime_ns
        local_header.write_text("#define LOCAL 2\n")
        os.utime(local_header, ns=(stamp, stamp))
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("headers:src/local.h", changed)
        self.assertFalse(self.obj.exists())
        self.assertFalse(asm_object.exists())

    def test_same_timestamp_asm_include_is_broad(self):
        asm_include = self.root / "asm/constants.inc"
        asm_include.write_text(".equ VALUE, 1\n")
        asm_object = self.root / "asm/test.o"
        asm_object.write_text("old")
        self._record_state()
        stamp = asm_include.stat().st_mtime_ns
        asm_include.write_text(".equ VALUE, 2\n")
        os.utime(asm_include, ns=(stamp, stamp))
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("headers:asm/constants.inc", changed)
        self.assertFalse(asm_object.exists())

    def test_same_timestamp_config_edit_invalidates_all_c_outputs(self):
        config = self.root / "Makefile"
        self._record_state()
        stamp = config.stat().st_mtime_ns
        config.write_text("all:\n\t@false\n")
        os.utime(config, ns=(stamp, stamp))
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("config:Makefile", changed)
        self.assertFalse(self.asm.exists())
        self.assertFalse(self.obj.exists())

    def test_modified_intermediate_is_not_trusted(self):
        self._record_state()
        stamp = self.obj.stat().st_mtime_ns
        self.obj.write_text("different but same timestamp")
        os.utime(self.obj, ns=(stamp, stamp))
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("output:src/test.o", changed)
        self.assertFalse(self.obj.exists())
        self.assertFalse(self.rom.exists())

    def test_asm_config_change_invalidates_non_c_objects(self):
        asm_source = self.root / "asm/test.s"
        asm_object = asm_source.with_suffix(".o")
        asm_source.write_text(".byte 1\n")
        asm_object.write_text("old")
        self._record_state()
        makefile = self.root / "Makefile"
        stamp = makefile.stat().st_mtime_ns
        makefile.write_text("ASFLAGS += --defsym CHANGED=1\n")
        os.utime(makefile, ns=(stamp, stamp))
        oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertFalse(asm_object.exists())

    def test_same_timestamp_linked_data_change_invalidates_asm_objects(self):
        data_dir = self.root / "data"
        data_dir.mkdir()
        blob = data_dir / "tile.bin"
        blob.write_bytes(b"old")
        asm_source = self.root / "asm/test.s"
        asm_object = asm_source.with_suffix(".o")
        asm_source.write_text('.incbin "data/tile.bin"\n')
        asm_object.write_text("old")
        self._record_state()
        stamp = blob.stat().st_mtime_ns
        blob.write_bytes(b"new")
        os.utime(blob, ns=(stamp, stamp))
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("linked_data:data/tile.bin", changed)
        self.assertFalse(asm_object.exists())

    def test_unchanged_inputs_and_outputs_do_not_invalidate(self):
        self._record_state()
        changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertEqual(changed, [])
        self.assertTrue(self.obj.exists())
        self.assertTrue(self.rom.exists())

    def test_build_environment_change_invalidates_all_objects(self):
        asm_object = self.root / "asm/test.o"
        asm_object.write_text("old")
        self._record_state()
        with mock.patch.dict(os.environ, {"ASFLAGS": "--defsym TEST=1"}):
            changed = oracle._prepare_reliable_build(oracle._fingerprints())
        self.assertIn("environment:ASFLAGS", changed)
        self.assertFalse(self.obj.exists())
        self.assertFalse(asm_object.exists())

    def test_input_change_during_build_is_rejected_and_not_recorded(self):
        self._record_state()
        state_before = oracle.BUILD_STATE.read_bytes()

        def mutate_during_make(*args, **kwargs):
            self.source.write_text("int Test(void) { return 99; }\n")
            return subprocess.CompletedProcess(args[0], 0, "", "")

        with mock.patch.object(oracle, "run", side_effect=mutate_during_make):
            ok, errors, _ = oracle.build_incremental()
        self.assertFalse(ok)
        self.assertIn("inputs changed", errors)
        self.assertEqual(oracle.BUILD_STATE.read_bytes(), state_before)
        self.assertFalse(self.rom.exists())

    def test_missing_baseline_does_not_mask_make_failure(self):
        self.baserom.unlink()
        failed = subprocess.CompletedProcess(["make"], 2, "", "compile failed")
        with mock.patch.object(oracle, "run", return_value=failed):
            ok, errors, provenance = oracle.build_incremental()
        self.assertFalse(ok)
        self.assertIn("compile failed", errors)
        self.assertEqual(provenance["baseline"], {"missing": True})

    def test_nonmatching_restores_source_when_measurement_raises(self):
        source_bytes = b"#ifdef NON_MATCHING\nint Test(void) { return 1; }\n#endif\n"
        self.source.write_bytes(source_bytes)
        with mock.patch.object(oracle, "find_defining_file", return_value=self.source), \
             mock.patch.object(oracle, "_diff_after_build", side_effect=RuntimeError("boom")), \
             mock.patch.object(oracle, "build_incremental", return_value=(True, "", {})):
            with self.assertRaisesRegex(RuntimeError, "boom"):
                oracle.measure("Test", non_matching=True)
        self.assertEqual(self.source.read_bytes(), source_bytes)

    def test_nonmatching_reports_failed_restoration_build(self):
        self.source.write_text("#ifdef NON_MATCHING\nint Test(void) { return 1; }\n#endif\n")
        candidate = {"function": "Test", "build_ok": True, "diff_count": 0}
        with mock.patch.object(oracle, "find_defining_file", return_value=self.source), \
             mock.patch.object(oracle, "_diff_after_build", return_value=candidate), \
             mock.patch.object(oracle, "build_incremental", return_value=(False, "bad build", {})):
            result = oracle.measure("Test", non_matching=True)
        self.assertFalse(result["build_ok"])
        self.assertIn("source was restored", result["build_errors"])


class TargetIdentityTests(unittest.TestCase):
    def test_unknown_baseline_refuses_current_link_address(self):
        with mock.patch.object(oracle, "build_incremental", return_value=(True, "", {})), \
             mock.patch.object(oracle, "find_in_map", return_value=(0x0803394c, 100)), \
             mock.patch.object(oracle, "baserom_addr", return_value=None), \
             mock.patch.object(oracle, "disasm_slice") as disasm:
            result = oracle._diff_after_build("RenamedTimer")
        self.assertIn("Unknown baserom address", result["error"])
        self.assertNotIn("byte_diff", result)
        disasm.assert_not_called()


if __name__ == "__main__":
    unittest.main()
