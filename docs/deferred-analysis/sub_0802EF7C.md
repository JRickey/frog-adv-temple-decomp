# Deferred analysis: sub_0802EF7C

Range [0x0802ef7c, 0x0802f054) (216 bytes), Thumb. Classifier verdict:
`ATTEMPT_MATCH` (not STRONG_UNMATCHABLE). Leaf function, no callee peel
prerequisites. The target is the envelope-C inactive/release counterpart to
`sub_0802EEF8`.

## Drift

Semantics are stable:

- `void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)`
- `channel <= 3`: use inline `SoundSystem` channel state. Flags are
  `ss->chFlags[channel]` at `ss + 0x10 + channel * 4`; envelope-C inactive
  delta is `ss + 0x8c + channel * 8`; accumulator is `ss + 0x90 + channel * 8`.
- `channel >= 4`: use `SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, channel)`. Flags
  at slot+0x38, inactive delta at slot+0x24, accumulator at slot+0x28.
- If neither ACTIVE nor INACTIVE is set (`flags & 0x21` is zero), prime the
  accumulator to `clearAcc ? 0 : 0xff00`.
- Set inactive mode with `(flags & ~7) | 0x20`.
- Store `value`, or `-value` when `clearAcc == 0`.
- Inline path unconditionally writes the final accumulator reset; sw-slot path
  does not.

New attempt notes:

- `classify_unmatchable.py sub_0802EF7C` now succeeds after refreshing
  `.function_addresses.json` and reports `ATTEMPT_MATCH`.
- Same-file destination `src/system/sound_channel_stream.c` is structurally
  hostile: that TU already needs `old_agbcc -O2 -fforce-addr -fno-gcse
  -fno-cse-follow-jumps` for `sub_0802EDF0`/`sub_0802EEF8`. A clean body in
  that TU shortened EF7C to 200 bytes (`byte_diff 193`), and the explicit
  chFlags-base source shape still shortened to 196 bytes (`byte_diff 191`).
  The viable route is an isolated TU with only `-fforce-addr`.
- Best new lane is an isolated `src/system/sub_0802ef7c.c` compiled with
  `old_agbcc -O2 -fforce-addr`, `gpsp asm("r8")`, and `flagOffset asm("r2")`:
  exact 216-byte length, `byte_diff 121`, `diff_count 63`.
- Compared with the prior 124 lane, pinning `gpsp` to `r8` improves one byte,
  but it front-loads `mov r8, r0`; target wants `ldr r3, =gpSoundSystem`,
  first flag test, then `mov r8, r3`.
- Remaining drift is still one coupled allocator cascade:
  - target: `channel -> r4`, `clearAcc -> r6`, `value -> r7`,
    `&gpSoundSystem -> r3` then late `r8`, first `*gpSoundSystem -> r5`,
    `channel << 2 -> r2` then `ip`, `channel << 3` by reusing r4.
  - best build: `channel -> r3`, `clearAcc -> r7`, `value -> ip`,
    `&gpSoundSystem -> r0` then early `r8`, first `*gpSoundSystem -> r6`,
    `channel << 2 -> r2`, `channel << 3 -> r5`.
- `agbcc_oracle.py --pass greg` on the best lane confirms the allocator
  dispositions behind the cascade: a user var in r7 for `clearAcc`, a user var
  in ip for `value`, `gpsp` in r8, first `SoundSystem *` in r6, `flagOffset`
  in r2, and channel*8 in r5. The register choice is in the
  `local-alloc`/`regclass`/`reload` family, not a loop or CSE issue.

Ruled out in this attempt:

- Plain readable C in `sound_channel_stream.c`: 200 bytes / `byte_diff 193`.
- Explicit `flagBase`/`flagOffset` source shape in `sound_channel_stream.c`:
  196 bytes / `byte_diff 191`.
- Separate TU with only `flagOffset asm("r2")`: 216 bytes / `byte_diff 122`.
- Pinning all normalized params (`channel r4`, `clear r6`, `value r7`): grows
  to 228 bytes / `byte_diff 222`.
- Pinning `&gpSoundSystem` to r3: grows to 224 bytes / `byte_diff 187`.
- Late-save structure using short-lived `pp`, then long-lived `gpsp` and saved
  flag offset after the first flag load: 216 bytes / `byte_diff 133`.
- Pinning only `clearAcc` to r6: adds extra high-reg saves, 232 bytes /
  `byte_diff 214`.
- Adding a separate `savedFlagOffset asm("ip")`: finds an ip copy but
  regresses to `byte_diff 167`.
- Removing the r2 flag-offset pin while keeping the r8 gp pointer: shrinks to
  204 bytes / `byte_diff 179`.
- `-ffixed-r0`: too blunt, adds r9/r8 saves, 232 bytes / `byte_diff 217`.
- Flag matrix on the best source: `-fno-gcse`, `-fno-cse-follow-jumps`,
  `-fno-expensive-optimizations`, `-fno-strength-reduce`, `-O1`, and `-O3`
  all stayed at `byte_diff 121`; `-fno-schedule-insns` did not produce a useful
  lane.
- `corpus_asm_search.py` history search could not run because this worktree
  has no `tools/agent/corpus-mirrors`. Current-tree corpus grep only found
  inline asm uses for `mov r8`, not a useful C replacement.
- Pinning only `value` to r7 grew to 220 bytes / `byte_diff 163`.

Next useful direction:

- Instrument a private `old_agbcc` in `reload1.c` / `reload.c` around the
  point that emits the early `mov r8, r0` for the gp literal. The source-level
  target is to make the gp literal materialize in r3 and survive through the
  first flag test before spilling to r8, while keeping `flagOffset` in r2.

## Best-effort C

Best lane: isolated TU, `old_agbcc -O2 -fforce-addr`, exact 216-byte size,
`byte_diff 121`, `diff_count 63`.

```c
#include "sound.h"
#include "macros.h"

void sub_0802EF7C(u8 clearAcc, u16 value, s32 channel)
{
    register u32 flagOffset asm("r2");
    register SoundSystem **gpsp asm("r8");
    SoundSystem *ss1;
    SoundSystem *ss2;
    SoundSystem *ss3;
    SoundSlot *slot;
    u8 *flagBase;
    u32 flags;
    u16 accReset;

    if (channel > 3)
        goto sw_slot;

    flagOffset = (u32)(channel << 2);
    gpsp = &gpSoundSystem;
    ss1 = *gpsp;
    flagBase = (u8 *)ss1 + SOUND_CH_FLAGS_OFFSET;
    flags = *(u32 *)(flagBase + flagOffset);
    if ((flags & (SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE)) == 0) {
        accReset = 0;
        if (clearAcc == 0)
            accReset = SOUND_ENVELOPE_C_HIGH_CLAMP;
        ss1->channels[channel].envelopeC.acc = accReset;
    }

    ss2 = *gpsp;
    flagBase = (u8 *)ss2 + SOUND_CH_FLAGS_OFFSET;
    flags = *(u32 *)(flagBase + flagOffset);
    flags = (flags & ~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    *(u32 *)(flagBase + flagOffset) = flags;
    ss2->channels[channel].envelopeC.param.inactiveDelta = value;
    if (clearAcc == 0)
        ss2->channels[channel].envelopeC.param.inactiveDelta = -(s32)value;

    ss3 = *gpsp;
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
        slot->envelopeC.acc = accReset;
    }

    flags = slot->flags;
    flags = (flags & ~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_ENVELOPE_C_MODE_BITS)) | SOUND_FLAG_ENVELOPE_C_INACTIVE;
    slot->flags = flags;
    slot->envelopeC.param.inactiveDelta = value;
    if (clearAcc == 0)
        slot->envelopeC.param.inactiveDelta = -(s32)value;
}
```
