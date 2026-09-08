import importlib.util
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

MODULE_PATH = Path(__file__).parents[1] / "unify_prototype.py"
SPEC = importlib.util.spec_from_file_location("unify_prototype", MODULE_PATH)
unify = importlib.util.module_from_spec(SPEC)
assert SPEC.loader
SPEC.loader.exec_module(unify)


class UnifyTests(unittest.TestCase):
    def fixture(self):
        temp = tempfile.TemporaryDirectory()
        root = Path(temp.name)
        (root / "src").mkdir()
        (root / "include").mkdir()
        (root / "src" / "definition.c").write_bytes(b"void Foo(u8 x) {\n}\n")
        (root / "src" / "caller.c").write_bytes(b"extern void Foo(u8 x);\nvoid Caller(void) { Foo(1); }\n")
        (root / "include" / "api.h").write_bytes(b"#ifndef API_H\n#define API_H\n#endif\n")
        return temp, root

    def run_main(self, root, argv, run=None):
        old_repo, old_src = unify.REPO, unify.SRC
        unify.REPO, unify.SRC = root, root / "src"
        try:
            with mock.patch.object(sys, "argv", ["unify_prototype.py", *argv]):
                if run is None:
                    unify.main()
                else:
                    with mock.patch.object(unify.subprocess, "run", side_effect=run):
                        unify.main()
        finally:
            unify.REPO, unify.SRC = old_repo, old_src

    def test_canonical_choice_is_required(self):
        temp, root = self.fixture()
        with temp, self.assertRaises(SystemExit) as raised:
            self.run_main(root, ["Foo", "--header", "include/api.h", "--dry-run"])
        self.assertEqual(raised.exception.code, 2)

    def test_conflicting_existing_header_is_rejected_without_writes(self):
        temp, root = self.fixture()
        with temp:
            header = root / "include" / "api.h"
            header.write_bytes(b"s8 Foo(u32 x);\n")
            before = {p: p.read_bytes() for p in root.rglob("*") if p.is_file()}
            with self.assertRaises(SystemExit) as raised:
                self.run_main(root, ["Foo", "--header", "include/api.h", "--sig", "void Foo(u8 x)", "--apply"])
            self.assertEqual(raised.exception.code, 2)
            self.assertEqual(before, {p: p.read_bytes() for p in root.rglob("*") if p.is_file()})

    def test_header_parameter_names_do_not_create_false_conflict(self):
        self.assertEqual(unify._prototype_shape("void Foo(u8 value);", "Foo"),
                         unify._prototype_shape("void Foo(u8 x)", "Foo"))

    def test_formatter_failure_restores_exact_bytes_and_reports_failure(self):
        temp, root = self.fixture()
        with temp:
            before = {p: p.read_bytes() for p in root.rglob("*") if p.is_file()}
            failed = subprocess.CompletedProcess(["clang-format"], 7, "", "format exploded")
            with self.assertRaises(SystemExit) as raised:
                self.run_main(root, ["Foo", "--header", "include/api.h", "--use-definition", "--apply"],
                              run=lambda *a, **k: failed)
            self.assertEqual(raised.exception.code, 1)
            self.assertEqual(before, {p: p.read_bytes() for p in root.rglob("*") if p.is_file()})

    def test_second_mutation_write_failure_rolls_back_first_write(self):
        temp, root = self.fixture()
        with temp:
            before = {p: p.read_bytes() for p in root.rglob("*") if p.is_file()}
            real_write_text = Path.write_text
            writes = 0

            def fail_second(path, *args, **kwargs):
                nonlocal writes
                writes += 1
                if writes == 2:
                    raise OSError("second write failed")
                return real_write_text(path, *args, **kwargs)

            with mock.patch.object(Path, "write_text", fail_second), \
                 mock.patch.object(unify.subprocess, "run") as run, \
                 self.assertRaises(SystemExit) as raised:
                self.run_main(root, ["Foo", "--header", "include/api.h",
                                     "--use-definition", "--apply"])
            self.assertEqual(raised.exception.code, 1)
            run.assert_not_called()
            self.assertEqual(before, {p: p.read_bytes() for p in root.rglob("*") if p.is_file()})

    def test_keyboard_interrupt_during_write_rolls_back_and_propagates(self):
        temp, root = self.fixture()
        with temp:
            before = {p: p.read_bytes() for p in root.rglob("*") if p.is_file()}
            real_write_text = Path.write_text
            writes = 0

            def interrupt_second(path, *args, **kwargs):
                nonlocal writes
                writes += 1
                if writes == 2:
                    raise KeyboardInterrupt()
                return real_write_text(path, *args, **kwargs)

            with mock.patch.object(Path, "write_text", interrupt_second), \
                 mock.patch.object(unify.subprocess, "run") as run, \
                 self.assertRaises(KeyboardInterrupt):
                self.run_main(root, ["Foo", "--header", "include/api.h",
                                     "--use-definition", "--apply"])
            run.assert_not_called()
            self.assertEqual(before, {p: p.read_bytes() for p in root.rglob("*") if p.is_file()})

    def test_already_consolidated_apply_is_noop_without_tools(self):
        temp, root = self.fixture()
        with temp:
            (root / "src" / "caller.c").write_text(
                '#include "api.h"\nvoid Caller(void) { Foo(1); }\n')
            (root / "src" / "definition.c").write_text(
                '#include "api.h"\nvoid Foo(u8 x) {\n}\n')
            (root / "include" / "api.h").write_text(
                "#ifndef API_H\n#define API_H\nvoid Foo(u8 x);\n#endif\n")
            before = {p: p.read_bytes() for p in root.rglob("*") if p.is_file()}
            with mock.patch.object(unify.subprocess, "run") as run:
                self.run_main(root, ["Foo", "--header", "include/api.h",
                                     "--use-definition", "--apply"])
            run.assert_not_called()
            self.assertEqual(before, {p: p.read_bytes() for p in root.rglob("*") if p.is_file()})


if __name__ == "__main__":
    unittest.main()
