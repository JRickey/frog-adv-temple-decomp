export const meta = {
  name: 'finish-decomp-sonnet',
  description:
    "Sonnet-only variant of finish-decomp for Frogger's Adventures: Temple of the Frog. NEVER calls Opus — every agent (scout, builder, decomp, integrator) runs on Sonnet. Keeps peeling/scaffolding to refill the queue, but the ONLY valid decomp targets are small, Sonnet-tractable functions (<=160 bytes); larger functions and Opus-escalation defers are excluded entirely (they wait for the Opus finish-decomp run). Integrates onto main one commit at a time with a make-check safety net.",
  whenToUse:
    'Cheaply grind the small-function long tail on Sonnet only (no Opus spend). Commits land on main; make check guards every cherry-pick. Re-run to continue; run the Opus finish-decomp for the large/escalated targets this loop skips.',
  phases: [
    { title: 'Scout', detail: 'scout a deep queue of <=160B fresh targets only (read-only on main)', model: 'sonnet' },
    { title: 'Decomp', detail: 'rolling pool of K Sonnet workers: true-match or corpus-gated NAKED; <=160B only', model: 'sonnet' },
    { title: 'Integrate', detail: 'per-result: cherry-pick onto main (serialized lock), make check, revert breakers', model: 'sonnet' },
    { title: 'Finalize', detail: 'once after the pool drains: regen scoreboard + prune worktrees', model: 'sonnet' },
  ],
}

// ---------------------------------------------------------------------------
// Config (override via Workflow args: {parallel, rounds, runBuilder})
// ---------------------------------------------------------------------------
const MAIN = '/Users/jackrickey/Dev/frog-adv-decomp'

// Workflow args may arrive as an OBJECT or a JSON-encoded STRING (caller-dependent).
// Normalize to `A` so every args.X read resolves either way — a string arg otherwise
// falls silently through to defaults (this bit name-cluster once).
let A = args
if (typeof A === 'string') {
  try { A = JSON.parse(A) } catch (e) { A = {} }
}
if (!A || typeof A !== 'object') A = {}

const K = A.parallel || 5 // parallel decomp worktrees per round
const MAX_ROUNDS = A.rounds || 130 // hard backstop under the 1000-agent cap (~7 agents/round: K decomp + builder + integrator)
// Cap on TOTAL decomp agents dispatched across all rounds, ANY model (Sonnet+Opus).
// null = unbounded. Set e.g. 30 for a bounded cost/quality sample of the tiering — the
// loop stops once this many decomp agents have run (builder/integrator not counted).
const MAX_DECOMP_AGENTS = A.maxDecompAgents || null
// ROLLING POOL: how deep a target queue the scout pre-loads. The K workers pull from this
// continuously (no round barrier — a slow Opus grinder occupies one slot while the other
// workers keep matching + integrating), so the queue must be much larger than K. The backlog
// of peeled functions is deep enough to feed it; escalation of THIS run's fresh defers
// happens on the NEXT run (function_status re-derives the tier from the note).
const QUEUE_DEPTH = A.queueDepth || 40
const DRY_LIMIT = 3 // (legacy round-mode knob; unused by the rolling pool)
const RUN_BUILDER = A.runBuilder === false ? false : true
const BUDGET_FLOOR = 80_000 // stop if a token target was set and we're near it

// SONNET-ONLY. This variant NEVER calls Opus: every phase — scout, builder, decomp,
// integrator, finalize — runs on Sonnet. decompLarge is pinned to Sonnet too as a
// defence-in-depth backstop, but no large/escalated target should ever reach a decomp
// agent here: the scout caps fresh picks at SONNET_MAX_BYTES and the driver re-filters
// the queue, so only small Sonnet-tractable functions are dispatched. (Override the cap
// via args.sonnetMaxBytes; args.models can still re-introduce Opus deliberately, but the
// default is pure Sonnet.)
const MODELS = Object.assign(
  { scout: 'sonnet', build: 'sonnet', integrate: 'sonnet', decompSmall: 'sonnet', decompLarge: 'sonnet' },
  A.models || {},
)
// Threshold in BYTES. The project's tractability line is ~80 *instructions*; Thumb is
// 2 bytes/instr, so that's ~160 bytes. In this Sonnet-only loop the threshold is not just
// a router — it is the ELIGIBILITY GATE: a target with byteSize > this is not a valid
// target at all and is excluded from the queue.
const SONNET_MAX_BYTES = A.sonnetMaxBytes || 160 // ONLY decomp targets with byteSize <= this are valid
// A valid target in this loop is ALWAYS Sonnet (no Opus tier). Opus-escalation
// (nextTier='opus') and firm-defer (nextTier='codex') targets are excluded upstream by
// the scout/driver filters, so this never needs to return Opus.
const decompModel = (_t) => MODELS.decompSmall
// Eligibility predicate shared by the scout-result filter and the builder refill: a target
// is dispatchable here iff it is fresh (no Opus/codex escalation tier) AND small enough.
const sonnetEligible = (t) =>
  t.nextTier !== 'opus' && t.nextTier !== 'codex' && (t.byteSize || 0) <= SONNET_MAX_BYTES

// (D) Targets parked OUT of the auto-loop: repeatedly-deferred long-tail funcs
// (700-900B mode-X per-frame dispatchers). The size-blind picker fed these to
// one-shot agents every round and they deferred 100% of the time (15×/12×/5×)
// — see memory picker-size-blind. They need a dedicated permuter campaign or a
// corpus-evidenced NAKED, not one-shot retries. Override via args.hardList.
const HARD_LIST = A.hardList || ['sub_08001E24', 'sub_08002EE8', 'sub_08003864']
// (C) Skip a target after this many consecutive deferrals so the scout stops
// re-feeding it: a clean defer reverts the slice, leaving it the lowest-address
// legal target, so without this it gets re-picked forever (the livelock).
const DEFER_SKIP_THRESHOLD = A.deferSkipThreshold || 2

// ---------------------------------------------------------------------------
// Shared prose: worktree bootstrap + universal hard rules.
// Baked into every worktree-agent prompt — these are validated, load-bearing.
// ---------------------------------------------------------------------------
const BOOTSTRAP = `
WORKTREE BOOTSTRAP (run FIRST, before any build — fresh worktrees lack gitignored deps):
\`\`\`sh
MAIN=${MAIN}
# vendor/{decomp-permuter,m2c} are submodules with gitignored .venv — symlink the whole
# set-up dirs from main so the permuter + m2c seed work without re-installing per worktree.
for dep in tools/agbcc tools/agbcc-src tools/agent/bin baserom.gba frog_us_baserom.gba node_modules \\
           vendor/decomp-permuter vendor/m2c; do
  [ -e "$dep" ] || ln -s "$MAIN/$dep" "$dep"
done
# tools/agbcc-src is the agbcc COMPILER SOURCE (gcc 2.x) — gcc_arm/{local-alloc,regclass,
# reload,cse,gcse,loop,combine}.c. Read the relevant pass to understand WHY agbcc diverges
# (which register it picks, when it strength-reduces a loop, when it CSE-folds) and what C
# avoids it. This is how the hardest matches get cracked — not by mutating, by understanding.
# data/ is gitignored; populate if empty (needs baserom symlink first):
[ -n "$(ls -A data 2>/dev/null)" ] || python3 tools/extractor.py
git status --short      # MUST be empty (all the above are gitignored)
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
const TARGET_SCHEMA = {
  type: 'object',
  required: ['name', 'asmFile', 'destC', 'addr', 'byteSize'],
  properties: {
    name: { type: 'string' },
    asmFile: { type: 'string' },
    destC: { type: 'string' },
    addr: { type: 'string' },
    byteSize: { type: 'integer' }, // true function span (pick_target byte_size) — sort/triage key
    lineCount: { type: 'integer' }, // legacy; pick_target line_count is the INCBIN-stub count, NOT size
    nextTier: { type: 'string', enum: ['', 'opus'], description: 'escalation: "opus" if Sonnet already deferred this (route to Opus); "" for a fresh target (route by size)' },
  },
}

const PLAN_SCHEMA = {
  type: 'object',
  required: ['mainDirty', 'asmFuncsRemaining', 'legalTargetCount', 'decompTargets'],
  properties: {
    mainDirty: { type: 'boolean' },
    asmFuncsRemaining: { type: 'integer' },
    legalTargetCount: { type: 'integer' },
    decompTargets: { type: 'array', items: TARGET_SCHEMA },
    codexQueue: {
      type: 'array',
      items: { type: 'string' },
      description: 'firm-defers: functions Opus already deferred (function_status --next-tier codex). NOT auto-dispatched — the human feeds these to codex one at a time.',
    },
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

const BUILDER_SCHEMA = {
  type: 'object',
  required: ['worktreePath', 'commits', 'scaffolded', 'peeled', 'frontierExhausted'],
  properties: {
    worktreePath: { type: 'string' },
    commits: { type: 'array', items: { type: 'string' } }, // full SHAs, apply order
    scaffolded: { type: 'array', items: { type: 'string' } },
    peeled: { type: 'array', items: { type: 'string' } },
    frontierExhausted: { type: 'boolean' },
    notes: { type: 'string' },
  },
}

const INTEG_SCHEMA = {
  type: 'object',
  required: ['committedCount', 'mainHealthy', 'sha1Match', 'asmFuncsRemaining', 'nextPlan'],
  properties: {
    committedCount: { type: 'integer' }, // commits actually landed on main this round
    landed: { type: 'array', items: { type: 'string' } },
    trueMatches: { type: 'array', items: { type: 'string' } }, // structurally-verified pure-C
    nakedShips: { type: 'array', items: { type: 'string' } }, // structurally-verified NAKED
    amendedSubjects: { type: 'array', items: { type: 'string' } }, // re-tagged as NAKED
    reverted: { type: 'array', items: { type: 'object', properties: { name: { type: 'string' }, reason: { type: 'string' } } } },
    mainHealthy: { type: 'boolean' }, // make check exits 0 on main right now
    sha1Match: { type: 'boolean' }, // ROM byte-identical to baserom
    asmFuncsRemaining: { type: 'integer' },
    worktreesCleaned: { type: 'integer' },
    nextPlan: PLAN_SCHEMA,
    notes: { type: 'string' },
  },
}

// ---------------------------------------------------------------------------
// Prompt builders
// ---------------------------------------------------------------------------
function scoutPrompt(skip) {
  const skipList = (skip && skip.length) ? skip.join(', ') : '(none)'
  return `You are the SCOUT for one round of an automated matching-decompilation loop in
${MAIN} (Frogger's Adventures: Temple of the Frog — GBA, agbcc toolchain).

READ-ONLY. Do NOT modify, create, or delete any file. Do NOT commit. You run in the
main checkout.

Steps:
1. git status --short  — if NON-empty, set mainDirty=true and STOP (report it; the
   loop will halt for safety).
2. python3 tools/agent/progress.py --human  — record asm_funcs_remaining.
3. python3 tools/agent/pick_target.py --json  — JSON list of decomp candidates, now
   PRE-SORTED smallest-first. Each row has: name, file (asm slice), destination (.c),
   addr, byte_size (TRUE function span in bytes), instr_count (real estimate), legal,
   legality_note. NOTE: \`line_count\` is the INCBIN-stub line count (~4 for every
   slice) — IGNORE it; rank by \`byte_size\`.
4. ESCALATION LADDER — \`python3 tools/agent/function_status.py --status deferred --json\`.
   The tier authority. Each deferred fn carries \`next_tier\`. THIS IS A SONNET-ONLY LOOP —
   you NEVER pick a deferred function, regardless of its tier:
   - next_tier=="opus" → Sonnet already deferred it; escalating it would mean Opus, which this
     loop does NOT run. Do NOT pick. (The Opus finish-decomp run handles these.)
   - next_tier=="codex" → Opus deferred it too (firm-defer). Do NOT pick; list it in codexQueue.
   So EXCLUDE every deferred fn from decompTargets. The only valid targets are FRESH (never
   deferred) functions.
5. Walk the legal pick_target rows and choose up to ${QUEUE_DEPTH} DISJOINT targets — fresh,
   smallest-first (a rolling pool of ${K} workers drains this deep queue; return MANY, not just
   a few) — where:
   - legal == true (legality_note begins "OK: appends"), AND
   - byte_size <= ${SONNET_MAX_BYTES} (HARD CAP — a larger function is NOT a valid target in this
     Sonnet-only loop; skip it entirely, it is left for the Opus run), AND
   - the name is NOT in this skip list (do NOT pick): ${skipList}, AND
   - the function is FRESH — its next_tier is NEITHER "opus" NOR "codex" (never deferred), AND
   - chosen targets have DISTINCT \`file\` (asm slice) AND DISTINCT \`destination\` (.c).
   Tag every chosen target nextTier:"" (this loop has no escalation tier). Smallest-first:
   success rate is highest on small leaf/helpers; 12-160B is the sweet spot here.
   Return as many as qualify (possibly zero) — the driver dispatches the first ${K}.
6. legalTargetCount = total legal "OK: appends" rows with byte_size <= ${SONNET_MAX_BYTES}
   (excluding the skip list and any deferred fn). codexQueue = ALL function_status
   next_tier=="codex" names (the firm-defer queue, even if not in pick_target).

Return ONLY the structured object. For each chosen target emit {name, asmFile (=file),
destC (=destination), addr (as the "0x…" hex string), byteSize (=byte_size), nextTier}. Also
emit codexQueue (array of firm-defer names).`
}

function decompPrompt(t, round, model) {
  const escalated = t.nextTier === 'opus'
  return `You are a DECOMP agent (running on ${model || 'the inherited model'}) in an isolated git worktree of ${MAIN}
(Frogger's Adventures: Temple of the Frog — GBA, agbcc). Round ${round}.

Your assigned target: ${t.name}  (asm slice ${t.asmFile} → C file ${t.destC}, addr ${t.addr}, ~${t.byteSize ?? '?'} bytes).
Decompile EXACTLY this one function. Do not pick a different target.
${escalated ? `ESCALATION (Opus retry — Sonnet deferred this). READ docs/deferred-analysis/${t.name}.md, but treat the prior attempt as a LOCAL PLATEAU to ESCAPE, not a base to extend: its drift + tried levers tell you what does NOT work, so RE-DERIVE the C from scratch rather than tweaking its near-match (a near-match is a local minimum — tweaking it stays in the same basin). This IS matchable in PURE C — every GBA decomp in the corpus is ~100% pure-C on game logic — so it is a THINKING problem, not a search. The permuter only MUTATES existing structure; it CANNOT invent the structure that matches (a pointer cast that forces a dead-register reuse; an \`asm("")\` barrier that blocks a tail-merge; a \`-fno-strength-reduce\` / \`-ffixed-rN\` per-TU flag). When a register CHOICE, a fold, or a loop shape is wrong, READ the responsible agbcc pass in tools/agbcc-src/gcc_arm/ (local-alloc.c / regclass.c / reload.c = register choice; loop.c = loop-reversal/strength-reduce; cse.c / gcse.c = folds) to learn WHY it diverges, then write the C that avoids it. Grind like codex does (it matches these in ~200-330k tokens by trying many DISTINCT structures + reading the compiler) before you EVER consider defer. Defer (append a "## Opus attempt" section to the note) ONLY after several FUNDAMENTALLY DIFFERENT structural approaches genuinely fail — not at the first plateau.` : ''}

Read ${MAIN}/CLAUDE.md ("Agent workflow", "C style") and docs/codegen-notes.md once
for the full workflow and the agbcc matching idioms. This brief is the iteration
contract layered on top.
${BOOTSTRAP}

DECOMP STEPS:
1. python3 tools/agent/decomp_brief.py ${t.name}  — range, callees+peel-status, pool
   labels (resolved addrs), struct xref, m2c seed C, dest hint.
1b. SEED FROM PRIOR WORK: cat docs/deferred-analysis/${t.name}.md 2>/dev/null. If it
   exists, a previous attempt stashed its best-effort readable C + the exact drift it
   got stuck on + levers/permuter already tried. RESUME from that analysis (try a
   DIFFERENT lever than the ones listed) instead of re-deriving the function cold.
2. For each callee tagged "UNPEELED ✗":
     python3 tools/agent/auto_peel.py --addr 0x<callee> --apply
   (auto_peel runs its own make check and self-reverts bad peels.) Commit each batch
   "Peel sub_XYZ". Cross-region BL callees MUST be peeled or the C cannot match.
3. If the target itself is "blocked: needs new C file", scaffold it first:
     python3 tools/agent/scaffold_cluster.py --asm ${t.asmFile} ${t.name} --apply
   (build-safe; commit "Scaffold ${t.destC}").
4. Grow typed struct headers from observed IWRAM/EWRAM offsets when the brief surfaces
   raw bases (struct_grow.py / struct_xref.py) BEFORE writing C — no raw [rN,#imm] magic.
TRIAGE — classify BEFORE writing C (prerequisites 2-4 are done either way; a NAKED ship
still needs callees peeled for symbol resolution + the dest .c scaffolded). Run the
deterministic classifier (it reads baserom bytes — ground truth):
     python3 tools/agent/classify_unmatchable.py ${t.name}
   • VERDICT STRONG_UNMATCHABLE  [class4-movpc | class3-libgcc] — a structural-impossibility
     signature agbcc 2.x literally cannot emit from C (a \`mov pc, rN\` computed jump, or a
     WIDE r4-r7 prologue whose only calls are libgcc helpers). CONFIRM it negatively against
     the corpus before shipping NAKED:
         python3 tools/agent/corpus.py grep '<exact idiom regex>' --asm   # expect MANY hits
         python3 tools/agent/corpus.py grep '<related C construct>'  --c   # hunt for matched-C
     Read the hits — does any repo decompile this idiom to PURE C (a real .c body, NOT an
     INCLUDE_ASM / NAKED block)? If YES → it is matchable; treat as ATTEMPT (go to 5). If it
     lives ONLY in hand-asm/NAKED → ship NAKED+NON_MATCHING now (skip the match grind):
     readable C under #ifdef NON_MATCHING, hand-asm NAKED under #else; every NAKED inline-asm
     block ends with "    .syntax divided\\n". status="naked".
   • VERDICT ATTEMPT_MATCH — no structural-impossibility signature. ATTEMPT the C match
     (step 5). The classifier may print an ⚐ advisory (e.g. "high regs pinned across a bl —
     POSSIBLE Class-1"): heed it as a HINT for WHICH lever to reach for (\`register asm("rN")\`
     pins), NOT as license to skip the attempt. High-reg pins are frequently matchable —
     sub_08004508 holds BOTH r8 and r9 across a bl and still byte-matches via register pins.
     You MUST attempt.

ASYMMETRIC-COST RULE (internalize this): a function wrongly shipped as NAKED is a PERMANENT
regression — nobody revisits it and it won't survive the phase-3 PC port. Wasted match
tokens are cheap and recoverable. So NAKED ONLY on a STRONG + corpus-confirmed signature, or
after the lever+corpus path (below) genuinely fails. When unsure → ATTEMPT.

5. Write C into ${t.destC} (use the brief's m2c seed; project C style — named constants/
   enums, early-return no-else, no side effects in conditions, u8 booleans).
6. Verify:
     make -j4
     python3 tools/agent/compile_and_view_assembly.py ${t.name} --human
   COST DISCIPLINE (token audit: ~98% of this workflow's cost is cache traffic from long
   iterate loops, so fewer/cheaper turns is the whole game):
   • While CONVERGING, prefer the FAST per-symbol diff — build_expected.py --fn ${t.name}
     then objdiff-cli on expected/src/<rel>.o vs src/<rel>.o (CLAUDE.md "Agent workflow"
     step 7). It skips the whole-ROM rebuild; use the full \`make -j4\` + compile_and_view
     only as an initial sanity check and for the FINAL match verification.
   • NEVER paste full build/make logs into your reasoning — they re-enter context every
     turn and dominate cost. Keep only the byte_diff / diff-count lines.

DEFINITION OF DONE — READ CAREFULLY (the previous run lied here):
  byte_diff 0 does NOT by itself mean "matched". A NAKED+NON_MATCHING function ALSO has
  byte_diff 0 — its asm path reproduces the bytes by construction. The status is STRUCTURAL,
  determined by what the committed .c contains, NOT by byte_diff:
    • status="matched"  ⟺  PURE C: the .c has NO \`NAKED\`, NO inline \`asm(\`, NO
      \`#ifdef NON_MATCHING\` for this function — AND byte_diff 0 / make check passes.
    • status="naked"    ⟺  the .c uses NAKED / inline asm / #ifdef NON_MATCHING (it still
      byte-matches via the asm path, but it is NOT a pure-C match).
  Verify your own status before reporting: a NAKED ship has a \`NAKED\` attribute or a
  \`#ifdef NON_MATCHING\` block for THIS function — \`grep -nE 'NON_MATCHING|\\bNAKED\\b' ${t.destC}\`
  (scope to ${t.name}'s body). If that prints for your function, status MUST be "naked".
  IMPORTANT: a \`register T x asm("rN")\` register-pin DECLARATION is PURE C (a matching lever),
  NOT inline asm — it does NOT make the function NAKED. NEVER call a NAKED ship a "true
  match" / "true byte-match" — say "matches via the NAKED asm path".

IF IT DRIFTS (ATTEMPT case, pure C not matching yet) — matchable-with-a-lever, NOT NAKED
yet — it IS matchable in pure C (corpus = ~100% on game logic), so this is a THINKING
problem, not a search. The "~6 iterations then defer" cost-cap from the audit is about NOT
GRINDING THE SAME C STRUCTURE (a near-match is a local minimum; tweaking one structure that
won't converge is wasted) — it is NOT permission to quit at the first plateau. RE-DERIVING a
FUNDAMENTALLY DIFFERENT structure (a register-forcing pointer cast, a different expression
shape, a -fXXX flag, an asm("") barrier — informed by READING the agbcc pass) resets the
budget. Defer only after SEVERAL DISTINCT structural approaches genuinely fail.
  a. Identify the EXACT drift (which register, fold/schedule, prologue push) — then READ the
     agbcc pass that causes it: tools/agbcc-src/gcc_arm/{local-alloc,regclass,reload}.c for
     register choice, loop.c for loop-reversal, cse.c/gcse.c for folds — to learn WHY it picks
     what it picks, then write the C that avoids it.
  b. Try levers — INVENT structure, don't just tweak: local base-ptr anchor (\`T *p=&gThing;\`);
     \`register T x asm("rN")\` pin INCLUDING high regs r8/r9/sl (these ARE matchable — see
     sub_080210A0 — do NOT auto-NAKED them); cast a now-dead pointer to an index to force its
     register reuse (\`p=(T*)(u32)p->f; x=tbl[(u32)p];\` — sub_0800A1C8, a structure the permuter
     cannot invent); \`asm("")\` barrier on an r0-pinned local to block a tail-merge of distinct
     return paths (sub_0800A104); void-return epilogue (decl caller+callee void → \`pop {r0};
     bx r0\`); linker-assigned IWRAM symbols to defeat a CSE-fold; per-TU \`CFLAGS +=\` flag
     overrides (\`-ffixed-rN\` to free a register, \`-fno-strength-reduce\` for loop-reversal,
     \`-fno-gcse\`, \`-fno-schedule-insns\`) and/or \`CC=\$(OLD_AGBCC_BIN)\`; statement/scope reorder.
  c. Corpus-grep the SPECIFIC drift; apply any pure-C precedent, retry.
  d. PERMUTER — if you are NEAR a match (small byte_diff, say ≤ ~40) and the function is
     NOT corpus-validated unmatchable, brute-force the residual drift per
     ${MAIN}/docs/permuter-howto.md. HARD BUDGET ~2000 iters ≈ 30s. macOS has NO \`timeout\`,
     and a naive \`& kill $PID\` LEAKS the -j workers (they orphan to PID 1 and burn CPU
     forever) — especially if you pipe the permuter. Use EXACTLY this PROCESS-GROUP kill, do
     NOT pipe it, redirect to a file:
         set -m
         vendor/decomp-permuter/.venv/bin/python vendor/decomp-permuter/permuter.py \\
             nonmatchings/<fn>-<id> -j4 --stop-on-zero --better-only > /tmp/perm-<fn>.log 2>&1 &
         PGID=$!; sleep 45; kill -- -$PGID 2>/dev/null; wait 2>/dev/null
         pkill -f "permuter.py nonmatchings/<fn>-<id>" 2>/dev/null || true   # scoped safety net
         grep -E 'base score|new best|score = 0|Found match' /tmp/perm-<fn>.log | tail
     NEVER \`pkill -f permuter.py\` unscoped (cross-kills sibling worktrees). After it, VERIFY
     \`pgrep -f "nonmatchings/<fn>-<id>"\` is EMPTY — leaked permuters are a real problem.
     If score 0 → adopt the output-*/ variant, CONFIRM byte_diff 0 independently, ship
     status="matched". If not within budget, do ONE structural rewrite + one more bounded
     run, then stop. Validate the scratch with a 3s smoke first; rm nonmatchings/<fn>-* when
     done (never commit it).
  e. RAISED BAR — if levers + permuter (+ one rewrite) + corpus ALL fail on an ATTEMPT
     function, DO NOT ship NAKED. The corpus proves game-logic functions match ~always
     (cvaos, a Konami GBA agbcc title like ours, is ~0.3% NAKED and 0% in game logic), so a
     stuck ATTEMPT means the right C STRUCTURE hasn't been found yet — NOT that it's
     impossible. NAKED here would be a false "done". Instead DEFER — but PRESERVE your work
     first so the next attempt doesn't restart cold (this is the ONE commit a deferral makes):
       i.  Write docs/deferred-analysis/${t.name}.md (mkdir -p docs/deferred-analysis first):
           a "## Drift" section (best byte_diff/diff_count, WHICH register/fold/schedule,
           levers + permuter score already tried — so the next agent picks a DIFFERENT lever)
           and a "## Best-effort C" section with your most-correct readable C in a \`\`\`c block.
       ii. git add docs/deferred-analysis/${t.name}.md && git commit -m "Stash deferred analysis: ${t.name}"
           This commit touches ONLY docs/ (a .md — NEVER compiled, make check stays green).
           Include its SHA in commits[].
       iii. THEN revert the rest: \`git checkout -- ${t.destC}\` (or restore the TODO stub),
           LEAVE the asm slice ${t.asmFile} in place (do NOT delete it, do NOT touch linker.ld).
     status="deferred". An honest un-decompiled asm slice beats a fake-matched NAKED, and the
     stashed .md lets the reclamation pass (or a human) resume from your analysis.
     (NAKED is reserved for classifier STRONG_UNMATCHABLE + corpus-confirmed only — handled
     in TRIAGE above. You should never reach here for a STRONG function.)

ON A PURE-C MATCH or a clean NAKED ship:
  - rm the now-empty asm slice ${t.asmFile} (if the function's whole slice is consumed).
  - Edit linker.ld to collapse the scaffold + asm pair into the single src .o(.text)
    entry, following the preceding sibling's pattern.
  - If a stale defer note exists for this now-RESOLVED function, remove it:
    \`[ -f docs/deferred-analysis/${t.name}.md ] && git rm docs/deferred-analysis/${t.name}.md\`
    (prevents function_status.py from still reporting it as deferred).
  - make -j4 && make check  (MUST exit 0).
  - Commit with the subject that matches your status — this is mandatory and the integrator
    re-checks it:
      • status="matched":  git commit -m "Decompile ${t.name}"
      • status="naked":    git commit -m "Decompile ${t.name} (NAKED + NON_MATCHING)"
    Body explains the structure + agbcc tricks; for NAKED include "class: <classN>, corpus:
    <the asm-vs-matched-C hit counts>, levers tried: <…>". Do NOT write "true match" for NAKED.

IF YOU CANNOT MATCH OR NAKED-SHIP (e.g. asm-slice needs mnemonic refinement too large
to do safely): revert to a clean tree (git checkout -- / git reset --hard \$BASE,
git clean -fd untracked you added) and report status "reverted" with the blocker.
DO NOT remove the asm slice, DO NOT commit a broken/non-matching build.
${WORKTREE_RULES}

Return the structured object: target="${t.name}", status, worktreePath, commits (the
\`git rev-list --reverse \$BASE..HEAD\` SHAs in apply order), nakedClass/corpusEvidence
if NAKED, and notes (what you did / why reverted).`
}

function builderPrompt(round) {
  return `You are the QUEUE-BUILDER in an isolated git worktree of ${MAIN}
(Frogger's Adventures: Temple of the Frog — GBA, agbcc). Round ${round}.

Your job: GROW the decompable queue so future rounds have unblocked targets. You do
NOT decompile anything. Read ${MAIN}/CLAUDE.md ("Disassembly workflow", layout
invariant) once.
${BOOTSTRAP}

Do these in order, then stop:

PART A — SCAFFOLD blocked peeled slices (PRIMARY; build-safe, high value, low risk):
1. python3 tools/agent/pick_target.py --all  — rows flagged "blocked: needs new C
   file" / "no src/*.c adjacent" are PEELED slices waiting only for a scaffold.
2. For up to 4 such blocked slices (vary which ones across rounds):
     python3 tools/agent/scaffold_cluster.py --asm asm/disasm_0x<addr>.s <fnname> --apply
     # add --dest src/{game,engine}/<name>.c when neither linker.ld neighbour is a C file
   Scaffolding adds an empty src .o(.text) + linker.ld entry; the asm slice still
   provides the bytes, so 'make check' stays green. Verify with 'make -j4 && make check'
   after each. Commit each "Scaffold src/.../<name>.c". Skip src/system/* (boot/sound,
   manually owned) and libgcc/BIOS thunks.

PART B — FRONTIER-PEEL new functions out of raw text buckets (SECONDARY; only if Part A
found < 4 scaffold candidates, i.e. the blocked backlog is thin):
3. The un-peeled code lives in asm/text/text_*.s INCBINs. To peel the next function:
     - Pick a text bucket; read its .incbin start address + length.
     - arm-none-eabi-objdump -D -b binary -m arm7tdmi -Mforce-thumb <bytes> to preview;
       find a 4-byte-aligned 'push {…, lr}' (b5xx) prologue = a real Thumb function start.
     - npx tsx tools/agent/ts/cmds/detect-fn-boundary.ts 0x<start>  — find the true end.
     - python3 tools/agent/auto_peel.py --addr 0x<start> --apply  (or peel.py with
       --start/--end; use --force-boundary only after manual review of a computed-bx end).
     - auto_peel self-reverts bad peels + runs make check. Commit "Peel sub_<addr>".
   NEVER peel jump tables, literal pools, or graphics/level/sound data (not code). When
   in doubt, skip it. Up to 4 peels. If you scan buckets and find NO more peelable code,
   set frontierExhausted=true.

If neither part produced any commit, that's fine — report it (this feeds the loop's
dry-detection).
${WORKTREE_RULES}

Return the structured object: worktreePath, commits (\`git rev-list --reverse
\$BASE..HEAD\`, apply order), scaffolded (names), peeled (addrs), frontierExhausted, notes.`
}

function integratorPrompt(round, builderRes, decompResults, goodNote, skip) {
  const skipList = (skip && skip.length) ? skip.join(', ') : '(none)'
  const payload = {
    builder: builderRes
      ? { worktreePath: builderRes.worktreePath, commits: builderRes.commits || [] }
      : null,
    decomps: decompResults
      .filter(Boolean)
      .map((r) => ({ target: r.target, status: r.status, worktreePath: r.worktreePath, commits: r.commits || [] })),
    // worktrees to clean even if their agent crashed (no report) are caught by prune.
  }
  return `You are the INTEGRATOR for round ${round} of an automated matching-decompilation
loop. You run on the MAIN checkout at ${MAIN}. ${goodNote}

Your inputs (commits live in the shared .git object store — reachable by SHA from main
even though they were made in sibling worktrees):
\`\`\`json
${JSON.stringify(payload, null, 2)}
\`\`\`

GOAL: land every good commit onto main WITHOUT ever leaving main non-matching. After
each cherry-pick, 'make check' MUST pass; if it doesn't, drop that pick and continue.

PROCEDURE:
1. GOOD=$(git rev-parse HEAD)   # last known-matching main commit; your fallback anchor.
2. Pre-flight 'git status --short'. If dirty, it is almost certainly the worktree-leak
   bug (a sibling worktree's uncommitted edits surfaced in main). For each dirty file,
   'git diff' it; if it matches a commit you're about to cherry-pick, discard the dupe
   with 'git checkout -- <file>'. The tree MUST be clean before you cherry-pick.
3. Cherry-pick the BUILDER commits first (Part A scaffolds + Part B peels), in the given
   order, ONE AT A TIME:
     git cherry-pick <sha>
     - On a linker.ld conflict: it is almost always two adjacent insertions in different
       address bands — open linker.ld, KEEP BOTH hunks, remove the conflict markers,
       'git add linker.ld', 'GIT_EDITOR=true git cherry-pick --continue'.
     - On any conflict you cannot cleanly resolve: 'git cherry-pick --abort' (safe — a
       single-commit pick hasn't advanced HEAD) and SKIP this commit (note it).
     After each successful pick: 'make -j4 && make check'. If make check FAILS:
     'git reset --hard HEAD~1' to drop it, record it as reverted, continue.
4. Then cherry-pick each DECOMP agent's commits, in order, ONE AT A TIME, same rules as
   step 3. Which agents contribute commits:
     - status matched / naked → pick their "Decompile <fn>" (+ any "Peel"/"Scaffold") commits.
     - status deferred → they did NOT land the function, BUT they may have ONE "Stash
       deferred analysis: <fn>" commit that touches only docs/deferred-analysis/<fn>.md.
       DO cherry-pick that one (it's a .md — never compiled, make check stays green); it
       preserves their best-effort C so the next attempt resumes instead of starting cold.
     - status reverted / blocked / skipped, or empty commits → skip entirely.
   NOTE: pick ONE COMMIT AT A TIME — never 'git cherry-pick A B C'. A batch that fails
   midway writes a sequencer; if you ever see one, clear it with 'git cherry-pick --quit'
   (NOT --abort, which rewinds HEAD and loses commits).
4b. VERIFY STATUS STRUCTURALLY — do NOT trust the agent's self-reported status (the last
   run mislabeled NAKED ships as matches). For each "Decompile <fn>" commit you just landed,
   inspect the .c it touched:
     git show --stat HEAD        # find the src/.../<fn>.c it changed
     grep -nE 'NON_MATCHING|\\bNAKED\\b' <that .c>   (scope to <fn>'s body; a
     \`register T x asm("rN")\` pin is PURE C, NOT NAKED — never flag it)
   • If the function's body uses NAKED / inline asm / #ifdef NON_MATCHING → it is a NAKED
     ship. Count it in nakedShips (NOT trueMatches). If the commit SUBJECT lacks
     "(NAKED + NON_MATCHING)", AMEND it so git log is truthful — the just-landed commit is
     HEAD, so: \`git commit --amend -m "Decompile <fn> (NAKED + NON_MATCHING)"\` (preserve the
     body with --no-edit + -m, or reuse the message). If it is NOT HEAD (a later pick landed
     after it), skip the amend but STILL count it as naked and note the stale subject.
   • Otherwise it is a genuine pure-C match → count it in trueMatches.
   This structural check is the source of truth for trueMatches vs nakedShips, overriding
   whatever the agent claimed.
5. After all picks: regenerate the scoreboard ONCE:
     python3 tools/agent/progress_stats.py --update-readme
     git add README.md && git commit -m "Update progress stats"   # only if it changed
     python3 tools/agent/snapshot_addresses.py    # refreshes gitignored cache; no commit
6. FINAL VERIFY — incremental builds can STALE-PASS and hide a non-match (codegen-notes
   §1162 linker.ld.pp-not-regenerated, §2024 slice-split staleness), so DO NOT trust the
   per-pick incremental make check alone. FORCE A CLEAN RELINK first:
     rm -f frog_us.gba frog_us.elf frog_us.map linker.ld.pp
     make -j4 && make check
   It MUST exit 0. If it does NOT:
     git reset --hard $GOOD     # restore main to the last known-matching state
   then set mainHealthy=false and report (the loop will halt). This relink catches
   link/linker.ld.pp staleness cheaply; a full \`make tidy && make && make check\` (which also
   catches stale .o) should be run periodically — note in your report if you did NOT do one,
   so the orchestrator can run a full clean-verify at run-end.
7. CLEANUP worktrees (avoid disk blowup over many rounds — 4 worktrees/round × many rounds
   fills the disk). The harness LOCKS agent worktrees, so a plain remove fails — UNLOCK
   first. For each worktreePath in the inputs above:
     git worktree unlock "<path>" 2>/dev/null || true
     git worktree remove --force "<path>" 2>/dev/null || true
   Then 'git worktree prune'. Count how many you actually removed (re-check 'git worktree
   list'). Do NOT remove the main worktree (${MAIN}). If a remove still fails, note it but
   continue — do not block the round on cleanup.
7b. REAP LEAKED PERMUTERS (decomp agents can leak orphaned -j workers that burn CPU): kill
   only ppid=1 (orphaned) permuter/multiprocessing python — never an active one (live parent):
     for p in $(pgrep -f 'decomp-permuter/permuter.py|multiprocessing' 2>/dev/null); do
       [ "$(ps -o ppid= -p $p 2>/dev/null|tr -d ' ')" = "1" ] && kill -9 $p 2>/dev/null
     done
8. Compute nextPlan (PLAN_SCHEMA) for the next round — SAME escalation logic as the scout:
     git status --short  (→ mainDirty)
     python3 tools/agent/progress.py --human  (→ asm_funcs_remaining)
     python3 tools/agent/function_status.py --status deferred --json  (the tier authority):
       next_tier=="opus" deferrals → ESCALATION targets (tag nextTier:"opus", pick FIRST);
       next_tier=="codex" → firm-defers → codexQueue, do NOT pick.
     python3 tools/agent/pick_target.py --json  (rows PRE-SORTED smallest-first; rank by
       byte_size, NOT line_count) → escalation-first then fresh smallest-first, up to ${K + 3}
       DISJOINT legal targets (distinct asmFile AND distinct destC), EXCLUDING any name in the
       skip list (parked / firm-defer): ${skipList} and any next_tier=="codex" name. Emit each
       as {name, asmFile, destC, addr, byteSize (=byte_size), nextTier}. legalTargetCount =
       legal rows minus the skip list. codexQueue = all next_tier=="codex" names.

Return the structured object: committedCount (commits actually landed this round),
landed (all fn/scaffold/peel names), trueMatches (pure-C decomps, structurally verified),
nakedShips (NAKED+NON_MATCHING decomps, structurally verified — NOT the agent's claim),
amendedSubjects (commits whose subject you re-tagged as NAKED), reverted ([{name,reason}]),
mainHealthy, sha1Match (ROM byte-identical), asmFuncsRemaining, worktreesCleaned, nextPlan,
notes.`
}

// --- Rolling-pool per-result integrator: integrate ONE finished decomp onto main ---
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
// Driver: scout once into a deep queue, then a rolling K-worker pool.
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
phase('Scout')
log(`finish-decomp-sonnet (NO Opus): K=${K} parallel, builder=${RUN_BUILDER}, <=${SONNET_MAX_BYTES}B targets only, max ${MAX_ROUNDS} rounds`)

// (C+D) Cross-round skip set: hard-listed long-tail funcs + anything deferred
// ≥ DEFER_SKIP_THRESHOLD times in a row. deferStreak counts consecutive defers
// per target (reset on a match/naked). skipNames() is the live exclusion list.
const deferStreak = {}
// Firm-defers (the codex queue): functions Opus has already deferred, surfaced by the
// scout from function_status.py --next-tier codex. Durable across runs (derived from the
// notes), unlike the per-run deferStreak. Both feed the exclusion list. In THIS Sonnet-only
// loop there is no Sonnet->Opus escalation: a function Sonnet defers (next_tier becomes
// "opus") is simply excluded by sonnetEligible and left for the Opus finish-decomp run, so a
// fresh target gets exactly one Sonnet attempt here; DEFER_SKIP_THRESHOLD is the backstop.
let firmDefers = []
const skipNames = () => [
  ...HARD_LIST,
  ...firmDefers,
  ...Object.keys(deferStreak).filter((n) => deferStreak[n] >= DEFER_SKIP_THRESHOLD),
]
log(`Parked OUT of the loop (hard-list, D): ${HARD_LIST.join(', ') || '(none)'} — re-attempt these via a dedicated permuter campaign, not the loop.`)

let plan = await agent(scoutPrompt(skipNames()), { schema: PLAN_SCHEMA, label: 'scout r1', phase: 'Scout', model: MODELS.scout })
if (!plan) {
  log('Initial scout failed — aborting.')
  return { error: 'scout failed', rounds: 0 }
}
if (plan.mainDirty) {
  log('main is dirty at start — aborting for safety (clean the tree, then re-run).')
  return { error: 'main dirty', rounds: 0 }
}
firmDefers = plan.codexQueue || []
if (firmDefers.length) log(`Firm-defers (codex queue — Opus already tried, NOT auto-dispatched): ${firmDefers.join(', ')}`)
log(`Start: ${plan.asmFuncsRemaining} asm funcs remaining, ${plan.legalTargetCount} legal targets, ${plan.decompTargets.length} assigned this round.`)

// Build a deep target queue; K workers pull from it continuously (no round barrier).
// sonnetEligible re-filters the scout's picks: fresh (no escalation tier) AND <=160B only.
// Belt-and-suspenders — the scout is already told to cap, but it is an LLM, so the driver
// enforces the gate too. Anything excluded here is left for the Opus finish-decomp run.
const skip0 = new Set(skipNames())
const scouted = (plan.decompTargets || []).filter((t) => !skip0.has(t.name))
let queue = scouted.filter(sonnetEligible)
const droppedIneligible = scouted.length - queue.length
if (droppedIneligible > 0) log(`Dropped ${droppedIneligible} scouted target(s) as Sonnet-ineligible (>${SONNET_MAX_BYTES}B or escalated).`)
if (MAX_DECOMP_AGENTS != null) queue = queue.slice(0, MAX_DECOMP_AGENTS)
log(`Rolling pool: ${K} Sonnet workers over a ${queue.length}-target queue (all fresh, <=${SONNET_MAX_BYTES}B; Opus-escalation + large targets excluded — left for the Opus run).`)

const results = []
let halt = false
let dispatched = 0

// Async mutex: integrations serialize on main (decomp stays fully parallel).
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

// --- Low-watermark builder refill: keep the queue fed on long/overnight runs ---
const BUILDER_WATERMARK = A.builderWatermark || 20
const MAX_REFILLS = A.maxRefills || 50
let frontierExhausted = !RUN_BUILDER // if builder disabled, never refill
let refills = 0
let builderLock = null
const seen = new Set(queue.map((t) => t.name))

function builderIntegratePrompt(bres) {
  return `You run on the MAIN checkout (${MAIN}). A builder peeled a batch in worktree
${bres.worktreePath}. Integrate its peels, then RE-SCOUT so the rolling pool gets fresh targets.
1. cd ${MAIN}. If git status --short is NOT clean, a decomp agent stray-wrote to main —
   SELF-HEAL it first: git checkout -- . && git clean -fd (gitignored deps/worktrees are
   preserved), then confirm it is empty before cherry-picking.
2. Cherry-pick the builder commits IN ORDER: ${(bres.commits || []).join(' ') || '(none)'} —
   one at a time; after the last, make -j4 && make check MUST exit 0 (else git reset --hard to
   the pre-pick HEAD and set mainDirty=true).
3. Clean the builder worktree: git worktree unlock ${bres.worktreePath} 2>/dev/null;
   git worktree remove --force ${bres.worktreePath} 2>/dev/null; git worktree prune.
4. RE-SCOUT like the scout (SONNET-ONLY constraints): python3 tools/agent/pick_target.py --json
   and python3 tools/agent/function_status.py --status deferred --json. Choose up to ${QUEUE_DEPTH}
   DISJOINT legal FRESH targets, smallest-first, each with byte_size <= ${SONNET_MAX_BYTES} (HARD
   CAP — larger functions are NOT valid in this loop). EXCLUDE every deferred fn (next_tier "opus"
   OR "codex" — list the codex ones in codexQueue) and these skip names:
   ${skipNames().join(', ') || '(none)'}. Tag every chosen target nextTier:"".
Return PLAN_SCHEMA: mainDirty, asmFuncsRemaining, legalTargetCount, decompTargets, codexQueue.`
}

async function refillQueue() {
  if (frontierExhausted || halt || refills >= MAX_REFILLS) return
  // Don't peel more than the decomp-agent cap can consume (counting in-flight + queued).
  if (MAX_DECOMP_AGENTS != null && dispatched + queue.length >= MAX_DECOMP_AGENTS) return
  if (builderLock) { await builderLock; return } // a refill is already running — wait, don't double-build
  let release
  builderLock = new Promise((r) => (release = r))
  try {
    refills += 1
    log(`Backlog low (${queue.length} < ${BUILDER_WATERMARK}) — builder #${refills} peeling more.`)
    const bres = await agent(builderPrompt(refills), {
      schema: BUILDER_SCHEMA,
      isolation: 'worktree',
      phase: 'Build queue',
      model: MODELS.build,
      label: `build #${refills}`,
    })
    if (!bres) { log(`Builder #${refills} returned null — skipping refill.`); return }
    await withIntegrateLock(async () => {
      const plan2 = await agent(builderIntegratePrompt(bres), {
        schema: PLAN_SCHEMA,
        phase: 'Build queue',
        model: MODELS.integrate,
        label: `build-integ #${refills}`,
      })
      if (plan2 && plan2.mainDirty) {
        log(`Builder #${refills} integrate left main dirty — HALTING.`)
        halt = true
      } else if (plan2) {
        let added = 0
        for (const t of plan2.decompTargets || []) {
          if (!seen.has(t.name) && sonnetEligible(t)) { seen.add(t.name); queue.push(t); added += 1 }
        }
        log(`Builder #${refills}: +${added} new Sonnet-eligible targets; queue now ${queue.length}.`)
        if (added === 0) { frontierExhausted = true; log('Refill added 0 new targets — treating frontier as exhausted, no more builder runs.') }
      }
      if (bres.frontierExhausted) { frontierExhausted = true; log('Frontier exhausted — builder will not run again.') }
    })
  } finally {
    release()
    builderLock = null
  }
}

async function worker(wid) {
  while (!halt) {
    if (!frontierExhausted && queue.length < BUILDER_WATERMARK) await refillQueue()
    const t = queue.shift()
    if (!t) {
      if (builderLock) { await builderLock; continue } // a refill is finishing — recheck the queue
      if (!frontierExhausted) { await refillQueue(); if (queue.length) continue }
      return // queue empty, no builder running, frontier exhausted -> done
    }
    // Total decomp-agent cap (counts refill-added targets too). Check + increment are
    // adjacent + synchronous (no await between), so K workers can't overshoot it.
    if (MAX_DECOMP_AGENTS != null && dispatched >= MAX_DECOMP_AGENTS) { queue.unshift(t); return }
    const m = decompModel(t)
    dispatched += 1
    const tag = `${t.name} [${m}${t.nextTier === 'opus' ? ' escal' : ''}]`
    const dres = await agent(decompPrompt(t, dispatched, m), {
      schema: DECOMP_SCHEMA,
      isolation: 'worktree',
      phase: 'Decomp',
      model: m,
      label: `decomp ${tag}`,
    })
    if (!dres) continue
    await withIntegrateLock(async () => {
      if (halt) return
      const integ = await agent(integrateOnePrompt(t, dres), {
        schema: INTEG1_SCHEMA,
        phase: 'Integrate',
        model: MODELS.integrate,
        label: `integ ${t.name}`,
      })
      if (!integ) {
        log(`integ ${t.name}: integrator returned null — HALTING new dispatches (inspect main).`)
        halt = true
        return
      }
      results.push({ target: t.name, decompStatus: dres.status, ...integ })
      log(`+ ${t.name}: decomp=${dres.status} integ=${integ.status} landed=[${(integ.integrated || []).join(', ') || '-'}] sha1Match=${integ.sha1Match} (${results.length} integrated, ${queue.length} queued)`)
      if (integ.mainHealthy === false || integ.sha1Match === false) {
        log(`main NON-MATCHING after ${t.name} (mainHealthy=${integ.mainHealthy}, sha1Match=${integ.sha1Match}). HALTING — inspect make check on main.`)
        halt = true
      }
    })
  }
}

await parallel(Array.from({ length: K }, (_, i) => () => worker(i)))

// Finalize ONCE: scoreboard + stray-worktree prune (per-result integrators skip these).
phase('Finalize')
const fin = await agent(
  `You run on the MAIN checkout (${MAIN}). The rolling pool has drained. Finalize:
1. git status --short MUST be clean (else mainHealthy=false).
2. make -j4 && make check MUST exit 0 (sha1Match).
3. Regenerate the scoreboard ONCE: python3 tools/agent/snapshot_addresses.py; then
   python3 tools/agent/progress_stats.py --update-readme; if README.md changed,
   git add README.md && git commit -m "Update progress stats".
4. Prune leftover pool worktrees under .claude/worktrees/: git worktree unlock then
   git worktree remove --force each, then git worktree prune. Do NOT touch the main worktree
   or any /private/tmp/* codex worktree.
5. python3 tools/agent/progress.py --human -> asm_funcs_remaining.
Report asmFuncsRemaining, sha1Match, mainHealthy, worktreesCleaned, notes.`,
  {
    schema: {
      type: 'object',
      required: ['sha1Match', 'mainHealthy'],
      properties: {
        asmFuncsRemaining: { type: 'integer' },
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
const trueMatches = results.filter((r) => r.decompStatus === 'matched' && !r.reverted).map((r) => r.target)
const nakedShips = results.filter((r) => r.decompStatus === 'naked' && !r.reverted).map((r) => r.target)
const deferredFns = results.filter((r) => r.decompStatus === 'deferred').map((r) => r.target)
const revertedFns = results.filter((r) => r.reverted).map((r) => r.target)
const landed = results.flatMap((r) => r.integrated || [])

log(`finish-decomp finished: ${dispatched} decomp agents -> ${trueMatches.length} true-C, ${nakedShips.length} NAKED, ${deferredFns.length} deferred, ${revertedFns.length} reverted; asm_funcs_remaining now ${fin ? fin.asmFuncsRemaining : '?'}${halt ? ' (HALTED on non-matching main)' : ''}.`)

return {
  decompAgents: dispatched,
  trueMatches,
  nakedShips,
  deferred: deferredFns,
  reverted: revertedFns,
  landed,
  asmFuncsRemaining: fin ? fin.asmFuncsRemaining : null,
  halted: halt,
  results,
}
