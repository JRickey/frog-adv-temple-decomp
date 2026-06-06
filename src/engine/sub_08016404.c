#include "macros.h"
#include "types.h"

/* --- UpdateColumnClipSpans: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "macros.h"
#include "types.h"
#include "game.h"
#include "gba/dma.h"

typedef struct {
    u16 lo;
    u16 hi;
    u8 unk4;
    u8 unk5;
    u8 _pad6[2];
    u32 lastTick;
    u8 tickDelta;
    u8 _pad13[3];
} ClipSpan;

typedef struct {
    u16 start;
    u16 end;
    u16 _pad4;
    u16 _pad6;
} ColumnRange;

typedef struct {
    u16 left;
    u16 top;
    u16 _pad4;
    u16 _pad6;
} ViewBounds;

typedef struct {
    u8 _pad0[8];
    s32 viewX;
} ViewState;

#define gViewState       ((ViewState *)0x030060A0)
#define gViewBounds      ((ViewBounds *)0x0830696C)
#define gFixedClipSpans  ((ClipSpan *)0x030063C0)
#define gColumnClipSpans ((ClipSpan *)0x03006360)

void UpdateColumnClipSpans(ColumnRange *columns, u8 count)
{
    vu16 fill;
    u8 *active;
    s32 viewX;
    s32 loWide;
    s32 hiWide;
    ViewState *viewState;
    u16 lo;
    u16 hi;
    u16 spanLo;
    u16 spanHi;
    ViewBounds *bounds;
    ClipSpan *fixed;
    u8 i;

    {
        u16 *clear = (u16 *)0x030065D0;
        u8 zero = 0;
        clear[1] = 0;
        clear[0] = 0;
        active = (u8 *)0x03003608;
        active[5] = zero;
    }

    /* Wide form: keep loWide held so lo, spanLo, hiWide, spanHi all CSE off the
       single `viewX<<16`. Using viewX (not a separate camera) for the shared
       value gives the 366 base. */
    viewX = gViewState->viewX - 0x30;
    loWide = viewX << 16;
    lo = (u16)((u32)loWide >> 16);
    hiWide = loWide + (0x100 << 16);
    hi = (u16)((u32)hiWide >> 16);

    {
        ViewBounds *viewBounds = gViewBounds;
        if (lo >= viewBounds[0].top)
            goto reset_columns;
        if (hi <= viewBounds[1].left)
            goto reset_columns;
    }

    fill = 0;
    REG_DMA3.src = (void *)&fill;
    REG_DMA3.dst = (void *)0x030053A0;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x50;
    (void)REG_DMA3.cnt;

    fill = 0;
    REG_DMA3.src = (void *)&fill;
    REG_DMA3.dst = (void *)0x03003610;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x50;
    (void)REG_DMA3.cnt;

    active[5] = 1;
    active[4] = 1;

    spanLo = (u16)((u32)loWide >> 19);
    spanHi = (u16)((u32)hiWide >> 19);
    bounds = gViewBounds;
    fixed = gFixedClipSpans;

    for (i = 0; i <= 1; i++) {
        if (spanLo < (u16)(bounds[i].left >> 3))
            fixed[i].lo = (((s32)(u16)bounds[i].left - lo) >> 3) + 1;
        else
            fixed[i].lo = 0;

        if (spanHi < (u16)(bounds[i].top >> 3)) {
            fixed[i].hi = 31;
        } else {
            fixed[i].hi = ((s32)(u16)bounds[i].top - lo) >> 3;
            if ((s16)fixed[i].hi > 31)
                fixed[i].hi = 31;
        }
    }

    viewState = gViewState;
    for (i = 0; i < count; i++) {
        u8 *buffer;
        s32 elapsed;
        u16 j;

        viewX = viewState->viewX;
        if (viewX >= (u16)columns[i].end)
            continue;
        if (viewX + 0x100 <= (u16)columns[i].start)
            continue;

        if (viewX > (u16)columns[i].start)
            gColumnClipSpans[i].lo = 0;
        else
            gColumnClipSpans[i].lo = columns[i].start - viewX;

        viewX = viewState->viewX;
        if (viewX + 0x100 < (u16)columns[i].end)
            gColumnClipSpans[i].hi = 255;
        else
            gColumnClipSpans[i].hi = columns[i].end - viewX;

        elapsed = gGameStuff._unk00 - gColumnClipSpans[i].lastTick;
        if (elapsed >= gColumnClipSpans[i].tickDelta) {
            gColumnClipSpans[i].lastTick = gGameStuff._unk00;
            if (gColumnClipSpans[i].unk5 == 0)
                gColumnClipSpans[i].unk4++;
            else
                gColumnClipSpans[i].unk4--;
        }

        for (j = gColumnClipSpans[i].lo; j < (s16)gColumnClipSpans[i].hi; j++) {
            if (gColumnClipSpans[i].unk5 & 0x10)
                buffer = (u8 *)0x03003610;
            else
                buffer = (u8 *)0x030053A0;
            buffer[j] = gColumnClipSpans[i].unk4;
        }
    }

reset_columns:
    fill = 0;
    REG_DMA3.src = (void *)&fill;
    REG_DMA3.dst = (void *)0x03005440;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x30;
    (void)REG_DMA3.cnt;

    fill = 0;
    REG_DMA3.src = (void *)&fill;
    REG_DMA3.dst = (void *)0x030036B0;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x30;
    (void)REG_DMA3.cnt;
}
#else
NAKED void UpdateColumnClipSpans(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x16404, 0x24c\n");
}
#endif /* NON_MATCHING */
