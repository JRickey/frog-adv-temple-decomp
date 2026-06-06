#include "sound.h"

extern void SoundIrqDisable(void);
extern void SoundIrqEnable(void);

void SoundSystem_SetPanParams(u16 a, u16 b, u16 c)
{
    /* c in r8 so params a/b/c fit in r6/r7/r8 with r4=pSys, r5=mask free */
    u16 cReg = c;
    /* mask in r5 so release path uses `ands r0, r5` (not lsls/lsrs) */
    register u32 mask asm("r5");
    SoundSystem **pSys;
    SoundSystem *ss;

    pSys = &gpSoundSystem;
    {
        /* v in r1 so acquire check uses `lsls r1, r1, #24` in-place */
        s32 v;
        v = (*pSys)->lockRefCount + 1;
        (*pSys)->lockRefCount = v;
        mask = 0xff;
        if ((u8)v == 1)
            SoundIrqDisable();
    }

    ss = *pSys;
    {
        /* offsets computed as 0x84<<1, 0x84<<1+2, 0x84<<1+4 to match
         * the target's `movs r2, #0x84; lsls r2, r2, #1; adds r0, r1, r2` pattern */
        u16 *p = (u16 *)((u8 *)ss + 0x108);
        *p = a;
        p = (u16 *)((u8 *)ss + 0x10a);
        *p = b;
        p = (u16 *)((u8 *)ss + 0x10c);
        *p = cReg;
    }

    {
        s32 v2 = ss->lockRefCount - 1;
        ss->lockRefCount = v2;
        v2 &= mask;
        if (v2 == 0)
            SoundIrqEnable();
    }
}
