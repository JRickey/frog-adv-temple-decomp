#include "macros.h"
#include "sound.h"
#include "iwram.h"
#include "types.h"

/* --- Entity10_UpdateStatus: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "iwram.h"
#include "types.h"

extern void Entity_AdvanceAnimFrames(s32 first, s32 last);

void Entity10_UpdateStatus(void)
{
    u8 *base;
    u32 off;

    base = (u8 *)gEntities;
    off = 0x24a;
    if (base[off] == 3) {
        off++;
        if (base[off] == 2 || base[off] == 6 || base[off] == 10) {
            u16 *s = (u16 *)(base + 0x264);
            if (*s & 0x200) {
                Sound_Play(43);
                *s &= 0xfdff;
            }
        } else {
            u16 *s = (u16 *)(base + 0x264);
            u16 t = *s;
            t |= 0x200;
            *s = t;
        }

        {
            u8 *b = (u8 *)gEntities;
            u16 *st10 = (u16 *)(b + 0x264);
            u16 v = *st10;
            u16 moved = 2;
            if (!(v & moved) && (v & 0x8000)) {
                b[0x24a] = 5;
                v |= moved;
                b[0x282] = 6;
                *(u16 *)(b + 0x29c) |= moved;
                v &= 0x7fff;
                *st10 = v;
            }
        }
    } else {
        u16 *s10 = (u16 *)(base + 0x264);
        u16 t10 = *s10;
        if (t10 & 0x8000) {
            t10 |= 2;
            *s10 = t10 & 0x7fff;
        }
        {
            u16 *s11 = (u16 *)(base + 0x29c);
            u16 t11 = *s11;
            if (t11 & 0x8000) {
                t11 |= 2;
                *s11 = t11 & 0x7fff;
            }
        }
    }

    Entity_AdvanceAnimFrames(10, 11);
}
#else
NAKED void Entity10_UpdateStatus(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x2a8fc, 0x100\n");
}
#endif /* NON_MATCHING */
