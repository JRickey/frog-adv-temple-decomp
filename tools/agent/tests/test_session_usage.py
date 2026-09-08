from __future__ import annotations

import importlib.util
import json
import tempfile
import unittest
from pathlib import Path


MODULE_PATH = Path(__file__).parents[1] / "session_usage.py"
SPEC = importlib.util.spec_from_file_location("session_usage", MODULE_PATH)
session_usage = importlib.util.module_from_spec(SPEC)
assert SPEC.loader
SPEC.loader.exec_module(session_usage)


def record(timestamp, kind, payload):
    return {"timestamp": timestamp, "type": kind, "payload": payload}


def usage(timestamp, input_tokens, cached, output, total=None, rate=1):
    counters = {"input_tokens": input_tokens, "cached_input_tokens": cached,
                "output_tokens": output, "total_tokens": total or input_tokens + output}
    return record(timestamp, "event_msg", {"type": "token_count",
        "info": {"total_token_usage": counters},
        "rate_limits": {"limit_id": "codex", "primary": {"used_percent": rate}}})


class SessionUsageTests(unittest.TestCase):
    def write(self, records, name="session.jsonl"):
        path = Path(self.tmp.name) / name
        path.write_text("".join(json.dumps(item) + "\n" for item in records))
        return path

    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()

    def tearDown(self):
        self.tmp.cleanup()

    def test_window_uses_prior_baseline_and_separates_cached_input(self):
        path = self.write([
            record("2026-01-01T00:00:00Z", "session_meta", {"id": "abc"}),
            usage("2026-01-01T00:01:00Z", 100, 60, 10, rate=2),
            record("2026-01-01T00:01:30Z", "turn_context",
                   {"model": "gpt-a", "effort": "high"}),
            usage("2026-01-01T00:02:00Z", 180, 110, 25, rate=3),
        ])
        result = session_usage.extract_session(
            path, session_usage.parse_time("2026-01-01T00:01:30Z"),
            session_usage.parse_time("2026-01-01T00:02:00Z"))
        self.assertEqual(result["usage"], {"input_tokens": 80,
            "cached_input_tokens": 50, "uncached_input_tokens": 30,
            "output_tokens": 15, "total_tokens": 95})
        self.assertEqual(result["contexts"], [{"model": "gpt-a", "reasoning_effort": "high"}])
        self.assertEqual(result["rate_limits"]["scope"], "account_wide")
        self.assertEqual(result["rate_limits"]["before"]["primary"]["used_percent"], 2)

    def test_session_beginning_in_window_has_zero_baseline(self):
        path = self.write([usage("2026-01-01T00:02:00Z", 20, 5, 4)])
        result = session_usage.extract_session(
            path, session_usage.parse_time("2026-01-01T00:01:00Z"), None)
        self.assertEqual(result["usage"]["input_tokens"], 20)

    def test_missing_usage_is_unknown(self):
        path = self.write([record("2026-01-01T00:00:00Z", "session_meta", {"id": "empty"})])
        self.assertEqual(session_usage.extract_session(path)["status"], "unknown")

    def test_duplicate_path_and_session_id_are_counted_once(self):
        records = [record("2026-01-01T00:00:00Z", "session_meta", {"id": "same"}),
                   usage("2026-01-01T00:01:00Z", 10, 5, 2)]
        first = self.write(records, "first.jsonl")
        second = self.write(records, "second.jsonl")
        report = session_usage.build_report([first, first, second])
        self.assertEqual(len(report["sessions"]), 1)
        self.assertEqual(report["summary"]["known_totals"]["input_tokens"], 10)

    def test_counter_reset_is_unknown_and_not_summed(self):
        path = self.write([usage("2026-01-01T00:01:00Z", 20, 10, 4),
                           usage("2026-01-01T00:02:00Z", 5, 2, 1)])
        report = session_usage.build_report([path])
        self.assertEqual(report["sessions"][0]["status"], "unknown")
        self.assertEqual(report["summary"]["known_totals"]["total_tokens"], 0)

    def test_missing_baseline_is_unknown(self):
        path = self.write([record("2026-01-01T00:00:00Z", "session_meta", {"id": "abc"}),
                           usage("2026-01-01T00:02:00Z", 10, 5, 1)])
        result = session_usage.extract_session(
            path, session_usage.parse_time("2026-01-01T00:01:00Z"), None)
        self.assertEqual(result["status"], "unknown")

    def test_malformed_line_fails_without_echoing_content(self):
        path = Path(self.tmp.name) / "bad.jsonl"
        path.write_text('{"prompt": "secret"\n')
        with self.assertRaisesRegex(session_usage.UsageError, "malformed JSON") as caught:
            session_usage.extract_session(path)
        self.assertNotIn("secret", str(caught.exception))

    def test_missing_timestamp_fails_cleanly(self):
        path = self.write([{"type": "session_meta", "payload": {"id": "abc"}}])
        with self.assertRaisesRegex(session_usage.UsageError, "invalid timestamp"):
            session_usage.extract_session(path)

    def test_cached_delta_larger_than_input_delta_is_unknown(self):
        path = self.write([usage("2026-01-01T00:01:00Z", 100, 10, 1),
                           usage("2026-01-01T00:02:00Z", 110, 30, 2)])
        result = session_usage.extract_session(
            path, session_usage.parse_time("2026-01-01T00:01:30Z"), None)
        self.assertEqual(result["status"], "unknown")
        self.assertIn("cached input delta", result["reason"])


if __name__ == "__main__":
    unittest.main()
