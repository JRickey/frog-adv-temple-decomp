# Deferred analysis: sub_0802EF7C

Range [0x0802ef7c, 0x0802f054) (216 bytes), Thumb. Classifier verdict:
`ATTEMPT_MATCH` (not STRONG_UNMATCHABLE). Leaf function, no callee peel
prerequisites. The target is the envelope-C inactive/release counterpart to
`sub_0802EEF8`.

## Semantics (stable — confirmed against the asm)

- `void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)`
- `channel <= 3`: inline `SoundSystem` channel state. Flags are
  `ss->chFlags[channel]` (`ss + 0x10 + channel*4`); envelope-C inactive
  delta is `ss + 0x8c + channel*8`; accumulator is `ss + 0x90 + channel*8`.
- `channel >= 4`: `SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, channel)`. Flags at
  slot+0x38, inactive delta at slot+0x24, accumulator at slot+0x28.
- If neither ACTIVE nor INACTIVE is set (`flags & 0x21` is zero), prime the
  accumulator to `clearAcc ? 0 : 0xff00`.
- Set inactive mode with `(flags & ~7) | 0x20` (`~7` spelled as `-8`/`negs`).
- Store `value`, or `-value` when `clearAcc == 0`.
- Inline path RELOADS `*gpSoundSystem` THREE times (via a pointer kept in r8)
  and writes the final accumulator reset unconditionally; sw-slot path does
  not write the unconditional final acc reset.

## Round 6 (Opus) — what was learned

The drift is ONE coupled register-coloring cascade rooted in `channel -> r3`
(target wants `channel -> r4`). This is a sharp local minimum that NO source
shape or compiler flag tried escaped. New, concrete findings that ADVANCE the
next attempt past the prior 121 plateau:

1. **No `gpsp asm("r8")` pin is needed.** A single plain `SoundSystem **gpsp =
   &gpSoundSystem;` dereferenced 3 times makes agbcc choose r8 for the pointer
   on its own (global allocator picks a callee-saved reg for the cross-block
   pointer). Dropping the pin keeps byte_diff at 122 and is cleaner than the
   prior 121 lane.
2. **Hoisting `channel << 3` into a single `chOffset` local FIXES the
   clearAcc/value coloring.** With `chOffset = channel << 3` computed once
   (after the first flag load, before the inline `if`), agbcc colours
   `clearAcc -> r6` and `value -> r7` (both CORRECT — the prior 121 struct lane
   had clearAcc -> r7 and value -> ip, which is WRONG). This is the single
   biggest structural improvement this round. Order is load-bearing: the hoist
   must come AFTER `gpsp/ss1/first-flag-load` or agbcc CSE-folds the 3 ss
   reloads (drops r8, regresses to ~196/183). Computing it before regresses too.
3. **The 3rd `*gpsp` reload folds.** With manual offset arithmetic the param
   store keeps ss2 alive as a bare pointer in r2, so `ss3 = *gpsp` CSE-folds
   with ss2 -> the function shrinks to 212 bytes (missing the `mov r1,r8; ldr`
   3rd reload, hence byte_diff 124 / diff_count 60). The 121 struct lane is
   exact 216 only because the struct field addressing makes ss2 die before the
   acc reset. Reading ss3 via the `gpSoundSystem` macro instead of `*gpsp`
   restores the 216 size BUT flips clearAcc/value back to the wrong regs
   (byte_diff 125). So size-vs-coloring are coupled through the ss3 reload.

### The unsolved root: `channel -> r3` (want r4)

`agbcc_oracle.py` (no-rebuild `-da` greg dump) pins the exact cause:
- channel = pseudo 32: refs=5, live_length=19  -> QTY_CMP_PRI ≈ 0.53
- block-2 flagBase temp = pseudo 40: refs=5, live_length=10 -> PRI ≈ 1.0
- allocation order: `41 40 42 39 32 56 55 36 22 27 35 33`. Pseudo 40 is
  colored 4th and TAKES r4; channel is colored 5th and gets r3 (r0/r1/r2 are
  the flags/literal/flagOffset). In the target r3 holds the gp literal
  transiently (`ldr r3,=gp; ... mov r8,r3`), so channel is pushed to r4.
- channel's live_length is 19 because it is referenced in BOTH the inline
  shifts and the sw_slot `channel*64-256` (the global live range spans both
  branches). To beat pseudo 40 it would need live_length < ~10.

So the lever the NEXT attempt should pull is **lower channel's live_length OR
lower pseudo 40's priority** so channel wins r4. Things that did NOT work this
round: a `swChannel = channel` copy for the sw_slot path (agbcc ties it, no
change); pinning channel to r4 via `register x asm("r4") = arg` (adds a copy,
regresses to 224+); pinning `pp asm("r3")` (r3 is scratch, regresses to 220).
The promising untried lever is **instrumenting a private agbcc** (codegen-notes
"Instrumenting agbcc itself") to watch `find_free_reg` for pseudo 32 and
confirm whether forcing the gp literal to materialize in r3 (so r3 is busy at
channel's allocation) is reachable from C — the `-da` dump shows the literal
currently lands in r0 then is copied to r8.

### Ruled out this round (flags + shapes)

- All CSE flags neutral on the fold: `-fno-gcse`, `-fno-cse-follow-jumps`,
  `-fno-cse-skip-blocks`, `-fno-expensive-optimizations`,
  `-fno-rerun-cse-after-loop` — all leave insns=103 in the standalone probe.
- channel stays r3 under every flag tried: `-O1/-O2/-O3`, `-fforce-addr`,
  `-ffixed-ip`, `-fno-strength-reduce`, `-funroll-loops`, `-fno-defer-pop`,
  `-f(no-)peephole`, `-f(no-)omit-frame-pointer`, `-frerun-loop-opt`.
- Pure `ss->chFlags[channel]` struct access for the flag read/write regresses
  (212/195) — target reuses `channel<<2` (flagOffset, in r2 then ip) across
  both flag accesses, which only the manual `flagBase + flagOffset` form
  captures.
- Combined single `flagPtr = ss + 0x10 + flagOffset` regresses (196/184) —
  target does the two-step `r2 = ss+16; add r2, ip`.
- Two-pointer (`pp` low + `gpsp asm("r8")` deferred copy): puts the `mov r8`
  in the right spot but either drops r8 (`gpsp = pp` folds, 204/186) or
  re-disrupts the param coloring (216/125).

Permuter is NOT appropriate (byte_diff 124 >> the ~40 threshold;
docs/permuter-howto.md forbids it for non-near matches). The prior round's
permuter run from the 121 lane scored 90 (worse).

## Round 7 (Codex) — additional drift ruled out

Re-attempted in-place in `src/system/sound_channel_stream.c` with the target
asm slice removed from `linker.ld`. Baseline and all probes were built with
the existing TU override: `old_agbcc -O2 -fforce-addr -fno-gcse
-fno-cse-follow-jumps`.

New semantic correction: the flag update is `(flags & ~7) | 0x20`, not the
existing `SOUND_ENVELOPE_C_CLEAR_MODE` macro (`(u32)-7`). A future active
attempt should add a named macro such as `SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE
((u32)-8)` in `include/sound.h`; do not reuse `SOUND_ENVELOPE_C_CLEAR_MODE`
for this function.

Best in this round: exact 216-byte size, `byte_diff 126 / diff_count 59`.
Shape: prior Round-6 one-pin lane, plus corrected `~7` mask and a single
`clearAcc asm("r6")` pin. This fixes the clear parameter color and improves
instruction diff, but leaves the same coupled allocator root:

- `channel` still colors to r3 (target r4).
- `value` colors to ip (target r7) unless r4/r6 pressure is changed.
- `&gpSoundSystem` colors to r8 but is copied too early (`ldr r0; mov r8,r0`)
  instead of target `ldr r3; ... and; mov r8,r3`.
- The first `SoundSystem *` colors to r7 in the best exact-size lane (target
  r5), so the inline accumulator reset and subsequent flag path drift.

Additional shapes tried and ruled out:

- Pinning only `clearAcc` to r6: keeps exact size and improves diff_count
  64 -> 59, but does not move `channel` or `value` into target regs.
- Pinning `channel` to r4 (with clear r6): gets the visible `adds r4,r2,#0`
  but drops the high-register `gpsp` cache entirely; object shrinks to 200
  bytes and regresses to `byte_diff 183`.
- Delayed `gpsp asm("r8")` via a separate `pool = &gpSoundSystem` local after
  the first flag load: still places the copy too early or over-pressures the
  function; best combined lane was 208 bytes / `byte_diff 184`.
- Splitting `pool` while keeping `gpsp` plain introduced r9 and regressed to
  224 bytes / `byte_diff 214`.
- Removing the `flagBase` local and using direct `((u8 *)ss + 0x10 + off)`
  addressing lets `channel` take r4 but loses r8 and shrinks to 192 bytes.
- Scoped `register u8 *flagBase1 asm("r0")` gets `channel` to r4 while
  preserving separate base-add addressing, but still loses r8 and shrinks to
  200 bytes. Adding `gpsp asm("r8")` on top is ignored by allocation in that
  shape and remains 200 bytes / `byte_diff 184`.
- Pinning `value` to r7 is harmful: agbcc spills/reconstructs it from `sp`
  in this TU and regresses to 220 bytes / `byte_diff 169`.

Corpus status: current-tree corpus grep only surfaced `mov r8` in inline asm
or NAKED bodies. The required history search could not run in this worktree
because `tools/agent/corpus-mirrors/` is not populated.

`agbcc_oracle.py --pass greg` on the best exact-size lane confirms this is a
local/global allocation problem. `channel` is pseudo 32 (`refs=5,
live_length=20`) and allocates after short-lived pointer pseudo 38
(`refs=5, live_length=10`), which takes r4. Removing or pinning that pointer
fixes r4 only by destroying the r8 cache, so the next useful step is still a
private debug compiler probe around `find_free_reg` / allocation order to see
whether the target's `ldr r3, =gpSoundSystem` can be made live at the right
decision point from C.

## Best-effort C

Best lane overall remains non-near and should not be permuted. The latest
in-place best is exact-size with `byte_diff 126 / diff_count 59`; it uses two
register pins (`flagOffset asm("r2")`, `clear asm("r6")`) and requires adding
`SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE ((u32)-8)` if reactivated.

```c
#include "sound.h"
#include "macros.h"

void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)
{
    SoundSystem **gpsp;
    SoundSystem *ss1;
    SoundSystem *ss2;
    SoundSystem *ss3;
    SoundSlot *slot;
    u8 *flagBase;
    u32 flags;
    register u32 flagOffset asm("r2");
    s32 chOffset;
    register u8 clear asm("r6");
    u16 accReset;

    clear = clearAcc;
    if (channel > 3)
        goto sw_slot;

    flagOffset = (u32)(channel << 2);
    gpsp = &gpSoundSystem;
    ss1 = *gpsp;
    flagBase = (u8 *)ss1 + SOUND_CH_FLAGS_OFFSET;
    flags = *(u32 *)(flagBase + flagOffset);
    chOffset = channel << 3;
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clear == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        *(u16 *)((u8 *)ss1 + chOffset + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    }

    ss2 = *gpsp;
    flagBase = (u8 *)ss2 + SOUND_CH_FLAGS_OFFSET;
    flags = *(u32 *)(flagBase + flagOffset);
    flags = (flags & SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    *(u32 *)(flagBase + flagOffset) = flags;
    *(s32 *)((u8 *)ss2 + SOUND_ENVELOPE_C_CHANNEL_BASE + chOffset) = value;
    if (clear == 0)
        *(s32 *)((u8 *)ss2 + SOUND_ENVELOPE_C_CHANNEL_BASE + chOffset) = -(s32)value;

    ss3 = *gpsp;
    accReset = 0;
    if (clear == 0)
        accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
    *(u16 *)((u8 *)ss3 + chOffset + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    return;

sw_slot:
    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, channel);
    flags = slot->flags;
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clear == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        SOUND_SLOT_ENVELOPE_C(slot)->acc = accReset;
    }

    flags = slot->flags;
    flags = (flags & SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    slot->flags = flags;
    SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = value;
    if (clear == 0)
        SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = -(s32)value;
}
```


## Round 8 (Opus escalation) — NEW lever found: `flagOffset asm("ip")` forces the 216-byte r8 shape

Re-derived from scratch (did not extend the prior 121/126 lanes). The
instrumented private-agbcc trace (probe at `reg_renumber[...] = best_reg` in
`gcc/global.c` — note old_agbcc builds from `gcc/`, NOT `gcc_arm/`) gives the
GROUND TRUTH allocation, which finally explains the wall and surfaces a new,
better-positioned lane.

### Instrumented allocation facts (the definitive model)

For the plain clean C (no pins, hoisted `chOffset`, mask-in-condition; 200B):
`global.c` allocates these cross-block allocnos last, in this order/result:
- flagOffset (refs=3 len=21) -> **r7** (prefs LO_REGS, takes a free low
  callee-saved before ip)
- clearAcc (refs=6 len=68) -> r5
- value    (refs=5 len=64) -> r6
- gpsp     (refs=4 len=68) -> **r12 (ip)** (last; ip is earliest non-LO in
  REG_ALLOC_ORDER `{3,2,1,0,12,14,4,5,6,7,8,...}`)

So WITHOUT a pin agbcc compiles a 200-byte object using r4-r7 + ip and never
touches r8 — a genuinely SMALLER allocation than the 216-byte target. The
target spends one EXTRA callee-saved reg (r8) by forcing flagOffset into ip,
which only happens when no low reg is free at flagOffset's allocation.

### The new lever (advances past 121/126)

`register u32 flagOffset asm("ip");` (single var, used in BOTH inline flag
accesses) FORCES flagOffset -> ip, which cascades:
- channel -> **r4** (correct! via local-alloc, no copy)
- gpsp    -> **r8** (correct! ip is now taken so gpsp spills to r8)
- exact **216-byte** size restored
- **byte_diff 173 / diff_count 72**, with ONE pin.

This is the first lane to get BOTH `channel->r4` AND `gpsp->r8` AND exact size
simultaneously — the prior rounds never reported r8/216 from a single clean
pin. The prior "channel->r3" root is SOLVED by this lever.

### Two coupled residuals that remain (the real wall now)

1. **`ss -> r2` (target wants r5).** Off-by-one: with ss in scratch r2,
   clearAcc/value fill r5/r6 instead of r6/r7. ss1 spans the block-1 inner
   `if`, so it COULD be a callee-saved global allocno — but it takes r2 because
   r2 is the first free low reg in REG_ALLOC_ORDER and nothing occupies it at
   ss1's birth. The target keeps flagOffset (r2 transient) + &gp (r3 transient)
   live across ss1's birth, so ss1 is pushed to r5.
   - Pinning `ss asm("r5")` DOES put ss in r5 but RELIEVES the pressure that
     promoted channel, so channel falls back to r2 (regresses 193-197). This is
     the hard tradeoff: **channel->r4 needs HIGH pressure; ss->r5 pin LOWERS
     pressure.** They are mutually exclusive under every pin combo tried.
   - Pinning channel=r4 AND ss=r5 together adds a channel copy the target lacks
     (220B / 194). `-ffixed-r2` is neutral (ss moves to r1/r3, still scratch).

2. **Eager `mov ip,r0` / `mov r8,r1` copies.** The `asm("ip")` pin emits the
   ip copy BEFORE block-1's first use; target copies AFTER (`mov ip,r2; mov
   r8,r3` at end of block 1). No scheduling flag defers it
   (`-fno-schedule-insns[2]`, `-fno-peephole`, `-fno-defer-pop` all neutral).
   - PARTIAL FIX FOUND: use a low-reg temp `o1 = channel<<2` for block-1
     addressing, then `flagOffset = o1` (flagOffset still `asm("ip")`) -> the
     ip copy moves LATE (`mov ip,r0` after the block-1 flag load), matching the
     target's `mov ip,r2` placement. byte_diff ~174 but structurally the right
     block-1 shape. The same trick does NOT work for &gp because `&gpSoundSystem`
     is a compile-time constant (0x030065e0) that agbcc re-materializes fresh
     and coalesces any `gpsp2 = gpsp` copy away — so `gpsp asm("r8")` pins and
     `gpsp2` late-copies are alike IGNORED (the eager `mov r8` stays).

### Best lanes this round (all exact-size 216 unless noted)
- `flagOffset asm("ip")` only: **byte_diff 173 / diff_count 72** (cleanest, 1 pin).
- + low-reg `o1` temp for block-1 offset (late ip copy): ~174 (better block-1 shape).
- 147 lane (plain `flagOffset` block1 + separate `ipOffset asm("ip")` block2):
  byte_diff 147 / diff_count 66 but size 212 — the `ipOffset` COALESCED into a
  low reg (r6) so ip was lost; value DID reach r7 and gpsp r8 here. Mixing in
  ss=r5 broke channel again.

### What the NEXT attempt should try (untried after this round)
- The wall is now narrow and precise: get **ss1 -> r5** WITHOUT a pin and
  WITHOUT relieving the channel->r4 pressure. Candidate: make the &gp literal
  and flagOffset both occupy low regs (r2/r3) ACROSS ss1's birth so ss1 is
  forced to r5 — i.e., defeat the constant-fold of `&gpSoundSystem` so it lives
  as a real pointer in a low reg through block 1 (a linker-assigned symbol for
  0x030065e0, cvaos-style, may make it a non-folded memory base — see
  codegen-notes "Adjacent IWRAM bases / linker-assigned symbols"). If &gp is a
  real low-reg pointer transient at ss1's birth alongside flagOffset, r2 AND r3
  are busy and ss1 should land in r5, cascading clearAcc->r6, value->r7.
- Permuter is still NOT appropriate (best 147/173 >> the ~40 threshold).
- A private-agbcc probe at `find_reg`'s REG_ALLOC_ORDER loop (the `used` set)
  for the ss1 pseudo would confirm exactly which regs are in `used` at its
  allocation and whether forcing the &gp literal into the conflict set is
  reachable from C.

## Best-effort C (Round 8 — the 173 lane, exact 216 size, 1 pin)

```c
void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)
{
    SoundSystem **gpsp;
    SoundSystem *ss;
    SoundSlot *slot;
    u8 *flagBase;
    u32 flags;
    register u32 flagOffset asm("ip"); /* forces gpsp->r8, channel->r4, size 216 */
    s32 chOffset;
    u16 accReset;

    if (channel > 3)
        goto sw_slot;

    flagOffset = channel << 2;
    gpsp = &gpSoundSystem;
    ss = *gpsp;
    flagBase = (u8 *)ss + SOUND_CH_FLAGS_OFFSET;
    flags = *(u32 *)(flagBase + flagOffset);
    chOffset = channel << 3;
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clearAcc == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        *(u16 *)((u8 *)ss + chOffset + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    }

    ss = *gpsp;
    flagBase = (u8 *)ss + SOUND_CH_FLAGS_OFFSET;
    flags = *(u32 *)(flagBase + flagOffset);
    flags = (flags & SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    *(u32 *)(flagBase + flagOffset) = flags;
    *(s32 *)((u8 *)ss + SOUND_ENVELOPE_C_CHANNEL_BASE + chOffset) = value;
    if (clearAcc == 0)
        *(s32 *)((u8 *)ss + SOUND_ENVELOPE_C_CHANNEL_BASE + chOffset) = -(s32)value;

    ss = *gpsp;
    accReset = 0;
    if (clearAcc == 0)
        accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
    *(u16 *)((u8 *)ss + chOffset + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET) = accReset;
    return;

sw_slot:
    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, channel);
    flags = slot->flags;
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clearAcc == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        SOUND_SLOT_ENVELOPE_C(slot)->acc = accReset;
    }

    flags = slot->flags;
    flags = (flags & SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    slot->flags = flags;
    SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = value;
    if (clearAcc == 0)
        SOUND_SLOT_ENVELOPE_C(slot)->param.inactiveDelta = -(s32)value;
}
```

Reactivating this lane needs `SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE ((u32)-8)`
added to `include/sound.h` (the `(flags & ~7) | 0x20` mask; do NOT reuse
`SOUND_ENVELOPE_C_CLEAR_MODE` which is `(u32)-7`).
