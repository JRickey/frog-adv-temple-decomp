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


---

## Corpus sweep (2026-06-03)

**Outcome: deferred at byte_diff 272 / diff_count 78 (no improvement over the documented baseline).** The corpus does NOT contain a transferable "trick", and the single highest-EV untried lever (linker-assigned symbol, recommendation #1 in the deferred doc) is now **disproven** both empirically and by reading the agbcc source. This is a genuine register-coloring local minimum driven by register pressure, not a missing idiom.

### The exact asm idiom that diverges
At entry the baserom does `ldr r1,[pc]` (r1 = `&gpSoundSystem`), `ldr r6,[r1]` (r6 = `ss = *gpSoundSystem`), then crucially **`adds r3, r1, #0`** at 0x2da12 — it copies the *address* `&gpSoundSystem` into a callee-saved register (r3) and keeps it live across each straight-line no-BL span, re-derefing via `ldr r0,[r3]` (panScale at 0x2da54) and `ldr r3,[r3]` (chSeq reload at 0x2dbbc). It keeps BOTH the address (r3) and the deref `ss` (r6) simultaneously in the first region. agbcc instead assigns `ss` to r3 (callee-saved) and **discards the address**, rematerializing the pool literal `.word 0x030065e0` with a fresh `ldr rX,[pc]` at every later use (0x68, 0x98 in our build). Each extra pool literal shifts the pool, producing the recurring `movs #N; lsls` (inline-offset) <-> `.word`/`ldr` mnemonic diffs through the tail. Concretely: baserom spreads the anchor into r3 and keeps r6=ss; agbcc funnels into r3=ss and reloads the constant.

### Every regex searched + hit counts
NB: corpus mirror asm uses pret style (immediate `0` not `#0`; zero offset omitted, i.e. `ldr r0, [r0]`; `\s` is unsupported by the git pickaxe — use literal spaces).
- `adds\s+r[0-7],\s*r[0-7],\s*#0` (require-c, min-hits 5): **0 hits** (the `\s` + `#0` style does not exist in mirrors).
- `ldr\s+r[0-7],\s*\[r[0-7],\s*#0\]` (min-hits 6): **0 hits** (same `\s`/`#0` issue).
- `idiom highreg-spread` (preset, calibration): pokeemerald 772 commits — confirmed tool works and mirrors use real mnemonics.
- `adds r4, r0, 0` (literal, require-c, min-hits 1): pokeemerald **803 commits** — too noisy (universal "save arg0 to r4").
- `adds r3, r1, 0` (require-c, min-hits 1): pokeemerald **226 commits** — top hit `46b00b11d4` (librfu, "match all the functions").
- `ldr r3, [r3]` (self re-deref of a held address, require-c, min-hits 2): pokeemerald **48 commits** — ubiquitous "deref a pointer in place"; not specific.

### Top corpus hits examined
- **pret__pokeemerald@46b00b11d4** (librfu) — declares `gRfuStatic`/`gRfuLinkStatus`/`gRfuFixed` as real `struct Foo *` global pointer variables and accesses `gRfuStatic->flags` etc.; agbcc keeps `&gGlobal` in a callee-saved reg and re-derefs naturally. This is the *same* shape as our linker-symbol switch, and its functions have far fewer call-live values than ours.
- **pret__pokeemerald@416d67c832 / @94b47c0686** (field_effect / overworld batches) — `ldr r3,[r3]` arises from ordinary `gGlobalPtr->field` C; multi-function commits, not isolable, no special trick.
- **pret__pokeemerald@50c48d7ef6 / @c3733f4b95** (berry_crush) — `adds r3, r1, 0` is just a saved-arg copy, unrelated.

### Whether/why the trick transferred — it did NOT
The corpus shows the "keep `&gGlobalPtr` in a callee-saved register, re-deref within a region" pattern is **everywhere and arises automatically from `gGlobalPtr->field` C** in those decomps — there is no documented idiom because for them it Just Works. The reason it works there and not here is **register pressure**, not C shape: this function has 4 args kept live (id->r5, vol->r9, pan->r7, pitch->r8) plus `sub` pinned to `sl` and `entry` pinned to `r5`, leaving no free callee-saved register for the anchor, so reload rematerializes it.

### agbcc pass implicated (register-coloring)
- `tools/agbcc-src/gcc_arm/local-alloc.c::update_equiv_regs` (lines ~755-872) promotes a `function_invariant_p` value to a REG_EQUIV. `function_invariant_p` (line 635) returns 1 for any `CONSTANT_P(x)` — and **a `SYMBOL_REF` (a linker symbol address) IS `CONSTANT_P`**, identical to the absolute `CONST_INT 0x030065e0`. So the linker-symbol switch cannot change the REG_EQUIV decision.
- `tools/agbcc-src/gcc_arm/reload1.c` (lines ~697-735): when a pseudo has a REG_EQUIV to a `function_invariant_p` constant, `reg_equiv_constant[i] = x` marks it eliminable; reload then **rematerializes the constant inline wherever no free register exists** rather than spilling. So the divergence is reload choosing rematerialization under pressure — exactly because our pinned regs (sl, r5) + 4 live args leave no callee-saved slot for the anchor, whereas the baserom compiler had one free.

### Levers tried this session (byte_diff)
- **Linker-assigned symbol `gpSoundSystem_sym`** (rec #1): **272, UNCHANGED**. `adds r3, r1, #0` still DELETED. Disproven (see agbcc analysis above). REVERTED the linker.ld pin.
- **mov-fence** `asm("" : "=r"(pPool) : "0"(&gpSoundSystem_sym))` to launder the address: **488, WORSE** — forced an extra live value, spilled vol to stack (`sub sp,#8; str r1,[sp,#4]`).
- **CFLAGS sweep** (`-ffixed-r6`, `-ffixed-r4`, `-fno-cse-follow-jumps`, `-fno-schedule-insns`, `-fno-schedule-insns2`, `-fcaller-saves`, `-fno-function-cse`, and `CC=old_agbcc`): **all neutral at 272**.
- **No register pins**: 502 (worse — confirms `entry asm("r5")` + `sub asm("sl")` are load-bearing).
- **Second anchor alias** for panScale: 513 (worse — more pressure).

Byte_diff progression: **272 -> 272** (no improvement; matches the deferred doc's documented floor). The captured nearMatchBase is the clean, linker.ld-independent 272 base (doc's best-effort C plus the proven `(*pPool)->globalSeq` / `swSys = *pPool` refinements).

### RECOMMENDED NEXT ANGLE
The blocker is now precisely characterized: it is NOT an idiom, it is reload rematerializing a `function_invariant_p` constant under register pressure that the baserom compiler avoided because it had a free callee-saved register. Two concrete directions:
1. **Reduce register pressure so a callee-saved reg is free for the anchor.** The 4 incoming args (id/vol/pan/pitch) are the pressure source. Investigate whether any arg can be consumed earlier (e.g. `id` is dead after `entry`/`sub` are computed — verify it actually frees r5 before panScale) or whether dropping the `entry asm("r5")` pin in favor of letting agbcc reuse the freed `id` register changes the coloring enough to let the anchor survive. The high-value experiment is: free exactly ONE callee-saved register at the panScale point and see if reload keeps the anchor instead of rematerializing.
2. **Permuter from the captured 272 base** — but diff_count 78 is ~2x above its ~40 sweet spot, so this is low-EV until (1) gets the structure closer. If pursued, the permuter must be checked out (the vendor submodule was not present in this worktree) and a reassembleable target.s built (awkward due to PC-relative pool loads, as the doc noted). Defer permuter until a structural change drops diff_count under ~40.
3. **Accept NON_MATCHING** only as a last resort — the classifier returns ATTEMPT_MATCH and the structure is fully correct, so a NAKED ship would be premature per the raised-bar policy; this function belongs in the "register-coloring local minimum" bucket, not the genuinely-unmatchable classes.

### Near-match C base (permuter seed) — byte_diff 272->272, CFLAGS: (default -O2)

```c
#include "types.h"

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
            u16 *seq = &(*pPool)->globalSeq;
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
            SoundSystem *swSys = *pPool;

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

---

## Round-15 Opus re-derivation (escalation): plateau CONFIRMED at 272

Re-derived from scratch and re-confirmed the deferred best (byte_diff 272 /
diff_count 77) is a genuine register-coloring local minimum, not a structural
miss. The single root cause is unchanged and now precisely localized.

### Root cause (refined): cross-basic-block constant rematerialization
The baserom loads `&gpSoundSystem` ONCE at entry (`ldr r1,[pc]`), derefs it to
`ss` in callee-saved **r6**, and COPIES the address into callee-saved **r3**
(`adds r3, r1, #0` at 0x0802da12) so the SAME pool load also serves the panScale
deref at 0x0802da54 — *across* the bound-check branch and the vol/pan `if`s.

This agbcc (`update_equiv_regs` in `gcc_arm/local-alloc.c`) marks the address
`CONSTANT_P` → REG_EQUIV and rematerializes it per **basic block**: it keeps a
constant in a register only within straight-line code / loops, never across the
BB boundaries the early-returns + `if`s introduce here. So my build emits a fresh
`ldr [pc]` (or `.word gpSoundSystem` with the linker-symbol variant) at panScale
instead of reusing the entry anchor — and the whole entry recolors (`ss`→r3 not
r6, `&gp`→r0 not r1, no `adds r3,r1,#0`), which cascades into ~30 of the 77 diffs.

### NEW levers tried this round (all FAILED — pick something else)
- **Linker-assigned symbol for gpSoundSystem** (deferred's #1 "most promising"):
  added `. = 0x000065E0; gpSoundSystem = .;` to linker.ld's iwram block +
  `extern SoundSystem *gpSoundSystem;`. Result: **identical 272**. Confirmed via
  the .s: agbcc emits 4× `.word gpSoundSystem` (one rematerialization per region)
  — `CONSTANT_ADDRESS_P` in thumb.h only covers pool-address SYMBOL_REFs, so a
  general extern symbol is NOT `LEGITIMATE_CONSTANT_P`, but `update_equiv_regs`
  still REG_EQUIVs it (force_const_mem path) and reloads per BB. The Init1 win
  doesn't transfer: Init1's fold was *adjacent distinct bases CSE'd into one*;
  here it's *one base rematerialized across BBs*. Different mechanism. RETRACT #1.
- **Cache panScale early** (`u16 panScaleV = (*pPool)->panScale;` right after
  `ss=*pPool`, to put both address uses in the entry BB): 487, worse — the cached
  value survives into the wrong register and shifts the tail.
- **panScale via cached `ss`** (`ss->panScale` instead of `(*pPool)->panScale`):
  512, worse — baserom genuinely re-derefs the anchor for a fresh ss.
- **kind via a plain temp before the `sub=sl` assign** (to drop the `mov r0,sl`
  before `ldrb kind`): 513, worse (re-confirms deferred #3).
- **`sub` unpinned** (let agbcc pick sl naturally): 512 — it does NOT land in sl,
  the `asm("sl")` pin is load-bearing, keep it.
- **anchor pinned `pPool asm("r3")` / `asm("r4")`**: 489 both — global pin
  clobbers across the BLs where the baserom intentionally reloads.
- **new agbcc (`CC=$(AGBCC_BIN)`)**: 284, worse than old's 272. Old stays best.
- **Permuter** (~4300 iters, -j4, 3 min, base score 3140): best **2660**, never
  approached 0. Statement/scope mutation cannot flip the cross-BB anchor-keeping
  decision. Distance (272) is far above the ~40 sweet spot anyway.

### What to try NEXT (genuinely untried)
1. **INSTRUMENT agbcc** (codegen-notes "Instrumenting agbcc itself"): probe
   `update_equiv_regs` / the reload path in `reload1.c` (~line 716, the
   `function_invariant_p` branch) to see exactly why the anchor pseudo is NOT
   kept in a callee-saved reg across the BBs. The cure is then a source-shape or
   `-fXXX` that steers that one decision. This is the only microscope not yet used.
2. A `-fXXX` that suppresses the per-BB rematerialization of equivalent regs
   (look for one gating `update_equiv_regs`/the reload-inheritance pass — none of
   the cse/gcse/strength-reduce flags touched it; needs source reading first).
3. Accept as a firm defer for a NON_MATCHING ship ONLY if a human signs off — the
   classifier says ATTEMPT_MATCH and the body is 100% correct C, so a NAKED ship
   would be a premature regression per the asymmetric-cost rule.

---

## Round-20 Opus escalation: PLATEAU ESCAPED 272 -> 246, new root cause = find_barrier pool placement

This round RE-DERIVED the entry from scratch (per the escalation brief) and broke
through the long-standing 272/78 floor to **byte_diff 246 / diff_count 60**, with the
ENTRY region now nearly byte-identical to the baserom (the `adds r3,r1,#0` address-copy
is reproduced, ss->r6, addr->r1, desc->r4 all match). Function size is EXACTLY 560B.
The residual is now precisely localized to agbcc's **constant-pool dump placement**, a
compiler-internal decision that is NOT controllable from C shape / flags / either
compiler / the permuter.

### The winning structural moves (KEEP these — they are the 246 base, below)
The 272 plateau was caused by the SINGLE `ss`/address variable being colored r3 with the
address rematerialized. The escape is to **split the entry into THREE pinned locals** so
agbcc reproduces the baserom's `ss=r6 + addr=r1->r3` two-register entry:
1. `register SoundSystem *ssE asm("r6")` — entry-only ss (count + bankPtr). Lands r6.
2. `register SoundSystem **pLoad asm("r1")` — entry-scoped pool-LOAD pointer.
   `pLoad = &gpSoundSystem; ssE = *pLoad;` puts the address in r1 (the baserom's scratch),
   so it SURVIVES the `&bankPtr` computation (which uses r0) instead of being clobbered.
3. `register SoundDescTable *desc asm("r4")` — desc lands r4 (frees r1 as the address holder).
4. An UNPINNED copy `pE = pLoad;` used for `(*pE)->panScale` — reproduces `adds r3,r1,#0`
   (the address copy into a callee-saved reg). MUST be unpinned; pinning pE/pPool->r1
   makes it global and spills across the BLs (445/489).
5. Read the bound-check `count` into a temp BEFORE the `pE = pLoad` copy:
   `{ u32 count = desc->count; pE = pLoad; if (id >= count) return 0; }` — this orders the
   count load before the address copy, matching baserom 0x2da10(count)/0x2da12(copy).
   (Without it: copy-before-count, +4 byte_diff.)

Progression this round: 272 -> 261 (ssE r6 + unpinned pE copy) -> 255 (defer pE to after
desc) -> 250 (pLoad r1 + desc r4) -> **246** (count-temp before copy).

### The remaining 60 diffs — root cause is find_barrier (NEW, the actionable lead)
Read `tools/agbcc-src/gcc/thumb.c::find_barrier` (line ~250) + `thumb_reorg` (line 352).
agbcc dumps each constant pool at "the last BARRIER (unconditional-jump point) within
MAX_COUNT_SI=1000 bytes forward of the pcrel load; if none, it CREATES one (`b` + pool)".

- OUR build: the entry `ldr r1,.L24` finds the EXISTING barrier after `bl sub_08032904; b`
  (~0xc4 bytes away, well within 1000) and dumps the first pool THERE (offset 0xd8). So
  loads at 0x14 and 0x96 SHARE that one pool word (4 total gpSoundSystem words).
- BASEROM: dumps its first pool EARLY at 0x2da68 (offset 0x7c) via a CREATED barrier
  (`b.n 0x2da76` skips it), right after the panScale/pitch block and BEFORE the kind
  dispatch. So its loads can't share -> 5 separate gpSoundSystem words.

The pool-offset diff (+0x14: `[pc,#100]` vs `[pc,#192]`) and ALL the branch-distance
diffs (+0x74, +0x84, +0x9c, +0xb0) are downstream of this single placement difference.
Why baserom created an early barrier when an existing one was in range is unresolved —
likely a few-byte difference in find_barrier's byte accumulation (our extra `mov r0,sl`
sub-reads and the descTableOff-in-r4 add bytes that shift the count), OR a tighter
MAX_COUNT in the baserom's agbcc. The diffs are SELF-REINFORCING: eliminating the
`mov sl` / descTableOff-temp extras would change the byte counts find_barrier sees and
could re-align the pool.

### Remaining diffs (the 60), all interlinked via the pool shift
- `mov r0,sl; ldrb r4,[r0]` (+0x44) and `mov r1,sl` (+0xb6) — sub->kind / sub->flags read
  through the high-reg `sub asm("sl")` pin; baserom reads `ldrb r4,[r2]` from the low temp
  BEFORE the sl store. Reading kind from an expression temp before `sub = t` REGRESSES
  hard (503-518) on every base tried — agbcc schedules the sl-store first regardless.
  The sl pin is load-bearing (unpinned sub = 507).
- descTableOff temp r4 vs r0 (+0x20/0x22): the `desc asm("r4")` pin folds the offset read
  into r4 (`ldr r4,[r2,#12]; adds r4,r2,r4`); baserom uses a scratch r0 (`ldr r0; adds
  r4,r2,r0`). Unpinning desc sends it to r1 and breaks the address-in-r1 win (459). An
  explicit `u32 off` temp still folds into r4. 1-arg cost, accepted.
- `bcs.n fail` vs `bcc.n continue; b.n fail` (+0x2a): the shared `return 0` branch
  direction — a pool-shift/layout artifact, expected to resolve once the pool lands right.

### Levers tried this round that FAILED (don't repeat)
- kind-from-temp before sub=sl: 503-518 on both the 250 and 246 bases.
- unpin sub (let agbcc pick sl): 507. unpin desc: 459. Both pins load-bearing.
- pin pE/pPool->r1 (global): 445/489 (spills across BLs). pin pE->r1 (scoped): 263.
- ss pinned r6 globally (single var): 452 (collides with tail swSlot wanting r3).
- explicit descTableOff `u32 off` temp: folds into r4, 246 unchanged.
- two pool-pointer copies / never-cache-ss: 513 / 272 (CSE folds them back).
- CFLAGS sweep (-fforce-addr, -fno-peephole, -fno-defer-pop, -fomit-frame-pointer,
  -fno-gcse/-fno-cse-follow-jumps/-fno-schedule-insns/2/-fno-strength-reduce/-fcaller-saves):
  ALL neutral — none change the pool-load register or the pool-dump point.
- new agbcc (AGBCC_BIN) vs old: both 246 (identical byte_diff; minor scheduling reorder).
- Private instrumented agbcc: ABANDONED — the SHARED tools/agbcc has a modified
  combine.o (a `DBG ftm` fprintf is in the source AND a clean rebuild of local-alloc
  diverges in register allocation), so a from-source private build does NOT reproduce the
  real compiler. Cannot instrument reliably. (Do NOT rebuild the shared agbcc.)
- permuter (~1068 iters, -j4, 25s, base score 3209): floor ~2785, NEVER approached 0 —
  the 3 entry pins lock the structure so statement/scope mutation can't reach the
  pool-placement decision. Permuter is the wrong tool for a find_barrier divergence.

### RECOMMENDED NEXT ANGLE (for the next attempt)
The pool placement is the whole remaining ballgame and it is byte-count-sensitive:
1. The highest-EV idea is to ELIMINATE the `mov r0/r1,sl` sub-reads and the
   descTableOff-r4 extra, because removing those bytes changes what find_barrier counts
   and may re-align the first pool to 0x7c (which would cascade-fix +0x14, +0x74, +0x84,
   +0x9c, +0xb0, and the bcs/bcc branch all at once). They resisted the temp-restructure
   this round, but a DIFFERENT approach to the sub pointer (e.g. not pinning sub to sl and
   instead finding a low-reg shape that still lands it in sl for the cross-BL chSeq use)
   could remove the movs.
2. Investigate forcing an early pool dump: a source construct that emits an unconditional
   branch (barrier) right after the pitch block / before the kind dispatch would make
   agbcc dump the pool at 0x7c like the baserom. (The baserom's `b.n 0x2da76` is a
   find_barrier-CREATED jump, not source — but a source `b` at that point would also serve
   as the barrier.) No natural C construct produces one there yet; this needs creativity.
3. This is NOT NAKED-worthy: classifier = ATTEMPT_MATCH, structure is 100% correct C, and
   the entry now matches the baserom. It is a find_barrier pool-placement local minimum.

### Best-effort C this round (byte_diff 246 / diff_count 60, OLD_AGBCC default)
```c
#include "types.h"

typedef struct SoundDescTable {
    u32 count;
    struct SoundDesc *entries;
} SoundDescTable;

typedef struct SoundDesc {
    u16 subIndex;
    u8 priority;
    u8 _pad3;
    u8 altId;
    u8 pan;
    u8 pitch;
    u8 volume;
} SoundDesc;

typedef struct SoundSubRecord {
    u8 kind;
    u8 flags;
} SoundSubRecord;

typedef struct SoundBank {
    u32 subTableOff;
    u8 _pad4[8];
    u32 descTableOff;
} SoundBank;

typedef struct ChannelRecord {
    u8 _pad0[4];
    u8 field4;
    u8 field5;
    u8 pan6;
    u8 vol7;
    u8 pan8;
} ChannelRecord;

typedef struct ChannelSeq {
    SoundSubRecord *cursor;
    u32 field4;
    u16 field8;
    u16 fielda;
    u16 subIndex;
} ChannelSeq;

typedef struct SoundSystem {
    u8 count;
    u8 _pad01[3];
    u32 rng;
    u8 _pad08[6];
    u16 panScale;
    u32 chDirty[4];
    u8 _pad20[0x18];
    u32 field38;
    u8 _pad3c[0x8c];
    u8 *swSlotBase;
    ChannelRecord **swHandleTable;
    u8 _padD0[0x40];
    u8 *bankPtr;
    u8 *chSeqTableBase;
    u8 *chRecHolder;
    u16 globalSeq;
    u8 _pad11e[2];
    u32 **handleTable;
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
    register SoundSystem *ssE asm("r6");
    register SoundSystem **pLoad asm("r1");
    SoundSystem *ss;
    SoundSystem **pPool = &gpSoundSystem;
    SoundSystem **pE;
    u8 *bank;
    register SoundDescTable *desc asm("r4");
    register SoundDesc *entry asm("r5");
    s32 kind;
    u32 handle;
    u32 rng;

    pLoad = &gpSoundSystem;
    ssE = *pLoad;
    bank = ssE->bankPtr;
    desc = (SoundDescTable *)(bank + ((SoundBank *)bank)->descTableOff);

    {
        u32 count = desc->count;
        pE = pLoad;
        if (id >= count)
            return 0;
    }

    entry = (SoundDesc *)((u8 *)&desc->entries + id * 8);
    sub = (SoundSubRecord *)(bank + *(u32 *)(bank + entry->subIndex * 4 + *(u32 *)bank));
    kind = sub->kind;

    if (kind != 0xff || entry->altId != 0xff) {
        if (kind >= (s32)(ssE->count + 4))
            return 0;
    }

    if ((s32)rVol > 0x7f)
        rVol = entry->volume;
    if ((s32)rPan > 0x7f)
        rPan = entry->pan;

    rPan = (s32)((*pE)->panScale * rPan) >> 8;

    if ((s32)rPitch > 0x80)
        rPitch = entry->pitch;
    if (rPitch == 0x80)
        rPitch = 0xff;

    if (kind <= 3) {
        if (sub_08032BA0(1, entry->priority, kind) == 0)
            return 0;

        {
            u16 *seq = &(*pPool)->globalSeq;
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
            SoundSystem *swSys = *pPool;

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
