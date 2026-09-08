# Hitbox campaign 01

This campaign establishes the evidence workflow and lands a small matching
interface/depin checkpoint. It does not complete hitbox reconstruction.

Base: `ebbae4970f4c14235a30c161e47ec91400ac74c5`. Source result: `a0cf53ce0485390de648d1ee2a7ee13a5f4527a7`.
Tooling commit: `c64ea829`. ROM SHA1:
`7b4c27009198df18555e63fb5dcad223eaf09815`.

## Accepted changes

- AGENTS.md is a regular file; CLAUDE.md is unchanged. Its SHA256 remains
  `a900487a92cfdfadd0e0e6c228af45eed150007a2e755f826d0a782419c40d1a`.
- The oracle fingerprints build inputs and artifacts, invalidates stale outputs,
  and reports provenance. Prototype consolidation requires a deliberate signature
  choice and restores source on failure; it never claims restored artifacts match.
- Evidence records support focused retrieval and prerequisite DAG validation.
  Interface inventories include definitions and headers, with width/sign conflicts.
  Classifier signals no longer automatically prescribe pins or NAKED fallbacks.
- FindPoint and RegisterGridPoints share declarations in `include/entity.h`.
  The grid writer has `include/sprite_grid.h`, adopted by its definition and
  the recently matched hitbox updater. Its parameters now have semantic names.
- Integrate the previously verified `c9f57c15` comparison-order depin: grid-point
  pins fall from eight to seven. This campaign discovered no new pin removal.
- Eight ad-hoc externs removed. Conflicting interfaces among the three audited
  APIs fall from two to one. Assembly-function count stays 245; no new C decomp.

The RegisterGridPoints shared declaration preserves the verified implementation:
`void(u8,u32,u32,u32)` with explicit low-byte consumption. Changing its callers
preserved the whole ROM. This establishes a consistent reconstructed interface,
not the original source types. Four u8 arguments remain a supported hypothesis.

## Bounded experiments

The prediction was that restoring narrow types would move conversions into
parameter setup and explain register lifetimes. It changed entry scheduling,
but these source shapes did not reproduce the target. The narrow grid-writer
prototype additionally changed call-boundary conversions and loop allocation.
Trial metrics are per-target observations, not whole-ROM acceptance gates.

| Trial | Byte differences | Instruction differences | Built bytes |
|---|---:|---:|---:|
| All four arguments u8 | 15 | 8 | 212 |
| Correct narrow writer prototype | 192 | 44 | 232 |
| Narrow pinned grid locals | 159 | 43 | 224 |
| Natural narrow locals without pins/barrier | 110 | 40 | 208 |
| Remove only two grid-argument pins | 189 | 38 | 220 |
| Natural locals and all-u8 entry | 122 | 48 | 208 |

The accepted seven-pin function is 212 bytes with zero byte/instruction diffs.
Candidate source hashes and oracle logs are preserved in ignored
`nonmatchings/hitbox-campaign/`. The table is durable; scratch is local and
must not be assumed present in a fresh clone. Failed shapes are not evidence
that the remaining pins are necessary.

## Verification

- 42 tooling regression tests pass (`python3 -m unittest discover -s tools/agent/tests`).
- Clean `make tidy && make -j8 && make check`: exact full-ROM match.
- Real same-mtime test: reversing the unpinned comparison while preserving the
  source timestamp produced 89 byte / 63 instruction differences and exit 1.
  Restoring exact source bytes with that same timestamp produced zero diffs.
- Final per-function oracle: build succeeds, layout unchanged, zero differences.
- Evidence source-path validation passes; free-text source locations still need
  human review. No graph query itself certifies a current match.

Final oracle fingerprints:

```json
{
  "input_fingerprints": {
    "sources": "08dd74fad9c4dd62de201791c260a401410205688bee2bc27f3eb2702c265e34",
    "headers": "d8cfb69104961f253e30c0e728f68788f4228bec4b6234c820c98fd39112e82d",
    "linked_data": "edd2745dd1cae963b1c577a5c2a1ae81ee3c1c27d1ff790475f7cad3f6429e37",
    "config": "22da97990603e8f16454c3f611ee516ccf8fd24a2d72af71e68692967bd648ef",
    "toolchain": "8d8fd8d2f89c61729d485cf27e1d95313b8c764348de6c88786bff49dc266890",
    "baseline": "7469a84c4b440ddaaca2244e125ba0fb658475ece2cdab8c399fed2b4f2b1aa2",
    "environment": "44136fa355b3678a1146ad16f7e8649e94fb4fc21fe77e8310c060f61caaff8a"
  },
  "changed_inputs": {
    "count": 1,
    "groups": {
      "sources": 1
    },
    "sample": [
      "sources:src/engine/sub_0800cb80.c"
    ]
  },
  "baseline": {
    "sha1": "7b4c27009198df18555e63fb5dcad223eaf09815",
    "mode": "0o700",
    "read_only": false
  },
  "output_fingerprint": "8c93b3ea9b9676b904f7f0504037ba4441fc88ccf8dc1b277059d0b2e76b8141"
}
```

## Model routing observations

The accompanying JSON records actual assignments and review corrections. Sol
implemented tooling, Terra audited interfaces and implemented bounded utilities,
and Luna checked evidence citations. Astra reviewed mechanisms, ran source
experiments, and integrated results. Workers received focused briefs rather
than full transcript forks.

Luna supplied a useful return-type qualification but also an incorrect ROM-entry
claim, rejected through direct disassembly. Sol implementations required normal
review fixes. These different tasks are not a controlled model comparison.
Token usage and selected reasoning effort were not available as measured records;
they remain null. No price, token-efficiency gain, or model ranking is claimed.

## Resume here

Five older callers still declare SpriteGrid_SetCellFlags as returning int with
five int parameters. Its definition and shared header use
`void(u8,u8,s16,s16,u8)`. Simply adopting that declaration in RegisterGridPoints
changed codegen substantially. Keep this conflict explicit while reconstructing
the caller; do not replace the real writer signature with a fabricated wide one.

Next investigate the signed index and alternate-flag branch lifetimes using the
successful TU-local Hitbox_SetPointFlags helper and loop-hoist budget evidence.
Predict which conversions become loop-invariant before writing a new inline
helper. Test the writer boundary and caller together. Reconsider the all-u8
entry hypothesis when the shared structure predicts conversion scheduling.
No blind repeat of the six recorded variants or automatic permuter run is due.

The preserved scroll and blit workstreams remain separate follow-up campaigns;
this hitbox checkpoint does not claim their completion.
