# Deferred analysis: sub_0802EF7C

Range [0x0802ef7c, 0x0802f054) (216 bytes), thumb. Asm slice
asm/disasm_0x0802ef7c.s. Destination: its OWN TU src/system/sub_0802ef7c.c
(the matching path needs `-fforce-addr` WITHOUT sub_0802EEF8's
`-fno-gcse -fno-cse-follow-jumps`, so a TU split is mandatory — those flags
shorten EF7C to 200 bytes and drop the r8 hold).

## Semantics (fully understood — confirmed by full asm trace, unchanged)

`void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)` — the INACTIVE/release
complement of sub_0802EEF8 (kickoff). Sets envelope-C into the INACTIVE state.

- `channel <= 3` (inline channels): operate on `gpSoundSystem` (`*0x030065e0`).
  Flags `ss->chFlags[channel]` (base 0x10, stride 4); envelope-C block at
  `ss + 0x8c + channel*8` — param (s32 inactiveDelta) at +0 (0x8c), acc (u16)
  at +4 (0x90).  NOTE: `channels[]` is stride 8 under agbcc (the union
  SoundEnvelopeCChannel is 8 bytes; host cc mis-pads it — trust the asm, not
  a host offsetof probe).
- `channel >= 4` (sw slots): `SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss,channel)`,
  flags at slot+0x38, envelope-C param at slot+0x24, acc at slot+0x28.

Per-path logic:
1. If `(flags & (ACTIVE|INACTIVE)) == 0` (`& 0x21`): prime acc = (clearAcc ? 0
   : 0xff00).  The acc-prime idiom is `accReset = 0; if (clearAcc==0)
   accReset = 0xff00;` (NOT the inverted form — inverting regresses sw_slot).
2. `flags = (flags & ~7) | 0x20`  (mask `~7` = `movs #8; negs`; INACTIVE=0x20).
3. param = value; if (!clearAcc) param = -value.
4. (inline path only) re-prime acc unconditionally = (clearAcc ? 0 : 0xff00).

The sw_slot path (channel >= 4) matches byte-for-byte. ALL residual divergence
is in the inline path (channels 0..3), and it is now narrowed to ONE coupled
register-allocation cascade (see Drift).

## BIG PROGRESS THIS ATTEMPT: byte_diff 184 -> 124 via cfbase + cf-r2 pin

The decisive structural finding (NEW — supersedes all prior 184-class lanes):

  - Spell the chFlags access through an EXPLICIT base-pointer variable
    `u8 *cfbase = (u8 *)ssN + 0x10;` and an EXPLICIT byte offset
    `register u32 cf asm("r2"); cf = channel << 2;`, then
    `*(u32 *)(cfbase + cf)`. The named `cfbase` variable is LOAD-BEARING: it
    breaks the address dataflow so agbcc keeps the `adds #16` SEPARATE (a plain
    `*(u32*)((u8*)ss + 0x10 + cf)` or `&ss->chFlags[0] + cf` FOLDS the 0x10 into
    the `ldr` displacement and shrinks the object to ~192 — see "byte-offset
    chFlags folds" below).
  - Keep the `channels[]` accesses in ARRAY syntax `ssN->channels[channel]...`
    (array is required for the +0x8c/+0x90 staged-add shape and to CSE
    channel<<3 into one long-lived index web; byte-offset channels regresses).
  - The `register u32 cf asm("r2")` pin is the key: it OCCUPIES r2 so channel's
    parameter-copy preference to r2 FAILS, and it matches the target (cf IS in
    r2 in block1). With this pin, channel's r2 copy-pref is gone (verified by
    instrumented allocator: channel pseudo loses its `copypref: r2`).

Result: **byte_diff 124 / diff_count 66 / size 216 (EXACT length)**, with the
r8 hold, the in-place `lsls rX,rX,#3` channel<<3 reuse, the `adds #16` chFlags
staging, and the cf-in-r2 — ALL structurally byte-correct. The 124 residual is
100% a single coupled register RENAME (no instruction-count or shape diffs).

## Drift — root cause, diagnosed at the agbcc global-allocator level

Instrumented a PRIVATE old_agbcc (probe in gcc/global.c find_reg printing
pseudo refs/ll, hard conflicts, and copy preferences) and read the trace for
the 124 lane. The ONE remaining coupled cascade:

  - The `gpSoundSystem` CONSTANT (0x030065e0) materialises into **r0** in our
    build (`ldr r0,=...; mov r8,r0; ldr r6,[r0]` — spills to r8 IMMEDIATELY),
    whereas the TARGET keeps it in **r3** (`ldr r3,=...; ldr r5,[r3]; ...block1
    work...; mov r8,r3` — spills to r8 LATE, after the AND).
  - Because the const sits in r0, `cfbase` (chFlags base ss+0x10, pseudo with
    refs=5 ll=10, hardconf r0 r1 r2 r3) cannot use r0 and is forced to the
    callee-saved **r4**. That eats r4, so the channel/channel<<3 web shifts to
    **r5** (target r4), ss1 to **r6** (target r5), and `value` spills to **ip**
    (target r7). Everything downstream is a mechanical +1 register rename of
    this one displacement.
  - In the TARGET the const stays in r3 through block1, so r0 is FREE → the
    chFlags address chain is computed in r0 (a scratch, NOT a callee-saved
    cfbase) → no extra callee-saved reg is consumed → channel<<3 web gets r4,
    ss1 r5, value r7, pp r8. EXACT.

So the last mile is: **make the gpSoundSystem const materialise+linger in a
LOW scratch (r3) for block1 and spill to r8 LATE, instead of spilling
immediately from r0.** This is a reload/scheduling decision, robust to every
`-fXXX` and to OLD vs NEW agbcc tried (see below). The fix is almost certainly
a source shape that keeps the const live in a low reg across block1 (so reload
defers the r8 spill), OR that occupies r0/r1 at the const-load point so the
const picks r3.

### Confirmed dead ends this attempt (do NOT repeat)
- Plain array-syntax everywhere (prior 184 lane): channel takes r2 via the
  param copy-pref, robust to ALL flags (`-ffixed-r*`, `-fno-strength-reduce`,
  `-fno-gcse`, scheduling, caller-saves, `-O3`, NEW agbcc). 184/56.
- Byte-offset chFlags (`*(u32*)(ss+0x10+cf)`, `&ss->chFlags[0]+cf`, or a
  pinned cf without the cfbase variable): FOLDS the +0x10 into the ldr, shrinks
  to ~188-192, DROPS the r8 hold. 181-192-class.
- Byte-offset channels (`*(u8*)ss + (channel<<3) + 0x90` etc): folds +0x90 and
  shrinks; array syntax for channels is required. 186/204, 136/216.
- `channel <<= 3` in-place + `channel >> 3` for the chFlags array index: ugly
  and regresses (196). chFlags must index by the UNSHIFTED channel.
- `i4 = channel` alias for chFlags index: coalesced away by agbcc; no effect.
- Pin channel asm("r4") (with or without cf-r2 / clearAcc-r6 / value-r7 pins):
  pins FREE a low reg, killing the pressure that forces pp->r8 (drops the r8
  hold) and/or break the channel<<2->ip CSE; 175-211-class. Multi-pin fights.
- Pin cfbase asm("r0") (scratch): drops pressure, channel->r3, pp->ip; 192.
- Separate cfbase1/cfbase2 (one per block, scratch): drops pressure, no r8; 190.
- cf pinned to ip/r3 instead of r2: 128-162 (worse than r2's 124).
- block1 direct `gpSoundSystem` + pp held for 2/3: loses r8 consistency; 193.
- The permuter cannot help (the residual is pure register coloring, not
  statement order/scope) — do NOT burn time on it.

### Next-attempt ideas (target the const->r3 / late-spill specifically)
- Instrument old_agbcc's RELOAD pass (reload1.c spill/inheritance, choose_reload_regs)
  on the 124-lane .i to watch WHY the const spills to r8 from r0 immediately
  rather than lingering in r3. The recipe: build ONLY old_agbcc with
  `make -C gcc old -j4` from a `cp -RL tools/agbcc-src /tmp/agbcc-dbg` copy
  (NEVER touch the shared symlink); compile the .i directly
  (`old_agbcc -O2 -mthumb-interwork -fhex-asm -fforce-addr file.i`).
- Try to occupy r0 (and maybe r1) with a live scratch value AT the const-load
  point so the const's materialise-scratch falls to r3. E.g. compute cf
  (channel<<2) so it lands in r0 transiently before the const load, or reorder
  so a clearAcc/value promotion holds r0 across the const load.
- Try keeping the const explicitly in a low local that is RE-DEREFERENCED in
  block1 a second time (lengthening its low-reg live range so reload defers the
  spill), e.g. read a throwaway `*pp` field early — but watch it doesn't add an
  instruction.

## Best-effort C (the byte_diff 124 / diff_count 66 / size 216 lane —
##  structurally byte-correct, ONE pin `cf asm("r2")`; own TU with -fforce-addr)
##  Wiring (add to Makefile near the other sound TUs):
##    src/system/sub_0802ef7c.s: CC = $(OLD_AGBCC_BIN)
##    src/system/sub_0802ef7c.s: CFLAGS += -fforce-addr
##  and a linker.ld entry replacing the asm slice:
##    src/system/sub_0802ef7c.o(.text);  /* 0x0802ef7c - 0x0802f054, sub_0802EF7C */

```c
#include "sound.h"
#include "macros.h"

void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)
{
    /* cf in r2 occupies channel's param-copy-preference register, so channel
     * falls to a callee-saved reg (the target shape) instead of staying in r2.
     * cf also IS r2 in block1 of the target (chFlags byte offset). */
    register u32 cf asm("r2");
    SoundSystem **pp;
    SoundSystem *ss1;
    SoundSystem *ss2;
    SoundSystem *ss3;
    SoundSlot *slot;
    u8 *cfbase; /* named base ptr breaks the dataflow so agbcc keeps `adds #16`
                 * separate (a folded ss+0x10+cf shrinks the object). */
    u32 flags;
    u32 newFlags;
    u16 accReset;

    if (channel > 3)
        goto sw_slot;

    cf = (u32)(channel << 2);
    pp = &gpSoundSystem;
    ss1 = *pp;
    cfbase = (u8 *)ss1 + SOUND_CH_FLAGS_OFFSET;
    flags = *(u32 *)(cfbase + cf);
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clearAcc == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        ss1->channels[channel].envelopeC.acc = accReset;
    }

    ss2 = *pp;
    cfbase = (u8 *)ss2 + SOUND_CH_FLAGS_OFFSET;
    newFlags = *(u32 *)(cfbase + cf);
    newFlags = (newFlags & ~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    *(u32 *)(cfbase + cf) = newFlags;
    ss2->channels[channel].envelopeC.param.inactiveDelta = value;
    if (clearAcc == 0)
        ss2->channels[channel].envelopeC.param.inactiveDelta = -(s32)value;

    ss3 = *pp;
    accReset = 0;
    if (clearAcc == 0)
        accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
    ss3->channels[channel].envelopeC.acc = accReset;
    return;

sw_slot:
    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, channel);
    flags = slot->flags;
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clearAcc == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        *(u16 *)((u8 *)slot + SOUND_SLOT_ENVELOPE_C_OFFSET + 4) = accReset;
    }

    newFlags = slot->flags;
    newFlags = (newFlags & ~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    slot->flags = newFlags;
    *(s32 *)((u8 *)slot + SOUND_SLOT_ENVELOPE_C_OFFSET) = value;
    if (clearAcc == 0)
        *(s32 *)((u8 *)slot + SOUND_SLOT_ENVELOPE_C_OFFSET) = -(s32)value;
}
```
