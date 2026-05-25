#include "types.h"

/* IWRAM globals touched by sub_08033910. The function takes a timer index
 * (0..3) and an out-pointer; it stashes the index, computes the matching
 * REG_TMxCNT_L address, and writes a ROM-resident IRQ-handler pointer
 * (0x080338ed, Thumb) into the caller's slot.
 *
 * Purpose is most likely "register an IRQ handler for one of the four
 * hardware timers" — sub_08000820 calls it with idx=3 (TM3), passing a
 * slot inside the IRQ-vector lookup table at 0x08035DB4.
 *
 * Both addresses appear only in this function so far; names are
 * placeholders until more of the IRQ subsystem is identified.
 */
#define gTimerIrqIndex  (*(u8 *)0x03003430)
#define gTimerIrqCntPtr (*(vu32 **)0x03003438)

#define REG_TM0CNT_L    0x04000100

u32 sub_08033910(u8 idx, void *out)
{
    if (idx > 3) {
        return 1;
    }
    gTimerIrqIndex = idx;
    gTimerIrqCntPtr = (vu32 *)(REG_TM0CNT_L + gTimerIrqIndex * 4);
    *(u32 *)out = 0x080338ed;
    return 0;
}
