#include "game.h"
#include "iwram.h"
#include "types.h"

/* --- sub_0802C200: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_08000764(u8 range);
extern u32 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_0800696C(void *p, s32 idx);
extern void sub_080059C4(struct Entity *p);
extern void sub_08020F3C(u8 idx);

extern void sub_0802C3E4(u8 owner, u8 group, u8 idx);
extern s32 sub_0802C5E0(u8 group, u8 idx);
extern s32 sub_0802C640(u8 group, u8 idx);

void sub_0802C200(u8 owner)
{
    register struct Entity *pool asm("r8");
    register struct Entity *base8 asm("sl");
    register u8 actor asm("r9") = owner;
    s8 j;
    s32 off;
    struct Entity *e;
    u8 r;

    for (j = 0; j <= 13; j++) {
        pool = gEntities;
        base8 = &pool[8];
        off = (j + 8) * 0x38;
        e = (struct Entity *)((char *)pool + off);

        if ((e->status & 0x08) && !(u8)sub_0800679C(&gIwram_6110, 3, 6)) {
            if (!(e->status & 0x80)) {
                r = sub_08000764(0xC8);
                e->field_32 = r + 0x32;
                e->status |= 0x80;
                *(u32 *)((char *)pool + off + 0x2c) = gGameStuff._unk00;
                continue;
            }
            if (gGameStuff._unk00 - *(u32 *)((char *)pool + off + 0x2c) <= e->field_32)
                continue;
            if (gIwram_6110.spawnMask == 0) {
                if ((u8)sub_08000764(3))
                    sub_0802C3E4(actor, 8, j);
            } else {
                sub_0802C3E4(actor, 8, j);
            }
            *(u16 *)((char *)pool + off + 0x34) &= 0xFF7F;
            sub_080059C4(&base8[j]);
            continue;
        }

        sub_0800696C(&gIwram_6110, j + 8);

        if (sub_0802C5E0(8, j)) {
            if (sub_0802C640(8, j))
                return;
            continue;
        }

        e = &gEntities[j + 8];
        if (e->field_1A > 5) {
            if (e->status & 0x8000) {
                e->status &= 0x7FFF;
                switch (e->field_1A) {
                case 6:
                    e->field_1A = 0;
                    break;
                case 7:
                    e->field_1A = 2;
                    break;
                case 8:
                    e->field_1A = 4;
                    break;
                default:
                    goto call_59c4;
                }
                e->status |= 2;
            }
        call_59c4:
            sub_080059C4(&base8[j]);
            continue;
        }
        if (e->status & 0x8000)
            e->status = (e->status & 0x7FFF) | 2;
        sub_08020F3C(j + 8);
        sub_080059C4(&base8[j]);
    }
}
#endif /* NON_MATCHING */
