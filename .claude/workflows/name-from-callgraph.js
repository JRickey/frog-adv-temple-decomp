export const meta = {
  name: 'name-from-callgraph',
  description:
    "Call-graph-driven semantic naming for the Frogger's Adventures decomp. A deterministic backbone (build_callgraph.py -> callgraph.db, naming_context.py -> per-function context packets) does ALL the I/O; Sonnet agents do ONLY the naming judgment (expressive, appropriate, accurate function/variable/data names), reading a prepared packet per function — who calls it, what it calls incl. BIOS/libgcc, what data it touches, its C body. Names are reconciled + applied by apply_renames.py guarded by make check (byte-identical, auto-revert). An optional file-renaming pass then gives each src/*.c a semantic name (rename_source_file.py patches linker.ld + the Makefile per-TU rules, make-check-guarded). Re-runnable: only still-anonymous symbols are targeted, so it keeps paying off as more functions are peeled/decompiled.",
  whenToUse:
    'Give human names to sub_XXXX functions (+ their vars/data) and rename the .c files, driven by the actual call graph. Run after a decomp/mapping pass. Commits land on main; make check guards everything. Re-run to continue.',
  phases: [
    { title: 'Prep', detail: 'make + build_callgraph.py + naming_context.py (plan + packets) on main', model: 'sonnet' },
    { title: 'Name', detail: 'parallel Sonnet agents: read packets, decide names, write manifest fragments', model: 'sonnet' },
    { title: 'Apply', detail: 'merge fragments + apply_renames.py (make check) + commit', model: 'sonnet' },
    { title: 'FilePrep', detail: 'rebuild graph; list generically-named files + their now-named functions', model: 'sonnet' },
    { title: 'NameFiles', detail: 'parallel Sonnet agents: propose a semantic path per file', model: 'sonnet' },
    { title: 'ApplyFiles', detail: 'rename_source_file.py per file (make check) + commit each', model: 'sonnet' },
  ],
}

// ---------------------------------------------------------------------------
// Config (Workflow args: {parallel, scope, clustersPerAgent, includeData,
//                         includeVars, renameFiles, maxClusters})
// ---------------------------------------------------------------------------
const MAIN = '/Users/jackrickey/Dev/frog-adv-decomp'
const PKT = '.callgraph_packets'

let A = args
if (typeof A === 'string') { try { A = JSON.parse(A) } catch (e) { A = {} } }
if (!A || typeof A !== 'object') A = {}

const SCOPE = A.scope || 'withbody'            // 'withbody' (has C body) | 'all'
const CLUSTERS_PER_AGENT = A.clustersPerAgent || 6
const INCLUDE_DATA = A.includeData !== false   // name anonymous data symbols too
const INCLUDE_VARS = A.includeVars !== false   // name params/locals (functions with bodies)
const RENAME_FILES = A.renameFiles !== false   // run the file-renaming pass
const MAX_CLUSTERS = A.maxClusters || null     // cap (debug / first run)
const MODEL = 'sonnet'                          // user directive: Sonnet decides names

// ---------------------------------------------------------------------------
// Schemas
// ---------------------------------------------------------------------------
const PREP_SCHEMA = {
  type: 'object',
  required: ['mainDirty', 'packetDir', 'clusters'],
  properties: {
    mainDirty: { type: 'boolean' },
    packetDir: { type: 'string' },
    totalFunctions: { type: 'integer' },
    totalFiles: { type: 'integer' },
    clusters: {
      type: 'array',
      items: {
        type: 'object',
        required: ['file', 'functions'],
        properties: { file: { type: 'string' }, functions: { type: 'array', items: { type: 'string' } } },
      },
    },
    note: { type: 'string' },
  },
}
const NAME_ACK_SCHEMA = {
  type: 'object',
  required: ['fragPath', 'named'],
  properties: {
    fragPath: { type: 'string' },
    named: { type: 'integer' },
    skipped: { type: 'integer' },
    sample: { type: 'array', items: { type: 'string' } },
    notes: { type: 'string' },
  },
}
const APPLY_SCHEMA = {
  type: 'object',
  required: ['makeCheck', 'committed'],
  properties: {
    applied: { type: 'integer' },
    droppedCollisions: { type: 'integer' },
    leftoverWarnings: { type: 'integer' },
    makeCheck: { type: 'boolean' },
    committed: { type: 'boolean' },
    commitSha: { type: 'string' },
    notes: { type: 'string' },
  },
}
const FILEPREP_SCHEMA = {
  type: 'object',
  required: ['files'],
  properties: {
    files: {
      type: 'array',
      items: {
        type: 'object',
        required: ['file', 'functions'],
        properties: { file: { type: 'string' }, functions: { type: 'array', items: { type: 'string' } } },
      },
    },
    note: { type: 'string' },
  },
}
const FILENAMES_SCHEMA = {
  type: 'object',
  required: ['renames'],
  properties: {
    renames: {
      type: 'array',
      items: {
        type: 'object',
        required: ['old', 'new'],
        properties: { old: { type: 'string' }, new: { type: 'string' }, rationale: { type: 'string' } },
      },
    },
  },
}
const APPLYFILES_SCHEMA = {
  type: 'object',
  required: ['renamed', 'makeCheckHealthy'],
  properties: {
    renamed: { type: 'array', items: { type: 'string' } },
    failed: { type: 'array', items: { type: 'string' } },
    makeCheckHealthy: { type: 'boolean' },
    notes: { type: 'string' },
  },
}

// ---------------------------------------------------------------------------
// Prompts
// ---------------------------------------------------------------------------
function prepPrompt() {
  return `You are the PREP agent for call-graph-driven naming, on the MAIN checkout (${MAIN}).
Mechanical only — run scripts, return the plan. Do NOT decide any names.

Steps:
1. git status --short. If it lists any TRACKED change (lines NOT starting with "??"), set
   mainDirty=true and STOP (return it). Untracked/gitignored (${PKT}/, callgraph.db) are fine.
2. make -j8 && make check  — MUST exit 0 (we need a fresh frog_us.elf/map). If not, mainDirty=true,
   STOP with the failure in note.
3. python3 tools/agent/build_callgraph.py --self-check   (builds callgraph.db; must say "self-check: OK").
4. python3 tools/agent/naming_context.py --plan --scope ${SCOPE}   — JSON {clusters:[{file,functions}],
   total_functions, total_files}, leaf-first (callees before callers). Capture it.
5. python3 tools/agent/naming_context.py --scope ${SCOPE} --out-dir ${PKT}   — writes one
   <fn>.json packet per function. Confirm the count printed matches total_functions.

Return: mainDirty=false, packetDir="${PKT}", totalFunctions, totalFiles, and clusters (the array
from step 4, IN ORDER — do not reorder). note any anomaly.`
}

function namePrompt(chunk, idx) {
  const fileList = chunk.map((c) => `  ${c.file}: ${c.functions.join(', ')}`).join('\n')
  const fragPath = `${PKT}/frag_${idx}.json`
  return `You are a NAMING agent (Sonnet) on the MAIN checkout (${MAIN}). You DECIDE NAMES — this is
the only judgment step. STRICTLY READ-ONLY on the tracked tree: your ONLY filesystem write is the
fragment file ${fragPath} (under the gitignored ${PKT}/). Do NOT edit any source/header/linker.ld,
do NOT git mv / rename / create / delete any tracked file, do NOT run apply_renames, do NOT
git add/commit. (Symbol + file renames are applied by separate later phases; if you think a FILE
should be renamed, just say so in "notes".) Touching the tracked tree here corrupts the run.

Your clusters (${chunk.length} file(s); name them as coherent families):
${fileList}

For EACH function above, read its packet: ${PKT}/<function>.json (read several at once with
\`cat ${PKT}/<a>.json ${PKT}/<b>.json ...\`). Each packet gives: the C body (if any), callers,
callees (incl. Bios_*/__libgcc — STRONG hints: "calls Bios_CpuFastSet + writes OAM" => a sprite
DMA helper), data_refs (named tables like sUiWindowBorderTiles, or raw addrs by region), file/SCC
siblings, and subsystem_hints harvested from docs/subsystems.md + sibling-map.md (REUSE an
already-proposed name verbatim when a hint gives one).

NAMING RULES — expressive, appropriate, accurate:
- Functions: PascalCase or Subsystem_Verb (match the neighbours already in the file/docs). Encode
  what it DOES from the evidence, not how. A whole cluster should share a family prefix
  (e.g. Save*, UiWindow*, Entity*). If the evidence does NOT support a confident semantic name,
  KEEP it as sub_XXXX (mark confidence "low" and omit, OR include with confidence "low" so the
  apply step can weigh it) — a wrong name is worse than no name.
- Variables/params (only functions WITH a C body)${INCLUDE_VARS ? '' : ' — SKIP this run'}: rename
  the generic ones (a, b, register names) to meaningful names; scope each to its function.
- Data symbols${INCLUDE_DATA ? '' : ' — SKIP this run'}: anonymous data the packet shows in
  data_refs (names like sScreenCharTiles_100CC4, gIwram_5330, Foo_3953c8) — propose a semantic
  name from how it is used across its referencing functions (s = const/rodata, g = mutable global).
  Only rename symbols that appear ANONYMOUS (with a hex/_NNNN suffix); never rename an
  already-semantic name.

Write ${fragPath} (use the Write tool — it handles JSON escaping) with EXACTLY this shape:
{
  "functions":    [{"old":"sub_XXXXXXXX","new":"Name","confidence":"high|medium|low","rationale":"<=1 line"}],
  "variables":    [{"function":"sub_XXXXXXXX","old":"a","new":"name","file":"src/.../home.c"}],
  "data_symbols": [{"old":"sFoo_1234","new":"sName","confidence":"...","rationale":"..."}]
}
(Use the packet's body_file / src_file as the variable "file".) Omit empty arrays.
Return: fragPath="${fragPath}", named (# functions you gave a new name), skipped, a few sample
"old->new" strings, notes.`
}

function applyPrompt(fragCount) {
  return `You are the APPLY agent on the MAIN checkout (${MAIN}). The naming agents wrote ${fragCount}
fragment file(s) to ${PKT}/frag_*.json. Land them, make-check-guarded.

Steps:
1. cd ${MAIN}. Confirm git status --short has no TRACKED changes (frags are gitignored).
2. Apply (this MERGES + dedups fragments, applies identifier renames, runs make -j8 && make check,
   and auto-reverts on any failure):
     python3 tools/agent/apply_renames.py ${PKT}/frag_*.json
   - It prints "merged N fragments; K dropped on collision", the change summary, and either
     "make check PASSED" or "make check FAILED — reverting".
   - It may print "⚠ leftover old identifiers" — count them (these are renames left inside
     non-compiled #ifdef NON_MATCHING bodies; record the count, they are acceptable but noted).
3. If make check FAILED: apply_renames already reverted (tree clean). The failure is almost always
   ONE new name colliding with an existing C symbol/keyword. Read the compiler error to find the
   offending NEW name, then drop the offending function/data entry from the relevant
   ${PKT}/frag_*.json (edit the file via bash/python) and RETRY apply_renames. Up to 3 retries.
   If it still fails, set makeCheck=false, committed=false, and STOP (nothing lands; tree is clean).
4. On make check PASS: do NOT rename/move/create/delete any source file here, and do NOT git mv —
   file renaming is a SEPARATE later phase. apply_renames only MODIFIES tracked files (and refreshes
   README + .function_addresses via its cache step); it creates no new files. Commit exactly those:
     git add -u && git add README.md .function_addresses.json 2>/dev/null; git commit -m "Name <N> symbols from call graph"
   (N = functions + data renamed). BEFORE committing, run \`git status --short\` and confirm there are
   NO renamed/added/deleted SOURCE files (no lines starting with R, A, D, or ??); if there are, some
   step overstepped — set committed=false and STOP (do not commit). Capture the commit sha.
5. Report applied (# renames that landed), droppedCollisions, leftoverWarnings, makeCheck=true,
   committed=true, commitSha, notes.`
}

function filePrepPrompt() {
  return `You are the FILE-PREP agent on the MAIN checkout (${MAIN}). Function names just landed;
now identify .c files that should be renamed to a semantic name. Mechanical — no naming decisions.

Steps:
1. git status --short must have no tracked changes.
2. make -j8 && make check (0); python3 tools/agent/build_callgraph.py   (rebuild — symbols changed).
3. Find still-generically-named source files: every distinct functions.src_file in callgraph.db
   whose BASENAME still matches sub_[0-9a-f]{8}.c (i.e. never got a semantic file name), e.g.:
     python3 tools/agent/naming_context.py --plan --scope all
   then for each cluster whose file basename is sub_XXXXXXXX.c, list it with the (now possibly
   renamed) function names it contains (read functions.name from the DB for that src_file).
   Only include files that have at LEAST one function with a real (non sub_XXXX) name — otherwise
   there is no evidence to name the file yet; skip it.
Return files=[{file, functions:[current names]}] (skip already-semantic files). note counts.`
}

function fileNamePrompt(chunk, idx) {
  const list = chunk.map((f) => `  ${f.file} :: ${f.functions.join(', ')}`).join('\n')
  return `You are a FILE-NAMING agent (Sonnet) on the MAIN checkout (${MAIN}). Decide a semantic
path for each .c file from the functions it now contains. READ-ONLY; do not edit/commit — just
return decisions.

Files (path :: its functions' current names):
${list}

For each: choose snake_case reflecting the file's SUBSYSTEM/role (pret convention: save.c,
ui_window.c, entity_dispatch.c, sound_mixer.c). Keep the same directory unless another
src/ subdir (game/engine/system/data) clearly fits better — moving dirs is fine and byte-neutral.
The name must describe the WHOLE file's contents, not one function. If the functions are too mixed
or still mostly unnamed to name the file confidently, OMIT it (do not force a name).
Return renames=[{old:"src/.../sub_XXXX.c", new:"src/.../<name>.c", rationale:"<=1 line"}].`
}

function applyFilesPrompt(renames) {
  const list = renames.map((r) => `  ${r.old} -> ${r.new}`).join('\n')
  return `You are the APPLY-FILES agent on the MAIN checkout (${MAIN}). Apply these file renames ONE
AT A TIME, make-check-guarded, committing each. Each is byte-neutral (rename_source_file.py patches
linker.ld + the Makefile per-TU .s rules and verifies make check).

Renames:
${list}

For EACH rename (skip any whose 'old' no longer exists or whose 'new' already exists):
1. Ensure git status --short is clean (commit/▲stash anything first — but there should be nothing).
2. python3 tools/agent/rename_source_file.py <old> <new>
   - On "make check PASSED": git add -A && git commit -m "Rename <oldbase> -> <newbase>".
   - On failure: rename_source_file already reverted (tree clean). Record it under failed[] and
     CONTINUE to the next (do not abort the whole batch).
3. After all: make check on main MUST still exit 0 -> makeCheckHealthy.
Report renamed[] (new paths that landed), failed[], makeCheckHealthy, notes.`
}

// ---------------------------------------------------------------------------
// Driver
// ---------------------------------------------------------------------------
function chunk(arr, n) {
  const out = []
  for (let i = 0; i < arr.length; i += n) out.push(arr.slice(i, i + n))
  return out
}

phase('Prep')
log(`name-from-callgraph: scope=${SCOPE} clustersPerAgent=${CLUSTERS_PER_AGENT} includeData=${INCLUDE_DATA} renameFiles=${RENAME_FILES}`)
const prep = await agent(prepPrompt(), { schema: PREP_SCHEMA, label: 'prep callgraph', phase: 'Prep', model: MODEL })
if (!prep) { log('Prep failed — aborting.'); return { error: 'prep failed' } }
if (prep.mainDirty) { log('main dirty / build unhealthy — aborting.'); return { error: 'main dirty', note: prep.note } }

let clusters = prep.clusters || []
if (MAX_CLUSTERS != null) clusters = clusters.slice(0, MAX_CLUSTERS)
if (!clusters.length) { log('No nameable clusters — nothing to do.'); return { named: 0 } }
log(`Plan: ${clusters.length} clusters, ${prep.totalFunctions} functions (leaf-first).`)

phase('Name')
const chunks = chunk(clusters, CLUSTERS_PER_AGENT)
log(`Naming: ${chunks.length} agents over ${clusters.length} clusters.`)
const acks = await parallel(chunks.map((ck, i) => () =>
  agent(namePrompt(ck, i), { schema: NAME_ACK_SCHEMA, phase: 'Name', model: MODEL, label: `name chunk ${i} (${ck.length}f)` })
))
const fragCount = acks.filter(Boolean).filter((a) => a.named > 0).length
const proposed = acks.filter(Boolean).reduce((s, a) => s + (a.named || 0), 0)
log(`Naming done: ${proposed} names proposed across ${fragCount} fragments.`)
if (!fragCount) { log('No names proposed — stopping.'); return { named: 0 } }

phase('Apply')
const applied = await agent(applyPrompt(fragCount), { schema: APPLY_SCHEMA, phase: 'Apply', model: MODEL, label: 'apply renames' })
if (!applied || !applied.makeCheck) {
  log(`Apply failed (makeCheck=${applied && applied.makeCheck}). Nothing landed; tree is clean.`)
  return { named: 0, applyFailed: true, notes: applied && applied.notes }
}
log(`Applied: ${applied.applied} renames landed (dropped ${applied.droppedCollisions || 0} collisions, ${applied.leftoverWarnings || 0} leftover warnings). commit ${applied.commitSha || '?'}`)

let fileResults = null
if (RENAME_FILES) {
  phase('FilePrep')
  const fprep = await agent(filePrepPrompt(), { schema: FILEPREP_SCHEMA, phase: 'FilePrep', model: MODEL, label: 'file-rename prep' })
  const files = (fprep && fprep.files) || []
  if (files.length) {
    phase('NameFiles')
    log(`File naming: ${files.length} generically-named files.`)
    const fchunks = chunk(files, CLUSTERS_PER_AGENT)
    const fnames = await parallel(fchunks.map((ck, i) => () =>
      agent(fileNamePrompt(ck, i), { schema: FILENAMES_SCHEMA, phase: 'NameFiles', model: MODEL, label: `name files ${i}` })
    ))
    const renames = fnames.filter(Boolean).flatMap((r) => r.renames || [])
    if (renames.length) {
      phase('ApplyFiles')
      fileResults = await agent(applyFilesPrompt(renames), { schema: APPLYFILES_SCHEMA, phase: 'ApplyFiles', model: MODEL, label: 'apply file renames' })
      log(`File renames: ${(fileResults && fileResults.renamed || []).length} landed, ${(fileResults && fileResults.failed || []).length} failed.`)
    }
  } else {
    log('No generically-named files ready to rename yet.')
  }
}

// ---------------------------------------------------------------------------
// Report
// ---------------------------------------------------------------------------
log(`name-from-callgraph finished: ${applied.applied} symbol renames + ${(fileResults && fileResults.renamed || []).length} file renames landed.`)
return {
  symbolsRenamed: applied.applied,
  droppedCollisions: applied.droppedCollisions || 0,
  leftoverWarnings: applied.leftoverWarnings || 0,
  filesRenamed: (fileResults && fileResults.renamed) || [],
  filesFailed: (fileResults && fileResults.failed) || [],
  applyCommit: applied.commitSha,
}
