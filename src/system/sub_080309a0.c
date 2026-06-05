#include "sound.h"
#include "macros.h"

extern void sub_0802F930(void *streamDesc);
extern void sub_080308B0(s32 channel, u16 slotIndex, u32 pitch, u32 bounce);

/* sub_080309A0 — stream-script command handler for commands 2 and >= 4.
 *
 * `op` is the decoded command type and `pCmd` points at the live cursor into
 * the 8-byte command stream. The handler advances the cursor past one record
 * and returns 1 to keep the script running on the same channel.
 *
 *   op == 2  Look the indexed stream descriptor up in the sound bank at
 *            SoundSystem+0x110 (a self-relative offset table); if the
 *            descriptor is armed (mode byte == 1), kick it via sub_0802F930.
 *   op <= 3  Nothing beyond advancing the cursor.
 *   op >= 4  Scale the command's 32-bit pitch by the per-channel ratio held
 *            in the request slot's region table (stride 12, ratio at +8),
 *            attenuating when flag bit 7 is set and boosting otherwise, then
 *            forward to sub_080308B0 with the bounce bit (flag bit 0).
 *
 * agbcc matching notes:
 *   - `op` is pinned to r3 so it stays caller-saved: the highest-priority
 *     global (pitch) would otherwise claim r3 and push op into a callee-saved
 *     register, shifting the whole register file.
 *   - `channel`/`slotIndex` are spelled as explicit locals so op's last read
 *     (op - 4) is sequenced before r3 is recycled for the bounce arg.
 *   - The bounce is built by recycling `opr` (`opr = 1; opr &= flags`) so
 *     agbcc emits `mov r3, #1; and r3, r7` into op's freed register instead
 *     of computing in flags' register and copying.
 */
u32 sub_080309A0(s32 op, u8 **pCmd)
{
    register s32 opr asm("r3") = op;
    register u8 **ppc asm("r6") = pCmd;
    register u8 *cmd asm("r5") = *ppc;
    u8 flags;
    u32 pitch;

    if (opr == 2) {
        u8 *bank = *(u8 **)((u8 *)gpSoundSystem + 0x110);
        u8 *desc = bank + *(u32 *)(bank + *(u32 *)(bank + 0x1c) + *(u16 *)(cmd + 2) * 4);

        if (desc[11] == 1)
            sub_0802F930(desc);

        goto advance;
    }

    if (opr <= 3)
        goto advance;

    pitch = (*(u16 *)(cmd + 6) << 16) | *(u16 *)(cmd + 4);
    flags = cmd[1];

    if (pitch != 0) {
        u8 *region = *(u8 **)((u8 *)gpSoundSystem->slot + 0x110);
        u32 scale = *(u8 *)(opr * 12 + region + 8);

        if (scale != 0)
            scale++;

        if (!(flags & 0x80)) {
            pitch = (pitch * scale) >> 7;
        } else {
            pitch -= (pitch * scale) >> 7;
        }
    }

    {
        s32 channel = opr - 4;
        u16 slotIndex = *(u16 *)(cmd + 2);

        opr = 1;
        opr &= flags;
        sub_080308B0(channel, slotIndex, pitch, opr);
    }

advance:
    *ppc += 8;
    return 1;
}
