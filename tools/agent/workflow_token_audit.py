#!/usr/bin/env python3
"""Token-cost audit for this repo's background Workflow runs.

Background Workflows (`.claude/workflows/*.js`) fan out per-round subagents
whose transcripts are persisted under the project transcript tree:

    <PROJECT>/<session-uuid>/subagents/workflows/wf_<id>/
        agent-<id>.jsonl       one transcript per subagent
        agent-<id>.meta.json   {"agentType": "workflow-subagent"}
        journal.jsonl          start/result events keyed by agentId

Each `.jsonl` line is a JSON object; assistant lines carry `message.usage`
(or a top-level `usage`) with input_tokens / output_tokens /
cache_read_input_tokens / cache_creation_input_tokens.

This tool sums those per agent, attributes each agent to a workflow PHASE by
regex-matching the first user-message text against per-workflow phase markers
(derived from the workflow scripts' prompt builders), detects which workflow a
run belongs to by the majority phase-marker set, and prints a per-phase token
table plus a cost estimate.

IMPORTANT — streamed-duplicate dedup:
    Each assistant message is written to the transcript TWICE (a streaming
    partial then the final), sharing the same `message.id`. The two lines carry
    identical input/cache_read/cache_creation but the partial has a smaller
    output_tokens. Summing every line (the naive approach) double-counts cache
    traffic ~1.5-1.7x and doubles the turn count. We dedup by `message.id`,
    keeping the line with the largest output_tokens per id. Lines without an id
    (rare) are counted once each.

Cost rates are APPROXIMATE per-MTok and may be stale — see RATES below. The
workflow subagents inherit the main-loop model (Opus), so Opus is the default;
`--model sonnet` switches rates.

Usage:
    python3 tools/agent/workflow_token_audit.py --all
    python3 tools/agent/workflow_token_audit.py --run wf_8dc65f93-f71
    python3 tools/agent/workflow_token_audit.py --workflow reclaim-naked
    python3 tools/agent/workflow_token_audit.py --all --model sonnet
    python3 tools/agent/workflow_token_audit.py --all --json
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from collections import defaultdict
from dataclasses import dataclass, field
from pathlib import Path

# ---------------------------------------------------------------------------
# Where transcripts live. The CLI default is this repo's project tree, but
# --transcript-root overrides it (e.g. a different machine / session export).
# ---------------------------------------------------------------------------
DEFAULT_TRANSCRIPT_ROOT = Path(
    "/Users/jackrickey/.claude/projects/-Users-jackrickey-Dev-frog-adv-decomp"
)

# ---------------------------------------------------------------------------
# Cost rates ($ per million tokens). APPROXIMATE — published list prices as of
# early 2026; treat the dollar figures as order-of-magnitude, not invoiced.
#   in  = fresh (uncached) input         out = output
#   cr  = cache read (cheap re-send)     cw  = cache write / creation
# ---------------------------------------------------------------------------
RATES = {
    "opus": {"in": 15.0, "cr": 1.50, "cw": 18.75, "out": 75.0},
    "sonnet": {"in": 3.0, "cr": 0.30, "cw": 3.75, "out": 15.0},
}

# ---------------------------------------------------------------------------
# Phase markers, per workflow. Each entry: (workflow_name, phase, regex) tested
# against the first user-message text of an agent transcript. The strings are
# the distinctive opening lines of each prompt builder in the .js workflows.
# Order matters: the first match wins, so more-specific markers come first
# (e.g. the two distinct INTEGRATOR openers before any generic fallback).
# ---------------------------------------------------------------------------
PHASE_MARKERS = [
    # --- finish-decomp ---
    ("finish-decomp", "Scout", re.compile(r"You are the SCOUT for one round")),
    ("finish-decomp", "Build queue", re.compile(r"You are the QUEUE-BUILDER")),
    ("finish-decomp", "Decomp", re.compile(r"You are a DECOMP agent in an isolated git worktree")),
    ("finish-decomp", "Integrate", re.compile(r"You are the INTEGRATOR for round \d+")),
    # --- reclaim-naked ---
    ("reclaim-naked", "Reclaim", re.compile(r"You are a NAKED-RECLAMATION agent")),
    ("reclaim-naked", "Integrate", re.compile(r"You are the INTEGRATOR for reclamation batch")),
]

# Display order of phases per workflow (for stable table rows).
PHASE_ORDER = {
    "finish-decomp": ["Scout", "Build queue", "Decomp", "Integrate", "?"],
    "reclaim-naked": ["Reclaim", "Integrate", "?"],
    "unknown": ["?"],
}


# ---------------------------------------------------------------------------
# Per-agent accumulator
# ---------------------------------------------------------------------------
@dataclass
class AgentTotals:
    agent_id: str
    workflow: str = "unknown"
    phase: str = "?"
    inp: int = 0           # fresh (uncached) input tokens
    out: int = 0           # output tokens
    cache_read: int = 0    # cache_read_input_tokens
    cache_create: int = 0  # cache_creation_input_tokens
    turns: int = 0         # assistant turns (deduped by message id)

    @property
    def total(self) -> int:
        return self.inp + self.out + self.cache_read + self.cache_create


@dataclass
class PhaseAgg:
    n: int = 0
    inp: int = 0
    out: int = 0
    cache_read: int = 0
    cache_create: int = 0
    turns: int = 0
    max_turns: int = 0   # highest single-agent turn count (the cache-traffic driver)

    def add(self, a: AgentTotals) -> None:
        self.n += 1
        self.inp += a.inp
        self.out += a.out
        self.cache_read += a.cache_read
        self.cache_create += a.cache_create
        self.turns += a.turns
        self.max_turns = max(self.max_turns, a.turns)

    @property
    def total(self) -> int:
        return self.inp + self.out + self.cache_read + self.cache_create


@dataclass
class RunAudit:
    run_id: str
    session: str
    workflow: str
    n_agents: int
    phases: dict  # phase -> PhaseAgg
    agents: list = field(default_factory=list)  # AgentTotals (for --json / drill-down)


# ---------------------------------------------------------------------------
# Parsing
# ---------------------------------------------------------------------------
def _first_user_text(path: Path) -> str:
    """Return the text of the first user message (the agent's task prompt)."""
    with path.open() as fh:
        for line in fh:
            try:
                o = json.loads(line)
            except json.JSONDecodeError:
                continue
            msg = o.get("message", o)
            role = msg.get("role") or o.get("type")
            if role != "user":
                continue
            content = msg.get("content")
            if isinstance(content, str):
                return content
            if isinstance(content, list):
                parts = [b.get("text", "") for b in content if isinstance(b, dict) and b.get("type") == "text"]
                if parts:
                    return "".join(parts)
                # tool_result-only user turns carry no prompt text; keep scanning.
                continue
    return ""


def attribute_phase(first_text: str) -> tuple[str, str]:
    """Map a first-user-message to (workflow, phase). ('unknown','?') if none."""
    for wf, phase, rx in PHASE_MARKERS:
        if rx.search(first_text):
            return wf, phase
    return "unknown", "?"


def parse_agent(path: Path) -> AgentTotals:
    """Sum token usage for one agent transcript, deduping streamed message lines.

    Keeps, per message id, the line with the largest output_tokens (the final
    streamed copy carries the full output; the partial carries less). Usage
    lines without a message id are counted once each.
    """
    agent_id = path.stem.replace("agent-", "")
    # message id -> (inp, out, cr, cc, is_assistant)
    by_id: dict[str, tuple] = {}
    noid_inp = noid_out = noid_cr = noid_cc = noid_turns = 0

    with path.open() as fh:
        for line in fh:
            try:
                o = json.loads(line)
            except json.JSONDecodeError:
                continue
            msg = o.get("message", o)
            u = msg.get("usage") or o.get("usage")
            if not u:
                continue
            role = msg.get("role") or o.get("type")
            inp = u.get("input_tokens", 0) or 0
            out = u.get("output_tokens", 0) or 0
            cr = u.get("cache_read_input_tokens", 0) or 0
            cc = u.get("cache_creation_input_tokens", 0) or 0
            is_asst = role == "assistant"
            mid = msg.get("id")
            if mid:
                cand = (inp, out, cr, cc, is_asst)
                cur = by_id.get(mid)
                # keep the copy with the larger output (final streamed line)
                if cur is None or cand[1] > cur[1]:
                    by_id[mid] = cand
            else:
                noid_inp += inp
                noid_out += out
                noid_cr += cr
                noid_cc += cc
                if is_asst:
                    noid_turns += 1

    t = AgentTotals(agent_id=agent_id)
    for inp, out, cr, cc, is_asst in by_id.values():
        t.inp += inp
        t.out += out
        t.cache_read += cr
        t.cache_create += cc
        if is_asst:
            t.turns += 1
    t.inp += noid_inp
    t.out += noid_out
    t.cache_read += noid_cr
    t.cache_create += noid_cc
    t.turns += noid_turns

    first = _first_user_text(path)
    t.workflow, t.phase = attribute_phase(first)
    return t


def audit_run(run_dir: Path) -> RunAudit:
    """Audit one wf_<id> directory."""
    run_id = run_dir.name
    # session-uuid is the dir three levels up: <session>/subagents/workflows/wf_id
    try:
        session = run_dir.parents[2].name
    except IndexError:
        session = "?"

    agents = [parse_agent(p) for p in sorted(run_dir.glob("agent-*.jsonl"))]

    # Detect the run's workflow by majority phase-marker set.
    wf_votes: dict[str, int] = defaultdict(int)
    for a in agents:
        if a.workflow != "unknown":
            wf_votes[a.workflow] += 1
    workflow = max(wf_votes, key=wf_votes.get) if wf_votes else "unknown"

    # Re-stamp agents that fell through to 'unknown' but belong to this run's
    # workflow: leave their phase as '?' (a genuinely-unmatched prompt), but the
    # run-level workflow label is the majority. Don't rewrite their workflow —
    # an unknown phase under a known run stays in the '?' bucket.
    phases: dict[str, PhaseAgg] = defaultdict(PhaseAgg)
    for a in agents:
        phases[a.phase].add(a)

    return RunAudit(
        run_id=run_id,
        session=session,
        workflow=workflow,
        n_agents=len(agents),
        phases=phases,
        agents=agents,
    )


# ---------------------------------------------------------------------------
# Cost
# ---------------------------------------------------------------------------
def cost_of(agg: PhaseAgg, rate: dict) -> float:
    return (
        agg.inp * rate["in"]
        + agg.cache_read * rate["cr"]
        + agg.cache_create * rate["cw"]
        + agg.out * rate["out"]
    ) / 1_000_000.0


# ---------------------------------------------------------------------------
# Discovery
# ---------------------------------------------------------------------------
def find_runs(root: Path) -> list[Path]:
    return sorted(root.glob("*/subagents/workflows/wf_*"))


# ---------------------------------------------------------------------------
# Rendering
# ---------------------------------------------------------------------------
def _fmt_k(n: int) -> str:
    """Compact token count: 1_234_567 -> '1.23M', 12_345 -> '12.3k'."""
    if n >= 1_000_000:
        return f"{n / 1_000_000:.2f}M"
    if n >= 1_000:
        return f"{n / 1_000:.1f}k"
    return str(n)


def print_run_human(run: RunAudit, model: str) -> None:
    rate = RATES[model]
    order = PHASE_ORDER.get(run.workflow, PHASE_ORDER["unknown"])
    present = [p for p in order if p in run.phases]
    for p in run.phases:  # any phase not in the canonical order
        if p not in present:
            present.append(p)

    print(f"\n=== {run.run_id}  workflow={run.workflow}  session={run.session[:13]}  "
          f"agents={run.n_agents}  model={model} ===")
    hdr = f"  {'phase':<12} {'n':>3} {'fresh_in':>9} {'output':>9} {'cache_rd':>9} {'cache_cr':>9} {'turns':>6} {'max_t':>6} {'total':>9} {'est_$':>9}"
    print(hdr)
    print("  " + "-" * (len(hdr) - 2))

    run_agg = PhaseAgg()
    run_cost = 0.0
    for p in present:
        agg = run.phases[p]
        c = cost_of(agg, rate)
        run_cost += c
        run_agg.n += agg.n
        run_agg.inp += agg.inp
        run_agg.out += agg.out
        run_agg.cache_read += agg.cache_read
        run_agg.cache_create += agg.cache_create
        run_agg.turns += agg.turns
        run_agg.max_turns = max(run_agg.max_turns, agg.max_turns)
        print(f"  {p:<12} {agg.n:>3} {_fmt_k(agg.inp):>9} {_fmt_k(agg.out):>9} "
              f"{_fmt_k(agg.cache_read):>9} {_fmt_k(agg.cache_create):>9} "
              f"{agg.turns:>6} {agg.max_turns:>6} {_fmt_k(agg.total):>9} {c:>8.2f}")
    print("  " + "-" * (len(hdr) - 2))
    print(f"  {'TOTAL':<12} {run_agg.n:>3} {_fmt_k(run_agg.inp):>9} {_fmt_k(run_agg.out):>9} "
          f"{_fmt_k(run_agg.cache_read):>9} {_fmt_k(run_agg.cache_create):>9} "
          f"{run_agg.turns:>6} {run_agg.max_turns:>6} {_fmt_k(run_agg.total):>9} {run_cost:>8.2f}")

    # Token-mix split (the key signal: cache-traffic vs fresh).
    tot = run_agg.total or 1
    print(f"  mix: fresh_in {100*run_agg.inp/tot:4.1f}%  "
          f"cache_rd {100*run_agg.cache_read/tot:4.1f}%  "
          f"cache_cr {100*run_agg.cache_create/tot:4.1f}%  "
          f"output {100*run_agg.out/tot:4.1f}%   "
          f"(est ${run_cost:.2f} {model}; rates approximate)")


def run_to_dict(run: RunAudit, model: str) -> dict:
    rate = RATES[model]
    phases = {}
    run_agg = PhaseAgg()
    for p, agg in run.phases.items():
        phases[p] = {
            "n": agg.n, "fresh_input": agg.inp, "output": agg.out,
            "cache_read": agg.cache_read, "cache_create": agg.cache_create,
            "turns": agg.turns, "max_turns": agg.max_turns,
            "total": agg.total, "est_cost_usd": round(cost_of(agg, rate), 2),
        }
        for fld in ("inp", "out", "cache_read", "cache_create", "turns"):
            setattr(run_agg, fld, getattr(run_agg, fld) + getattr(agg, fld))
        run_agg.n += agg.n
        run_agg.max_turns = max(run_agg.max_turns, agg.max_turns)
    return {
        "run_id": run.run_id,
        "session": run.session,
        "workflow": run.workflow,
        "n_agents": run.n_agents,
        "model": model,
        "phases": phases,
        "total": {
            "n": run_agg.n, "fresh_input": run_agg.inp, "output": run_agg.out,
            "cache_read": run_agg.cache_read, "cache_create": run_agg.cache_create,
            "turns": run_agg.turns, "max_turns": run_agg.max_turns,
            "total": run_agg.total, "est_cost_usd": round(cost_of(run_agg, rate), 2),
        },
    }


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------
def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        description="Per-phase token-cost audit of background Workflow runs.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    sel = ap.add_mutually_exclusive_group()
    sel.add_argument("--all", action="store_true", help="audit every wf_* run under the transcript tree")
    sel.add_argument("--run", metavar="WF_ID", help="audit one run by its wf_<id> directory name")
    ap.add_argument("--workflow", metavar="NAME", help="filter to runs detected as this workflow (finish-decomp|reclaim-naked)")
    ap.add_argument("--model", choices=sorted(RATES), default="opus", help="cost-rate model (default: opus — subagents inherit the main-loop model)")
    ap.add_argument("--transcript-root", type=Path, default=DEFAULT_TRANSCRIPT_ROOT, help="root of the project transcript tree")
    ap.add_argument("--json", action="store_true", help="emit machine-readable JSON instead of tables")
    args = ap.parse_args(argv)

    root = args.transcript_root
    if not root.exists():
        print(f"transcript root not found: {root}", file=sys.stderr)
        return 2

    if args.run:
        matches = [d for d in find_runs(root) if d.name == args.run]
        if not matches:
            print(f"run not found: {args.run}", file=sys.stderr)
            return 2
        run_dirs = matches
    else:
        run_dirs = find_runs(root)

    runs = [audit_run(d) for d in run_dirs]

    if args.workflow:
        runs = [r for r in runs if r.workflow == args.workflow]
        if not runs:
            print(f"no runs detected as workflow={args.workflow}", file=sys.stderr)
            return 2

    if args.json:
        out = {"model": args.model, "runs": [run_to_dict(r, args.model) for r in runs]}
        print(json.dumps(out, indent=2))
        return 0

    for r in runs:
        print_run_human(r, args.model)

    # Cross-run grand total.
    if len(runs) > 1:
        rate = RATES[args.model]
        grand = PhaseAgg()
        grand_cost = 0.0
        for r in runs:
            for agg in r.phases.values():
                grand.n += agg.n
                grand.inp += agg.inp
                grand.out += agg.out
                grand.cache_read += agg.cache_read
                grand.cache_create += agg.cache_create
                grand.turns += agg.turns
                grand.max_turns = max(grand.max_turns, agg.max_turns)
            grand_cost += sum(cost_of(a, rate) for a in r.phases.values())
        print(f"\n=== GRAND TOTAL over {len(runs)} runs  model={args.model} ===")
        print(f"  agents={grand.n}  fresh_in={_fmt_k(grand.inp)}  output={_fmt_k(grand.out)}  "
              f"cache_rd={_fmt_k(grand.cache_read)}  cache_cr={_fmt_k(grand.cache_create)}  "
              f"turns={grand.turns}  total={_fmt_k(grand.total)}  est ${grand_cost:.2f} ({args.model}, approximate)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
