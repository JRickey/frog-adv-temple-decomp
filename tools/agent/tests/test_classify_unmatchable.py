from __future__ import annotations

import importlib.util
import sys
import unittest
from pathlib import Path
from unittest import mock


AGENT_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(AGENT_DIR))
SPEC = importlib.util.spec_from_file_location(
    "classify_unmatchable", AGENT_DIR / "classify_unmatchable.py"
)
assert SPEC and SPEC.loader
classifier = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(classifier)


class ClassifyUnmatchableTests(unittest.TestCase):
    """Exercise synthetic instruction fixtures; no ROM or objdump is involved."""

    def _classify(self, insns, addrs=None):
        start = 0x08000100
        addrs = addrs or {"Fixture": start}
        with mock.patch.object(classifier, "_load_addrs", return_value=addrs), \
             mock.patch.object(classifier, "_resolve", return_value=("Fixture", start)), \
             mock.patch.object(classifier, "_next_addr", return_value=start + 0x40), \
             mock.patch.object(classifier, "_disasm", return_value=insns):
            return classifier.classify("Fixture")

    def test_wide_libgcc_prologue_is_advisory(self):
        start = 0x08000100
        result = self._classify(
            [
                (start, "push {r4, r5, r6, r7, lr}"),
                (start + 2, "bl 0x20"),
                (start + 4, "pop {r4, r5, r6, r7}"),
                (start + 6, "bx r0"),
            ],
            {"Fixture": start, "__divsi3": start + 0x20},
        )
        self.assertEqual(result["verdict"], "ATTEMPT_MATCH")
        self.assertIn("class3-libgcc", result["classes"])
        self.assertTrue(any("archive member" in item for item in result["advisories"]))
        self.assertFalse(any("NAKED" in item for item in result["advisories"]))

    def test_high_register_signal_recommends_investigation_not_pins(self):
        start = 0x08000100
        result = self._classify(
            [
                (start, "push {r4, lr}"),
                (start + 2, "mov r8, r0"),
                (start + 4, "bl 0x20"),
                (start + 6, "adds r0, r8, #0"),
                (start + 8, "pop {r4}"),
                (start + 10, "bx r1"),
            ]
        )
        self.assertEqual(result["verdict"], "ATTEMPT_MATCH")
        advisory = "\n".join(result["advisories"])
        self.assertIn("narrow parameter types", advisory)
        self.assertNotIn("register T x asm", advisory)
        self.assertNotIn("NAKED", advisory)

    def test_dense_switch_signal_is_advisory(self):
        start = 0x08000100
        result = self._classify(
            [
                (start, "push {lr}"),
                (start + 2, "mov pc, r0"),
                (start + 4, "pop {r0}"),
                (start + 6, "bx r0"),
            ]
        )
        self.assertEqual(result["verdict"], "ATTEMPT_MATCH")
        advisory = "\n".join(result["advisories"])
        self.assertIn("dense C `switch`", advisory)
        self.assertNotIn("NAKED", advisory)


if __name__ == "__main__":
    unittest.main()
