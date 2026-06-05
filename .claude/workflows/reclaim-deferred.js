export const meta = {
  name: 'reclaim-deferred',
  description:
    "Codex-only reclamation sweep over the DEFERRED-ANALYSIS backlog of Frogger's Adventures: Temple of the Frog. Enumerates docs/deferred-analysis/*.md (every function a prior Sonnet/Opus/codex agent deferred with a stashed drift note), keeps the ones still un-decompiled AND legal to attempt, and dispatches EACH to codex (GPT-5.5-high) via the codex plugin runtime — the exact dispatch+verify mechanism finish-decomp uses (a thin Sonnet driver shells `codex-companion.mjs task`, then INDEPENDENTLY verifies byte_diff + structural NAKED and commits). codex reads the prior drift note plus the now-fixed tooling (permuter, corpus history search) to escape the plateau. Integrates onto main one commit at a time with a make-check safety net. No Claude decomp tier, no builder/peel — a finite sweep of the existing backlog.",
  whenToUse:
    'Sweep the whole deferred-analysis backlog through codex GPT-5.5-high (run after the tooling fixes). Commits land on main; make check guards every cherry-pick. Re-run to continue; already-resolved or layout-blocked notes are skipped automatically.',
  phases: [
    { title: 'Scout', detail: 'enumerate docs/deferred-analysis/*.md, keep still-legal unmatched ones (read-only on main)', model: 'sonnet' },
    { title: 'Codex', detail: 'rolling pool of K Sonnet drivers, each shelling codex GPT-5.5-high on one deferred target', model: 'sonnet' },
    { title: 'Integrate', detail: 'per-result: cherry-pick onto main (serialized lock), make check, revert breakers', model: 'sonnet' },
    { title: 'Finalize', detail: 'once after the pool drains: regen scoreboard + prune worktrees', model: 'sonnet' },
  ],
}

// ---------------------------------------------------------------------------
// Config (override via Workflow args: {parallel, candidates, skip, maxTargets, codex:{model,effort}})
// ---------------------------------------------------------------------------
const MAIN = '/Users/jackrickey/Dev/frog-adv-decomp'

// args may arrive as an OBJECT or a JSON-encoded STRING — normalize to A.
let A = args
if (typeof A === 'string') {
  try { A = JSON.parse(A) } catch (e) { A = {} }
}
if (!A || typeof A !== 'object') A = {}

const K = A.parallel || 4 // parallel codex drivers (rolling pool). codex runs are long + Max-sub-bound; keep modest.
const MAX_TARGETS = A.maxTargets || null // cap total codex dispatches (null = every legal deferred doc)
const BUDGET_FLOOR = 80_000

// codex (GPT-5.5-high) is the ONLY decomp tier here. model+effort default to ~/.codex/config.toml;
// goal mode is stable-default-on. Override via args.codex.{model,effort}.
const CODEX = Object.assign({ model: 'gpt-5.5', effort: 'high' }, A.codex || {})
// Orchestration agents (scout, integrator, the codex DRIVER shell) are mechanical -> Sonnet. The
// expensive reasoning is codex's, not the driver's.
const MODELS = Object.assign(
  { scout: 'sonnet', integrate: 'sonnet', codexDriver: 'sonnet' },
  A.models || {},
)
// Optional explicit subset of deferred fns to sweep (else: ALL legal deferred docs). SKIP is never
// dispatched (e.g. a name you've confirmed is genuinely STRONG_UNMATCHABLE).
const ONLY = A.candidates || null
const SKIP = A.skip || []
const BOOTSTRAP = `
WORKTREE BOOTSTRAP (run FIRST, before any build — fresh worktrees lack gitignored deps):
\`\`\`sh
MAIN=${MAIN}
# GITIGNORED deps — plain symlink from main. corpus-mirrors (1.4G) is REQUIRED for the asm-history
# search (corpus_asm_search.py); tools/agbcc-src is the agbcc COMPILER SOURCE you read to crack
# coloring/fold/schedule divergences. Omitting either silently disables the two hardest-tier levers.
for dep in tools/agbcc tools/agbcc-src tools/agent/bin tools/agent/corpus-mirrors \\
           baserom.gba frog_us_baserom.gba node_modules; do
  [ -e "$dep" ] || ln -s "$MAIN/$dep" "$dep"
done
# vendor/{decomp-permuter,m2c} are git SUBMODULES. \`git worktree add\` leaves an EMPTY mountpoint
# dir, which made the old \`[ -e ]\` guard SKIP the symlink — so .venv/permuter.py went missing and
# the permuter silently never ran in worktrees. Replace each empty mountpoint with a symlink to
# main's populated checkout (which has the gitignored .venv), then \`submodule.<sub>.ignore all\` so
# \`git status\` does not error (exit 128) on the gitlink->symlink typechange and stays clean.
for sub in vendor/decomp-permuter vendor/m2c; do
  if [ ! -L "$sub" ] && [ -d "$sub" ] && [ -z "$(ls -A "$sub" 2>/dev/null)" ]; then
    rmdir "$sub" 2>/dev/null && ln -s "$MAIN/$sub" "$sub"
  fi
  git config "submodule.$sub.ignore" all 2>/dev/null
done
# tools/agbcc-src is the agbcc COMPILER SOURCE (gcc 2.x) — gcc_arm/{local-alloc,regclass,
# reload,cse,gcse,loop,combine}.c. Read the relevant pass to understand WHY agbcc diverges
# (which register it picks, when it strength-reduces a loop, when it CSE-folds) and what C
# avoids it. This is how the hardest matches get cracked — not by mutating, by understanding.
# Sanity-check the hard-tier levers actually resolved (symlinks above), so a decomp does not waste
# a session discovering they are missing:
[ -x vendor/decomp-permuter/.venv/bin/python ] || echo "WARN: permuter .venv missing"
[ -e tools/agent/corpus-mirrors ] || echo "WARN: corpus-mirrors missing (asm-history search disabled)"
# data/ is gitignored; populate if empty (needs baserom symlink first):
[ -n "$(ls -A data 2>/dev/null)" ] || python3 tools/extractor.py
git status --short      # MUST be empty (all the above are gitignored / submodule-ignored)
make -j4 && make check  # MUST exit 0 on the pristine tree before you touch anything
\`\`\`
If 'make check' does NOT exit 0 on the pristine bootstrapped tree, STOP and report
status "reverted" with note "bootstrap make check failed" — do not attempt work.`

const WORKTREE_RULES = `
HARD RULES (worktree mode):
- STAY in your worktree. NEVER 'cd' to ${MAIN}; it is only the symlink source.
- NEVER use the Edit/Write tools in your worktree. They SILENTLY RESOLVE TO MAIN and
  corrupt it (this raced and broke an overnight run — a decomp's .c + linker.ld landed on
  main, not the worktree). Write/modify EVERY file via BASH ONLY: a quoted heredoc
  (cat > path <<"EOF" ... EOF), python, or sed -i. After each write, confirm it landed in
  YOUR worktree with bash: git status --short (run from pwd) + grep -n the file. Bash is the
  ONLY safe writer inside a worktree; Edit/Write are forbidden here.
- Do NOT touch README.md, and do NOT run progress_stats.py or snapshot_addresses.py
  (the integrator regenerates those once on main — agent README bumps cause merge
  conflicts).
- Record your base commit at the very start:  BASE=$(git rev-parse HEAD)
- End with a CLEAN 'git status --short' (everything either committed or reverted).
- Report your worktree path:  pwd  (and: git rev-parse --show-toplevel)
- Report your commit SHAs in apply order:  git rev-list --reverse $BASE..HEAD
- If 'make check' ever fails after your change and you cannot fix it: revert
  EVERYTHING ('git reset --hard $BASE' + 'git clean -fd' on untracked you added)
  and report status "reverted" with the blocker. NEVER leave a broken tree.`

// ---------------------------------------------------------------------------
// Schemas
// ---------------------------------------------------------------------------
const CAND_SCHEMA = {
  type: 'object',
  required: ['name', 'asmFile', 'destC', 'addr', 'byteSize'],
  properties: {
    name: { type: 'string' },
    asmFile: { type: 'string' },
    destC: { type: 'string' },
    addr: { type: 'string' },
    byteSize: { type: 'integer' },
    nextTier: { type: 'string' }, // 'opus' (Sonnet-deferred) | 'codex' (firm-defer) | '' — informational; ALL go to codex here
  },
}

const PLAN_SCHEMA = {
  type: 'object',
  required: ['mainDirty', 'deferredNoteCount', 'candidates'],
  properties: {
    mainDirty: { type: 'boolean' },
    deferredNoteCount: { type: 'integer' }, // total docs/deferred-analysis/*.md
    staleResolved: { type: 'array', items: { type: 'string' } }, // note exists but fn already on main -> skip
    illegal: { type: 'array', items: { type: 'string' } }, // deferred + still asm but layout-blocked now -> skip
    candidates: { type: 'array', items: CAND_SCHEMA }, // legal, still-asm deferred targets (codex-bound)
    note: { type: 'string' },
  },
}
const DECOMP_SCHEMA = {
  type: 'object',
  required: ['target', 'status', 'worktreePath', 'commits'],
  properties: {
    target: { type: 'string' },
    status: { type: 'string', enum: ['matched', 'naked', 'deferred', 'reverted', 'blocked', 'skipped'] },
    worktreePath: { type: 'string' },
    commits: { type: 'array', items: { type: 'string' } }, // full SHAs, apply order
    nakedClass: { type: 'string' },
    corpusEvidence: { type: 'string' },
    notes: { type: 'string' },
  },
}

// ---------------------------------------------------------------------------
// Scout: enumerate the deferred-analysis backlog -> legal codex targets.
// ---------------------------------------------------------------------------
function scoutPrompt() {
  const onlyClause = ONLY ? `\n   RESTRICT to ONLY these names (ignore every other note): ${ONLY.join(', ')}.` : ''
  const skipClause = SKIP.length ? `\n   NEVER include these (skip entirely): ${SKIP.join(', ')}.` : ''
  return `You are the SCOUT for a codex-only reclamation sweep of the DEFERRED-ANALYSIS backlog in
${MAIN} (Frogger's Adventures: Temple of the Frog — GBA, agbcc). READ-ONLY: do NOT modify, create,
or delete any file; do NOT commit. You run in the main checkout.

GOAL: every deferred function carries a docs/deferred-analysis/<name>.md drift note from a prior
agent. Return the ones that are STILL un-decompiled AND legal to attempt right now — each will be
dispatched to codex (GPT-5.5-high).

Steps:
1. git status --short — if NON-empty, set mainDirty=true and STOP (report it; the loop halts).
2. Enumerate the backlog:  ls docs/deferred-analysis/*.md  → strip dir + ".md" to get fn names
   (docs/deferred-analysis/sub_08030644.md → sub_08030644). deferredNoteCount = how many.${onlyClause}${skipClause}
3. python3 tools/agent/pick_target.py --json --limit 500 — rows carry name, file (asm slice),
   destination (.c), addr, byte_size, legal, legality_note. Build a name→row map.
4. python3 tools/agent/function_status.py --status deferred --json — carries next_tier per fn
   ('opus' = Sonnet-deferred, 'codex' = firm-defer). INFORMATIONAL ONLY — in THIS sweep every legal
   deferred target goes to codex regardless of tier.
5. Classify EACH deferred-note fn:
   - ALREADY RESOLVED → put name in staleResolved, do NOT dispatch. A note is resolved if the fn no
     longer has an asm slice / is absent from pick_target / is already defined in a committed source
     (grep -rlE "\\b<name>\\s*\\(" src finds a real body). The stash note is stale; a later attempt
     already landed it.
   - LEGAL → emit a candidate. Legal == the pick_target row has legal==true (legality_note begins
     "OK: appends"). Emit {name, asmFile (=file), destC (=destination), addr (the "0x…" hex string),
     byteSize (=byte_size), nextTier (from function_status, else "")}.
   - LAYOUT-BLOCKED → put name in illegal, do NOT dispatch. Deferred + still asm but legal==false
     (an earlier sibling in its slice must land first). A later sweep picks it up.
6. Order candidates smallest byteSize first. They MAY share asmFile/destC across the list (the pool
   serializes integration), but prefer DISTINCT destC early so concurrent codex drivers rarely touch
   the same file.

Return ONLY the structured object: mainDirty, deferredNoteCount, staleResolved, illegal, and
candidates (array of {name, asmFile, destC, addr, byteSize, nextTier}).`
}
function codexDecompBody(t) {
  return `You are a DECOMP agent powered by GPT-5.5 (high reasoning, goal mode) driving ONE
function to a MATCHING decompilation: ${t.name}, for Frogger's Adventures: Temple of the Frog
(Game Boy Advance, agbcc 2.x). You run via the codex plugin runtime inside an isolated git
worktree — the directory you were launched in (your cwd). Target: asm slice ${t.asmFile} -> C file
${t.destC}, addr ${t.addr}, ~${t.byteSize ?? '?'} bytes. Decompile EXACTLY this one function.

ENVIRONMENT RULES (critical):
- STAY in your cwd (this worktree). Do NOT cd to ${MAIN} — it is only the symlink source for
  gitignored deps (tools/agbcc, baserom, vendor, node_modules). All edits + commits land HERE.
- The worktree is already bootstrapped. Verify ONCE before touching anything: git status --short
  is clean AND make -j4 && make check exits 0. If not, do nothing and report that.
- macOS has NO timeout command; never use it.
- COST: do not re-read full build logs each turn; keep only byte_diff / diff-count lines.

Read once: ${MAIN}/CLAUDE.md sections "Agent workflow — peel-first, then decomp" and "C style",
plus docs/codegen-notes.md (the agbcc 2.x matching idioms — your Phase 2 toolkit).

Work in FOUR EXPLICIT PHASES. Do NOT jump straight to byte-forcing. The point of this prompt is
that you satisfy "match the bytes" THROUGH readable source, not by accumulating pins/asm/volatile.

== PHASE 0 — UNDERSTAND (no C edits yet) ==
- python3 tools/agent/decomp_brief.py ${t.name}  (range, callees+peel-status, pool labels with
  resolved addrs, struct xref, m2c seed C, dest hint).
- python3 tools/agent/classify_unmatchable.py ${t.name}  (reads baserom bytes = ground truth;
  note the VERDICT and any advisory). ONLY class3-libgcc is STRONG_UNMATCHABLE (and it has no
  confirmed instance on this ROM). EVERYTHING ELSE is ATTEMPT: a \`mov pc, rN\` computed jump is the
  SIGNATURE OF A C \`switch\` (the old "class4-movpc" wall is RETRACTED — 7 mode-X dispatchers that
  shipped NAKED were promoted to true-C as plain switches); high regs across a \`bl\` are advisory.
- cat docs/deferred-analysis/${t.name}.md 2>/dev/null  — a Claude agent JUST deferred this target
  and stashed "## Drift" + "## Best-effort C" here (already landed on main, so present in your
  worktree). READ it: those tried levers/structures are what does NOT work. Treat the near-match as
  a LOCAL PLATEAU to ESCAPE by re-deriving from scratch, NOT a base to tweak.
- Read the destination file ${t.destC} end-to-end (reuse its types/conventions); dump_pool.py
  ${t.name} for resolved literals; struct_grow.py / struct_xref.py any raw IWRAM/EWRAM base so the
  C has typed offsets, not [rN,#imm] magic.
- PREREQUISITES (do these regardless of which path you take): peel every callee tagged
  "UNPEELED" (python3 tools/agent/auto_peel.py --addr 0x<callee> --apply; commit "Peel sub_XYZ"),
  and if the target is "blocked: needs new C file" scaffold it first
  (python3 tools/agent/scaffold_cluster.py --asm ${t.asmFile} ${t.name} --apply; commit
  "Scaffold ${t.destC}").
- Write a SHORT model (a few lines, for yourself): params, the structs/fields touched, the
  control-flow shape, and the compiler drift you anticipate. For drift you expect, name the
  responsible agbcc pass in tools/agbcc-src/gcc_arm/ ({local-alloc,regclass,reload}=register
  choice; loop.c=loop-reversal/strength-reduce; cse.c/gcse.c=folds) and READ it.

== PHASE 1 — CLEAN C FIRST ==
- Write a HUMAN-READABLE first implementation into ${t.destC}: named constants/enums (add the
  enum to the right include/ header if it is missing — no bare 0x29 for a thing that has a name),
  early-return with NO else, u8 booleans, no intermediate locals that only cache one field read.
- HARD CONSTRAINT for this phase: NO inline asm, NO NAKED, NO volatile-for-matching, and ideally
  NO register pins. This is the readable reference you keep.
- If it does not match, your FIRST round of fixes MUST be SOURCE-LEVEL — control-flow shape,
  types, expression structure, statement order — informed by the agbcc pass you read. RE-DERIVE a
  different structure; do NOT yet reach for pins/barriers. A near-match is a local minimum, and
  tweaking one structure that will not converge is wasted; a fundamentally different structure
  resets the budget. When a register CHOICE is wrong, coerce it by rewriting the C SHAPE, not by
  pinning — a pin means the shape is still wrong.
- COMPILER FIRST, BEFORE ANY PIN: the default is now OLD_AGBCC (\`CC = $(OLD_AGBCC_BIN)\` is the
  Makefile default — the correct model for this title; only 4 named TUs use the newer agbcc). Most
  pin/asm debt came from C written against the WRONG compiler. If a fresh decomp drifts on register
  coloring, a redundant \`push {lr}; pop {r1}; bx r1\` epilogue at joins, or AND-operand ordering, add
  a per-TU CC override (the .s target matching ${t.destC}, e.g. \`src/game/foo.s: CC = $(AGBCC_BIN)\`)
  and re-check BEFORE pinning. Swapping the compiler matches more functions than pins do.
- DISPATCHER RECIPE (mov pc / mode-X): write the dense \`switch\` over the state index, then (a) order
  the case BODIES in baserom PHYSICAL order, not numeric (codegen-notes "Case-number ≠
  source-block-order"); (b) share epilogues via fallthrough / \`goto tail\`; (c) add \`<that .s>:
  CFLAGS += -fforce-addr -fno-expensive-optimizations -fno-gcse\` and \`/DISCARD/\` the stray
  \`.rodata\`. This matched the whole mode-X cluster.

== PHASE 2 — DIFF DOWN (only after a clean attempt exists) ==
*** WHEN A NEAR-MATCH WON'T CONVERGE, THESE TWO MOVES BREAK THROUGH MORE OFTEN THAN ANY LEVER —
DO THEM BEFORE GUESSING. *** (Both rely on worktree deps the bootstrap just symlinked: the agbcc
SOURCE at tools/agbcc-src/ and the corpus at tools/agent/corpus-mirrors/ + ~/.cache/decomp-corpus.
If a command says either is missing, STOP and report it — do not silently work around it.)
  1. READ THE COMPILER. The divergence has a CAUSE in a specific agbcc pass. Open the real source
     in tools/agbcc-src/gcc_arm/ for the symptom — register choice: local-alloc.c / regclass.c /
     reload.c / global.c; loop reversal or strength-reduce: loop.c; a fold: cse.c / gcse.c;
     scheduling: sched / combine.c — and read WHY it picks what it picks, then write C that gives it
     no other choice. If you still can't see it, INSTRUMENT agbcc (private debug build, fprintf at
     the decision site — recipe below). This is the move that cracked the hardest matches.
  2. MINE THE CORPUS for the exact idiom (other agbcc decomps already solved it): run BOTH
     \`corpus.py grep\` (current-tree C) AND \`corpus_asm_search.py search --asm ... --require-c\` (the
     HISTORY/asm<->C pairing) — details below. Adapt their C STRUCTURE; do not reinvent it.
A pin / asm("") / -fXXX is a LAST resort applied AFTER 1 and 2, never instead of them.
- NOW the matching levers are allowed: register T x asm("rN") pins (INCLUDING high regs
  r8/r9/sl — these are usually matchable and are NOT a NAKED trigger); a local base-ptr anchor
  (T *p=&gThing;); cast a now-dead pointer to an index to force its register reuse; an asm("")
  mov-fence to block a tail-merge or CSE; a void-return epilogue; linker-assigned IWRAM symbols
  to defeat a CSE-fold; per-TU CFLAGS (-ffixed-rN, -fno-strength-reduce, -fno-gcse,
  -fno-schedule-insns) and/or CC=\$(OLD_AGBCC_BIN); statement/scope reorder. A pin is the LAST
  resort and the loudest "shape is wrong" signal — prefer a shape rewrite that needs none.
- INSTRUMENT AGBCC when you cannot tell WHY a pass diverges (proven technique): build a PRIVATE debug
  copy of agbcc with an \`fprintf(stderr,…)\` at the decision site, compile only your TU with it to
  watch the choice. SAFETY: never edit/rebuild the SHARED symlinked tools/agbcc or tools/agbcc-src
  (it races siblings) — private copy, private prefix, rm after. Recipe in codegen-notes
  "Instrumenting agbcc itself — build a private debug compiler".
- Corpus FIRST, permuter LAST: python3 tools/agent/corpus.py grep '<the specific idiom>' --c for
  prior pure-C art before mutating.
  HISTORY search (THE asm-idiom step) when grep finds the idiom in NO current-tree C and you are
  blocked on a fold / register spread or funnel / addressing mode: it finds the commit that DELETED
  asm matching your idiom and shows the C that REPLACED it in the same commit (exact asm<->C
  pairing) — python3 tools/agent/corpus_asm_search.py search --asm '<register-AGNOSTIC asm regex;
  use char classes r[0-7] and (r8|r9|sl) for regs>' --require-c (or a preset, e.g.
  --idiom highreg-spread), then corpus_asm_search.py show <repo>@<sha> to read the C and adapt its
  STRUCTURE. Do this BEFORE permuter. Permuter only if you are NEAR a match (byte_diff <= ~40):
  bounded ~2000 iters (~30-45s), process-GROUP kill (set -m; kill -- -\$PGID), per
  ${MAIN}/docs/permuter-howto.md — never pipe it, redirect to a file, and verify there are no
  leaked workers afterward (pgrep -f the scratch dir is empty).
- EVERY pin / asm("") / volatile / -fXXX you keep gets a ONE-LINE comment stating WHY it is
  necessary, tied to the SPECIFIC diff instruction it fixes. An unexplained lever is debt.

== PHASE 3 — READABILITY PASS (after byte_diff hits 0) ==
- If the match required 3+ register pins, ANY asm(""), a suspicious volatile, or contorted
  locals: do a SECOND pass that REDUCES that debt while PRESERVING the match. Remove each lever
  that is NOT actually load-bearing and re-verify byte_diff 0 after every removal (fast path:
  python3 tools/agent/build_expected.py --fn ${t.name} then objdiff-cli on expected/src/<rel>.o
  vs src/<rel>.o). Keep ONLY genuinely-required levers, each with its WHY note. The deliverable
  is readable C that happens to match — NOT matched bytes that happen to be C.

== NAKED IS EXCEPTIONAL ==
Ship NAKED+NON_MATCHING ONLY if classify_unmatchable.py returns STRONG_UNMATCHABLE
(class3-libgcc ONLY — class4-movpc is RETRACTED; a computed jump is a switch, write it) AND the
corpus confirms the idiom lives ONLY in hand-asm:
  python3 tools/agent/corpus.py grep '<exact idiom regex>' --asm   (expect MANY hits)
  python3 tools/agent/corpus.py grep '<related C construct>'  --c   (expect NONE matched to C)
  python3 tools/agent/corpus_asm_search.py search --asm '<idiom regex>' --require-c   (HISTORY pairing — if EVEN ONE repo replaced this exact asm with C, it is MATCHABLE: do NOT NAKED)
"All corpus hits are NAKED" is NOT proof of impossibility — it is circular (everyone NAKED'd for the
same wrong reason, as the movpc cluster proved); a direct compile probe beats a census.
High registers ALONE are NOT a fast path to NAKED — attempt them in Phase 2. Asymmetric-cost
rule: a wrongly-NAKED function is a PERMANENT regression (it will not survive the phase-3 PC
port); wasted match tokens are cheap and recoverable. When unsure -> ATTEMPT. If you DO ship
NAKED: readable C under #ifdef NON_MATCHING, hand-asm NAKED under #else, and EVERY NAKED asm()
block ends with the literal "    .syntax divided\\n".

== DEFINITION OF DONE (structural, NOT byte_diff) ==
byte_diff 0 alone does NOT mean matched — a NAKED ship is also byte_diff 0 by construction.
- matched: the committed ${t.destC} body for ${t.name} has NO NAKED, NO inline asm(, NO
  #ifdef NON_MATCHING — AND byte_diff 0 / make check passes. (A register T x asm("rN") pin
  DECLARATION is PURE C, not inline asm — it does NOT make the function naked.)
- naked: the body uses NAKED / inline asm / #ifdef NON_MATCHING (matches via the asm path).
Never call a NAKED ship a "true match".

== ON A MATCH OR A CLEAN NAKED SHIP ==
- rm the consumed asm slice ${t.asmFile} (if its whole slice is now in C); collapse the
  scaffold+asm pair in linker.ld into the single src .o(.text) entry (follow the preceding
  sibling's pattern); if a stale docs/deferred-analysis/${t.name}.md exists, git rm it.
- make -j4 && make check (MUST exit 0).
- Commit with the subject matching your status (the driver re-verifies this):
    matched: git commit -m "Decompile ${t.name}"
    naked:   git commit -m "Decompile ${t.name} (NAKED + NON_MATCHING)"
  Body: the structure + agbcc tricks; for NAKED include class + corpus hit counts + levers tried.

== IF YOU CANNOT MATCH (after SEVERAL fundamentally-different structural approaches) ==
Do NOT ship NAKED for a non-STRONG function — an honest un-decompiled asm slice beats a fake
match. DEFER, updating the existing analysis so a future attempt resumes instead of restarting:
  1. mkdir -p docs/deferred-analysis ; OVERWRITE docs/deferred-analysis/${t.name}.md with a
     "## Drift" section (best byte_diff, WHICH register/fold/schedule diverged, levers + permuter
     score tried — ADD what you newly ruled out) and a "## Best-effort C" section (your
     most-correct readable C inside a fenced code block opened with three backticks then c).
  2. git add docs/deferred-analysis/${t.name}.md ; git commit -m "Stash deferred analysis: ${t.name}"
     (docs-only; never compiled, so make check stays green). (If the file is byte-identical to what
     is already on main there is nothing to commit — that is fine.)
  3. git checkout -- ${t.destC} (restore the stub); LEAVE the asm slice ${t.asmFile} and
     linker.ld untouched.

Finish with a CLEAN tree (everything committed or reverted) and print a final line exactly:
STATUS=<matched|naked|deferred|reverted> ${t.name}
The driver computes the commit SHAs itself — you just need correct commits and a clean tree.`
}

function codexDriverPrompt(t, round) {
  return `You are the CODEX DRIVER (running on Sonnet) for decomp target ${t.name} (asm
${t.asmFile} -> C ${t.destC}, addr ${t.addr}, ~${t.byteSize ?? '?'} bytes) in an isolated git
worktree of ${MAIN}. Round ${round}.

This target was JUST DEFERRED by a Claude decomp agent in THIS run — codex (GPT-5.5-high) is the
top rung of the ladder and its last in-pass shot. The prior agent's drift note
docs/deferred-analysis/${t.name}.md was already landed on main, so it IS present in your fresh
worktree; the codex prompt tells codex to READ it and ESCAPE that plateau (re-derive, don't tweak).

You DO NOT decompile the function yourself. Your job: (a) bootstrap the worktree, (b) hand the
decomp to GPT-5.5-high via the codex PLUGIN runtime (codex-companion.mjs task), (c) INDEPENDENTLY
verify the result, (d) report the structured object. The expensive reasoning is codex's; you are
the harness-visible shell + verifier, so this tracks in /workflows exactly like a normal decomp.
${BOOTSTRAP}
${WORKTREE_RULES}

PROCEDURE:
1. BASE=\$(git rev-parse HEAD)   # record before anything; the SHAs you report are \$BASE..HEAD.
2. Resolve the codex plugin companion + the codex CLI via BASH (the plugin env var
   CLAUDE_PLUGIN_ROOT is NOT set inside a workflow agent, so glob the versioned install):
\`\`\`sh
COMPANION="\$(ls -d "\$HOME"/.claude/plugins/cache/openai-codex/codex/*/scripts/codex-companion.mjs 2>/dev/null | sort -V | tail -1)"
command -v codex >/dev/null 2>&1 || export PATH="/Applications/Codex.app/Contents/Resources:\$PATH"
[ -n "\$COMPANION" ] && command -v codex >/dev/null 2>&1 && node "\$COMPANION" setup --json | grep -q '"ready": true' && echo CODEX_READY
\`\`\`
   If that does NOT print CODEX_READY: set status="deferred" (the Claude deferral already landed its
   stash note on main — leave it as the resume point), note "codex plugin/CLI not ready — run
   /codex:setup", commits=[], and STOP.
3. Write the codex task prompt to codex-task.md with a QUOTED heredoc (so \$ and backticks stay
   literal). Use BASH ONLY (Edit/Write resolve to main and corrupt it):
\`\`\`sh
cat > codex-task.md <<'CODEXEOF'
${codexDecompBody(t)}
CODEXEOF
\`\`\`
   Confirm: wc -l codex-task.md (many lines) and grep -c '${t.name}' codex-task.md (>0).
4. Launch codex via the PLUGIN task runtime in the BACKGROUND with run_in_background=true (hard
   decomps run 10-40+ minutes — a FOREGROUND Bash call would hit the 10-minute cap and kill the
   work mid-decomp). Run EXACTLY this:
\`\`\`sh
node "\$COMPANION" task --write --cwd "\$PWD" --model ${CODEX.model} --effort ${CODEX.effort} \\
  --prompt-file codex-task.md > codex-run.log 2>&1
\`\`\`
   (--write gives codex a workspace-write sandbox with approvalPolicy=never, so it edits + commits
   inside THIS worktree without approval prompts; --cwd "\$PWD" pins the codex thread to your
   worktree's git root. The plugin renders codex's final message + touched files to codex-run.log.)

   *** PATIENCE — THIS IS THE #1 DRIVER MISTAKE TO AVOID. *** The background command is delivered
   back to you as a COMPLETED tool result ONLY when codex EXITS. codex legitimately spends many
   minutes in Phase 0 analysis ALONE and 10-40+ minutes end-to-end. SLOWNESS IS NORMAL, NOT FAILURE.
   HARD RULES, no exceptions:
   - You may call StructuredOutput / decide the outcome ONLY AFTER you have SEEN the completed result
     of THIS backgrounded command (its exit + final output land in your context). That completion is
     the ONLY signal that codex is done.
   - NEVER report status="deferred"/"reverted"/"matched"/"naked" while codex may still be running. A
     premature finalize ORPHANS codex mid-decomp and strands the worktree — this is the exact bug
     this rule exists to prevent. "deferred" is a CONCLUSION ABOUT CODEX'S FINISHED OUTPUT, never a
     way to end your own turn early.
   - Do NOT poll, do NOT tail the log to judge "far enough", do NOT decide codex is "too slow" or
     "still in Phase 0". Its pace is irrelevant.
   - LIVENESS BACKSTOP: if for ANY reason you are prompted to act before that completion arrives
     (a nudge, a reminder, an apparent stop), FIRST run \`pgrep -fl 'codex-task.md|codex (exec|app-server)|codex-companion.mjs task'\`.
     If that lists ANY live process, codex is STILL WORKING: do NOT finalize — end your turn again to
     keep waiting. Only when pgrep shows codex is GONE may you proceed to step 5/6.
   The match/naked/defer decision is made ONLY in step 6, AFTER codex has exited, FROM THE TREE —
   never from codex's pace and never to escape your turn.
5. ONLY once the backgrounded codex command has returned its completed result (and \`pgrep\` confirms
   no codex process remains), read the OUTCOME compactly (do NOT paste whole logs into your
   reasoning):  tail -n 60 codex-run.log
6. VERIFY INDEPENDENTLY — do NOT trust codex's printed summary. Derive the truth from the tree:
   a. make -j4 && make check — if it does NOT exit 0 the tree is broken: git reset --hard \$BASE
      && git clean -fd (drops codex-task.md/codex-run.log + anything codex left untracked),
      status="reverted", note the failure, then go to step 7.
   b. python3 tools/agent/compile_and_view_assembly.py ${t.name} --human — confirm byte_diff 0.
   c. COMMIT SAFETY NET: codex sometimes finishes the edits but does NOT commit. If byte_diff is 0
      and make check passes BUT \`git log --oneline \$BASE..HEAD\` has no "Decompile ${t.name}"
      commit: first \`rm -f codex-task.md codex-run.log\` so scratch is excluded, then check
      \`git status --short\` shows ONLY the decomp's own files (${t.destC}, the removed asm slice,
      linker.ld, any header/peel) — if so \`git add -A && git commit -m "Decompile ${t.name}"\`
      (the structural grep in (d) decides whether to re-tag it NAKED).
      If byte_diff != 0: codex did not land a match. If a "Decompile ${t.name}" commit exists it is
      a non-match — git reset --hard \$BASE && git clean -fd, status="reverted". If only a "Stash
      deferred analysis" commit (or nothing) exists -> status="deferred".
   d. STRUCTURAL matched-vs-naked (this OVERRIDES any codex claim): grep -nE 'NON_MATCHING|\\bNAKED\\b'
      ${t.destC} scoped to ${t.name}'s body — a register-pin asm("rN") DECLARATION is PURE C, NOT
      naked, never flag it. If NAKED / inline asm / #ifdef NON_MATCHING is present -> status="naked";
      ensure the commit subject says "(NAKED + NON_MATCHING)" — if the just-committed commit is HEAD
      and lacks it, git commit --amend -m "Decompile ${t.name} (NAKED + NON_MATCHING)" (keep the
      body). Otherwise -> status="matched".
7. CLEAN UP scratch so the tree is clean for the integrator: rm -f codex-task.md codex-run.log
   (untracked; never commit them). Confirm git status --short is empty (everything committed or
   reverted).
8. SHAs: git rev-list --reverse \$BASE..HEAD -> commits (apply order).

Return the structured object: target="${t.name}", status (YOUR structural verdict, not codex's),
worktreePath (pwd), commits (the \$BASE..HEAD SHAs in apply order), nakedClass/corpusEvidence if
naked, and notes — keep notes SHORT: what codex did + any caveat.`
}
const INTEG1_SCHEMA = {
  type: 'object',
  required: ['status', 'sha1Match', 'mainHealthy'],
  properties: {
    integrated: { type: 'array', items: { type: 'string' }, description: 'fn/scaffold names that LANDED on main' },
    status: { type: 'string', enum: ['matched', 'naked', 'deferred', 'reverted', 'noop'] },
    amendedSubject: { type: 'boolean' },
    reverted: { type: 'boolean' },
    sha1Match: { type: 'boolean' }, // main byte-identical after this integration
    mainHealthy: { type: 'boolean' }, // make check exits 0 on main
    notes: { type: 'string' },
  },
}

function integrateOnePrompt(t, dres) {
  return `You are the INTEGRATOR running on the MAIN checkout (${MAIN}) — NOT a worktree.
A decomp agent just finished ONE target; land it on main, make-check-guarded. The driver
serializes you (only one integrator runs at a time), so main is yours exclusively right now.

Result to integrate:
  target:       ${t.name}
  status:       ${dres.status}
  worktree:     ${dres.worktreePath}
  commits (apply order, full SHAs): ${(dres.commits || []).join(' ') || '(none)'}

Steps:
1. cd ${MAIN}. If \`git status --short\` is NOT clean, a decomp agent stray-wrote to main
   (integrations are SERIALIZED, so a dirty tree here is ALWAYS a stray write, never a
   pending change). SELF-HEAL it: \`git checkout -- . && git clean -fd\` — this reverts stray
   tracked edits and removes stray untracked files; gitignored deps/worktrees are preserved.
   Confirm \`git status --short\` is now empty, then proceed.
2. If status is "matched" or "naked" with commits: cherry-pick each SHA IN ORDER
   (\`git cherry-pick <sha>\`), one at a time. On a conflict: \`git cherry-pick --abort\`,
   set reverted=true, status="reverted". After the LAST pick: \`make -j4 && make check\`.
   - make check FAILS → \`git reset --hard <pre-pick HEAD>\`, reverted=true, status="reverted".
   - Re-verify the STRUCTURAL status by grepping the committed .c for ${t.name}: matched ⟺
     no \`NAKED\`/inline \`asm(\`/\`#ifdef NON_MATCHING\` for it; else naked. If the commit subject
     is mislabeled (says "Decompile" but it's NAKED, or vice-versa), \`git commit --amend\` the
     subject and set amendedSubject=true.
3. If status is "deferred"/"reverted": the agent may have a "Stash deferred analysis" commit —
   cherry-pick THAT one (docs-only, safe) if present in commits; otherwise nothing lands.
4. CLEAN UP the worktree: \`git worktree unlock ${dres.worktreePath} 2>/dev/null;
   git worktree remove --force ${dres.worktreePath} 2>/dev/null; git worktree prune\`, then
   \`git branch -D\` its branch if it lingers.
5. \`make check\` on main MUST still exit 0 → sha1Match + mainHealthy. Do NOT touch
   README/progress_stats/snapshot (a single finalize step regenerates them after the pool).
sha1Match/mainHealthy describe main AFTER all your actions: a clean revert (or a self-heal
in step 1) leaves main MATCHING, so report sha1Match=true / mainHealthy=true in those cases —
status="reverted" still lands nothing, but the pool keeps going. Report mainHealthy=false ONLY
if you genuinely CANNOT restore main to a matching state (a real unrecoverable break = HALT).
Report: integrated[], status, amendedSubject, reverted, sha1Match, mainHealthy, notes.`
}

// ---------------------------------------------------------------------------
// Driver: scout the deferred backlog once, then a rolling K-worker pool where EVERY worker
// dispatches codex (GPT-5.5-high) via the Sonnet driver + integrates its result under a serialized
// lock. No Claude decomp tier, no builder/peel — a finite sweep of the existing backlog.
// ---------------------------------------------------------------------------
phase('Scout')
log(`reclaim-deferred: K=${K} codex drivers, model=${CODEX.model}/${CODEX.effort}${ONLY ? `, restricted to ${ONLY.length} names` : ''}${MAX_TARGETS != null ? `, max ${MAX_TARGETS} dispatches` : ''}`)

let plan = await agent(scoutPrompt(), { schema: PLAN_SCHEMA, label: 'scout deferred', phase: 'Scout', model: MODELS.scout })
if (!plan) {
  log('Scout failed — aborting.')
  return { error: 'scout failed' }
}
if (plan.mainDirty) {
  log('main is dirty at start — aborting for safety (clean the tree, then re-run).')
  return { error: 'main dirty' }
}
log(`Backlog: ${plan.deferredNoteCount} deferred notes → ${(plan.candidates || []).length} legal codex targets; ${(plan.staleResolved || []).length} already-resolved (skip), ${(plan.illegal || []).length} layout-blocked (skip).`)

let queue = (plan.candidates || []).filter((t) => !SKIP.includes(t.name))
if (MAX_TARGETS != null) queue = queue.slice(0, MAX_TARGETS)
if (!queue.length) {
  log('No legal deferred targets to sweep — done.')
  return { codexDispatched: 0, rescued: [], stillDeferred: [], reverted: [], results: [] }
}
log(`Rolling pool: ${K} codex drivers over a ${queue.length}-target queue.`)

const results = []
let halt = false
let codexDispatched = 0

// Async mutex: integrations serialize on main (codex drivers stay fully parallel).
let integLock = Promise.resolve()
async function withIntegrateLock(fn) {
  const prev = integLock
  let release
  integLock = new Promise((r) => (release = r))
  await prev
  try {
    return await fn()
  } finally {
    release()
  }
}

// Integrate ONE codex result onto main under the serialized lock; returns the INTEG1 object or null.
async function integrateResult(t, dres, tierLabel) {
  return withIntegrateLock(async () => {
    if (halt) return null
    const integ = await agent(integrateOnePrompt(t, dres), {
      schema: INTEG1_SCHEMA,
      phase: 'Integrate',
      model: MODELS.integrate,
      label: `integ ${t.name}${tierLabel ? ' ' + tierLabel : ''}`,
    })
    if (!integ) {
      log(`integ ${t.name}: integrator returned null — HALTING new dispatches (inspect main).`)
      halt = true
      return null
    }
    log(`+ ${t.name}: codex=${dres.status} integ=${integ.status} landed=[${(integ.integrated || []).join(', ') || '-'}] sha1Match=${integ.sha1Match} (${results.length} done, ${queue.length} queued)`)
    if (integ.mainHealthy === false || integ.sha1Match === false) {
      log(`main NON-MATCHING after ${t.name} (mainHealthy=${integ.mainHealthy}, sha1Match=${integ.sha1Match}). HALTING — inspect make check on main.`)
      halt = true
    }
    return integ
  })
}

async function worker(wid) {
  while (!halt) {
    const t = queue.shift()
    if (!t) return // queue drained -> this worker is done (finite sweep, no refill)
    codexDispatched += 1
    log(`↑ ${t.name}: dispatching codex ${CODEX.model} (${CODEX.effort}) [${t.nextTier || 'deferred'}, ~${t.byteSize ?? '?'}B]`)
    const cres = await agent(codexDriverPrompt(t, codexDispatched), {
      schema: DECOMP_SCHEMA,
      isolation: 'worktree',
      phase: 'Codex',
      model: MODELS.codexDriver,
      label: `codex ${t.name}`,
    })
    if (!cres) continue
    const integ = await integrateResult(t, cres, '[codex]')
    const rescued = (cres.status === 'matched' || cres.status === 'naked') && !(integ && integ.reverted)
    results.push({ target: t.name, codexStatus: cres.status, rescued, ...(integ || {}) })
  }
}

await parallel(Array.from({ length: K }, (_, i) => () => worker(i)))

// Finalize ONCE: scoreboard + stray-worktree prune (per-result integrators skip these).
phase('Finalize')
const fin = await agent(
  `You run on the MAIN checkout (${MAIN}). The codex reclamation pool has drained. Finalize:
1. git status --short MUST be clean (else mainHealthy=false).
2. make -j8 && make check MUST exit 0 (sha1Match).
3. Regenerate the scoreboard ONCE: python3 tools/agent/snapshot_addresses.py; then
   python3 tools/agent/progress_stats.py --update-readme; if README.md changed,
   git add README.md && git commit -m "Update progress stats".
4. Prune leftover pool worktrees under .claude/worktrees/: git worktree unlock then
   git worktree remove --force each, then git worktree prune. Do NOT touch the main worktree.
5. python3 tools/agent/progress.py --human -> asm_funcs_remaining; and
   (ls docs/deferred-analysis/*.md 2>/dev/null | wc -l) -> deferredRemaining.
Report asmFuncsRemaining, deferredRemaining, sha1Match, mainHealthy, worktreesCleaned, notes.`,
  {
    schema: {
      type: 'object',
      required: ['sha1Match', 'mainHealthy'],
      properties: {
        asmFuncsRemaining: { type: 'integer' },
        deferredRemaining: { type: 'integer' },
        sha1Match: { type: 'boolean' },
        mainHealthy: { type: 'boolean' },
        worktreesCleaned: { type: 'integer' },
        notes: { type: 'string' },
      },
    },
    label: 'finalize',
    phase: 'Finalize',
    model: MODELS.integrate,
  },
)

// ---------------------------------------------------------------------------
// Final report
// ---------------------------------------------------------------------------
const rescued = results.filter((r) => r.rescued).map((r) => r.target)
const stillDeferred = results.filter((r) => r.codexStatus === 'deferred').map((r) => r.target)
const reverted = results.filter((r) => r.reverted).map((r) => r.target)

log(`reclaim-deferred finished: ${codexDispatched} codex dispatches -> ${rescued.length} rescued [${rescued.join(', ') || '—'}], ${stillDeferred.length} still deferred, ${reverted.length} reverted; deferred notes remaining ${fin ? fin.deferredRemaining : '?'}${halt ? ' (HALTED on non-matching main)' : ''}.`)

return {
  codexDispatched,
  rescued,
  stillDeferred,
  reverted,
  asmFuncsRemaining: fin ? fin.asmFuncsRemaining : null,
  deferredRemaining: fin ? fin.deferredRemaining : null,
  halted: halt,
  results,
}
