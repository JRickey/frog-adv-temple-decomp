#include "gba/io.h"
#include "iwram.h"
#include "types.h"

/* --- sub_08011E40: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void sub_08011984(const u8 *records, u8 idx);
extern void sub_0800EE94(u8 layer);
extern s8 sub_08011AA4(const u8 *records);
extern u8 gIwram_6480[];
extern const u8 gBlitRecord_08306d40[];

s32 sub_08011E40(void)
{
    struct IwramAt6110 *ctrl;
    volatile DmaChannel *dma;
    u16 zero;
    u16 i;
    register s32 one asm("r8"); /* baserom holds mask const 1 in r8 */
    register s32 result asm("sl");

    result = 0;

    if (gIwram_6110.byteFlags8 != gIwram_6110.gateByte) { /* absolute → no CSE-fold of &base+0x2a */
        i = 0;
        ctrl = &gIwram_6110;
        one = 1;
        dma = &REG_DMA3;
        do {
            if (((ctrl->byteFlags8 >> i) & one) != 0 &&
                ((ctrl->byteFlags8 >> i) & one) != ((ctrl->gateByte >> i) & one)) {
                zero = 0;
                dma->src = &zero;
                dma->dst = (void *)0x0600f000;
                dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
                (void)dma->cnt;

                zero = 0;
                dma->src = &zero;
                dma->dst = (void *)0x02020000;
                dma->cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x8000;
                (void)dma->cnt;

                sub_08011984(gBlitRecord_08306d40, (u8)(i * 3));
                sub_0800EE94(2);

                *(vu16 *)0x04000050 = 0x1744;
                *(vu16 *)0x04000052 = 0x020e;

                ctrl->gateByte |= (u8)(1 << i); /* literal 1<<i; `one<<i` regresses */
                gIwram_6480[2] = (u8)i;
            }
            i++;
        } while (i <= 1);
    }

    if ((s8)sub_08011AA4(gBlitRecord_08306d40) != 0)
        result = 1;

    return result;
}
#endif /* NON_MATCHING */
