#include "macros.h"
#include "types.h"

/* Entity-dispatch cluster at [0x080c0ab0, 0x080c1254) — 13 named tables
 * extracted from the still-asm 0x080c0000 bucket. Surfaced as the
 * top-refcount cluster by tools/agent/refcount_pool_loads.py: the master
 * hitbox table at 0x080c0b00 is pool-loaded from 33 callsites, the
 * highest concentration observed so far in the code region.
 *
 * The consumers (still in asm) form an entity / object-system dispatch:
 * 17-entry parallel handler tables indexed by a u8 entity-type field
 * (read via `ldrb [entity, #10]` in every consumer), plus an init/state
 * table, a parameter LUT, and a master hitbox/collision-points table.
 * A 320-entry s16 sine LUT is co-located, used by entity movement code
 * (the extra 64 entries past index 255 implement the `sin(angle + 90°)
 * → cosine` lookup without modulo).
 *
 * Field semantics inferred from consumer code (objdump of the still-asm
 * pool-load callsites in the [0x0800a7a8, 0x0800df80) range). Real
 * type names await decomp of those callers.
 *
 * --- 0x080c0ab0  sEntityScriptIndex  (7 entries x 8 B) ---
 *
 * Consumer at 0x080072dc: `r1 = arg << 24 >> 21` (×8 stride),
 * `ldrsb [r1, #0]` then `ldrsb [r1, #2]` — reads two signed bytes at
 * offsets 0 and 2. Each entry encodes a short header for an enemy /
 * NPC script: { u8 a; u8 _; u8 b; u8 _; const u8 *script; }.
 *
 * --- 0x080c0ae8  sEntityScriptIndexExt  (2 entries x 12 B) ---
 *
 * Consumer at 0x08007354: `r5 * 12` stride, then `ldrh [r1, #2]`.
 * Same family as sEntityScriptIndex but the extended record carries
 * a halfword field at +2 and a second ptr at +8 — likely a variant
 * with two script-segment pointers.
 *
 * --- 0x080c0b00  sEntityHitboxTable  (31 entries x 12 B) ---
 *
 * The 33-callsite master. Each record:
 *   { u32 count;          // number of (x,y) points (1..0x30)
 *     const s16 *points;  // pointer into 0x082f9xxx-0x082faxxx
 *     u32 flags;          // recurring values 0x408, 0x414, 0x416,
 *                         // 0x817, 0x10408, 0x10804, 0x10817 — looks
 *                         // bit-packed (low byte = size class, bit
 *                         // 0x10000 = "extended" flag)
 *   }
 *
 * Consumers at 0x0800a7bc, 0x0800b394, 0x0800b988, ... compute
 * `addr = table + idx * 12`, then `ldrb [addr, #0]` (the count, treated
 * as u8 even though stored as u32 — values are all ≤ 48), and iterate
 * `[points + i*4 + 0]` = x, `[points + i*4 + 2]` = y as `ldrsh` pairs.
 * It is a hitbox / collision-point lookup: "is the world-space point
 * (X, Y) present in entity-type N hit-mask?"
 *
 * The 15-callsite anchor at offset +4 (0x080c0b04) is the same table
 * — different consumers load the `points` field directly without
 * going through the +0 count.
 *
 * --- 0x080c0c74..0x080c0ddc  sEntityProc{A,B,C,D,E}  (5 x 17 x 4 B) ---
 *
 * Five parallel 17-entry Thumb function-pointer tables. All five are
 * indexed by the same u8 entity-type id; the count of 17 + identical
 * dispatch shape strongly suggests an entity-system "vtable" laid out
 * as struct-of-arrays:
 *
 *     proc_a[id]  // init       (refs=4   from 0x08003f4c, 0x0800576c, ...)
 *     proc_b[id]  // update     (refs=13  from 0x08002324, 0x080024d8, ...)
 *     proc_c[id]  // ??         (refs=3   from 0x08009d08, 0x0800a292, ...)
 *     proc_d[id]  // hurt/touch (refs=6   from 0x0800232c, 0x080024e0, ...)
 *     proc_e[id]  // cleanup    (refs=1   from 0x0800df7e — and 16/17
 *                                slots point to the same stub
 *                                0x0800c4e4, suggesting an optional
 *                                callback most entity types do not use)
 *
 * Real role names await decomp; the alphabetic suffix avoids guessing.
 *
 * --- 0x080c0d84  sEntitySubtypeLut[20]  (u8) ---
 *
 * Consumer at 0x080032a8: `r4 = [r4, #10]` (entity-type byte),
 * `r0 = sEntitySubtypeLut + r4`, `ldrb` — a u8-indexed remap LUT.
 * 20 entries even though id range is 17 — possibly indexed by a
 * different (broader) classifier.
 *
 * --- 0x080c0d98  sEntityParamTable[17]  (u32) ---
 *
 * 17 u32s, mostly small (0..19), with a recurring zero-padded triplet
 * pattern (0, X, Y, 0, X, Y, ...). Likely per-entity-type parameters —
 * the consumer at 0x08009ce4 / 0x0800a1f0 reads via base+id*4.
 *
 * --- 0x080c0e20  sEntityInitTable  (17 entries x 8 B) ---
 *
 * Consumer at 0x0800dc62: `r3 = [entity, #10]` (id), `r0 = r3*8`,
 * `r0 = ldrb [table+r0, #1]`. Each record:
 *   { u8 spawn_count;  // signed loop bound (mostly 0)
 *     u8 max_index;    // unsigned compare against r5 (mostly 0x78)
 *     u8 _;            // padding
 *     u8 _;
 *     const T *data;   // pointer into 0x082fa400-0x082fa418
 *   }
 *
 * Pretty close to a "default spawn descriptor" per entity-type.
 *
 * --- 0x080c0ea8  sSineTable[320]  (s16) ---
 *
 * 256-entry sine table extended by 64 cosine-tail entries so that
 * `sSineTable[(angle + 64) & 0x1FF]` works as cosine without an
 * explicit modulo wrap. Amplitude 256 (so `sSineTable[64] == 256`,
 * `sSineTable[192] == -256`). Consumer at 0x080060c0 / 0x080060ec /
 * 0x08006114 indexes `(angle + 64) * 2 + sSineTable`.
 *
 * This is the only sine LUT in the ROM seen so far — keeping it in
 * entity_dispatch.c because the entity-movement code is its only
 * known consumer; if a future pass finds it consumed elsewhere,
 * promote into src/data/math_luts.c.
 *
 * --- 0x080c1128  sSpriteFrameDescriptors  (25 entries x 12 B) ---
 *
 * Not pool-loaded directly (accessed via base + offset from one of
 * the above anchors). Layout: 5 groups of 5 records, each record
 * { u16 a; u16 b; u16 c; u16 d; const u8 *sprite; } pointing into
 * 0x080e3xxx (tile data) and 0x08219bxx (sprite-frame data). The
 * (a,b,c,d) halfwords are small ints (0..0x11) — likely (x, y, w, h)
 * for sprite-frame bounding boxes. Five groups of 5 suggests a 5×5
 * pose-state matrix for one of the entity types in this cluster.
 *
 * TODO: confirm field semantics and rename once any of the consumers
 *   (sub_0800c4e4 dispatch stub, sub_0800a7a8 collision query,
 *   sub_0800dc60 entity update) land in C.
 */

/* EntityHitbox is promoted (all-u32 fields). The other record-shaped
 * tables here have mixed u8/u16/u32 fields, but INCBIN expands as
 * `{u32, u32, ...}` and a u32-into-u8/u16 narrowing in an aggregate
 * initializer is a -Werror under agbcc, so they stay as flat u32 arrays
 * until their consumer lands in C with a real bytewise reader. */

typedef struct EntityHitbox {
    u32 count;  /* +0x00 -- 1..0x30 (consumer reads as u8) */
    u32 points; /* +0x04 -- const s16* into 0x082f9xxx..0x082faxxx */
    u32 flags;  /* +0x08 -- bit-packed (low byte = size class, 0x10000 = extended) */
} EntityHitbox;

const u32 sEntityScriptIndex[7 * 2] = INCBIN_U32("data/entity/script_descriptors.bin");

const u32 sEntityScriptIndexExt[2 * 3] = INCBIN_U32("data/entity/script_descriptors_ext.bin");

const EntityHitbox sEntityHitboxTable[31] = INCBIN_U32("data/entity/hitbox_table.bin");

const u32 sEntityProcA[17] = INCBIN_U32("data/entity/proc_a_handlers.bin");

const u32 sEntityProcB[17] = INCBIN_U32("data/entity/proc_b_handlers.bin");

const u32 sEntityProcC[17] = INCBIN_U32("data/entity/proc_c_handlers.bin");

const u32 sEntityProcD[17] = INCBIN_U32("data/entity/proc_d_handlers.bin");

const u8 sEntitySubtypeLut[20] = INCBIN_U8("data/entity/subtype_lut.bin");

const u32 sEntityParamTable[17] = INCBIN_U32("data/entity/param_table.bin");

const u32 sEntityProcE[17] = INCBIN_U32("data/entity/proc_e_handlers.bin");

const u32 sEntityInitTable[17 * 2] = INCBIN_U32("data/entity/init_table.bin");

const s16 sSineTable[320] = INCBIN_S16("data/math/sine_table.bin");

const u32 sSpriteFrameDescriptors[25 * 3] = INCBIN_U32("data/entity/sprite_frame_descriptors.bin");
