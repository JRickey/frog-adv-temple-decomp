# Deferred: sub_0802D9EC — "play sound by id" / sound-request submission

Status at defer: **structurally correct**, best `byte_diff 272 / diff_count 77`
(size 560B = baserom). All control flow, struct field accesses, arithmetic, and
the 6 callee BLs produce the right instructions. This is NOT NAKED-worthy — the
classifier returns ATTEMPT_MATCH and the structure matches; the residual is pure
register-coloring of one constant address.

## Prerequisite landed (keep)
`sub_08032BC8` (0x08032bc8, 80B) was peeled in this round so the BL at 0x0802db6e
resolves. That peel is committed separately and is real progress; do NOT revert it.

## The drift (single root cause)
agbcc **rematerializes the `&gpSoundSystem` constant address** (`#define
gpSoundSystem (*(SoundSystem **)0x030065e0)`) at nearly every use — emitting
`ldr rX,[pc,#…]; ldr rY,[rX]` from a fresh pool literal. The baserom instead keeps
`&gpSoundSystem` in a callee-saved register (r3) **across the whole function** and
re-derefs it (`ldr r3,[r3]`), copying it once at 0x0802da12 (`adds r3, r1, #0`).

Concretely the baserom keeps BOTH:
  - `ss` (= *gpSoundSystem) in **r6** (used for bank load + count check), AND
  - `&gpSoundSystem` (the address) in **r3** (re-derefed for panScale at 0x0802da54,
    the common-tail chRec block at 0x0802db8e, and the chSeq reload at 0x0802dbbc).

My agbcc keeps only ONE of {ss-value, address} in a callee-saved reg per region and
reloads the pool literal for the other. Each extra `ldr [pc]` adds a `.word
0x030065e0` to the pool, which shifts pool placement and shows up as the recurring
`movs #N; lsls` (inline offset) ⇄ `.word`/`ldr` mnemonic diffs in the tail.

agbcc source: `gcc_arm/local-alloc.c::update_equiv_regs` marks a constant pool
address as REG_EQUIV and **rematerializes it at each use in straight-line code**
(it only keeps it in a register inside a loop, where rematerialization is costlier).
This function is straight-line, so agbcc reloads; the baserom's compiler made the
opposite cost call. The sibling `src/game/sub_0802d8f8.c` keeps the anchor ONLY
because its uses are inside a `do/while` loop (it pins `register SoundSystem **pool
asm("r0")` + `head = *pool`). That loop trick does NOT transfer to this straight-line
body.

## Levers already tried (don't repeat — pick a DIFFERENT one)
Each measured via the clean `compile_and_view_assembly.py` number:
  - High-reg pins `register u32 rVol asm("r9")/rPan asm("r7")/rPitch asm("r8")`:
    **HARMFUL** — agbcc reused the pinned r7 for the anchor (pan not live across the
    entry resolution), producing semantically WRONG code (anchor aliased into pan).
    The natural arg shuffle already lands vol→r9, pan→r7, pitch→r8 with NO pins —
    leave them unpinned. (byte_diff 423→381 when removed.)
  - `register SoundDesc *entry asm("r5")`: **HELPED** (diff_count 157→125 then folded
    into the 77 base). KEEP this pin — id→r5→entry→r5 reuse matches the baserom.
  - `register SoundSystem *ss asm("r6")`: HARMFUL (forces r6 in the tail too, colliding
    with swSlot which the baserom also wants in r6). 423→451.
  - `register SoundSystem **pPool asm("r3")`: HARMFUL (r3 clobbered by the BLs). 489.
  - Anchor SHARING via `(*pPool)->` instead of the `gpSoundSystem` macro: **BIG WIN**
    where the access flows into a no-BL region. chDirty + swHandleTable via `*pPool`
    took 485→272. swSlot-path `SoundSystem *swSys = gpSoundSystem;` shared for
    swSlotBase+globalSeq made that block byte-exact. panScale via `*pPool` (anchor)
    beats the macro (272 vs 492). chRec block reads `ss = *pPool` then chSeq re-reads
    `ss = *pPool` (two derefs, matching the baserom's two `ldr [r3]`).
  - globalSeq++: write as `{ u16 *seq = &gpSoundSystem->globalSeq; if (++*seq == 0)
    *seq = 1; }` — makes the channel-path block byte-EXACT (the `<<16; cmp 0` wrap
    check from the reused incremented value). KEEP.
  - rng/handle: `ss->rng *= 0xa8351d63; rng = (ss->rng << 11) >> 17; handle =
    (kind<<16) | ss->globalSeq | (rng<<24);` (compute rngBits first). Helped 125→111.
  - CFLAGS: `-fforce-addr` (518, worse), `-fno-gcse`/`-fno-strength-reduce`/
    `-fno-cse-follow-jumps`/`-fcse-skip-blocks`/`-fno-expensive-optimizations`
    (all neutral, 272). new agbcc vs old_agbcc: old is the better base.
  - Permuter: NOT run — byte_diff 272 is well above its ~40 sweet spot and a
    reassembleable target.s (PC-relative pool loads) is awkward to build here.

## What to try NEXT (untried, most promising first)
1. **linker-assigned symbol for gpSoundSystem** (the documented Init1 win in
   CLAUDE.md / docs/codegen-notes.md "Adjacent IWRAM bases"): add
   `. = 0x030065e0; gpSoundSystem_sym = .;` (or similar) to linker.ld and `extern
   SoundSystem *gpSoundSystem_sym;` instead of the cast-from-constant `#define`.
   A linker symbol is NOT a REG_EQUIV-able constant, so agbcc may keep it in a
   callee-saved reg (defeating the rematerialization). This is the single highest-EV
   move — it directly attacks update_equiv_regs. NB: would change how this TU spells
   the pool base; siblings can keep their macro (separate TUs).
2. If (1) lands the anchor in a reg but in the WRONG reg, layer the `entry asm("r5")`
   pin (already proven) + a fresh anchor pin once it's a real symbol.
3. The `mov r0, sl; ldrb r4,[r0]` extra at 0x0802da30 (sub->kind read via the pinned
   sl) — baserom reads kind from the live r2 temp. Reading kind via a non-pinned temp
   before `sub = temp` did NOT remove the mov (98 vs 96); revisit only after (1).
4. The bound-check `bcc + b` (two-branch) vs my `bcs` (one-branch) is a return-target
   distance artifact — will likely resolve once the pool stops shifting from (1).

## Best-effort C (byte_diff 272 / diff_count 77, structurally correct)
```c
#include "types.h"

/* sub_0802D9EC — "play sound by id" / sound-request submission.
 *
 * Resolves sound `id` in the active sound bank (gpSoundSystem->bankPtr,
 * +0x110), reads its descriptor and per-id sub-record, applies the caller's
 * vol/pan/pitch overrides (>0x7f / >0x80 / ==0x80 sentinels select the
 * descriptor's own defaults), arbitrates a channel (kind 0..3) or software
 * slot (kind >= 4) by priority, primes the chosen channel/slot via the
 * 0x08032xxx sound-init helpers, fills the active-sound bookkeeping records,
 * advances the per-system RNG, and returns a packed sound handle consumed by
 * sub_0802DC1C. Returns 0 on rejection.
 *
 * Struct shapes are scaffold-grade; the SoundSystem layout matches the sibling
 * sound_*.c decomps (chDirty[] at +0x10, software-slot tables at +0xc8/+0xcc,
 * the channel record/sequence tables at +0x114/+0x118, globalSeq at +0x11c,
 * handle table at +0x120). r7/r8/r9/sl are pinned to reproduce the baserom's
 * argument shuffle and the cross-bl-live sub-record pointer.
 */

typedef struct SoundDescTable {
    u32 count;
    struct SoundDesc *entries; /* inline array at +4, stride 8 */
} SoundDescTable;

typedef struct SoundDesc {
    u16 subIndex; /* +0 */
    u8 priority;  /* +2 */
    u8 _pad3;
    u8 altId;  /* +4 */
    u8 pan;    /* +5 */
    u8 pitch;  /* +6 */
    u8 volume; /* +7 */
} SoundDesc;

typedef struct SoundSubRecord {
    u8 kind;  /* +0  0..3 = channel kind, 0xff = software slot */
    u8 flags; /* +1  bit 0x80 = high-channel variant */
} SoundSubRecord;

typedef struct SoundBank {
    u32 subTableOff;  /* +0 */
    u8 _pad4[8];
    u32 descTableOff; /* +0xc */
} SoundBank;

typedef struct ChannelRecord {
    u8 _pad0[4];
    u8 field4; /* +4 */
    u8 field5; /* +5 */
    u8 pan6;   /* +6 */
    u8 vol7;   /* +7 */
    u8 pan8;   /* +8 */
} ChannelRecord;

typedef struct ChannelSeq {
    SoundSubRecord *cursor; /* +0 */
    u32 field4;             /* +4 */
    u16 field8;             /* +8 */
    u16 fielda;             /* +10 */
    u16 subIndex;           /* +12 */
} ChannelSeq;

typedef struct SoundSystem {
    u8 count; /* +0 */
    u8 _pad01[3];
    u32 rng; /* +4 */
    u8 _pad08[6];
    u16 panScale; /* +0xe */
    u32 chDirty[4]; /* +0x10 */
    u8 _pad20[0x18];
    u32 field38;    /* +0x38 */
    u8 _pad3c[0x8c];
    u8 *swSlotBase; /* +0xc8 */
    ChannelRecord **swHandleTable; /* +0xcc */
    u8 _padD0[0x40];
    u8 *bankPtr;             /* +0x110 */
    u8 *chSeqTableBase;        /* +0x114 */
    u8 *chRecHolder;           /* +0x118 */
    u16 globalSeq;             /* +0x11c */
    u8 _pad11e[2];
    u32 **handleTable;         /* +0x120 */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

extern u32 sub_08032BA0(u32 flag, u32 priority, u32 kind);
extern void sub_08032904(s32 ch, u32 step, u32 pan, u32 ctrl, u16 hwCtrl);
extern void SoundChannel_Init(u32 index, u32 step, u32 mode, u32 ctrl);
extern s32 SoundSlot_PickByPriority(s32 a0, u32 priority, s32 a2, s32 idx);
extern void sub_08032894(void *slot, u32 a1, u32 a2, u32 a3, u32 a4);
extern void sub_08032BC8(void *slot, u32 a1, u32 a2, u32 a3);

u32 sub_0802D9EC(u32 id, u32 vol, u32 pan, u32 pitch)
{
    register SoundSubRecord *sub asm("sl");
    u32 rVol = vol;
    u32 rPan = pan;
    u32 rPitch = pitch;
    SoundSystem *ss;
    SoundSystem **pPool = &gpSoundSystem;
    u8 *bank;
    SoundDescTable *desc;
    register SoundDesc *entry asm("r5");
    s32 kind;
    u32 handle;
    u32 rng;

    ss = *pPool;
    bank = ss->bankPtr;
    desc = (SoundDescTable *)(bank + ((SoundBank *)bank)->descTableOff);

    if (id >= desc->count)
        return 0;

    entry = (SoundDesc *)((u8 *)&desc->entries + id * 8);
    sub = (SoundSubRecord *)(bank + *(u32 *)(bank + entry->subIndex * 4 + *(u32 *)bank));
    kind = sub->kind;

    if (kind != 0xff || entry->altId != 0xff) {
        if (kind >= (s32)(ss->count + 4))
            return 0;
    }

    if ((s32)rVol > 0x7f)
        rVol = entry->volume;
    if ((s32)rPan > 0x7f)
        rPan = entry->pan;

    rPan = (s32)((*pPool)->panScale * rPan) >> 8;

    if ((s32)rPitch > 0x80)
        rPitch = entry->pitch;
    if (rPitch == 0x80)
        rPitch = 0xff;

    if (kind <= 3) {
        if (sub_08032BA0(1, entry->priority, kind) == 0)
            return 0;

        {
            u16 *seq = &gpSoundSystem->globalSeq;
            if (++*seq == 0)
                *seq = 1;
        }

        if ((sub->flags & 0x80) == 0)
            sub_08032904(kind, rVol, rPitch, rPan, 0x100 | entry->priority);
        else
            SoundChannel_Init(kind, rVol, rPan, 0x100 | entry->priority);

        (*pPool)->chDirty[kind] |= 0x10000;
    } else {
        ChannelRecord *swSlot;

        if (kind != 0xff)
            kind -= 4;

        kind = SoundSlot_PickByPriority(1, entry->priority, 0xff, kind);
        if (kind < 0)
            return 0;

        {
            SoundSystem *swSys = gpSoundSystem;

            swSlot = (ChannelRecord *)(swSys->swSlotBase + (kind << 6));

            if (++swSys->globalSeq == 0)
                swSys->globalSeq = 1;
        }

        if ((sub->flags & 0x80) == 0)
            sub_08032894(swSlot, rVol, rPitch, rPan, 0x100 | entry->priority);
        else
            sub_08032BC8(swSlot, rVol, rPan, 0x100 | entry->priority);

        *(u32 *)((u8 *)swSlot + 0x38) |= 0x10000;
        (*pPool)->swHandleTable[kind] = swSlot;
        kind += 4;
    }

    ss = *pPool;
    {
        ChannelRecord *rec = (ChannelRecord *)(*(u8 **)(ss->chRecHolder + 0x110) + kind * 12);

        rec->field4 = 0;
        rec->field5 = 0xff;
        rec->pan6 = entry->pan;
        rec->pan8 = entry->pan;
        rec->vol7 = entry->volume;
    }

    ss = *pPool;
    {
        ChannelSeq *rec2 = (ChannelSeq *)(ss->chSeqTableBase + kind * 16);

        rec2->field8 = 0;
        rec2->fielda = 0;
        rec2->field4 = 0;
        rec2->cursor = sub + 4;
        rec2->subIndex = entry->subIndex;
    }

    ss->rng *= 0xa8351d63;
    rng = (ss->rng << 11) >> 17;
    handle = (kind << 16) | ss->globalSeq | (rng << 24);
    ss->handleTable[kind] = (u32 *)handle;

    return handle;
}
```
