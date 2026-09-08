from __future__ import annotations

import importlib.util
import json
import tempfile
import unittest
from pathlib import Path


MODULE_PATH = Path(__file__).parents[1] / "campaign_report.py"
SPEC = importlib.util.spec_from_file_location("campaign_report", MODULE_PATH)
campaign_report = importlib.util.module_from_spec(SPEC)
assert SPEC.loader
SPEC.loader.exec_module(campaign_report)


def run(run_id: str, usage, *, corrections=None):
    return {
        "id": run_id,
        "model": "gpt-test",
        "reasoning_effort": None,
        "task": "bounded audit",
        "outcome": "accepted",
        "review_corrections": corrections or [],
        "usage": usage,
    }


def campaign(runs):
    return {
        "schema_version": 1,
        "id": "first-calibration",
        "base_commit": "abc123",
        "rom_sha1": "deadbeef",
        "summary": "First honest sample.",
        "metrics": {"accepted_changes": 1},
        "runs": runs,
    }


class CampaignReportTests(unittest.TestCase):
    def load(self, payload):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "ledger.json"
            path.write_text(json.dumps(payload))
            return campaign_report.load_campaigns(path)

    def test_missing_usage_keeps_machine_null_and_makes_totals_partial(self):
        campaigns = self.load(campaign([
            run("known", {"input_tokens": 10, "output_tokens": 5}),
            run("unknown", None, corrections=["Clarified an assumption."]),
        ]))
        data = campaign_report.report_data(campaigns)
        usage = data["summary"]["usage"]
        self.assertIsNone(data["campaigns"][0]["runs"][1]["usage"])
        self.assertEqual((usage["known_runs"], usage["unknown_runs"]), (1, 1))
        self.assertFalse(usage["complete"])
        self.assertEqual(usage["known_totals"]["input_tokens"], 10)
        self.assertIsNone(usage["complete_totals"])
        self.assertIn("partial (1/2 runs known)", campaign_report.format_report(data))

    def test_token_counts_reject_negative_and_boolean_values(self):
        for bad in ("unknown", -1, True):
            with self.subTest(bad=bad):
                payload = campaign([run("bad", {"input_tokens": bad, "output_tokens": 0})])
                with self.assertRaisesRegex(campaign_report.CampaignError, "non-negative integer"):
                    self.load(payload)

    def test_complete_usage_exposes_complete_totals(self):
        campaigns = self.load(campaign([
            run("one", {"input_tokens": 10, "output_tokens": 4, "cached_input_tokens": 3}),
            run("two", {"input_tokens": 7, "output_tokens": 6, "cached_input_tokens": 2}),
        ]))
        usage = campaign_report.report_data(campaigns)["summary"]["usage"]
        self.assertTrue(usage["complete"])
        self.assertEqual(usage["complete_totals"], {
            "input_tokens": 17,
            "output_tokens": 10,
            "cached_input_tokens": 5,
        })


if __name__ == "__main__":
    unittest.main()
