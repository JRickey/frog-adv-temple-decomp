# Deferred analysis: sub_0802EF7C

Range [0x0802ef7c, 0x0802f054) (216 bytes), thumb. Asm slice
asm/disasm_0x0802ef7c.s. Destination src/system/sound_channel_stream.c
(appends after sub_0802EEF8, its near-twin) — OR its own TU
src/system/sub_0802ef7c.c (see below; the matching path needs a flag
incompatible with sub_0802EEF8's, so a TU split is required).

## Semantics (fully understood — unchanged from prior attempt)

`void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)` — the INACTIVE/release
complement of sub_0802EEF8 (kickoff). Sets envelope-C into the INACTIVE state.

- `channel <= 3` (inline/direct channels): operate on `gpSoundSystem`
  (`*0x030065e0`). Flags in `ss->chFlags[channel]` (base +0x10, stride 4);
  envelope-C block in `ss->channels[channel]` (base 0x8c, stride 8) — param
  (s32 inactiveDelta) at +0, acc (u16) at +4 (=0x90).
- `channel >= 4` (sw-mixed slots): `SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss,channel)`,
  flags at slot+0x38, envelope-C param at slot+0x24, acc at slot+0x28.

Per-path logic:
1. If `(flags & (ACTIVE|INACTIVE)) == 0`: prime acc = (clearAcc ? 0 : 0xff00).
2. `flags = (flags & ~7) | INACTIVE`  (mask is `~7` == `movs #8; negs`, i.e.
   `~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)`).
3. param = value; if (!clearAcc) param = -value.
4. (inline path only) re-prime acc unconditionally = (clearAcc ? 0 : 0xff00).
   The inline path holds `&gpSoundSystem` (the constant 0x030065e0) in a
   callee-saved high reg (r8) and RELOADS `*r8` at each of the 3 blocks.

The sw_slot path (channel >= 4) matches byte-for-byte. ALL residual divergence
is in the inline path (channels 0..3), and it is ONE register-coloring decision
(see Drift). The acc-prime idiom in BOTH paths is `accReset = 0; if (clearAcc
== 0) accReset = 0xff00;` (NOT the `0xff00; if (clearAcc != 0) 0` form the prior
attempt used — using the wrong form regresses sw_slot under -fforce-addr).

## NEW (this attempt): the -fforce-addr lane reproduces the WHOLE structure

The prior attempt's best was byte_diff 149 WITHOUT -fforce-addr. The decisive
new finding: compile this function in its OWN translation unit with
`-fforce-addr` (and NOT -fno-gcse / -fno-cse-follow-jumps — those are
sub_0802EEF8's flags and they SHORTEN this function to 200 bytes, dropping the
r8 hold). With a pointer-to-pointer local for &gpSoundSystem, plain
`ss->chFlags[channel]` / `ss->channels[channel]` array syntax, and 3 explicit
`ss = *pp` reloads:

    src/system/sub_0802ef7c.s: CC = $(OLD_AGBCC_BIN)
    src/system/sub_0802ef7c.s: CFLAGS += -fforce-addr

gives **byte_diff 184 / diff_count 56 / size 208** (vs target 216). The
structure is now BYTE-CORRECT: it emits the r8 address-hold (`mov r8,r3`),
`mov ip` for channel<<2, the 3 reloads of `*r8`, the 0xff00-via-scratch
materialise — everything. 100% of the residual diff is a single
register-RENAMING of an otherwise-identical instruction stream.

(Using separate ss1/ss2/ss3 locals per block trims diff_count 61 -> 56 with
the same 184 byte_diff and is marginally cleaner — see Best-effort C.)

## Drift — root cause, diagnosed at the agbcc-pseudo level

The ONE difference: where `channel` lives.
  - TARGET: `channel` -> r4 (copied in at entry: `adds r4, r2, #0`), then
    reused for `channel<<3` (`lsls r4,r4,#3`); `ss`(block1) -> r5;
    `channel<<2` -> r2 (scratch) -> ip.
  - OURS:   `channel` STAYS in its incoming arg reg r2; `ss`(block1) -> r4;
    `channel<<2` -> r0 -> ip; `channel<<3` -> r5.
Everything else (the 0xff00-in-scratch-then-copy at 3 sites, the flags-block
register numbers, the acc-address-computed-first ordering) is a MECHANICAL
cascade of this one choice.

Instrumented old_agbcc (private debug build of gcc/global.c — old_agbcc builds
from gcc/, NOT gcc_arm/) and read the global-allocator trace. Findings:
  - `channel` is pseudo 32, refs=5, live_length=21.  `ss`(block1) is pseudo 34,
    refs=8, ll=33.  `&gpSoundSystem` (pp) is pseudo 33, refs=4, ll=74.
  - allocno priority = `floor_log2(refs)*refs/live_length*10000*size`
    (allocno_compare). ss(34): 3*8/33 -> ~7272.  channel(32): 2*5/21 -> ~4761.
    So ss is allocated FIRST and takes r4.
  - `channel` has a COPY PREFERENCE to r2 (born from `set (reg/v 32) (reg 2
    r2)`, the incoming-param copy). In find_reg, the copy-preferred reg
    OVERRIDES best_reg whenever it is free. r2 is free when channel is
    allocated, so channel ALWAYS takes r2.
  - `pp` spills to r8 only because r4(ss),r5,r6(clearAcc),r7(value) are all
    taken by long-lived values. This is why ANY lever that frees a low reg
    (e.g. pinning channel to r4 with a short-lived ss) makes pp drop OUT of r8.

To get channel -> r4 you must EITHER (a) make a higher-priority pseudo grab r2
before channel, OR (b) remove channel's r2 copy-preference. gcc-2.x has no flag
to disable copy-preferencing, and no clean source shape found does either while
preserving the four-long-lived-low-reg pressure that forces pp -> r8.

### Levers tried this attempt (all 184-class, or regress, or perturb)
- -fforce-addr alone (single ss):            184 / 61 / 208  (BEST structural)
- -fforce-addr + separate ss1/ss2/ss3:       184 / 56 / 208  (BEST, cleanest)
- -fforce-addr + {-ffixed-r0..r3, -fno-gcse(=200), -fno-cse-follow-jumps,
  -fno-expensive-optimizations, -frerun-cse-after-loop, -fschedule-insns2,
  -fno-delayed-branch, -fcaller-saves, -fomit-frame-pointer, …}: all 184
  (channel coloring robust to every flag).
- newer agbcc + -fforce-addr:                same channel->r2, 192-class.
- pin channel asm("r4") (local copy) + single ss:  174 / 87 / 208 but DROPS r8
  (pp reloaded to r7 each block; pin freed a low reg so pp no longer spills).
- pin channel r4 + ss r5:                    200 / 146 / 216 (size right, scrambled).
- pin channel r4 + pp r8:                    206 / 85 / 220 (pp held from entry —
  target loads &gpSS to r3 first, derefs, THEN moves to r8).
- pin channel r4 + ss r5 + clearAcc r6 + value r7 (force pp->r8): 199 / 160 / 216
  (the keep* copies add instructions; pins fight).
- explicit chFlagsOff/chBlockOff locals + byte addressing: 173 / 78 / 184 (TOO
  SHORT — byte addressing folds +0x10/+0x90 into the load; array syntax
  `chFlags[channel]` is REQUIRED for the `adds #16; index` shape).
- folded `flags & mask == 0` test: 194 (changes the flag-test codegen).
- decomp-permuter from the 184 base (-fforce-addr compile, custom compile.sh):
  base score 1765, NEVER beaten in ~75 iters — confirmed a sharp local minimum
  the permuter cannot escape (it only reorders statements / scopes).

### Next-attempt ideas (use a DIFFERENT lever than above)
- The mechanism is now exact: you need r2 occupied by a higher-priority pseudo
  *at the moment channel is allocated*, so channel's r2 copy-preference fails
  and it falls to r4. Look for a source shape that gives the chFlags-read
  result (`flags`) OR the chFlags offset a copy-preference to r2 and a priority
  above ss(7272). Computing `channel<<2` into a named local that is itself
  copied (so it copy-prefers an arg reg) might do it — but every array-syntax
  variant re-CSE's the shift. The byte-addressing form that would let you name
  the offset cleanly breaks the chFlags `adds #16` shape; you'd need to keep
  array syntax for chFlags AND a named offset for channels, without the two
  CSE-merging.
- Alternatively confirm via the instrumented allocator (recipe in
  codegen-notes "Instrumenting agbcc itself") that a candidate source makes
  channel(32) sort before ss(34): patch gcc/global.c find_reg to
  `fprintf(stderr,"AGBCC-DBG pseudo %d refs=%d ll=%d -> r%d\n", ...)` at the
  `reg_renumber[...] = best_reg;` line and read the order. (Throwaway private
  build; never touch the shared tools/agbcc-src.)

## Best-effort C (the 184 / diff_count 56 lane — structurally byte-correct,
##  pure C, NO pins/asm; in its own TU with `-fforce-addr`)

```c
/* In src/system/sub_0802ef7c.c — own TU because -fforce-addr is incompatible
 * with sub_0802EEF8's -fno-gcse/-fno-cse-follow-jumps tuning.
 *   src/system/sub_0802ef7c.s: CC = $(OLD_AGBCC_BIN)
 *   src/system/sub_0802ef7c.s: CFLAGS += -fforce-addr
 */
void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)
{
    SoundSystem **pp;
    SoundSystem *ss1;
    SoundSystem *ss2;
    SoundSystem *ss3;
    SoundSlot *slot;
    u32 flags;
    u32 newFlags;
    u16 accReset;

    if (channel > 3)
        goto sw_slot;

    pp = &gpSoundSystem;
    ss1 = *pp;
    flags = ss1->chFlags[channel];
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clearAcc == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        ss1->channels[channel].envelopeC.acc = accReset;
    }

    ss2 = *pp;
    newFlags = ss2->chFlags[channel];
    newFlags = (newFlags & ~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    ss2->chFlags[channel] = newFlags;
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
