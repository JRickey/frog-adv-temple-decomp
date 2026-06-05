# Deferred: sub_0802D9EC — "play sound by id" / sound-request submission

Status at defer (Round 12, Opus escalation): **byte_diff 7 / diff_count 6**
(size 560B = baserom, exact). This is a MAJOR breakthrough from the long-standing
246/55 plateau documented in prior rounds — the structure, control flow, struct
offsets, semantics, pool placement, and 5/6 callee args are now byte-identical.
The residual 6 diffs are a single, precisely-localized reload register-coloring
issue in the tail (the rematerialized `gpSoundSystem` address lands in r0 instead
of the baserom's callee-saved r3/r2). Classifier = ATTEMPT_MATCH. NOT NAKED-worthy.

**START FROM THE "## Best-effort C (7/6)" BLOCK BELOW — do NOT restart from 246.**

## Drift
GPT-5.5 attempt on 2026-06-05 reconfirmed the same true-C plateau:
**byte_diff 7 / diff_count 6**, exact 560-byte size. `classify_unmatchable.py`
returns `ATTEMPT_MATCH` with only high-register advisory, so this must remain
deferred rather than NAKED.

New evidence from this attempt:
- Clean no-pin Phase 1 C built but stayed far away: `byte_diff 482`,
  `diff_count 76`; a source-only lifetime/order rewrite without pins stayed
  `482/81`. The high-reg/descriptor pins from the block below are still needed.
- Reapplying the load-bearing pure-C pins plus the pointer-form `globalSeq`
  increment returns to `7/6`. The residual remains exactly:
  `+0xf2/+0xf4` channel-side `gpSoundSystem` pool address in r0 instead of r3,
  `+0x190/+0x192` slot-side pool address in r0 instead of r2, and `+0x1a0`
  common merge reload instead of `adds r3,r2,#0`.
- A local analogue from `src/game/sub_0802dfbc.c` suggested splitting value and
  pool-pointer RTXs. Applying a branch-carried `SoundSystem **tailPool` fixed the
  channel-side r3 address but regressed to `byte_diff 51`: slot-side chose r3
  instead of r2, deleted the target `adds r3,r2,#0`, and reloaded the pool later
  near the RNG block. Adding a slot-side `register SoundSystem **slotTailPool
  asm("r2")` made size drift worse (`byte_diff 106`) and shifted BL targets.
- A common-block `recPool = &gpSoundSystem; ... ss = *recPool;` rewrite was
  neutral: still `7/6`.
- Flag sweep from the 7-base:
  `-fforce-addr`, `-fno-gcse`, `-fno-cse-follow-jumps`,
  `-fforce-addr -fno-gcse`, `-fforce-addr -fno-gcse -fno-cse-follow-jumps`,
  and `-fcaller-saves` were all neutral at `7/6`;
  `-fno-expensive-optimizations` regressed to `48/33`;
  `-ffixed-r0` and `-ffixed-r2` regressed to ~500 byte diff.
- Current-tree corpus grep found no matching C idiom for carrying a
  `gpSoundSystem` address across a merge. History search could not run in this
  worktree because `tools/agent/corpus-mirrors/` is absent.
- A private `/tmp` old_agbcc instrumentation build was made (shared
  `tools/agbcc-src` was not touched). Logging `allocate_reload_reg` showed the
  residual pool loads are not ordinary reloads of `0x030065e0`; reload saw only
  small field-offset constants (`272`, `276`, `280`, `284`, `288`). RTL dump
  showed the common block materializes a fresh `(const_int 50357728)` into r3
  before dereferencing, confirming the branch-carried pool-address pseudo is
  lost before/at global allocation rather than picked by a simple reload choice.
- Permuter could not be run: `vendor/decomp-permuter` exists as an empty
  directory in this worktree, with no `.venv/bin/python`. `setup_permuter.py`
  can create `nonmatchings/sub_0802D9EC`, but the runner is unavailable.

Newly ruled out: branch-carried `tailPool`, slot-side r2 pool pin, common
`recPool`, the above CFLAGS, and simple reload-register instrumentation as the
decision site. Still untried: a full history search from populated mirrors, and
a real permuter run from the 7-byte base once `vendor/decomp-permuter` is
available.

## The breakthroughs that broke the 246 plateau (KEEP ALL OF THESE)
The prior rounds were stuck at 246 because the constant pool was MISPLACED (agbcc
shared the entry pool across the whole function; the baserom dumps 5 separate
`.word 0x030065e0` words via find_barrier-created barriers). The fixes, in order
of discovery, each verified with compile_and_view_assembly.py:

1. **`else if` for the pitch sentinel → early pool dump (272→498→…).** The baserom
   writes `if (pitch > 0x80) pitch = entry->pitch; ELSE IF (pitch == 0x80)
   pitch = 0xff;`. The `else` emits an unconditional `b.n` after the first block,
   which find_barrier (gcc/thumb.c) uses as the barrier to dump the FIRST pool at
   offset 0x7c — exactly where the baserom dumps it. Two separate `if`s (the prior
   rounds' form) keep the pool shared at 0xd8. This is THE find_barrier fix prior
   rounds missed. Semantically correct: when pitch>0x80 it's set to the descriptor
   default and the ==0x80 check is skipped (baserom proves this via the `b.n`).

2. **low-temp for `sub` + kind read (removes the `mov r0,sl` before `ldrb kind`).**
   `{ SoundSubRecord *t = (...); sub = t; kind = t->kind; }` lets agbcc read kind
   from the low reg holding the pointer right after `mov sl, t`, matching the
   baserom's `mov sl,r2; ldrb r4,[r2]`. (Reading kind via the sl pin alone adds a
   `mov r0,sl` = +2 bytes that mis-aligns the pool.)

3. **`bank +=` accumulator → `sub` lands in r2 (reusing dead bank).** Write
   `bank += *(u32*)(bank + *(u32*)bank + entry->subIndex*4); t = (SoundSubRecord*)bank;`
   so the final add reuses bank's r2 (`adds r2,r2,r0`) instead of r0
   (`adds r0,r2,r0`). The `combine_regs` tie (local-alloc.c) then matches.

4. **`gpSoundSystem` MACRO (not `(*pPool)`/cached `ss`) in EACH tail block →
   rematerialization (THE big one, 335→42).** The baserom RE-LOADS the pool word
   `.word 0x030065e0` in every tail block (chDirty, swHandleTable, chRec) — 5
   separate words. `(*pPool)` or a cached `ss = *pPool` makes agbcc CSE the deref
   (one shared word, function 4 bytes too long, cascading distance diffs). Using
   the bare macro `gpSoundSystem->...` forces `update_equiv_regs` to rematerialize
   the constant per use. **chSeq + rng MUST still share one `ss = gpSoundSystem`**
   (the baserom's `ldr r3,[r3]` re-deref keeps ss in r3 across chSeq→rng).

5. **`(u8 *)sub + 4` byte arithmetic for `rec2->cursor` (fixes a real `adds #16`
   vs `#4`).** `sub + 4` on a 2-byte SoundSubRecord* is +8 bytes; the baserom
   wants +4 BYTES. Cast to `(u8*)` first.

6. **unpin `entry` (was `asm("r5")`) → r0 scratch for the id*8 index.** With entry
   pinned r5, `entry = desc + 4 + id*8` folds in-place (`lsls r5,r5,#3`); unpinned,
   agbcc uses r0 scratch (`lsls r0,r5,#3`) like the baserom. (entry still lands r5
   naturally.)

7. **kind-or-altId SEMANTIC FIX (was a real bug, not coloring).** The baserom
   reuses r4 for kind AND altId: the bound check + dispatch operate on
   `n = (kind != 0xff) ? kind : altId`, NOT kind alone. Write:
   `if (kind == 0xff) { kind = entry->altId; if (kind == 0xff) goto boundOk; }
    if (kind >= ssE->count+4) return 0; boundOk:` — and `kind` (now possibly altId)
   flows into the `if (kind <= 3)` dispatch. The prior `if (kind!=0xff || altId!=0xff)
   { if (kind>=...) }` form mis-checked kind when kind==0xff.

8. **handle OR reorder: `ss->globalSeq | (kind<<16) | (rng<<24)`** (globalSeq FIRST)
   → the 0x118 offset materializes in r0 scratch before `kind<<16`, matching the
   baserom (instead of `movs r5,#142` after r5 frees).

9. **`ctrl` temp for the stack-arg branches:** `{ u32 ctrl = 0x100 | entry->priority;
   sub_08032904(..., ctrl); }` → 0x100 computes directly in r0 (no `adds r0,r1,#0`
   copy). Needed for BOTH stack-arg calls (sub_08032904, sub_08032894).

10. **`register u32 dOff asm("r0")` for descTableOff (fixes the desc-fold).** With
    `desc asm("r4")`, `desc = bank + descTableOff` folds the offset into r4
    (`ldr r4,[r2,#12]`); pinning the offset read to r0 gives the baserom's
    `ldr r0,[r2,#12]; adds r4,r2,r0`.

11. **`subL = sub` low-reg alias (the permuter found this; 23→7).** Caching sub in
    a plain low-reg var and using `subL` for both `(subL->flags & 0x80)` checks AND
    `rec2->cursor` removes the `mov r1,sl` scheduling diffs (the sl pin schedules
    the high-reg mov early; the low alias reads flags directly).

KEEP these pins (all PURE C, all load-bearing — removing any individually that's
marked so regresses): `sub asm("sl")`, `ssE asm("r6")`, `pLoad asm("r1")`,
`desc asm("r4")`, `dOff asm("r0")`. `entry` and `subL` are UNpinned (correct).

## The remaining 6 diffs (THE blocker — reload coloring, all in the tail)
All are the rematerialized `gpSoundSystem` address landing in r0 (mine) instead of
the baserom's callee-saved r3/r2, where the address then FLOWS across the
channel/slot → common-chRec merge:
  - +0xf2/f4 (channel chDirty): `ldr r0,[pc]; ldr r1,[r0]` vs baserom `ldr r3,[pc];
    ldr r1,[r3]`. Baserom keeps the chDirty address in r3 so the common chRec
    (reached via `b.n 0x2db8e`) re-derefs r3 with NO pool load.
  - +0x190/192 (slot swHandle): `ldr r0` vs `ldr r2`. Baserom keeps swHandle addr
    in r2.
  - +0x1a0 (slot→common chRec): `ldr r3,[pc]` (mine RE-LOADS) vs `adds r3,r2,#0`
    (baserom REUSES the swHandle r2).
  - +0x106: a `b.n` distance artifact downstream of +0x1a0.

Root cause: the baserom keeps the rematerialized address in a callee-saved reg
(r3 channel / r2→r3 slot) so the COMMON chRec has NO pool load — it re-derefs r3.
agbcc rematerializes the address AGAIN in the common chRec (its own pool load,
into r0 scratch), because with the `gpSoundSystem` macro each use is an independent
`update_equiv_regs` rematerialization (no CSE of the address across the merge).
The needed behaviour is "CSE the ADDRESS pool-load across the merge but NOT the
deref" — agbcc only offers all-CSE (`*pPool`, caches the VALUE → 316, size wrong)
or all-rematerialize (macro → 7, address in r0).

## Levers tried on the 6-diff residual (ALL FAILED — pick a DIFFERENT one)
  - **global `register SoundSystem** asm("r3")` tail anchor:** 317-489. r3 is used
    by the dispatch (`adds r3,r1,#0` panScale anchor + the casesi-free flow), so a
    function-wide r3 pin collides and recolors everything.
  - **scoped `register SoundSystem* asm("r3")` in chRec only:** 474 (the scoped pin
    still globally reserves r3, breaking the dispatch).
  - **cache `ss = gpSoundSystem` shared across the branch→merge** (vII/vLL): 316 —
    caches the VALUE, agbcc keeps it in a callee-saved reg across the merge, breaks
    the address-rematerialize structure + size.
  - **`(*pPool)` / `pE`-address carried into the tail:** 110-317 (CSE the value,
    or pE spills across the BLs).
  - **`-fXXX` sweep** (force-addr, no-gcse, no-cse-follow-jumps, no-schedule-insns/2,
    no-expensive-optimizations, caller-saves, fixed-r0/1/2): ALL neutral at 7.
  - **new agbcc (AGBCC_BIN):** 64 (worse). old_agbcc is the correct/best base.
  - **permuter** (~4000+ iters across several -j6 runs from the 7-base; base score
    221): NEVER beat 7. It DID find lever #11 (subL) from the 23-base — so it works
    for alias tricks, but the address-in-callee-saved-reg-across-merge is beyond
    statement/scope mutation. (It plateaus at score ~220 = the 6 diffs.)
  - **linker-symbol for gpSoundSystem:** NOT re-tried this round; round-15/20 proved
    a SYMBOL_REF is `CONSTANT_P` so `update_equiv_regs` rematerializes it identically
    — it will not change the address-register choice. Skip.

## What to try NEXT (genuinely untried for the 6-diff residual)
1. **INSTRUMENT reload1.c's reload-register selection** for the rematerialized
   constant in the tail blocks (a private debug agbcc REPRODUCES old_agbcc exactly
   — verified this round; the round-20 "can't instrument" claim was WRONG, the DBG
   fprintf in combine.c does not affect codegen). Find WHY reload picks r0 (caller-
   saved) for the chDirty/swHandle address instead of a callee-saved reg, then a
   source shape or `-fXXX` that steers it. This is the only microscope not yet
   pointed at the EXACT residual. Recipe: `cp -RL tools/agbcc-src /tmp/priv; ` add
   fprintf to the reload reg-choice site; rebuild ONLY local-alloc.o/reload1.o +
   relink (do NOT touch shared tools/agbcc-src — it races siblings). Object list is
   in gcc/Makefile SRCS; link cmd is the `old:` target.
2. The needed asm is "address in r3 from chDirty flows over `b.n` into common chRec
   re-deref". A source construct that makes the common chRec's address provably the
   SAME pool entry as the chDirty's (so reload keeps it live in a callee-saved reg
   across the b.n) — without CSE-ing the VALUE. No C shape found yet expresses this.
3. Permuter from the 7-base with a DIFFERENT random seed / much longer (>20k iters)
   — it found subL once; an alias on the tail address (`a = gpSoundSystem; ... a->`)
   in just the right place might tip it. Low EV but cheap.

## Prerequisites already landed in prior rounds (keep)
sub_08032BC8 peel; the scaffold src/game/sub_0802d9ec.c + linker.ld entry. All
6 callees (sub_08032BA0, sub_08032904, SoundChannel_Init, SoundSlot_PickByPriority,
sub_08032894, sub_08032BC8) are peeled and their BLs resolve.

## Best-effort C (7/6) — START HERE
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
    SoundDesc *entry;
    SoundSubRecord *subL;
    s32 kind;
    u32 handle;
    u32 rng;

    pLoad = &gpSoundSystem;
    ssE = *pLoad;
    bank = ssE->bankPtr;
    {
        register u32 dOff asm("r0") = ((SoundBank *)bank)->descTableOff;
        desc = (SoundDescTable *)(bank + dOff);
    }

    {
        u32 count = desc->count;
        pE = pLoad;
        if (id >= count)
            return 0;
    }

    entry = (SoundDesc *)((u8 *)&desc->entries + id * 8);
    {
        SoundSubRecord *t;
        bank += *(u32 *)(bank + *(u32 *)bank + entry->subIndex * 4);
        t = (SoundSubRecord *)bank;
        sub = t;
        kind = t->kind;
    }

    if (kind == 0xff) {
        kind = entry->altId;
        if (kind == 0xff)
            goto boundOk;
    }
    if (kind >= (s32)(ssE->count + 4))
        return 0;
boundOk:

    subL = sub;

    if ((s32)rVol > 0x7f)
        rVol = entry->volume;
    if ((s32)rPan > 0x7f)
        rPan = entry->pan;

    rPan = (s32)((*pE)->panScale * rPan) >> 8;

    if ((s32)rPitch > 0x80)
        rPitch = entry->pitch;
    else if (rPitch == 0x80)
        rPitch = 0xff;

    if (kind <= 3) {
        if (sub_08032BA0(1, entry->priority, kind) == 0)
            return 0;

        {
            u16 *seq = &gpSoundSystem->globalSeq;
            if (++*seq == 0)
                *seq = 1;
        }

        if ((subL->flags & 0x80) == 0) {
            u32 ctrl = 0x100 | entry->priority;
            sub_08032904(kind, rVol, rPitch, rPan, ctrl);
        } else {
            SoundChannel_Init(kind, rVol, rPan, 0x100 | entry->priority);
        }

        gpSoundSystem->chDirty[kind] |= 0x10000;
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

        if ((subL->flags & 0x80) == 0) {
            u32 ctrl = 0x100 | entry->priority;
            sub_08032894(swSlot, rVol, rPitch, rPan, ctrl);
        } else {
            sub_08032BC8(swSlot, rVol, rPan, 0x100 | entry->priority);
        }

        *(u32 *)((u8 *)swSlot + 0x38) |= 0x10000;
        gpSoundSystem->swHandleTable[kind] = swSlot;
        kind += 4;
    }

    {
        ChannelRecord *rec = (ChannelRecord *)(*(u8 **)(gpSoundSystem->chRecHolder + 0x110) + kind * 12);

        rec->field4 = 0;
        rec->field5 = 0xff;
        rec->pan6 = entry->pan;
        rec->pan8 = entry->pan;
        rec->vol7 = entry->volume;
    }

    ss = gpSoundSystem;
    {
        ChannelSeq *rec2 = (ChannelSeq *)(ss->chSeqTableBase + kind * 16);

        rec2->field8 = 0;
        rec2->fielda = 0;
        rec2->field4 = 0;
        rec2->cursor = (SoundSubRecord *)((u8 *)subL + 4);
        rec2->subIndex = entry->subIndex;
    }

    ss->rng *= 0xa8351d63;
    rng = (ss->rng << 11) >> 17;
    handle = ss->globalSeq | (kind << 16) | (rng << 24);
    ss->handleTable[kind] = (u32 *)handle;

    return handle;
}
```
