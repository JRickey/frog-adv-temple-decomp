#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void Frog_UpdateContactHitboxes(void);

/* agbcc register layout: mode stays in r4 throughout; cases 20/21 load
 * the base pointer into r5; case 22 repurposes r4 (mode is no longer
 * needed) for the base pointer. The register pin forces that split. */
void Frog_ProcessTileContact(u8 mode)
{
    u8 *base;

    if (mode == 20) {
        base = (u8 *)0x03006110;
        if (ModeControl_GetFlag(base, 5, 0) == 0) {
            CtrlFlags_SetBit(base, 5, 0);
            Frog_UpdateContactHitboxes();
        }
    }

    if (mode == 21) {
        base = (u8 *)0x03006110;
        if (ModeControl_GetFlag(base, 5, 1) == 0) {
            CtrlFlags_SetBit(base, 5, 1);
            Frog_UpdateContactHitboxes();
        }
    }

    if (mode == 22) {
        u8 *base4 = (u8 *)0x03006110;
        if (ModeControl_GetFlag(base4, 5, 3) != 0) {
            if (ModeControl_GetFlag(base4, 5, 2) == 0) {
                CtrlFlags_SetBit(base4, 5, 2);
                Frog_UpdateContactHitboxes();
            }
        }
    }
}

/* agbcc register layout: case 20 loads base into r5; case 21 loads base
 * into r4 (r5 is still live from the previous block). The register pin for
 * case 21 forces agbcc to use r4 instead of spilling to r5. */
void UpdateSceneGate(u8 mode)
{
    if (mode == 20) {
        u8 *base = (u8 *)0x03006110;
        if (ModeControl_GetFlag(base, 5, 0) == 0) {
            CtrlFlags_SetBit(base, 5, 0);
        }
    }

    if (mode == 21) {
        u8 *base4 = (u8 *)0x03006110;
        if (ModeControl_GetFlag(base4, 5, 0) != 0) {
            if (ModeControl_GetFlag(base4, 5, 1) == 0) {
                CtrlFlags_SetBit(base4, 5, 1);
            }
        }
    }
}
