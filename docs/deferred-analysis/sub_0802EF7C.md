# Deferred analysis: sub_0802EF7C

Range [0x0802ef7c, 0x0802f054) (216 bytes), thumb. Asm slice
asm/disasm_0x0802ef7c.s. Destination src/system/sound_channel_stream.c
(appends after sub_0802EEF8, its near-twin).

## Semantics (fully understood)

`void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)` — the INACTIVE/release
complement of sub_0802EEF8 (kickoff). Sets envelope-C into the INACTIVE state:

- `channel <= 3` (inline/direct channels): operate on `gpSoundSystem`
  (`*0x030065e0`). Flags in `ss->chFlags[channel]` (base +0x10, stride 4);
  envelope-C block in `ss->channels[channel]` (base 0x8c, stride 8) — param
  (s32 inactiveDelta) at +0, acc (u16) at +4 (=0x90).
- `channel >= 4` (sw-mixed slots): `SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss,channel)`,
  flags at slot+0x38, envelope-C param at slot+0x24, acc at slot+0x28.

Logic per path:
1. If `(flags & (ACTIVE|INACTIVE)) == 0`: prime acc = (clearAcc ? 0 : 0xff00).
   (0xff00 = SOUND_ENVELOPE_C_HIGH_CLAMP.)
2. `flags = (flags & ~7) | INACTIVE`  — clear ACTIVE(0x1)+MODE_BITS(0x6), set
   INACTIVE(0x20). NOTE the mask is `~7` (==`movs #8;negs`), NOT the header's
   `SOUND_ENVELOPE_C_CLEAR_MODE` (which is (u32)-7 == ~6). Use
   `~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)`.
3. param = value; if (!clearAcc) param = -value.
4. (inline path only) re-prime acc unconditionally = (clearAcc ? 0 : 0xff00).
   The inline path reloads `*gpSoundSystem` THREE times (first block / flags
   block / final acc block) — the baserom holds `&gpSoundSystem` in r8 and
   reloads `*r8` at each block, keeping the first `ss` in r5 across block 1.

The sw_slot path (channel >= 4) MATCHES byte-for-byte in the best-effort C.
All divergence is confined to the inline path (channels 0..3).

## Drift

Best stable lane: **byte_diff 149 / diff_count 56 / size 212** (target 216 = 108hw,
mine 106hw — only ~2hw short). Confirmed IDENTICAL under BOTH old_agbcc and
the newer agbcc, and under every flag combo tried (see below). NOT a flag or
compiler issue — a pure register-coloring divergence.

Root cause — a single agbcc reload/local-alloc hoist mine never reproduces:
the target, right after the `(flags & 0x21)` test and before the conditional
branch, emits

    mov  r8, r3        @ &gpSoundSystem -> r8
    mov  ip, r2        @ channel<<2  preserved in ip (r12)
    lsls r4, r4, #3    @ channel<<3 computed into r4, DESTROYING raw channel

i.e. it keeps BOTH shifted index forms live across the branch (channel<<2 in
ip, channel<<3 in r4) and lets raw `channel` die. Mine instead RECOMPUTES
`lsls rX, r4, #2` / `lsls rX, r4, #3` at each of the ~5 use sites (channel
stays live in r4). This cascades: because ip/r4 are free in mine, the
accReset constant builds directly in r3 (`movs r3,#255; lsls r3,#8`) whereas
the target — with r1 the only free low reg — builds 0xff00 in a scratch r2
then `adds r1,r2,#0` (a 3-insn materialise), and `ss` colours to r5 vs my
caller-saved r3. Every downstream instruction differs only in register
number, inflating byte_diff far past what diff_count's "56 insns" implies
(most are the SAME instruction, wrong register).

agbcc treats `channel<<const` as cheap and re-emits it rather than allocating
a register; the target's build allocated. I could not find the C shape or
flag that flips this single decision.

### Levers tried (all converge to 149/56/212 or regress)
- gpsp pinned r8 (needed for the r8 address-hold) — 163 alone; +ss r5 -> 149.
- ss pinned r5 (keeps ss live across block 1, gets the r4-r7+r8 prologue right).
- accReset pinned r1 (target's reg): diff_count 54 but byte_diff 168, size 220.
- chFlagsOff/chBlockOff explicit locals (channel<<2/<<3): agbcc IGNORES them,
  recomputes from r4 anyway; or over-CSEs to size 196/byte_diff 177.
- chBlockOff primary + chFlagsOff = chBlockOff>>1: over-shares, 196/177.
- chFlagsOff pinned ip + chBlockOff pinned r4: ip clobbered, 208/186.
- typed `ss->channels[channel]` array access (channel<<3 as array index):
  149 — does NOT trigger the hoist.
- EEF8-proven idiom `*(u16*)((u8*)ss + (channel<<3) + 0x90)`: 149.
- casted chFlags base `((u8*)&ss->chFlags[0] + chFlagsOff)`: still folds +16
  into the load (`ldr [r0,#16]`) vs target's separate `adds r0,#16` — array
  syntax `chFlags[channel]` is the only form giving the +16-then-index shape.
- single `ss` (no reloads): agbcc keeps ss in one reg, size 196 (too short —
  target reloads 3x). 3 explicit reloads needed.
- no pins, 3 reloads: 191/71/200 — RIGHT inline shape (accReset in r1,
  address-compute preserves ss in r0) but loads the gpSoundSystem LITERAL each
  block via r7 instead of holding the address in r8 (no r8 prologue save).
- Flag sweep (all keep EEF8=0, EF7C=149): {-fforce-addr}, {-fno-gcse},
  {-fno-cse-follow-jumps}, {} , +{-fno-strength-reduce, -fno-schedule-insns,
  -fcaller-saves, -fno-peephole, -frerun-cse-after-loop, -fno-expensive-optimizations}.
- Newer agbcc (AGBCC_BIN) instead of OLD_AGBCC: identical 149/56/212, EEF8=0.

### Next-attempt ideas (use DIFFERENT levers than above)
- Instrument agbcc local-alloc/reload (private debug build) to log WHY
  `channel<<3` is re-emitted instead of allocated to the freed r4 — find the
  cost-model / `reg_equiv` decision and the C that flips it.
- A no-pin base at 191/200 already has the correct inline instruction SHAPE
  (accReset r1, ss-preserving address compute) and only misses the r8
  address-hold + the ip/r4 hoist; a dead-pointer-cast that forces channel<<3
  materialisation into the dead channel register might be reachable from there.
- decomp-permuter was NOT runnable in this worktree (vendor/decomp-permuter
  was an empty dir, not the main symlink) and 149/56 is well beyond its range
  anyway — only worth it from a <=~40 base.

## Best-effort C

```c
void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)
{
    register SoundSystem **gpsp asm("r8");
    register SoundSystem *ss asm("r5");
    SoundSystem *ssFlags;
    SoundSystem *ssAcc;
    SoundSlot *slot;
    u32 flags;
    u32 newFlags;
    u16 accReset;

    if (channel > 3)
        goto sw_slot;

    gpsp = &gpSoundSystem;
    ss = *gpsp;
    flags = ss->chFlags[channel];
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clearAcc == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        ss->channels[channel].envelopeC.acc = accReset;
    }

    ssFlags = *gpsp;
    newFlags = ssFlags->chFlags[channel];
    newFlags = (newFlags & ~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    ssFlags->chFlags[channel] = newFlags;
    ssFlags->channels[channel].envelopeC.param.inactiveDelta = value;
    if (clearAcc == 0)
        ssFlags->channels[channel].envelopeC.param.inactiveDelta = -(s32)value;

    ssAcc = *gpsp;
    accReset = 0;
    if (clearAcc == 0)
        accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
    ssAcc->channels[channel].envelopeC.acc = accReset;
    return;

sw_slot:
    slot = SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(gpSoundSystem, channel);
    flags = slot->flags;
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        if (clearAcc != 0)
            accReset = 0;
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
