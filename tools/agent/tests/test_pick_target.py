from pathlib import Path
import sys
import tempfile
import unittest
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import pick_target


class ExistingDefinitionTests(unittest.TestCase):
    def classify(self, source):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "src").mkdir()
            path = root / "src" / "example.c"
            path.write_text(source)
            with mock.patch.object(pick_target, "ROOT", root):
                result = pick_target._existing_c_definition("DrawTextGlyphs")
            return None if result is None else result[1]

    def test_prototype_does_not_claim_next_function_body(self):
        self.assertIsNone(self.classify(
            "void DrawTextGlyphs(const char *text, int length);\n"
            "void Menu(void) { update(); }\n"))

    def test_multiline_callback_prototype_is_not_definition(self):
        self.assertIsNone(self.classify(
            "void DrawTextGlyphs(\n void (*callback)(int), int count);\n"
            "void Menu(void) { update(); }\n"))

    def test_prototype_before_actual_definition(self):
        self.assertFalse(self.classify(
            "void DrawTextGlyphs(void);\n"
            "void Menu(void) {}\n"
            "void DrawTextGlyphs(void) { draw(); }\n"))

    def test_empty_scaffold_remains_distinct(self):
        self.assertTrue(self.classify("void DrawTextGlyphs(void) { /* todo */ }\n"))

    def test_comments_and_literals_do_not_supply_delimiters(self):
        self.assertFalse(self.classify(
            '/* void DrawTextGlyphs(void) {} */\n'
            'void DrawTextGlyphs(void /* ; { */) { draw("}"); }\n'))
