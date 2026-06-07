#include "gfx.h"
#include "macros.h"
#include "types.h"

extern void SetModeBlendRegs(void);
extern void BgScrollAnim_Update(void);
extern void DmaJob_Advance(struct TransferDesc desc, u8 mode, void *buf);
extern void ScaleAnim_SyncSelectors(void);
extern void FrogStatusBar_Update(void);

void ScaleAnim_UpdateFrame(void)
{
    u8 state;
    u8 *statePtr;

    statePtr = (u8 *)0x03003610;
    state = *statePtr;

    switch (state) {
    case 0:
        *statePtr = 1;
        break;
    case 1: {
        struct TransferDesc *desc0;

        SetModeBlendRegs();
        BgScrollAnim_Update();
        desc0 = (struct TransferDesc *)0x08306f08;
        DmaJob_Advance(*desc0, ((u8 *)desc0)[2], (void *)0x030064c0);
        break;
    }
    }

    {
        struct TransferDesc *desc1 = (struct TransferDesc *)0x08306f50;

        DmaJob_Advance(*desc1, ((u8 *)desc1)[2], (void *)0x03006580);
    }

    ScaleAnim_SyncSelectors();
    FrogStatusBar_Update();
}
