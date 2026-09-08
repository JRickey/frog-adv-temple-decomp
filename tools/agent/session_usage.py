#!/usr/bin/env python3
"""Extract bounded, content-free token usage from explicit Codex JSONL sessions."""

from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path


class UsageError(ValueError):
    pass


COUNTERS = ("input_tokens", "cached_input_tokens", "output_tokens", "total_tokens")


def parse_time(value: str) -> datetime:
    try:
        parsed = datetime.fromisoformat(value.replace("Z", "+00:00"))
    except (AttributeError, TypeError, ValueError) as exc:
        raise UsageError(f"invalid timestamp: {value!r}") from exc
    if parsed.tzinfo is None:
        raise UsageError(f"timestamp must include a UTC offset: {value!r}")
    return parsed.astimezone(timezone.utc)


def _counters(value: object, path: Path, line_no: int) -> dict[str, int]:
    if not isinstance(value, dict):
        raise UsageError(f"{path}:{line_no}: missing total_token_usage")
    result = {}
    for name in COUNTERS:
        number = value.get(name)
        if isinstance(number, bool) or not isinstance(number, int) or number < 0:
            raise UsageError(f"{path}:{line_no}: invalid {name}")
        result[name] = number
    if result["cached_input_tokens"] > result["input_tokens"]:
        raise UsageError(f"{path}:{line_no}: cached input exceeds input")
    return result


def _safe_rate_limits(value: object) -> object:
    """Retain quota counters while excluding unrelated event metadata."""
    if not isinstance(value, dict):
        return None
    allowed = {
        "limit_id", "limit_name", "primary", "secondary", "credits",
        "individual_limit", "spend_control_reached", "plan_type",
        "rate_limit_reached_type",
    }
    return {key: value[key] for key in allowed if key in value}


def extract_session(path: Path, start: datetime | None = None,
                    end: datetime | None = None) -> dict[str, object]:
    path = path.resolve()
    session_id = None
    first_time = None
    usages = []
    contexts = []
    try:
        lines = path.open(encoding="utf-8")
    except OSError as exc:
        raise UsageError(f"cannot read {path}: {exc}") from exc
    with lines:
        for line_no, line in enumerate(lines, 1):
            try:
                record = json.loads(line)
            except json.JSONDecodeError as exc:
                raise UsageError(f"{path}:{line_no}: malformed JSON") from exc
            if not isinstance(record, dict):
                raise UsageError(f"{path}:{line_no}: record is not an object")
            timestamp = parse_time(record.get("timestamp"))
            first_time = timestamp if first_time is None else min(first_time, timestamp)
            kind = record.get("type")
            payload = record.get("payload")
            if not isinstance(payload, dict):
                continue
            if kind == "session_meta" and isinstance(payload.get("id"), str):
                if session_id is not None and session_id != payload["id"]:
                    raise UsageError(f"{path}:{line_no}: conflicting session ids")
                session_id = payload["id"]
            elif kind == "turn_context":
                model = payload.get("model")
                effort = payload.get("effort")
                if isinstance(model, str) or isinstance(effort, str):
                    contexts.append((timestamp, model if isinstance(model, str) else None,
                                     effort if isinstance(effort, str) else None))
            elif kind == "event_msg" and payload.get("type") == "token_count":
                info = payload.get("info")
                if not isinstance(info, dict):
                    raise UsageError(f"{path}:{line_no}: missing token_count info")
                usages.append((timestamp, _counters(info.get("total_token_usage"), path, line_no),
                               _safe_rate_limits(payload.get("rate_limits"))))

    if start is not None and end is not None and start > end:
        raise UsageError("--start must not be later than --end")
    bounded = [item for item in usages if end is None or item[0] <= end]
    for previous, current in zip(bounded, bounded[1:]):
        if any(current[1][name] < previous[1][name] for name in COUNTERS):
            return _unknown(path, session_id, "nonmonotonic cumulative counters", contexts,
                            start, end)
    after = bounded[-1] if bounded else None
    if after is None:
        return _unknown(path, session_id, "no usage counter at or before end", contexts,
                        start, end)

    before = None
    baseline = None
    if start is None:
        baseline = {name: 0 for name in COUNTERS}
    else:
        prior = [item for item in bounded if item[0] < start]
        if prior:
            before = prior[-1]
            baseline = before[1]
        elif first_time is not None and first_time >= start:
            baseline = {name: 0 for name in COUNTERS}
        else:
            return _unknown(path, session_id, "no cumulative baseline before start", contexts,
                            start, end)

    delta = {name: after[1][name] - baseline[name] for name in COUNTERS}
    if any(value < 0 for value in delta.values()):
        return _unknown(path, session_id, "cumulative counters reset across window", contexts,
                        start, end)
    delta["uncached_input_tokens"] = delta["input_tokens"] - delta["cached_input_tokens"]
    if delta["uncached_input_tokens"] < 0:
        return _unknown(path, session_id, "cached input delta exceeds input delta", contexts,
                        start, end)
    return {
        "path": str(path), "session_id": session_id, "status": "known",
        "window": _window(start, end), "usage": delta,
        "contexts": _selected_contexts(contexts, start, end),
        "rate_limits": {"scope": "account_wide", "before": before[2] if before else None,
                        "after": after[2]},
    }


def _window(start, end):
    return {"start": start.isoformat() if start else None,
            "end": end.isoformat() if end else None}


def _selected_contexts(contexts, start, end):
    selected = []
    prior = [item for item in contexts if start is not None and item[0] < start]
    if prior:
        selected.append(prior[-1])
    selected.extend(item for item in contexts
                    if (start is None or item[0] >= start) and (end is None or item[0] <= end))
    result = []
    for _, model, effort in selected:
        pair = {"model": model, "reasoning_effort": effort}
        if pair not in result:
            result.append(pair)
    return result


def _unknown(path, session_id, reason, contexts, start, end):
    return {
        "path": str(path), "session_id": session_id, "status": "unknown",
        "reason": reason, "window": _window(start, end), "usage": None,
        "contexts": _selected_contexts(contexts, start, end),
        "rate_limits": {"scope": "account_wide", "before": None, "after": None},
    }


def build_report(paths: list[Path], start=None, end=None):
    sessions = []
    seen_paths = set()
    seen_ids = set()
    for path in paths:
        resolved = path.resolve()
        if resolved in seen_paths:
            continue
        result = extract_session(resolved, start, end)
        identity = result["session_id"]
        if identity is not None and identity in seen_ids:
            continue
        seen_paths.add(resolved)
        if identity is not None:
            seen_ids.add(identity)
        sessions.append(result)
    known = [item["usage"] for item in sessions if item["status"] == "known"]
    totals = {name: sum(item[name] for item in known) for name in (*COUNTERS, "uncached_input_tokens")}
    return {"sessions": sessions, "summary": {"known_sessions": len(known),
            "unknown_sessions": len(sessions) - len(known), "known_totals": totals,
            "complete": len(known) == len(sessions)}}


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("sessions", nargs="+", type=Path, help="explicit Codex JSONL file(s)")
    parser.add_argument("--start", type=parse_time, help="inclusive UTC timestamp")
    parser.add_argument("--end", type=parse_time, help="inclusive UTC timestamp")
    args = parser.parse_args(argv)
    try:
        report = build_report(args.sessions, args.start, args.end)
    except UsageError as exc:
        parser.error(str(exc))
    json.dump(report, sys.stdout, indent=2, sort_keys=True)
    sys.stdout.write("\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
