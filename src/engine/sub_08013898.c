#include "macros.h"
#include "types.h"

struct TransferDesc {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

extern void sub_0800E7D4(void);
extern void sub_08012CAC(void);
extern void sub_08013C60(struct TransferDesc desc, u8 mode, void *buf);
extern void sub_0801310C(void);
extern void sub_08017000(void);

void sub_08013898(void)
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

        sub_0800E7D4();
        sub_08012CAC();
        desc0 = (struct TransferDesc *)0x08306f08;
        sub_08013C60(*desc0, ((u8 *)desc0)[2], (void *)0x030064c0);
        break;
    }
    }

    {
        struct TransferDesc *desc1 = (struct TransferDesc *)0x08306f50;

        sub_08013C60(*desc1, ((u8 *)desc1)[2], (void *)0x03006580);
    }

    sub_0801310C();
    sub_08017000();
}
