from pathlib import Path
import sys
import tempfile
import unittest
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import decomp_brief


class DestinationTests(unittest.TestCase):
    def hint(self, script):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "linker.ld").write_text(script)
            with mock.patch.object(decomp_brief, "ROOT", root):
                return decomp_brief.suggest_destination(0x080296b8)

    def test_unannotated_immediate_predecessor_wins(self):
        hint = self.hint("src/old.o(.text); /* 0x08000000 - 0x08000020 */\n"
                         "src/right.o(.text);\nasm/disasm_0x080296b8.o(.text);")
        self.assertIn("src/right.c", hint)

    def test_intervening_assembly_requires_scaffold(self):
        hint = self.hint("src/old.o(.text); asm/other.o(.text); "
                         "asm/disasm_0x080296b8.o(.text); src/next.o(.text);")
        self.assertIn("scaffold", hint)
        self.assertNotIn("src/next.c", hint)

    def test_commented_objects_do_not_count(self):
        hint = self.hint("src/right.o(.text); /* asm/fake.o(.text); */ "
                         "asm/disasm_0x080296b8.o(.text);")
        self.assertIn("src/right.c", hint)

    def test_missing_target_is_explicit(self):
        self.assertIn("not currently", self.hint("src/other.o(.text);"))
