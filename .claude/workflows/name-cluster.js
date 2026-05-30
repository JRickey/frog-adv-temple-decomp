export const meta = {
  name: 'name-cluster',
  description:
    "Propose human-readable names for one decompiled call-cluster of Frogger's Adventures: function symbols, their parameters/locals, and the struct fields/types they touch. Fans out per-function proposals, reconciles them into a globally-consistent rename manifest, then adversarially verifies each semantic name before emitting. Output is a REVIEWED MANIFEST (decisions only) — the deterministic applier tools/agent/apply_renames.py applies it guarded by make check. Never edits sources; never commits.",
  whenToUse:
    'Give human names to a cluster of sub_XXXXXXXX functions (and their vars/struct fields) once decompiled. Pass args {file, functions:[...]}. Returns a manifest JSON to feed apply_renames.py. Re-run per cluster.',
  phases: [
    { title: 'Map', detail: 'one agent maps the cluster + pre-digests a per-function evidence brief', model: 'sonnet' },
    { title: 'Propose', detail: 'one agent per function, working from its brief: name + var + field ideas', model: 'sonnet' },
    { title: 'Reconcile', detail: 'one agent merges proposals into a consistent rename manifest', model: 'opus' },
    { title: 'Verify', detail: 'parallel skeptics refute the medium/low-confidence names (high pass through)', model: 'sonnet' },
  ],
}

// --------------------------------------------------------------------------
// Inputs (Workflow args). file = the cluster's .c; functions = symbols in it.
// --------------------------------------------------------------------------
// Workflow args can arrive as an OBJECT or, depending on the caller, as a
// JSON-encoded STRING. If we don't normalize, `args.file` is undefined on the
// string path and the `|| default` below silently runs the WRONG cluster (this
// bit us once — a run meant for the sound cluster fell back to the engine
// default). Parse-if-string so {file, functions, models, verifyConfidence}
// resolve either way; A is the normalized object used everywhere below.
let A = args
if (typeof A === 'string') {
  try { A = JSON.parse(A) } catch (e) { A = {} }
}
if (!A || typeof A !== 'object') A = {}
if (!A.file || !Array.isArray(A.functions) || !A.functions.length) {
  throw new Error('name-cluster: args.file and args.functions[] are required (got ' + JSON.stringify(args) + ')')
}
const FILE = A.file
const FUNCTIONS = A.functions

// Per-phase model tiers. Naming is bounded, evidence-grounded work, so the
// fan-out phases (Propose, Verify) run on Sonnet — that's ~12 of ~14 agents and
// the bulk of the token cost. Reconcile stays on Opus: it's the single
// global-consistency synthesizer, and every pilot quality slip (prose in a name
// field, family-prefix drift) originated there, so it's the one phase that earns
// the stronger model. Map is mechanical evidence-gathering -> Sonnet.
// Override any tier via args.models, e.g. {models:{verify:'opus'}}.
const MODELS = Object.assign(
  { map: 'sonnet', propose: 'sonnet', reconcile: 'opus', verify: 'sonnet' },
  A.models || {}
)

// Shared rules baked into every agent prompt. These encode the project's
// naming philosophy (CLAUDE.md "C style — keep it human-readable") and the
// hard constraint that this workflow proposes NAMES ONLY — it never edits code.
const RULES = `
You are working in a matching decompilation of a GBA game (agbcc toolchain).
You are NOT editing any source — your job is to DECIDE NAMES and return them as
structured data. A separate deterministic tool applies them and verifies the
ROM still byte-matches, so your output must be name decisions only.

Naming philosophy (from the project's CLAUDE.md):
- A name must be EARNED by evidence in the code you can read: the function body,
  its callers/callees, the MMIO/pool constants it touches, the struct fields it
  reads/writes, charmap strings, and docs/{subsystems,memory-map,unknowns}.md.
- A MISLEADING name is WORSE than sub_XXXXXXXX. If you cannot support a semantic
  name, keep the address-based form (functions) or _field_NN / _padNN (struct
  fields). Mark such items low confidence and let the verifier cull them.
- Prefer the project's existing conventions. Functions that already have names
  (AgbMain, Init1, SetGameMode_03, the gpSoundSystem sound cluster, gGameStuff)
  set the style: PascalCase, Subsystem_Verb or Verb+Noun. Flag predicates that
  return 0/1 read well as Is.../Has.../...Test. Setters/clearers of a flag
  halfword read well as Set.../Clear.../...Flags.
- Variable names: short but meaningful. Keep register-pin locals' asm("rN")
  constraint conceptually intact (you only rename the identifier, never the
  pin) — e.g. a local "rE asm("r9")" can become "flagsHi" but stays pinned.
  Args named a,b,c,d... and locals named after registers are the prime targets.
- Don't invent a subsystem the evidence doesn't show. "Entity"/"Object" is
  acceptable structural language for an anonymous struct; a specific name like
  "Player"/"Enemy" needs a callee/string/table that proves it.

Useful commands (run via Bash):
  cat <file>                                   read the cluster source
  grep -rn '\\bsub_XXXXXXXX\\b' src include      find callers/callees
  python3 tools/agent/dump_pool.py <fn>        resolved pool literals (MMIO/addr)
  python3 tools/agent/struct_xref.py 0x<addr>  reader/writer columns per offset
  sed -n in docs/subsystems.md / memory-map.md / unknowns.md for prior semantics
`

const MAP_SCHEMA = {
  type: 'object',
  required: ['purpose', 'confidence', 'structs', 'external_callers', 'external_callees', 'function_briefs'],
  properties: {
    purpose: { type: 'string', description: 'what this cluster does, in one or two sentences' },
    function_briefs: {
      type: 'array',
      description:
        'ONE per cluster function — the pre-digested evidence the propose/verify agents consume so they need almost no tool calls. Gather it here ONCE; do it thoroughly.',
      items: {
        type: 'object',
        required: ['name', 'signature', 'behavior', 'callers', 'callees', 'fields_touched'],
        properties: {
          name: { type: 'string' },
          signature: { type: 'string', description: 'the function signature as written in the source' },
          behavior: { type: 'string', description: 'what the body does, concretely (2-4 sentences); note return shape (e.g. returns 0/1 predicate)' },
          callers: { type: 'array', items: { type: 'string' }, description: 'symbols/sites that call this fn (with the args they pass, if telling)' },
          callees: { type: 'array', items: { type: 'string' } },
          constants: { type: 'array', items: { type: 'string' }, description: 'notable pool literals / MMIO regs / magic numbers and their resolved meaning' },
          fields_touched: { type: 'array', items: { type: 'string' }, description: 'struct fields read/written, e.g. "ClusterA710._field_34 |= mask (flag halfword)"' },
        },
      },
    },
    confidence: { type: 'string', enum: ['high', 'medium', 'low'] },
    theme: { type: 'string', description: 'a naming prefix/family that fits the whole cluster, or "" if none earned' },
    structs: {
      type: 'array',
      items: {
        type: 'object',
        required: ['type', 'fields'],
        properties: {
          type: { type: 'string' },
          header_file: { type: 'string' },
          access_files: {
            type: 'array',
            items: { type: 'string' },
            description:
              'EVERY file that accesses a field of THIS struct type (grep the type + its field ids). Load-bearing: _field_NN ids are positional and reused across unrelated structs, so field renames are scoped to exactly this list — miss a file and that accessor keeps the old name; include an unrelated file and you corrupt its struct.',
          },
          fields: {
            type: 'array',
            items: {
              type: 'object',
              required: ['current', 'offset'],
              properties: {
                current: { type: 'string', description: 'current field identifier, e.g. _field_34' },
                offset: { type: 'string' },
                access: { type: 'string', description: 'how it is read/written across the cluster' },
              },
            },
          },
        },
      },
    },
    external_callers: { type: 'array', items: { type: 'string' } },
    external_callees: { type: 'array', items: { type: 'string' } },
    notes: { type: 'string' },
  },
}

const PROPOSE_SCHEMA = {
  type: 'object',
  required: ['function_old', 'function_new', 'function_confidence', 'function_rationale', 'variables', 'field_suggestions'],
  properties: {
    function_old: { type: 'string' },
    function_new: {
      type: 'string',
      pattern: '^[A-Za-z_][A-Za-z0-9_]*$',
      description: 'a SINGLE bare C identifier (no prose, no arrows, no commentary), or the old sub_ name if none earned',
    },
    function_confidence: { type: 'string', enum: ['high', 'medium', 'low'] },
    function_rationale: { type: 'string', description: 'the evidence: callers, constants, fields touched, return shape' },
    variables: {
      type: 'array',
      items: {
        type: 'object',
        required: ['old', 'new', 'confidence'],
        properties: {
          old: { type: 'string' },
          new: { type: 'string' },
          confidence: { type: 'string', enum: ['high', 'medium', 'low'] },
          rationale: { type: 'string' },
        },
      },
    },
    field_suggestions: {
      type: 'array',
      items: {
        type: 'object',
        required: ['type', 'field_old', 'field_new', 'confidence'],
        properties: {
          type: { type: 'string' },
          field_old: { type: 'string' },
          field_new: { type: 'string' },
          confidence: { type: 'string', enum: ['high', 'medium', 'low'] },
          rationale: { type: 'string' },
        },
      },
    },
  },
}

const MANIFEST_SCHEMA = {
  type: 'object',
  required: ['functions', 'variables', 'struct_fields', 'struct_types'],
  properties: {
    functions: {
      type: 'array',
      items: {
        type: 'object',
        required: ['old', 'new', 'file', 'confidence', 'rationale'],
        properties: {
          old: { type: 'string' },
          new: { type: 'string', pattern: '^[A-Za-z_][A-Za-z0-9_]*$', description: 'a SINGLE bare C identifier — no prose or commentary' },
          file: { type: 'string' },
          confidence: { type: 'string', enum: ['high', 'medium', 'low'] },
          rationale: { type: 'string' },
        },
      },
    },
    variables: {
      type: 'array',
      items: {
        type: 'object',
        required: ['function', 'old', 'new', 'file'],
        properties: {
          function: { type: 'string', description: 'OLD function symbol whose body scopes this rename' },
          old: { type: 'string' },
          new: { type: 'string' },
          file: { type: 'string' },
        },
      },
    },
    struct_fields: {
      type: 'array',
      items: {
        type: 'object',
        required: ['type', 'old', 'new', 'files', 'confidence', 'rationale'],
        properties: {
          type: { type: 'string' },
          old: { type: 'string' },
          new: { type: 'string', pattern: '^[A-Za-z_][A-Za-z0-9_]*$', description: 'a SINGLE bare C identifier' },
          files: {
            type: 'array',
            items: { type: 'string' },
            description: "the struct's access_files from the cluster map — the EXACT scope this field rename is applied to",
          },
          header_file: { type: 'string' },
          confidence: { type: 'string', enum: ['high', 'medium', 'low'] },
          rationale: { type: 'string' },
        },
      },
    },
    struct_types: {
      type: 'array',
      items: {
        type: 'object',
        required: ['old', 'new', 'confidence', 'rationale'],
        properties: {
          old: { type: 'string' },
          new: { type: 'string' },
          confidence: { type: 'string', enum: ['high', 'medium', 'low'] },
          rationale: { type: 'string' },
        },
      },
    },
    consistency_notes: { type: 'string' },
  },
}

const VERDICT_SCHEMA = {
  type: 'object',
  required: ['verdict', 'rationale'],
  properties: {
    verdict: {
      type: 'string',
      enum: ['keep', 'demote', 'weaken'],
      description: 'keep = name is earned; demote = revert to sub_/_field_/original type; weaken = use suggested_alternative',
    },
    suggested_alternative: { type: 'string' },
    rationale: { type: 'string' },
  },
}

// --------------------------------------------------------------------------
// Phase 1 — Map the cluster.
// --------------------------------------------------------------------------
phase('Map')
const map = await agent(
  `${RULES}

CLUSTER MAP TASK. The cluster lives in ${FILE} and contains these functions:
${FUNCTIONS.join(', ')}.

Read ${FILE} in full. Then build a map of the cluster:
- Its overall purpose (what subsystem/object does it serve?), with a confidence.
- Every struct it touches: the type name, the header it's declared in, and each
  field with its current identifier, offset, and how it's accessed across the
  cluster (read-only? written once in an init? a flag halfword toggled by
  setters?). Use grep + struct_xref.py to confirm where the struct is used.
- For each struct, its access_files: EVERY file that reads/writes a field of
  that type. Find them by grepping the type name AND its field ids
  (\`grep -rln '_field_NN' src include\`) and keeping only files where those ids
  belong to THIS struct. This list scopes the later field renames — \`_field_NN\`
  ids are positional and shared across unrelated structs, so getting this set
  right is what keeps the rename from corrupting other structs' fields.
- External callers (who calls into this cluster) and external callees.
- A naming theme/prefix if one is honestly earned by the evidence, else "".
- function_briefs: ONE per cluster function — a pre-digested evidence packet
  (signature, concrete behavior + return shape, callers with the args they pass,
  callees, notable constants, struct fields touched). This is the single most
  valuable thing you produce: the downstream propose/verify agents work ONLY
  from these briefs and skip re-reading the source, so spend your tool budget
  here gathering it thoroughly and accurately. Do NOT skimp — a thin brief forces
  every downstream agent to re-grep, which is exactly the redundant cost we're
  eliminating by gathering once.

Return the structured map.`,
  { schema: MAP_SCHEMA, label: 'map', phase: 'Map', model: MODELS.map }
)
log(`cluster purpose (${map.confidence}): ${map.purpose}`)

// --------------------------------------------------------------------------
// Phase 2 — Propose names, one agent per function.
// --------------------------------------------------------------------------
phase('Propose')
// Lighter context for the fan-out: the structs (for fields + theme) and the
// cluster purpose/theme, but NOT every other function's brief — each propose
// agent gets only its own function's brief below. Cache traffic on the fan-out
// scales with what we hand each agent times how many turns it takes, so we keep
// the shared payload small and tell agents not to re-derive what's already here.
const briefByFn = {}
for (const b of map.function_briefs || []) briefByFn[b.name] = b
const sharedContext = JSON.stringify({
  purpose: map.purpose,
  theme: map.theme,
  structs: map.structs,
})
const proposals = (
  await parallel(
    FUNCTIONS.map((fn) => () =>
      agent(
        `${RULES}

NAME-PROPOSAL TASK for a single function: ${fn} (in ${FILE}).

Cluster context (purpose, theme, struct layouts — use for consistency):
${sharedContext}

Pre-gathered evidence brief for ${fn} (produced by the mapping pass):
${JSON.stringify(briefByFn[fn] || { note: 'no brief — read the source yourself' })}

The brief above is your evidence. Work from it. Only run a tool if a SPECIFIC
fact you need to decide a name is genuinely missing from the brief — and if so,
keep it to AT MOST 3 tool calls (one targeted grep/read, not a re-survey). Then
propose:
- function_new: a human name, or keep ${fn} if no name is earned (low confidence).
- variables: a rename for each parameter/local whose current name is a
  placeholder (a,b,c.. or a register name). Skip ones already meaningful.
- field_suggestions: for each struct field THIS function clarifies, suggest a
  name (merged across the cluster next pass; partial views are fine). Cite why.

Every item carries a confidence and a one-line rationale grounded in evidence.`,
        { schema: PROPOSE_SCHEMA, label: `propose:${fn}`, phase: 'Propose', model: MODELS.propose }
      )
    )
  )
).filter(Boolean)
log(`${proposals.length}/${FUNCTIONS.length} function proposals returned`)

// --------------------------------------------------------------------------
// Phase 3 — Reconcile into a single consistent manifest.
// --------------------------------------------------------------------------
phase('Reconcile')
const manifest = await agent(
  `${RULES}

RECONCILE TASK. Merge the per-function proposals below into ONE consistent
rename manifest for the cluster in ${FILE}.

Cluster context (purpose, theme, struct layouts incl. access_files for scoping):
${sharedContext}

Per-function proposals (each carries its own evidence in the rationale):
${JSON.stringify(proposals)}

Produce the manifest:
- functions[]: one entry per function (old, new, file="${FILE}", confidence,
  rationale). \`new\` MUST be a single bare C identifier — never prose or a
  "X -> do Y" note (put deliberation in rationale/consistency_notes). Resolve
  collisions (no two functions share a name). Make the names a coherent FAMILY
  with ONE shared prefix consistent with the cluster theme — e.g. all Entity_*,
  parallel Set/Clear/Test verbs for sibling flag helpers; do NOT mix prefixes
  (Entity_Init alongside Iwram3720_ClearFlags is wrong — pick one). If a
  function's name wasn't earned, keep its sub_ name at low confidence.
- variables[]: every accepted variable rename, each tagged with the OLD function
  symbol it belongs to and file="${FILE}". These are body-scoped, low-stakes —
  keep the good ones even for functions you left as sub_.
- struct_fields[]: MERGE the field_suggestions across functions into ONE decision
  per (type, field_old). Where functions disagree, pick the best-evidenced name.
  Set \`files\` to that struct's access_files from the cluster map (the rename's
  exact scope) and include header_file. Leave a field as _field_NN (omit it) if
  unearned.
- struct_types[]: rename anonymous placeholder struct types (e.g. ClusterA710)
  only if the cluster's purpose earns a real type name; else omit.
- consistency_notes: anything a reviewer should know (cross-cluster siblings
  that should later get matching names, fields left unnamed and why).

Be conservative: it is better to ship fewer, well-earned names than a full sweep
of guesses. The next pass will try to refute each semantic name.`,
  { schema: MANIFEST_SCHEMA, label: 'reconcile', phase: 'Reconcile', model: MODELS.reconcile }
)
log(
  `draft manifest: ${manifest.functions.length} fns, ${manifest.variables.length} vars, ` +
    `${manifest.struct_fields.length} fields, ${manifest.struct_types.length} types`
)

// --------------------------------------------------------------------------
// Phase 4 — Adversarial verification of the DOUBTFUL semantic names (functions,
// struct fields, struct types) — gated to medium/low confidence; high-confidence
// names pass through (see VERIFY_CONFIDENCE). Variable renames are body-scoped
// and low-stakes — they're never verified.
// --------------------------------------------------------------------------
phase('Verify')
const allClaims = [
  ...manifest.functions
    .filter((f) => !f.new.startsWith('sub_'))
    .map((f) => ({ kind: 'function', old: f.old, proposed: f.new, rationale: f.rationale, confidence: f.confidence })),
  ...manifest.struct_fields.map((f) => ({
    kind: 'field',
    old: f.old,
    proposed: f.new,
    type: f.type,
    rationale: f.rationale,
    confidence: f.confidence,
  })),
  ...manifest.struct_types.map((t) => ({ kind: 'type', old: t.old, proposed: t.new, rationale: t.rationale, confidence: t.confidence })),
]

// Confidence gate: a `high`-confidence name already survived two passes (a
// proposer's evidence + reconcile's scrutiny); spending a multi-turn skeptic on
// it is where the verify phase's cost ran away in the pilot (it was the single
// most expensive phase). Reserve adversarial verification for the claims that
// actually carry doubt — medium/low. High-confidence claims pass through, logged
// so the cull is never silent.
const VERIFY_CONFIDENCE = A.verifyConfidence || ['medium', 'low']
const toVerify = allClaims.filter((c) => VERIFY_CONFIDENCE.includes(c.confidence))
const autoKept = allClaims.filter((c) => !VERIFY_CONFIDENCE.includes(c.confidence))
if (autoKept.length) {
  log(`verify: auto-keeping ${autoKept.length} high-confidence claim(s) unverified: ` +
    autoKept.map((c) => `${c.old}->${c.proposed}`).join(', '))
}
log(`verify: refuting ${toVerify.length} non-high-confidence claim(s)`)

// Per-claim context: the relevant brief only (functions) or the struct's fields
// (field/type), NOT the whole map — keeps each skeptic's input small.
function claimContext(c) {
  if (c.kind === 'function') return JSON.stringify(briefByFn[c.old] || { note: 'no brief' })
  const st = (map.structs || []).find((s) => s.type === c.type) || {}
  return JSON.stringify({ type: c.type, fields: st.fields, briefs_touching: (map.function_briefs || []).filter((b) => (b.fields_touched || []).some((f) => f.includes(c.old))) })
}

const verdicts = (
  await parallel(
    toVerify.map((c) => () =>
      agent(
        `${RULES}

REFUTATION TASK. A previous pass proposed renaming a ${c.kind}:
    ${c.old}  ->  ${c.proposed}${c.type ? `   (field of ${c.type})` : ''}
Stated rationale: ${c.rationale}

Pre-gathered evidence for this claim:
${claimContext(c)}

Your job is to REFUTE this name. Work from the evidence above; only if a
decisive fact is missing, run AT MOST 2 targeted tool calls against ${FILE} /
its callers. Ask: does the evidence actually support "${c.proposed}", or is it a
plausible guess that asserts more than the code shows? Default toward refuting
when uncertain — a wrong name is worse than the address/_field form.

Return:
- verdict "keep" only if the evidence clearly earns it;
- "weaken" + suggested_alternative if the right idea but the name overclaims
  (e.g. propose a more generic but defensible name). When weakening a function,
  KEEP the cluster's family prefix so the group stays consistent — weaken the
  noun/verb, not the prefix;
- "demote" if the name isn't supported (it will revert to ${c.old}).`,
        { schema: VERDICT_SCHEMA, label: `verify:${c.kind}:${c.old}`, phase: 'Verify', model: MODELS.verify }
      ).then((v) => ({ ...c, ...v }))
    )
  )
).filter(Boolean)

// Apply verdicts to the manifest.
const verdictByKey = {}
verdicts.forEach((v) => {
  verdictByKey[`${v.kind}:${v.old}`] = v
})

function applyVerdicts(list, kind, newField) {
  const kept = []
  for (const item of list) {
    const v = verdictByKey[`${kind}:${item.old}`]
    if (!v || v.verdict === 'keep') {
      kept.push(item)
    } else if (v.verdict === 'weaken' && v.suggested_alternative) {
      log(`weaken ${kind} ${item.old}: ${item[newField]} -> ${v.suggested_alternative} (${v.rationale})`)
      item[newField] = v.suggested_alternative
      kept.push(item)
    } else {
      // demote (or weaken with no alternative) -> drop the rename entirely.
      log(`demote ${kind} ${item.old} -> keep original (${v.rationale})`)
    }
  }
  return kept
}

manifest.functions = applyVerdicts(manifest.functions, 'function', 'new')
manifest.struct_fields = applyVerdicts(manifest.struct_fields, 'field', 'new')
manifest.struct_types = applyVerdicts(manifest.struct_types, 'type', 'new')

// Drop function entries that are now no-ops (new === old).
manifest.functions = manifest.functions.filter((f) => f.new !== f.old)

manifest.cluster = FILE.replace(/^src\//, '').replace(/\.c$/, '')
log(
  `final manifest: ${manifest.functions.length} fns, ${manifest.variables.length} vars, ` +
    `${manifest.struct_fields.length} fields, ${manifest.struct_types.length} types`
)

return manifest
