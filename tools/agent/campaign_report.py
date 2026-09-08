#!/usr/bin/env python3
"""Validate and summarize read-only campaign run ledgers.

This tool only reports recorded calibration data. It does not schedule work, estimate price, rank
models, or infer missing usage.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from collections import Counter
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_DIR = ROOT / "docs" / "campaigns"
ID_RE = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]*$")
USAGE_FIELDS = ("input_tokens", "output_tokens")


class CampaignError(ValueError):
    """A ledger is malformed or conflicts with another supplied ledger."""


def _nonempty_string(value: Any, where: str) -> str:
    if not isinstance(value, str) or not value.strip():
        raise CampaignError(f"{where} must be a non-empty string")
    return value


def _id(value: Any, where: str) -> str:
    value = _nonempty_string(value, where)
    if not ID_RE.fullmatch(value):
        raise CampaignError(f"{where} must contain only letters, digits, '.', '_', or '-'")
    return value


def _number(value: Any, where: str) -> int | float:
    if isinstance(value, bool) or not isinstance(value, (int, float)):
        raise CampaignError(f"{where} must be numeric")
    return value


def _token_count(value: Any, where: str) -> int:
    if isinstance(value, bool) or not isinstance(value, int) or value < 0:
        raise CampaignError(f"{where} must be a non-negative integer")
    return value


def validate_campaign(record: Any, source: str) -> dict[str, Any]:
    if not isinstance(record, dict):
        raise CampaignError(f"{source} must be an object")
    required = ("schema_version", "id", "base_commit", "rom_sha1", "summary", "metrics", "runs")
    missing = [field for field in required if field not in record]
    if missing:
        raise CampaignError(f"{source}: missing {', '.join(missing)}")
    if isinstance(record["schema_version"], bool) or record["schema_version"] != 1:
        raise CampaignError(f"{source}.schema_version must be 1")
    _id(record["id"], f"{source}.id")
    _nonempty_string(record["base_commit"], f"{source}.base_commit")
    _nonempty_string(record["rom_sha1"], f"{source}.rom_sha1")
    _nonempty_string(record["summary"], f"{source}.summary")
    metrics = record["metrics"]
    if not isinstance(metrics, dict):
        raise CampaignError(f"{source}.metrics must be an object")
    for name, value in metrics.items():
        if not isinstance(name, str) or not name:
            raise CampaignError(f"{source}.metrics keys must be non-empty strings")
        _number(value, f"{source}.metrics.{name}")
    runs = record["runs"]
    if not isinstance(runs, list):
        raise CampaignError(f"{source}.runs must be an array")
    for index, run in enumerate(runs):
        _validate_run(run, f"{source}.runs[{index}]")
    return record


def _validate_run(run: Any, source: str) -> None:
    if not isinstance(run, dict):
        raise CampaignError(f"{source} must be an object")
    required = ("id", "model", "reasoning_effort", "task", "outcome", "review_corrections", "usage")
    missing = [field for field in required if field not in run]
    if missing:
        raise CampaignError(f"{source}: missing {', '.join(missing)}")
    for field in ("id", "model", "task", "outcome"):
        _id(run[field], f"{source}.{field}") if field == "id" else _nonempty_string(run[field], f"{source}.{field}")
    effort = run["reasoning_effort"]
    if effort is not None and not isinstance(effort, str):
        raise CampaignError(f"{source}.reasoning_effort must be null or a string")
    corrections = run["review_corrections"]
    if not isinstance(corrections, list) or not all(isinstance(x, str) for x in corrections):
        raise CampaignError(f"{source}.review_corrections must be an array of strings")
    usage = run["usage"]
    if usage is None:
        return
    if not isinstance(usage, dict):
        raise CampaignError(f"{source}.usage must be null or an object")
    for field in USAGE_FIELDS:
        if field not in usage:
            raise CampaignError(f"{source}.usage missing {field}")
        _token_count(usage[field], f"{source}.usage.{field}")
    if "cached_input_tokens" in usage:
        _token_count(usage["cached_input_tokens"], f"{source}.usage.cached_input_tokens")


def ledger_paths(path: Path) -> list[Path]:
    if path.is_file():
        return [path]
    if path.exists() and not path.is_dir():
        raise CampaignError(f"{path} is neither a JSON file nor a directory")
    return sorted(path.glob("*.json")) if path.exists() else []


def load_campaigns(path: Path = DEFAULT_DIR) -> list[dict[str, Any]]:
    campaigns: list[dict[str, Any]] = []
    campaign_ids: dict[str, str] = {}
    run_ids: dict[str, str] = {}
    for ledger_path in ledger_paths(path):
        try:
            payload = json.loads(ledger_path.read_text())
        except (OSError, json.JSONDecodeError) as exc:
            raise CampaignError(f"{ledger_path}: {exc}") from exc
        records = payload if isinstance(payload, list) else [payload]
        for index, raw in enumerate(records):
            source = f"{ledger_path}[{index}]"
            record = validate_campaign(raw, source)
            campaign_id = record["id"]
            if campaign_id in campaign_ids:
                raise CampaignError(f"{source}: duplicate campaign id {campaign_id!r} (first in {campaign_ids[campaign_id]})")
            campaign_ids[campaign_id] = source
            for run_index, run in enumerate(record["runs"]):
                run_id = run["id"]
                run_source = f"{source}.runs[{run_index}]"
                if run_id in run_ids:
                    raise CampaignError(f"{run_source}: duplicate run id {run_id!r} (first in {run_ids[run_id]})")
                run_ids[run_id] = run_source
            campaigns.append(record)
    return sorted(campaigns, key=lambda campaign: campaign["id"])


def report_data(campaigns: list[dict[str, Any]]) -> dict[str, Any]:
    runs = [run for campaign in campaigns for run in campaign["runs"]]
    outcomes = Counter(run["outcome"] for run in runs)
    models = Counter(run["model"] for run in runs)
    known_usage = [run["usage"] for run in runs if run["usage"] is not None]
    known_input = sum(usage["input_tokens"] for usage in known_usage)
    known_output = sum(usage["output_tokens"] for usage in known_usage)
    cached_usage = [usage["cached_input_tokens"] for usage in known_usage if "cached_input_tokens" in usage]
    usage_complete = bool(runs) and len(known_usage) == len(runs)
    usage_status = "complete" if usage_complete else "partial" if known_usage else "unavailable"
    complete_totals = None
    if usage_complete:
        complete_totals = {
            "input_tokens": known_input,
            "output_tokens": known_output,
        }
        if len(cached_usage) == len(known_usage):
            complete_totals["cached_input_tokens"] = sum(cached_usage)
    return {
        "campaigns": campaigns,
        "summary": {
            "campaign_count": len(campaigns),
            "run_count": len(runs),
            "outcomes": dict(sorted(outcomes.items())),
            "models": dict(sorted(models.items())),
            "review_correction_count": sum(len(run["review_corrections"]) for run in runs),
            "usage": {
                "known_runs": len(known_usage),
                "unknown_runs": len(runs) - len(known_usage),
                "complete": usage_complete,
                "status": usage_status,
                "known_totals": {
                    "input_tokens": known_input,
                    "output_tokens": known_output,
                    "cached_input_tokens": sum(cached_usage) if cached_usage else None,
                    "cached_input_tokens_known_runs": len(cached_usage),
                },
                "complete_totals": complete_totals,
            },
        },
    }


def format_report(data: dict[str, Any]) -> str:
    summary = data["summary"]
    lines = [f"Campaigns: {summary['campaign_count']}", f"Runs: {summary['run_count']}"]
    lines.append("Outcomes: " + (", ".join(f"{key}={value}" for key, value in summary["outcomes"].items()) or "none"))
    lines.append("Models: " + (", ".join(f"{key}={value}" for key, value in summary["models"].items()) or "none"))
    usage = summary["usage"]
    status = usage["status"]
    lines.append(f"Usage: {status} ({usage['known_runs']}/{summary['run_count']} runs known)")
    known = usage["known_totals"]
    lines.append(f"Known usage totals: input_tokens={known['input_tokens']}, output_tokens={known['output_tokens']}")
    if known["cached_input_tokens"] is not None:
        lines.append(
            f"Known cached input: {known['cached_input_tokens']} "
            f"({known['cached_input_tokens_known_runs']}/{usage['known_runs']} known-usage runs reported it)"
        )
    if usage["complete_totals"] is None:
        reason = "no runs recorded" if summary["run_count"] == 0 else "one or more runs have null usage"
        lines.append(f"Complete overall usage totals: unavailable ({reason})")
    else:
        lines.append("Complete overall usage totals: " + ", ".join(
            f"{key}={value}" for key, value in usage["complete_totals"].items()
        ))
    lines.append(f"Review corrections: {summary['review_correction_count']}")
    return "\n".join(lines)


def main() -> None:
    parser = argparse.ArgumentParser(description="Validate and summarize campaign run ledgers.")
    parser.add_argument("path", nargs="?", type=Path, default=DEFAULT_DIR,
                        help="ledger JSON file or directory (default: docs/campaigns)")
    parser.add_argument("--json", action="store_true", help="emit validated ledgers and summary as JSON")
    args = parser.parse_args()
    try:
        data = report_data(load_campaigns(args.path))
    except CampaignError as exc:
        parser.error(str(exc))
    if args.json:
        print(json.dumps(data, indent=2, sort_keys=True))
    else:
        print(format_report(data))


if __name__ == "__main__":
    main()
