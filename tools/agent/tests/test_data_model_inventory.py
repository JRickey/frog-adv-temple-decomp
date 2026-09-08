import importlib.util
import tempfile
import unittest
from pathlib import Path

MODULE_PATH = Path(__file__).parents[1] / "data_model_inventory.py"
SPEC = importlib.util.spec_from_file_location("data_model_inventory", MODULE_PATH)
inventory = importlib.util.module_from_spec(SPEC)
assert SPEC.loader
SPEC.loader.exec_module(inventory)


class InventoryTests(unittest.TestCase):
    def test_normalization_preserves_scalar_signedness_width_and_argcount(self):
        ret, args = inventory.normalize_sig("unsigned int Foo", "signed char x, u16 y, unsigned long z")
        self.assertEqual(ret, "unsigned int")
        self.assertEqual(args, ("signed char", "u16", "unsigned long"))

    def test_roles_lines_headers_and_dead_branches(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / "src" / "x.c"
            header = root / "include" / "x.h"
            source.parent.mkdir()
            header.parent.mkdir()
            source.write_text("#ifdef NON_MATCHING\nextern s8 Foo(u32 x);\n#else\nu8 Foo(u16 x) {\n return 0;\n}\n#endif\n")
            header.write_text("u8 Foo(u16 x);\n")
            old = inventory.REPO
            inventory.REPO = root
            try:
                c_rows = inventory.extract_functions(source, ["Foo"])
                h_rows = inventory.extract_functions(header, ["Foo"])
            finally:
                inventory.REPO = old
            self.assertEqual([(x["role"], x["line"], x["dead"]) for x in c_rows],
                             [("extern", 2, True), ("definition", 4, False)])
            self.assertEqual(h_rows[0]["role"], "header")
            self.assertEqual(h_rows[0]["return"], "u8")
            self.assertEqual(h_rows[0]["args"], ["u16"])
            self.assertEqual(h_rows[0]["argcount"], 1)

    def test_multiline_comments_preserve_source_lines(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / "src" / "x.c"
            source.parent.mkdir()
            source.write_text("/* heading\n * across\n * four lines\n */\n\nvoid Foo(s8 x) {\n}\n")
            old = inventory.REPO
            inventory.REPO = root
            try:
                rows = inventory.extract_functions(source, ["Foo"])
            finally:
                inventory.REPO = old
            self.assertEqual(rows[0]["line"], 6)

    def test_source_conflict_preserves_pointer_target_and_scalar_width(self):
        self.assertNotEqual(inventory.source_signature("void Foo(u8 *p)", "Foo"),
                            inventory.source_signature("void Foo(u32 *p)", "Foo"))


if __name__ == "__main__":
    unittest.main()
