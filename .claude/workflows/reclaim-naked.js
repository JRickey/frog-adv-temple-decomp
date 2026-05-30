export const meta = {
  name: 'reclaim-naked',
  description:
    "Reclaim premature NAKED+NON_MATCHING decomps back to true pure-C matches. The corpus proves a Konami GBA agbcc title matches game logic ~100% (cvaos = 0.3% NAKED), so our ~30 game/engine NAKEDs are mostly the prior agents giving up early. For each: extract the readable C, mine cvaos/pret for the matching idiom, try fresh structure + levers + OLD_AGBCC + permuter; PROMOTE to true-C, or (raised bar) optionally DEMOTE a genuinely-stuck one to an honest un-decompiled asm slice. Processes a finite candidate list in parallel worktree batches, integrating onto main with a make-check safety net.",
  whenToUse:
    'Drive down the NAKED rate by reclaiming game/engine NAKEDs the corpus says are matchable. Run before/after finish-decomp. Re-run to continue; skips already-reclaimed functions.',
  phases: [
    { title: 'Reclaim', detail: 'parallel worktrees: extract readable C, corpus-mine, match or defer' },
    { title: 'Integrate', detail: 'cherry-pick promotions/demotions onto main, make check, regen README' },
  ],
}

// ---------------------------------------------------------------------------
const MAIN = '/Users/jackrickey/Dev/frog-adv-decomp'
const K = (args && args.parallel) || 3
const ON_STUCK = (args && args.onStuck) || 'leave-naked' // 'leave-naked' | 'demote-to-asm'
const MAX_BATCHES = (args && args.maxBatches) || 50
// game/engine NAKED ∩ classifier ATTEMPT, MINUS the 6 already promoted this session
// (sub_0800A1C8, sub_08009884, sub_080072E0, sub_08001CEC, sub_08006948, sub_08006958).
// Already-reclaimed entries are skipped by the agent anyway. NOTE: args may not thread
// through a scriptPath invocation — the baked DEFAULT is authoritative for a no-arg run.
const DEFAULT_CANDIDATES = [
  'sub_0800A104', 'sub_080090B0', 'sub_08003254', 'sub_0800696C',
  'sub_08006A74', 'sub_08006B94', 'sub_08006BA4', 'sub_08006BB4', 'sub_08006D24',
  'sub_08006E8C', 'sub_08006FEC', 'sub_08007228', 'sub_08007874', 'sub_08008F98',
  'sub_08009984', 'sub_08009A58', 'sub_08009BA0', 'sub_08009C14', 'sub_08009D9C',
  'sub_0800A05C', 'sub_0800A2D8', 'sub_0800A328', 'sub_0800BE18', 'sub_08020BC0',
]
// fn -> source file, so the driver never puts two SAME-FILE candidates in one parallel
// batch (that caused the 06948/06958 cherry-pick conflict). Unknown fns map to themselves.
const CANDIDATE_FILES = {
  sub_0800A104: 'src/engine/sub_0800a104.c', sub_080090B0: 'src/game/sub_080090b0.c',
  sub_08003254: 'src/game/sub_08003254.c', sub_0800696C: 'src/game/sub_08006948.c',
  sub_08006A74: 'src/game/sub_08006a74.c', sub_08006B94: 'src/game/sub_08006b88.c',
  sub_08006BA4: 'src/game/sub_08006b88.c', sub_08006BB4: 'src/game/sub_08006b88.c',
  sub_08006D24: 'src/game/sub_08006b88.c', sub_08006E8C: 'src/game/sub_08006b88.c',
  sub_08006FEC: 'src/game/sub_08006b88.c', sub_08007228: 'src/game/sub_08007228.c',
  sub_08007874: 'src/game/sub_08007874.c', sub_08008F98: 'src/game/sub_08008f98.c',
  sub_08009984: 'src/game/sub_08009984.c', sub_08009A58: 'src/game/sub_08009984.c',
  sub_08009BA0: 'src/game/sub_08009ba0.c', sub_08009C14: 'src/game/sub_08009ba0.c',
  sub_08009D9C: 'src/game/sub_08009d9c.c', sub_0800A05C: 'src/engine/sub_0800a05c.c',
  sub_0800A2D8: 'src/game/dispatch_helpers.c', sub_0800A328: 'src/game/dispatch_helpers.c',
  sub_0800BE18: 'src/engine/sub_0800be18.c', sub_08020BC0: 'src/game/sub_080019b4.c',
}
const CANDIDATES = (args && args.candidates) || DEFAULT_CANDIDATES

const BOOTSTRAP = `
WORKTREE BOOTSTRAP (run FIRST — fresh worktrees lack gitignored deps):
\`\`\`sh
MAIN=${MAIN}
for dep in tools/agbcc tools/agent/bin baserom.gba frog_us_baserom.gba node_modules \\
           vendor/decomp-permuter vendor/m2c; do
  [ -e "$dep" ] || ln -s "$MAIN/$dep" "$dep"
done
[ -n "$(ls -A data 2>/dev/null)" ] || python3 tools/extractor.py
git status --short      # must be empty
make -j8 && make check  # MUST exit 0 before any work
\`\`\`
If make check doesn't pass on the pristine tree, STOP and report status "blocked".`

const WORKTREE_RULES = `
HARD RULES (worktree mode): STAY in your worktree (never cd to ${MAIN} — symlink source
only). After every Edit, verify on disk with bash grep/sed before trusting a build. Do
NOT touch README.md / progress_stats.py / snapshot_addresses.py (integrator does it).
Record BASE=$(git rev-parse HEAD) at the start. End with a CLEAN git status. Report
worktreePath (git rev-parse --show-toplevel) and commits (git rev-list --reverse
$BASE..HEAD). If make check ever fails and you can't fix it, git reset --hard $BASE +
git clean -fd, report status "blocked".`

const RECLAIM_SCHEMA = {
  type: 'object',
  required: ['target', 'status', 'worktreePath', 'commits'],
  properties: {
    target: { type: 'string' },
    status: { type: 'string', enum: ['promoted', 'demoted', 'stuck', 'skipped', 'blocked'] },
    worktreePath: { type: 'string' },
    commits: { type: 'array', items: { type: 'string' } },
    bestByteDiff: { type: 'integer' }, // best diff reached if not promoted
    corpusIdiom: { type: 'string' }, // the matching idiom found in cvaos/pret, if any
    notes: { type: 'string' },
  },
}

const INTEG_SCHEMA = {
  type: 'object',
  required: ['committedCount', 'mainHealthy', 'sha1Match'],
  properties: {
    committedCount: { type: 'integer' },
    promoted: { type: 'array', items: { type: 'string' } }, // NAKED → true-C
    demoted: { type: 'array', items: { type: 'string' } }, // NAKED → asm slice
    reverted: { type: 'array', items: { type: 'object', properties: { name: { type: 'string' }, reason: { type: 'string' } } } },
    mainHealthy: { type: 'boolean' },
    sha1Match: { type: 'boolean' },
    nakedRemaining: { type: 'integer' }, // grep -rl NON_MATCHING src/{game,engine} | wc -l
    worktreesCleaned: { type: 'integer' },
    notes: { type: 'string' },
  },
}

function reclaimPrompt(fn, round) {
  return `You are a NAKED-RECLAMATION agent in an isolated git worktree of ${MAIN}
(Frogger's Adventures: Temple of the Frog — GBA, agbcc). Batch ${round}.

TARGET: ${fn} — currently shipped NAKED+NON_MATCHING. Your job: turn it into a TRUE pure-C
byte match if at all possible. CONTEXT THAT MATTERS: a mature Konami GBA agbcc decomp
(Castlevania: Aria of Sorrow = testyourmine/cvaos in the corpus, SAME publisher/era/
toolchain as us) is ~0.3% NAKED and 0% in game logic. So this function is almost certainly
MATCHABLE — the prior agent gave up early. Find the C structure that matches.

Read ${MAIN}/CLAUDE.md ("C style", "Agent workflow") and ${MAIN}/docs/permuter-howto.md once.
${BOOTSTRAP}

STEP 1 — locate + sanity check:
  - Find the file: \`grep -rl 'NAKED' src/game src/engine | xargs grep -ln '${fn}'\` (or recall
    from the symbol). If ${fn} is NO LONGER NAKED (already reclaimed, or pure C, or not
    found) → status="skipped", report and stop.
  - python3 tools/agent/classify_unmatchable.py ${fn} — if it returns STRONG_UNMATCHABLE
    (mov pc / libgcc-prologue), it is legitimately NAKED → status="skipped", stop. (It
    should be ATTEMPT; heed any ⚐ advisory about which register lever to try.)

STEP 2 — establish the readable-C base:
  Extract the function's \`#ifdef NON_MATCHING\` readable C and make it the ACTIVE definition
  (drop the #ifdef/#else/#endif and the NAKED asm; keep only the readable C). \`make -j8\`,
  then \`python3 tools/agent/compile_and_view_assembly.py ${fn} --human\` → note the byte_diff.
  (Verify edits hit disk via grep/sed — worktree desync is real.)

STEP 3 — MINE THE CORPUS (this is the key step — do it before grinding):
  The prior agent's C structure drifts. Find how a MATCHED agbcc decomp writes this idiom:
    python3 tools/agent/corpus.py grep '<the specific idiom/drift>' --c   # focus on cvaos first
    python3 tools/agent/corpus.py decomps --name <similar>
  Look especially in testyourmine/cvaos (Konami, proven). The drift is usually one of:
  register-coloring, a CSE-fold, a scheduling order, a prologue push width, a dead-base
  reuse, or a signed-load form. Find the C SHAPE that produces the baserom's instruction
  choice (e.g. local base-ptr to anchor a load; \`register T x asm("rN")\`; void-return
  epilogue; linker-assigned IWRAM symbols to defeat a CSE-fold; re-reading a field vs
  caching it; per-TU \`src/.../X.s: CC=\$(OLD_AGBCC_BIN)\` if it's a leaf-epilogue / older-codegen case).

STEP 4 — iterate to a TRUE match:
  Apply the corpus idiom + levers; rebuild + diff. If you get NEAR (small byte_diff) but not
  0, run the PERMUTER on your best base. Use EXACTLY the process-group recipe from
  docs/permuter-howto.md (HARD BUDGET ~2000 iters ≈ 30s) — do NOT pipe the permuter and do
  NOT use a naive \`& kill $PID\`; that LEAKS the -j workers as orphaned CPU-burning processes:
      set -m
      vendor/decomp-permuter/.venv/bin/python vendor/decomp-permuter/permuter.py \\
          nonmatchings/${fn}-<id> -j4 --stop-on-zero --better-only > /tmp/perm-${fn}.log 2>&1 &
      PGID=$!; sleep 45; kill -- -$PGID 2>/dev/null; wait 2>/dev/null
      pkill -f "permuter.py nonmatchings/${fn}-" 2>/dev/null || true
      grep -E 'base score|new best|score = 0|Found match' /tmp/perm-${fn}.log | tail
  After it, VERIFY \`pgrep -f "nonmatchings/${fn}-"\` is EMPTY (no leaked permuter). NEVER
  \`pkill -f permuter.py\` unscoped (cross-kills siblings). Permuter only refines a base — if it
  plateaus, REWRITE the C structure (a different shape from corpus) and try once more.

STEP 5 — outcome:
  • byte_diff 0, PURE C (no NAKED / inline asm / #ifdef NON_MATCHING left for ${fn}):
    \`make -j8 && make check\` MUST exit 0; \`grep -nE 'NON_MATCHING|\\bNAKED\\b' <file>\` MUST be
    empty for ${fn}'s body (a \`register T x asm("rN")\` pin is PURE C — fine, not NAKED).
    rm any nonmatchings/${fn}-* scratch. Commit
    \`git commit -am "Promote ${fn}: NAKED -> true-C match"\` with a body naming the corpus
    idiom + key levers. status="promoted".
  • Genuinely stuck after corpus + levers + permuter + a rewrite:
    ${ON_STUCK === 'demote-to-asm'
      ? `DEMOTE to an honest un-decompiled asm slice (better than a false-"done" NAKED): re-peel
    the function — \`python3 tools/agent/auto_peel.py --addr 0x${fn.replace('sub_', '')} --apply\`
    (recreates asm/disasm_*.s), revert ${fn}'s .c to a scaffold/TODO stub, restore the
    linker.ld split so the asm slice provides the bytes. \`make check\` MUST pass. Commit
    \`git commit -am "Demote ${fn}: NAKED -> asm slice (not yet matched)"\`. status="demoted",
    report bestByteDiff + what you tried.`
      : `LEAVE it as the original NAKED (do NOT demote): \`git reset --hard $BASE; git clean -fd;
    rm -rf nonmatchings/${fn}-*\` so the tree is exactly as it started. Commit NOTHING.
    status="stuck", report bestByteDiff reached, the corpus idiom you found (if any), and
    which levers/permuter scores you tried — so a later pass resumes from your analysis.`}
${WORKTREE_RULES}

Return the structured object: target="${fn}", status, worktreePath, commits, bestByteDiff
(0 if promoted), corpusIdiom (the matching shape you found, if any), notes.`
}

function integratorPrompt(round, results) {
  const payload = results
    .filter(Boolean)
    .map((r) => ({ target: r.target, status: r.status, worktreePath: r.worktreePath, commits: r.commits || [] }))
  return `You are the INTEGRATOR for reclamation batch ${round}. You run on MAIN at ${MAIN}.
main currently passes make check.

Inputs (worktree commits are reachable by SHA from main via the shared .git store):
\`\`\`json
${JSON.stringify(payload, null, 2)}
\`\`\`

PROCEDURE:
1. GOOD=$(git rev-parse HEAD). Pre-flight \`git status --short\`; if dirty from a worktree
   leak, \`git checkout -- <file>\` the dupes so the tree is clean before cherry-picking.
2. For each agent with status promoted/demoted and non-empty commits, cherry-pick its
   commits ONE AT A TIME (never a batch — a failed multi-pick leaves a sequencer; clear
   with \`git cherry-pick --quit\`, never --abort). On a linker.ld conflict, keep BOTH
   hunks. After each pick: \`make -j8 && make check\`. If make check FAILS, \`git reset --hard
   HEAD~1\` to drop it and record it as reverted.
3. After all picks: \`python3 tools/agent/progress_stats.py --update-readme\`; if README
   changed, \`git add README.md && git commit -m "Update progress stats"\`.
   \`python3 tools/agent/snapshot_addresses.py\` (gitignored cache; no commit).
4. FINAL VERIFY — FORCE A FULL CLEAN BUILD. Incremental builds can stale-pass and hide a
   non-match (codegen-notes §1162 linker.ld.pp, §2024 slice-split), so the per-pick
   incremental make check is NOT trustworthy alone: \`make tidy && make -j8 && make check\`
   MUST exit 0. If not, \`git reset --hard $GOOD\`, set mainHealthy=false, report. (A clean
   build is the only authoritative gate.)
5. CLEANUP worktrees: for each worktreePath, \`git worktree unlock "<p>" 2>/dev/null||true;
   git worktree remove --force "<p>" 2>/dev/null||true\`; then \`git worktree prune\`. Count removed.
5b. REAP LEAKED PERMUTERS (the reclaim agents can leak orphaned -j workers): kill only
   ppid=1 (orphaned) permuter/multiprocessing python — never an active one (those have a
   live parent):
     for p in $(pgrep -f 'decomp-permuter/permuter.py|multiprocessing' 2>/dev/null); do
       [ "$(ps -o ppid= -p $p 2>/dev/null|tr -d ' ')" = "1" ] && kill -9 $p 2>/dev/null
     done
6. nakedRemaining = \`grep -rl 'NON_MATCHING' src/game src/engine | wc -l\`.

Return: committedCount, promoted (names landed as true-C), demoted (names → asm slice),
reverted ([{name,reason}]), mainHealthy, sha1Match, nakedRemaining, worktreesCleaned, notes.`
}

// ---------------------------------------------------------------------------
// Driver: process the candidate list in parallel batches of K, ensuring no two
// SAME-FILE candidates land in one batch (same-file parallel edits collide at
// cherry-pick — that caused the 06948/06958 conflict). Greedy distinct-file fill.
// ---------------------------------------------------------------------------
const fileOf = (fn) => CANDIDATE_FILES[fn] || fn
const BATCHES = []
{
  const remaining = [...CANDIDATES]
  while (remaining.length) {
    const group = []
    const usedFiles = new Set()
    for (let i = 0; i < remaining.length && group.length < K; ) {
      const f = fileOf(remaining[i])
      if (!usedFiles.has(f)) {
        usedFiles.add(f)
        group.push(remaining.splice(i, 1)[0])
      } else {
        i += 1
      }
    }
    BATCHES.push(group)
  }
}
log(`reclaim-naked: ${CANDIDATES.length} candidates → ${BATCHES.length} distinct-file batches, K=${K}, onStuck=${ON_STUCK}`)
const summary = []
let promotedTotal = 0
let batch = 0
for (const group of BATCHES) {
  if (batch >= MAX_BATCHES) {
    log(`Hit MAX_BATCHES=${MAX_BATCHES} — stopping; re-run to continue.`)
    break
  }
  batch += 1
  if (budget.total && budget.remaining() < 80_000) {
    log(`Token budget nearly exhausted — stopping after ${batch - 1} batches.`)
    break
  }
  phase('Reclaim')
  log(`Batch ${batch}: reclaiming ${group.join(', ')}`)
  const results = await parallel(
    group.map((fn) => () =>
      agent(reclaimPrompt(fn, batch), { schema: RECLAIM_SCHEMA, isolation: 'worktree', phase: 'Reclaim', label: `reclaim ${fn}` }),
    ),
  )

  phase('Integrate')
  const integ = await agent(integratorPrompt(batch, results), { schema: INTEG_SCHEMA, label: `integrate b${batch}`, phase: 'Integrate' })
  if (!integ) {
    log(`Batch ${batch}: integrator returned null — HALTING (inspect main).`)
    summary.push({ batch, error: 'integrator null' })
    break
  }
  const promoted = integ.promoted || []
  const demoted = integ.demoted || []
  promotedTotal += promoted.length
  summary.push({ batch, group, promoted, demoted, reverted: integ.reverted || [], nakedRemaining: integ.nakedRemaining, sha1Match: integ.sha1Match })
  log(
    `Batch ${batch} done: promoted ${promoted.length} [${promoted.join(', ') || '—'}]; ` +
      `demoted ${demoted.length} [${demoted.join(', ') || '—'}]; ` +
      `game/engine NAKED remaining=${integ.nakedRemaining}; sha1Match=${integ.sha1Match}; ` +
      `cleaned ${integ.worktreesCleaned || 0} worktrees.`,
  )
  if (integ.mainHealthy === false || integ.sha1Match === false) {
    log(`Batch ${batch}: main NON-MATCHING after integration — HALTING. Inspect make check on main.`)
    break
  }
}

const allPromoted = summary.flatMap((s) => s.promoted || [])
const allDemoted = summary.flatMap((s) => s.demoted || [])
const lastNaked = summary.length ? summary[summary.length - 1].nakedRemaining : null
log(`reclaim-naked finished: ${summary.length} batches, ${promotedTotal} promoted to true-C, ${allDemoted.length} demoted to asm. game/engine NAKED remaining: ${lastNaked}.`)
return { batches: summary.length, promoted: allPromoted, demoted: allDemoted, nakedRemaining: lastNaked, perBatch: summary }
