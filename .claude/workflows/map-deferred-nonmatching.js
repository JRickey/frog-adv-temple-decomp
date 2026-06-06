export const meta = {
  name: 'map-deferred-nonmatching',
  description:
    "Map the DEFERRED-ANALYSIS backlog of Frogger's Adventures: Temple of the Frog into the src/ tree WITHOUT decompiling. Each docs/deferred-analysis/<fn>.md carries a prior agent's '## Best-effort C' reference body; this workflow lifts that body into the function's home src/*.c under `#ifdef NON_MATCHING` (NON_MATCHING is never defined in the build, so it never compiles — the linked asm slice still provides the matching bytes and `make check` stays green). The point is COVERAGE: get as much of the ROM expressed as readable C in src/ as possible so a later pass can rename symbols/fields across a global corpus. Sonnet-only, no matching attempts, no NAKED reassembly. Functions that are ALREADY MATCHED (no asm slice, real compiled body) are skipped and their stale doc is deleted. Integrates onto main one commit at a time with a make-check safety net.",
  whenToUse:
    'Pull the deferred-analysis reference C into src/ for global symbol mapping (run before a rename pass). Commits land on main; make check guards every cherry-pick. Re-run to continue; already-mapped and already-matched notes are skipped automatically.',
  phases: [
    { title: 'Scout', detail: 'enumerate docs/deferred-analysis/*.md; classify needs-injection / already-mapped / matched-stale / no-best-C (read-only on main)', model: 'sonnet' },
    { title: 'Map', detail: 'K Sonnet workers, each injects a BATCH of best-effort-C bodies into their home src/*.c under #ifdef NON_MATCHING (worktree)', model: 'sonnet' },
    { title: 'Integrate', detail: 'per-worker: cherry-pick commits onto main (serialized lock), make check, revert breakers', model: 'sonnet' },
    { title: 'StaleDocs', detail: 'one agent on main: git rm the docs for already-matched functions', model: 'sonnet' },
    { title: 'Finalize', detail: 'once after the pool drains: regen scoreboard + prune worktrees', model: 'sonnet' },
  ],
}

// ---------------------------------------------------------------------------
// Config (override via Workflow args: {parallel, candidates, skip, maxTargets, deleteStaleDocs})
// ---------------------------------------------------------------------------
const MAIN = '/Users/jackrickey/Dev/frog-adv-decomp'

// args may arrive as an OBJECT or a JSON-encoded STRING — normalize to A.
let A = args
if (typeof A === 'string') {
  try { A = JSON.parse(A) } catch (e) { A = {} }
}
if (!A || typeof A !== 'object') A = {}

const K = A.parallel || 4 // parallel Sonnet workers (each owns a worktree + handles a whole batch)
const MAX_TARGETS = A.maxTargets || null // cap total injections (null = every legal note)
const ONLY = A.candidates || null // restrict to these fn names (else: all)
const SKIP = A.skip || [] // never touch these
const DELETE_STALE_DOCS = A.deleteStaleDocs !== false // default true: rm docs for already-matched fns

// Sonnet across the board — the work is mechanical text-injection, not reasoning.
const MODELS = Object.assign(
  { scout: 'sonnet', map: 'sonnet', integrate: 'sonnet', finalize: 'sonnet' },
  A.models || {},
)

// Lighter bootstrap than the decomp workflows: this task NEVER changes compiled
// output (everything lands under #ifdef NON_MATCHING), so it needs no corpus,
// no permuter, no agbcc-src — just enough to build + make check.
const BOOTSTRAP = `
WORKTREE BOOTSTRAP (run FIRST, before any build — fresh worktrees lack gitignored deps):
\`\`\`sh
MAIN=${MAIN}
for dep in tools/agbcc tools/agent/bin baserom.gba frog_us_baserom.gba node_modules; do
  [ -e "$dep" ] || ln -s "$MAIN/$dep" "$dep"
done
for sub in vendor/decomp-permuter vendor/m2c; do
  if [ ! -L "$sub" ] && [ -d "$sub" ] && [ -z "$(ls -A "$sub" 2>/dev/null)" ]; then
    rmdir "$sub" 2>/dev/null && ln -s "$MAIN/$sub" "$sub"
  fi
  git config "submodule.$sub.ignore" all 2>/dev/null
done
# data/ is gitignored; populate if empty (needs baserom symlink first):
[ -n "$(ls -A data 2>/dev/null)" ] || python3 tools/extractor.py
git status --short      # MUST be empty (everything above is gitignored / submodule-ignored)
make -j4 && make check  # MUST exit 0 on the pristine tree before you touch anything
\`\`\`
If 'make check' does NOT exit 0 on the pristine bootstrapped tree, STOP and report
status "reverted" with note "bootstrap make check failed" — do not attempt work.`

const WORKTREE_RULES = `
HARD RULES (worktree mode):
- STAY in your worktree. NEVER 'cd' to ${MAIN}; it is only the symlink source.
- NEVER use the Edit/Write tools in your worktree. They SILENTLY RESOLVE TO MAIN and
  corrupt it. Write/modify EVERY file via BASH ONLY (a quoted heredoc, python, or sed -i).
  After each write, confirm it landed in YOUR worktree with bash: git status --short
  (from pwd) + grep the file. Bash is the ONLY safe writer inside a worktree.
- Do NOT touch README.md / linker.ld / asm/ , and do NOT run progress_stats.py or
  snapshot_addresses.py (the integrator/finalizer handle those on main). You ONLY append
  to existing home src/*.c files.
- Record your base commit at the very start:  BASE=$(git rev-parse HEAD)
- End with a CLEAN 'git status --short' (everything committed or reverted).
- Report your worktree path (pwd) and commit SHAs in apply order
  (git rev-list --reverse $BASE..HEAD).
- If 'make check' ever fails after your change and you cannot fix it: revert EVERYTHING
  (git reset --hard $BASE + git clean -fd) and report what broke. NEVER leave a broken tree.`

// The exact, deterministic injection recipe handed to every Map worker. Kept as a
// python heredoc so extraction of the fenced '## Best-effort C' block is robust (no
// LLM hand-copying of 150-line C bodies, no heredoc-escaping hazards).
const INJECT_RECIPE = `
INJECTION RECIPE (run this python per function — it is deterministic; do NOT hand-edit C):
For a function NAME with note NOTE (docs/deferred-analysis/NAME.md) and home file HOME:
\`\`\`sh
python3 - "$NAME" "$NOTE" "$HOME" <<'PYEOF'
import re, sys
name, note, home = sys.argv[1], sys.argv[2], sys.argv[3]
text = open(note, encoding="utf-8", errors="replace").read()
# Prefer the fenced block under a "## Best-effort C" heading; else the largest
# \`\`\`c block that actually contains the function definition NAME(.
blocks = re.findall(r"\`\`\`c\\n(.*?)\\n\`\`\`", text, re.S)
sec = re.search(r"##[^\\n]*Best-effort C.*?(\`\`\`c\\n.*?\\n\`\`\`)", text, re.S)
chosen = None
if sec:
    m = re.search(r"\`\`\`c\\n(.*?)\\n\`\`\`", sec.group(1), re.S)
    chosen = m.group(1) if m else None
if not chosen:
    cands = [b for b in blocks if re.search(r"\\b%s\\s*\\(" % re.escape(name), b)]
    chosen = max(cands or blocks, key=len) if (cands or blocks) else None
if not chosen:
    print("NO_BEST_C"); sys.exit(2)
body = open(home, encoding="utf-8", errors="replace").read()
if name in body and ("NON_MATCHING" in body):
    print("ALREADY_PRESENT"); sys.exit(3)
block = chosen.strip("\\n")
# Wrap in the NON_MATCHING guard unless the block already carries one.
if "#ifdef NON_MATCHING" not in block:
    block = "#ifdef NON_MATCHING\\n" + block + "\\n#endif /* NON_MATCHING */"
with open(home, "a", encoding="utf-8") as f:
    f.write("\\n\\n/* --- %s: non-matching reference (asm slice provides the matching bytes) --- */\\n" % name)
    f.write(block + "\\n")
print("INJECTED")
PYEOF
\`\`\`
- Exit/print INJECTED -> proceed. ALREADY_PRESENT / NO_BEST_C -> mark that fn skipped
  (record the reason) and move on; do NOT fail the batch.`

// ---------------------------------------------------------------------------
// Schemas
// ---------------------------------------------------------------------------
const CAND_SCHEMA = {
  type: 'object',
  required: ['name', 'note', 'homeC'],
  properties: {
    name: { type: 'string' },
    note: { type: 'string' },   // docs/deferred-analysis/<name>.md
    homeC: { type: 'string' },  // src/<dir>/<file>.c — the linker-adjacent home
    asmFile: { type: 'string' },
    addr: { type: 'string' },
  },
}
const SCOUT_SCHEMA = {
  type: 'object',
  required: ['mainDirty', 'noteCount', 'candidates'],
  properties: {
    mainDirty: { type: 'boolean' },
    noteCount: { type: 'integer' },
    candidates: { type: 'array', items: CAND_SCHEMA },      // need injection
    alreadyMapped: { type: 'array', items: { type: 'string' } }, // body already in src
    staleMatched: { type: 'array', items: { type: 'string' } },  // matched -> delete doc
    noBestC: { type: 'array', items: { type: 'string' } },       // no fenced C -> can't map
    note: { type: 'string' },
  },
}
const WORKER_SCHEMA = {
  type: 'object',
  required: ['status', 'worktreePath', 'commits', 'mapped'],
  properties: {
    status: { type: 'string', enum: ['ok', 'partial', 'reverted'] },
    worktreePath: { type: 'string' },
    commits: { type: 'array', items: { type: 'string' } }, // full SHAs, apply order
    mapped: { type: 'array', items: { type: 'string' } },  // fn names injected
    skipped: { type: 'array', items: { type: 'string' } }, // fn names skipped (+reason in notes)
    notes: { type: 'string' },
  },
}
const INTEG_SCHEMA = {
  type: 'object',
  required: ['integrated', 'sha1Match', 'mainHealthy'],
  properties: {
    integrated: { type: 'array', items: { type: 'string' } },
    reverted: { type: 'boolean' },
    sha1Match: { type: 'boolean' },
    mainHealthy: { type: 'boolean' },
    notes: { type: 'string' },
  },
}

// ---------------------------------------------------------------------------
// Scout: classify the deferred backlog.
// ---------------------------------------------------------------------------
function scoutPrompt() {
  const onlyClause = ONLY ? `\n   RESTRICT to ONLY these names (ignore every other note): ${ONLY.join(', ')}.` : ''
  const skipClause = SKIP.length ? `\n   NEVER include these (skip entirely): ${SKIP.join(', ')}.` : ''
  return `You are the SCOUT for a mapping sweep of the DEFERRED-ANALYSIS backlog in ${MAIN}
(Frogger's Adventures: Temple of the Frog — GBA, agbcc). READ-ONLY: do NOT modify, create, or
delete any file; do NOT commit. You run in the main checkout.

GOAL: each docs/deferred-analysis/<fn>.md carries a prior agent's "## Best-effort C" reference
body. We want that body lifted into the function's HOME src/*.c under \`#ifdef NON_MATCHING\` (it
never compiles — NON_MATCHING is never defined — so the linked asm slice keeps providing the bytes
and make check stays green). Classify every note so the Map workers know what to inject.

Steps:
1. git status --short — if NON-empty, set mainDirty=true and STOP (report it; the loop halts).
2. Enumerate: ls docs/deferred-analysis/*.md . IGNORE any file whose name is not sub_XXXXXXXX
   (e.g. permuter-fleet-*.md). noteCount = number of sub_* notes.${onlyClause}${skipClause}
3. For EACH sub_<addr> note, determine the HOME src file and classify:
   a. ASM SLICE? grep -lF "func_start <name>" asm/disasm_*.s (thumb_func_start OR arm_func_start).
   b. HOME src file = the \`src/.../*.o(.text)\` entry IMMEDIATELY PRECEDING this function's
      \`asm/disasm_0x<addr>.o(.text)\` line in linker.ld. Strip ".o(.text)" -> the .c path. (Use
      grep -nF "disasm_0x<addr>.o(.text)" linker.ld to find the line, then read the previous
      src line.) That .c file already exists (a scaffold or a cluster file).
   c. Does HOME already contain this fn's body? grep -n "<name>" "$HOME" and check for either a
      \`#ifdef NON_MATCHING\` block mentioning <name> OR a real \`<name>(\` definition.
   Then bucket:
   - staleMatched: NO asm slice remains AND the function is MATCHED (a real compiled definition
     exists in committed src with NO \`#ifdef NON_MATCHING\` guard and NO sibling src/*.s providing
     it). Confirm with: python3 tools/agent/function_status.py --json (look up <name>; matched/
     decompiled status) when unsure. These get their doc DELETED later — list the NAME only.
   - alreadyMapped: HOME already has the \`#ifdef NON_MATCHING\` body for <name> (nothing to do),
     OR no asm slice but the fn is shipped via NAKED/#ifdef + a src/*.s (already expressed in src).
     List the NAME only.
   - noBestC: asm slice STILL exists but the note has NO \`\`\`c fenced block at all (cannot map).
     List the NAME only.
   - candidate (the main bucket): asm slice STILL exists, note HAS a \`\`\`c block, and HOME does
     NOT yet contain the body. Emit {name, note (=docs/deferred-analysis/<name>.md path),
     homeC (the .c path from step b), asmFile (the asm/disasm path), addr (the 0x… hex)}.
4. Order candidates by homeC then name (so same-home functions are adjacent — the driver groups
   them). It is FINE for several candidates to share a homeC.

Return ONLY the structured object: mainDirty, noteCount, candidates, alreadyMapped, staleMatched,
noBestC, note.`
}

// ---------------------------------------------------------------------------
// Map worker: inject a BATCH of best-effort-C bodies into their home files.
// ---------------------------------------------------------------------------
function workerPrompt(batch, wid) {
  const list = batch.map((t) => `  - ${t.name}  note=${t.note}  home=${t.homeC}  asm=${t.asmFile || '?'}`).join('\n')
  return `You are MAP WORKER #${wid} (running on Sonnet) in an isolated git worktree of ${MAIN}
(Frogger's Adventures: Temple of the Frog). Your job is MECHANICAL: lift each function's
"## Best-effort C" reference body out of its deferred-analysis note and append it to that
function's HOME src/*.c under \`#ifdef NON_MATCHING\`. You are NOT decompiling and NOT matching —
the body never compiles (NON_MATCHING is never defined), the linked asm slice keeps the bytes,
and make check must stay green. Coverage is the only goal: more readable C in src/ for a later
symbol-rename pass.

YOUR BATCH (${batch.length} functions; some may share a home file — handle them top-to-bottom):
${list}
${BOOTSTRAP}
${WORKTREE_RULES}
${INJECT_RECIPE}

PROCEDURE:
1. BASE=$(git rev-parse HEAD). Bootstrap + verify make check is 0 on the pristine tree.
2. For EACH function in your batch, IN ORDER:
   a. Confirm the home file exists (ls "$HOME"). If a function shares a home with an earlier one
      in your batch, just append again — multiple #ifdef blocks in one file is fine.
   b. Run the INJECTION RECIPE python with NAME/NOTE/HOME set for this function.
      - INJECTED: good. (The block went in under #ifdef NON_MATCHING.)
      - ALREADY_PRESENT or NO_BEST_C: record this fn under "skipped" with the reason; continue.
   c. Sanity: grep -c "ifdef NON_MATCHING" "$HOME" rose by 1 (for INJECTED), and
      git status --short shows ONLY "$HOME" modified (no stray files, nothing in asm/ or linker.ld).
   d. FORMAT FIRST — the pre-commit hook runs \`clang-format --dry-run -Werror\` and REJECTS the
      commit if the file is not formatted. So run \`clang-format -i "$HOME"\` BEFORE committing.
      (If clang-format is somehow not on PATH the hook only warns — but assume it is.) Then commit
      JUST this function's change:
      git add "$HOME" && git commit -m "Map <name> non-matching reference into <home basename>"
      (one commit per INJECTED function, so the integrator can cherry-pick granularly). If a commit
      is still rejected for formatting, re-run clang-format -i, git add, and retry once.
3. After the whole batch: make -j4 && make check MUST exit 0 (it will — nothing you added
   compiles; this catches accidental edits outside the #ifdef). If it FAILS, find the bad
   append, fix or drop it (git revert/reset that one commit), and re-run until make check is 0.
   If you cannot get to 0: git reset --hard $BASE && git clean -fd, status="reverted".
4. Finish CLEAN: git status --short empty. Report worktreePath (pwd), commits
   (git rev-list --reverse $BASE..HEAD, apply order), mapped (INJECTED names), skipped (names),
   status ("ok" if all handled, "partial" if some skipped, "reverted" if you bailed), notes.`
}

function integratePrompt(wid, wres) {
  return `You are the INTEGRATOR running on the MAIN checkout (${MAIN}) — NOT a worktree.
Map worker #${wid} finished a batch; land its commits on main, make-check-guarded. The driver
serializes you (only one integrator runs at a time), so main is yours exclusively right now.

Worker result:
  status:    ${wres.status}
  worktree:  ${wres.worktreePath}
  mapped:    ${(wres.mapped || []).join(', ') || '(none)'}
  commits (apply order, full SHAs): ${(wres.commits || []).join(' ') || '(none)'}

Steps:
1. cd ${MAIN}. If git status --short is NOT clean, a worker stray-wrote to main (integrations are
   SERIALIZED, so a dirty tree here is ALWAYS a stray write). SELF-HEAL: git checkout -- . &&
   git clean -fd ; confirm clean, then proceed.
2. If there are commits: cherry-pick each SHA IN ORDER (git cherry-pick <sha>). These are pure
   #ifdef NON_MATCHING appends to distinct/own home files, so conflicts are unlikely; on a
   conflict, git cherry-pick --abort, set reverted=true, and skip the rest of this worker.
   After the LAST pick: make -j4 && make check.
   - make check FAILS -> git reset --hard <pre-pick HEAD>, reverted=true.
   - make check 0 -> integrated = the fn names that landed.
3. CLEAN UP the worktree: git worktree unlock ${wres.worktreePath} 2>/dev/null;
   git worktree remove --force ${wres.worktreePath} 2>/dev/null; git worktree prune; then
   git branch -D its branch if it lingers.
4. make check on main MUST still exit 0 -> sha1Match + mainHealthy. Do NOT touch
   README/progress_stats/snapshot (a single finalize step handles those).
A clean revert leaves main MATCHING (report sha1Match=true/mainHealthy=true; integrated=[]).
Report mainHealthy=false ONLY if you genuinely cannot restore main to a matching state.
Report: integrated[], reverted, sha1Match, mainHealthy, notes.`
}

// ---------------------------------------------------------------------------
// Driver
// ---------------------------------------------------------------------------
phase('Scout')
log(`map-deferred-nonmatching: K=${K} Sonnet workers${ONLY ? `, restricted to ${ONLY.length} names` : ''}${MAX_TARGETS != null ? `, max ${MAX_TARGETS}` : ''}, deleteStaleDocs=${DELETE_STALE_DOCS}`)

const plan = await agent(scoutPrompt(), { schema: SCOUT_SCHEMA, label: 'scout deferred', phase: 'Scout', model: MODELS.scout })
if (!plan) { log('Scout failed — aborting.'); return { error: 'scout failed' } }
if (plan.mainDirty) { log('main is dirty at start — aborting (clean the tree, then re-run).'); return { error: 'main dirty' } }

let cands = (plan.candidates || []).filter((t) => !SKIP.includes(t.name) && (!ONLY || ONLY.includes(t.name)))
if (MAX_TARGETS != null) cands = cands.slice(0, MAX_TARGETS)
log(`Backlog: ${plan.noteCount} notes -> ${cands.length} to inject; ${(plan.alreadyMapped || []).length} already-mapped, ${(plan.staleMatched || []).length} matched (stale doc), ${(plan.noBestC || []).length} no-best-C.`)

const results = []
let halt = false

// Group candidates by home file so a given file is wholly owned by ONE worker (no cross-worker
// cherry-pick conflicts, no intra-file races), then distribute groups round-robin across K batches.
const byHome = new Map()
for (const c of cands) {
  if (!byHome.has(c.homeC)) byHome.set(c.homeC, [])
  byHome.get(c.homeC).push(c)
}
const groups = [...byHome.values()]
const batches = Array.from({ length: Math.min(K, Math.max(1, groups.length)) }, () => [])
groups.forEach((g, i) => batches[i % batches.length].push(...g))
const liveBatches = batches.filter((b) => b.length)

if (!liveBatches.length) {
  log('Nothing to inject.')
} else {
  log(`Map: ${liveBatches.length} worker(s) over ${cands.length} functions (${groups.length} home files).`)
  phase('Map')

  // Async mutex: integrations serialize on main (workers stay fully parallel).
  let integLock = Promise.resolve()
  async function withIntegrateLock(fn) {
    const prev = integLock
    let release
    integLock = new Promise((r) => (release = r))
    await prev
    try { return await fn() } finally { release() }
  }

  await parallel(liveBatches.map((batch, wid) => async () => {
    if (halt) return
    const wres = await agent(workerPrompt(batch, wid), {
      schema: WORKER_SCHEMA, isolation: 'worktree', phase: 'Map', model: MODELS.map,
      label: `map w${wid} (${batch.length} fns)`,
    })
    if (!wres) return
    const integ = await withIntegrateLock(async () => {
      if (halt) return null
      const r = await agent(integratePrompt(wid, wres), {
        schema: INTEG_SCHEMA, phase: 'Integrate', model: MODELS.integrate, label: `integ w${wid}`,
      })
      if (!r) { log(`integ w${wid}: integrator returned null — HALTING.`); halt = true; return null }
      log(`+ w${wid}: mapped=[${(wres.mapped || []).join(', ') || '-'}] landed=[${(r.integrated || []).join(', ') || '-'}] sha1Match=${r.sha1Match}`)
      if (r.mainHealthy === false || r.sha1Match === false) {
        log(`main NON-MATCHING after w${wid} (mainHealthy=${r.mainHealthy}, sha1Match=${r.sha1Match}). HALTING.`)
        halt = true
      }
      return r
    })
    results.push({ wid, mapped: wres.mapped || [], skipped: wres.skipped || [], ...(integ || {}) })
  }))
}

// StaleDocs: delete the docs for already-matched functions (user-authorized).
let staleDeleted = []
const stale = (plan.staleMatched || []).filter((n) => !SKIP.includes(n))
if (DELETE_STALE_DOCS && stale.length && !halt) {
  phase('StaleDocs')
  const sd = await agent(
    `You run on the MAIN checkout (${MAIN}). These functions are ALREADY MATCHED (a real compiled
body exists in src, no asm slice remains), so their deferred-analysis notes are STALE and should
be removed: ${stale.join(', ')}.
Steps:
1. cd ${MAIN}; git status --short must be clean (self-heal with git checkout -- . && git clean -fd
   if a stray write is present).
2. For EACH name, RE-CONFIRM it is genuinely matched before deleting its doc: there must be NO
   asm/disasm slice (grep -lF "func_start <name>" asm/disasm_*.s is empty) AND a real committed
   definition with no \`#ifdef NON_MATCHING\` guard. If a name does NOT pass this check, SKIP it
   (leave its doc) and note why. Then: git rm docs/deferred-analysis/<name>.md for the confirmed ones.
3. ONE commit: git commit -m "Remove stale deferred-analysis notes for matched functions"
   (docs-only — make check is unaffected, but run make -j4 && make check anyway to be safe).
Report: deleted (names whose doc was removed), kept (names you left + reason), mainHealthy, notes.`,
    {
      schema: { type: 'object', required: ['deleted', 'mainHealthy'], properties: {
        deleted: { type: 'array', items: { type: 'string' } },
        kept: { type: 'array', items: { type: 'string' } },
        mainHealthy: { type: 'boolean' }, notes: { type: 'string' },
      } },
      label: 'delete stale docs', phase: 'StaleDocs', model: MODELS.finalize,
    },
  )
  staleDeleted = (sd && sd.deleted) || []
  log(`Stale docs: deleted ${staleDeleted.length} [${staleDeleted.join(', ') || '-'}]${sd && sd.kept && sd.kept.length ? `, kept ${sd.kept.length}` : ''}.`)
}

// Finalize: scoreboard + worktree prune.
phase('Finalize')
const fin = await agent(
  `You run on the MAIN checkout (${MAIN}). The mapping pool has drained. Finalize:
1. git status --short MUST be clean (else mainHealthy=false).
2. make -j8 && make check MUST exit 0 (sha1Match).
3. Regenerate the scoreboard ONCE: python3 tools/agent/snapshot_addresses.py; then
   python3 tools/agent/progress_stats.py --update-readme; if README.md changed,
   git add README.md && git commit -m "Update progress stats".
4. Prune leftover pool worktrees under .claude/worktrees/: git worktree unlock then
   git worktree remove --force each, then git worktree prune. Do NOT touch the main worktree.
5. Report: (ls docs/deferred-analysis/sub_*.md 2>/dev/null | wc -l) -> deferredRemaining;
   (grep -rl "ifdef NON_MATCHING" src | wc -l) -> nonMatchingFiles.
Report sha1Match, mainHealthy, deferredRemaining, nonMatchingFiles, worktreesCleaned, notes.`,
  {
    schema: { type: 'object', required: ['sha1Match', 'mainHealthy'], properties: {
      sha1Match: { type: 'boolean' }, mainHealthy: { type: 'boolean' },
      deferredRemaining: { type: 'integer' }, nonMatchingFiles: { type: 'integer' },
      worktreesCleaned: { type: 'integer' }, notes: { type: 'string' },
    } },
    label: 'finalize', phase: 'Finalize', model: MODELS.finalize,
  },
)

// ---------------------------------------------------------------------------
// Final report
// ---------------------------------------------------------------------------
const mapped = results.flatMap((r) => r.integrated || [])
const skipped = results.flatMap((r) => r.skipped || [])
log(`map-deferred-nonmatching finished: ${mapped.length} mapped [${mapped.join(', ') || '—'}], ${skipped.length} skipped, ${staleDeleted.length} stale docs deleted${halt ? ' (HALTED)' : ''}. deferred notes remaining: ${fin ? fin.deferredRemaining : '?'}.`)

return {
  mapped,
  skipped,
  staleDocsDeleted: staleDeleted,
  alreadyMapped: plan.alreadyMapped || [],
  noBestC: plan.noBestC || [],
  deferredRemaining: fin ? fin.deferredRemaining : null,
  nonMatchingFiles: fin ? fin.nonMatchingFiles : null,
  halted: halt,
  results,
}
