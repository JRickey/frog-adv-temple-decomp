import importlib.util
import json
import tempfile
import unittest
from pathlib import Path
from unittest import mock

MODULE_PATH = Path(__file__).parents[1] / "evidence.py"
SPEC = importlib.util.spec_from_file_location("evidence", MODULE_PATH)
evidence = importlib.util.module_from_spec(SPEC)
assert SPEC.loader
SPEC.loader.exec_module(evidence)


def record(rid, *, prerequisites=None, relations=None):
    return {
        "schema_version": 1,
        "id": rid,
        "kind": "behavior",
        "title": "Hitbox behavior",
        "status": "observed",
        "claim": "The hitbox overlaps an entity slot.",
        "subjects": ["fn:0800a83c"],
        "provenance": [{"path": "asm/disasm_0x0800a83c.s", "location": "sub_0800A83C"}],
        "prerequisites": prerequisites or [],
        "relations": relations or [],
    }


class EvidenceTests(unittest.TestCase):
    def load(self, payload):
        with tempfile.TemporaryDirectory() as tmp:
            directory = Path(tmp) / "docs" / "evidence"
            directory.mkdir(parents=True)
            (directory / "records.json").write_text(json.dumps(payload))
            return evidence.load_records(directory)

    def test_load_and_address_search_are_deterministic(self):
        records = self.load([record("hitbox.second"), record("hitbox.first")])
        found = evidence.search(records, "fn:0800a83c", 10)
        self.assertEqual([x["id"] for x in found], ["hitbox.first", "hitbox.second"])

    def test_unknown_relation_is_rejected(self):
        with self.assertRaisesRegex(evidence.EvidenceError, "unknown evidence reference"):
            self.load([record("hitbox.one", relations=[{"type": "supports", "target": "missing"}])])

    def test_prerequisite_cycle_is_rejected_but_relation_cycle_is_allowed(self):
        with self.assertRaisesRegex(evidence.EvidenceError, "prerequisite cycle"):
            self.load([record("hitbox.a", prerequisites=["hitbox.b"]),
                       record("hitbox.b", prerequisites=["hitbox.a"])])
        loaded = self.load([
            record("hitbox.a", relations=[{"type": "calls", "target": "hitbox.b"}]),
            record("hitbox.b", relations=[{"type": "calls", "target": "hitbox.a"}]),
        ])
        self.assertEqual(len(loaded), 2)

    def test_paths_must_be_repository_relative(self):
        item = record("hitbox.one")
        item["provenance"][0]["path"] = "/Users/example/private.s"
        with self.assertRaisesRegex(evidence.EvidenceError, "repository-relative"):
            self.load([item])

    def test_historical_confirmation_is_not_current(self):
        item = record("hitbox.one")
        item["status"] = "verified"
        item["current_validation"] = {"state": "confirmed", "commit": "a" * 40}
        label = evidence.validation_label(item, "b" * 40)
        self.assertIn("recorded confirmed", label)
        self.assertIn("current checkout unvalidated", label)

    def test_plan_is_dependency_first_and_marks_nonverified_unresolved(self):
        records = self.load([
            record("hitbox.goal", prerequisites=["hitbox.fact"]),
            record("hitbox.fact"),
        ])
        records[0 if records[0]["id"] == "hitbox.fact" else 1]["status"] = "verified"
        plan = evidence.dependency_plan(records, ["hitbox.goal"])
        self.assertEqual(plan["order"], ["hitbox.fact", "hitbox.goal"])
        self.assertEqual(plan["unresolved"], ["hitbox.goal"])

    def test_empty_plan_seeds_do_not_expand_to_whole_graph(self):
        records = [record("hitbox.one")]
        seeds = [x["id"] for x in evidence.search(records, "NONEXISTENT_QUERY", 10)]
        plan = evidence.dependency_plan(records, seeds)
        self.assertEqual(plan["nodes"], [])
        self.assertEqual(plan["seeds"], [])

    def test_symbolic_target_resolves_map_address_only_subject(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "frog_us.map").write_text(
                "                0x0800a83c                EntityHitbox_RegisterGridPoints\n")
            records = [record("address.only")]
            found = evidence.brief_data(records, "EntityHitbox_RegisterGridPoints",
                                        root, 5, root / "missing.db")
            self.assertEqual([x["id"] for x in found], ["address.only"])

    def test_human_brief_includes_compact_provenance(self):
        text = evidence.format_records([record("hitbox.one")], Path("."), compact=True)
        self.assertIn("source: asm/disasm_0x0800a83c.s:sub_0800A83C", text)

    def test_source_validation_checks_local_paths(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "src").mkdir()
            item = record("hitbox.one")
            item["provenance"][0]["path"] = "src/missing.c"
            self.assertRegex(evidence.validate_sources([item], root)[0], "does not exist")
            (root / "src" / "missing.c").write_text("x")
            self.assertEqual(evidence.validate_sources([item], root), [])

    @mock.patch.object(evidence.subprocess, "run")
    def test_source_validation_uses_git_object_for_committed_path(self, run):
        run.return_value.returncode = 0
        item = record("hitbox.one")
        item["provenance"][0].update({"path": "src/old.c", "commit": "a" * 40})
        self.assertEqual(evidence.validate_sources([item], Path("/repo")), [])
        self.assertEqual(run.call_args.args[0], ["git", "cat-file", "-e", f"{'a' * 40}:src/old.c"])


if __name__ == "__main__":
    unittest.main()
