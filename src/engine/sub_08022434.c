#include "iwram.h"
#include "types.h"

/* --- sub_08022434: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "iwram.h"
#include "types.h"

extern u32 sub_08020CDC(struct Entity *entity, u32 sound, u8 halfW, u8 halfH);
extern void sub_08020F3C(u8 idx);
extern void sub_080059C4(void *p);
extern void sub_08020FE4(s32 a, s32 b);
extern void sub_08005D10(s32 a, s32 b);

void sub_08022434(void)
{
    u8 i;
    struct Entity *slot;
    s16 y;
    s32 k;
    s32 resetY;

    if (gEntities[0].x <= 154)
        return;
    {
        /* pin y to r1 so k(0x26f) takes r0 and flows to 0x2ef->sl (baserom order) */
        register s32 yg asm("r1") = gEntities[0].y;
        if (yg <= 0x26f)
            return;
    }

    k = 0x26f;
    for (i = 0; i < 2; i++) {
        /* loop-top hoist: agbcc keeps 0x2ef in sl via `adds r0,#0x80` reuse */
        resetY = k + 0x80;
        slot = &gEntities[69 + i];

        if (slot->y == 0x2f5 || slot->y == 0x30d || slot->y == 0x325 || slot->y == 0x33d || slot->y == 0x355 ||
            slot->y == 0x36d)
            sub_08020CDC(slot, 14, 3, 3);

        switch (slot->field_1A) {
        case 0:
            if (slot->status & 2)
                break;
            y = slot->y;
            if (y > 0x311) {
                slot->field_17 = 2;
                slot->field_06 = 2;
            }
            if ((slot->y - 767) % 24 == 13) {
                slot->field_1A = (slot->field_1A != 1);
                slot->status |= 2;
            }
            if (y > 0x375) {
                gEntities[69].x = 0x143;
                gEntities[70].x = 0x15b;
                slot->field_1A = 2;
                slot->status |= 2;
            }
            if (slot->status & 0x8000) {
                slot->status |= 2;
                gEntities[69 + i].status &= 0x7fff;
            }
            break;
        case 1:
            if (slot->status & 2)
                break;
            y = slot->y;
            if (y > 0x311) {
                slot->field_17 = 2;
                slot->field_06 = 2;
            }
            if ((slot->y - 767) % 24 == 0) {
                slot->field_1A = (slot->field_1A != 1);
                slot->status |= 2;
            }
            if (y > 0x376) {
                gEntities[69].x = 0x143;
                gEntities[70].x = 0x15b;
                slot->field_1A = 2;
                slot->status |= 2;
            }
            if (slot->status & 0x8000) {
                slot->status |= 2;
                gEntities[69 + i].status &= 0x7fff;
            }
            break;
        case 2:
            if (slot->status & 2)
                break;
            if (gEntities[69].y == resetY && gEntities[70].y > 0x339) {
                gEntities[69].field_1A = 1;
                gEntities[69].status |= 2;
            }
            if (gEntities[70].y == resetY && gEntities[69].y > 0x339) {
                gEntities[70].field_1A = 1;
                gEntities[70].status |= 2;
            }
            if (slot->field_1B == 1)
                sub_08020CDC(slot, 14, 3, 3);
            if (slot->status & 0x8000) {
                slot->y = resetY;
                slot->field_06 = 4;
                slot->field_17 = 3;
            }
            break;
        }
    }

    if (gEntities[69].field_1A == 2) {
        sub_08020F3C(70);
        sub_080059C4(&gEntities[69]);
        sub_080059C4(&gEntities[70]);
    } else if (gEntities[70].field_1A == 2) {
        sub_08020F3C(69);
        sub_080059C4(&gEntities[69]);
        sub_080059C4(&gEntities[70]);
    } else {
        sub_08020FE4(69, 70);
        sub_08005D10(69, 70);
    }
}
#endif /* NON_MATCHING */
