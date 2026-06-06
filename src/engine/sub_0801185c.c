#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern int __modsi3(int num, int den);

/* VCOUNT-seeded "pick a value in [0, range)" helper: scrambles the current
 * scanline with an LCG-style multiply-add, then folds it modulo `range`. */
u8 GetVcountRandom(u8 range)
{
    return (u8)__modsi3((u8)REG_VCOUNT * 107 + 7, range);
}

typedef struct AnimDesc {
    u8 state;
    u8 _pad01[3];
    u32 field_04;
    u32 field_08;
    u8 maxFrames;
    u8 _pad0d;
    s16 field_0e;
    u8 _pad10[4];
    u32 field_14;
} AnimDesc;

extern const AnimDesc sAnimDesc_6e08;
extern const AnimDesc sAnimDesc_6e28;

extern void InitScrollAnimSequence(u32, u32, u32, u32, s32);
extern void UpdateScrollFromAnimChannels(void);

u32 Anim_CheckScreenIdle(void)
{
    u32 result;

    result = 0;
    InitScrollAnimSequence(sAnimDesc_6e08.field_04, sAnimDesc_6e08.field_14, sAnimDesc_6e28.field_04,
                           sAnimDesc_6e28.field_04, sAnimDesc_6e28.field_0e);
    UpdateScrollFromAnimChannels();

    if (gIwram_6150._field_04 != 0)
        goto done;
    if (gIwram_5360._field_04 != 0)
        goto done;
    if (gIwram_5360._field_0e != 0)
        goto done;

    result = 1;
done:
    return result;
}

extern void CharLayers_Upload(u8 arg);
extern void Selector_InitState(void);
extern void FrogOam_Init(void);
extern void Scroll_UpdateCamera(u8 arg);
extern void BgScrollBlit(u8 arg);
extern void StatusBar_Update(void);
extern void Selector_BlitStateMachine(u32 arg);
extern void FrogStatusBar_Update(void);
extern void Selector_StepScrollAxes(s32 a, s32 b, s32 c, s32 d);

struct IwramAt60A0_sub1190C {
    u8 _pad00[12];
    s32 field_c;
    s32 field_10;
    u8 _pad14[24];
    s32 field_2c;
    s32 field_30;
};

struct IwramAt6480_sub1190C {
    u8 _pad00[46];
    s16 field_2e;
    u8 _pad30[6];
    s16 field_36;
};

struct IwramAt6540_sub1190C {
    u8 _pad00[9];
    u8 field_9;
    u8 _pad0a[34];
    s16 field_2c;
    u8 _pad2e[6];
    s16 field_34;
};

extern struct IwramAt60A0_sub1190C gIwram_60A0;
extern struct IwramAt6480_sub1190C gIwram_6480;
extern struct IwramAt6540_sub1190C gIwram_6540;

void Selector_InitScene(void)
{
    CharLayers_Upload(2);
    Selector_InitState();
    FrogOam_Init();
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}

void Selector_Update(void)
{
    Selector_BlitStateMachine(4);
    FrogStatusBar_Update();
}

u32 Selector_StepScroll(void)
{
    u32 result;
    s32 x;
    s32 y;

    result = 0;
    Selector_StepScrollAxes(-24, 2, -72, 2);
    x = gIwram_60A0.field_c + gIwram_6540.field_2c;
    gIwram_60A0.field_c = x;
    y = gIwram_60A0.field_10 + gIwram_6480.field_2e;
    gIwram_60A0.field_10 = y;
    gIwram_60A0.field_2c = x;
    gIwram_60A0.field_30 = y;

    if (gIwram_6480.field_36 == -72)
        gIwram_6540.field_9 = 3;

    if (gIwram_6540.field_34 == -24)
        result = 1;

    return result;
}

void Selector_VblankTick(void)
{
    FrogStatusBar_Update();
}

/* --- Selector_BlitTiles: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
struct IwramAt60A0_sub1190C {
    u8 _pad00[12];
    s32 field_c;
    s32 field_10;
    u8 _pad14[6];
    u16 field_1a;
    u8 _pad1c[16];
    s32 field_2c;
    s32 field_30;
};
struct IwramAt6480_sub1190C {
    u8 field_0;
    u8 _pad01[7];
    u8 field_8;
    u8 field_9;
    u8 _pad0a;
    u8 field_b;
    u8 _pad0c[4];
    u32 field_10;
    u8 _pad14[4];
    u32 field_18;
    u8 _pad1c[16];
    u16 field_2c;
    s16 field_2e; /* field_2e MUST stay s16 (Selector_StepScroll) */
    u16 field_30;
    u16 field_32;
    u16 field_34;
    s16 field_36; /* field_36 MUST stay s16 (Selector_StepScroll) */
};
struct IwramAt6540_sub1190C {
    u8 field_0;
    u8 _pad01[8];
    u8 field_9;
    u8 field_a;
    u8 field_b;
    u8 _pad0c[4];
    u32 field_10;
    u8 _pad14[24];
    s16 field_2c;
    u16 field_2e; /* field_2c MUST stay s16 (Selector_StepScroll) */
    u16 field_30;
    u16 field_32;
    s16 field_34; /* field_34 MUST stay s16 (Selector_StepScroll) */
};

struct Unk11984Elem {
    u16 field_0;
    u16 field_2;
    u16 field_4;
    u16 field_6;
    u8 _pad08[4];
    u8 field_c;
    u8 _pad0d[3];
    u32 field_10;
    u8 _pad14[8];
};

extern void ScaleAnim_BlitFrameToVram(u8 rows, u8 cols, u16 dstX, u16 dstY, u32 bank, u32 src, u32 vram);

void Selector_BlitTiles(struct Unk11984Elem *elems, u8 idx)
{
    u32 idx8;
    u32 ofs;
    u16 *src;
    u16 *dst;
    u32 x;
    u32 y;
    u32 width;
    u32 height;

    gIwram_6540.field_0 = 1;
    gIwram_6540.field_a = 0;
    gIwram_6540.field_30 = elems[idx].field_4;
    gIwram_6540.field_32 = elems[idx].field_6;
    gIwram_6540.field_2c = elems[idx].field_4;
    gIwram_6540.field_2e = elems[idx].field_6;
    gIwram_6540.field_b = elems[idx].field_c;
    gIwram_6540.field_10 = elems[idx].field_10;

    gIwram_6480.field_0 = 1;
    gIwram_6480.field_9 = 1;
    gIwram_6480.field_36 = elems[idx + 1].field_2;
    gIwram_6480.field_34 = elems[idx + 1].field_0;
    src = (u16 *)elems[idx + 1].field_10;
    gIwram_6480.field_10 = (u32)src;
    gIwram_6480.field_8 = 2;
    gIwram_6480.field_18 = 0x02020000;
    gIwram_6480.field_b = elems[idx + 1].field_c;
    gIwram_6480.field_30 = elems[idx + 1].field_4;
    gIwram_6480.field_32 = elems[1].field_6;
    gIwram_6480.field_2c = elems[idx + 1].field_4;
    gIwram_6480.field_2e = elems[idx + 1].field_6;

    /* lever #1: the `ofs` temp (multiply-first) lengthens the 60A0/dst base pseudo
     * to len 36, dropping its allocno priority below idx's -> idx wins ip, elems->r9 */
    ofs = gIwram_60A0.field_1a * elems[idx + 1].field_2 + elems[idx + 1].field_0;
    dst = (u16 *)0x02020000 + ofs;
    gIwram_6480.field_18 = (u32)dst;

    idx8 = idx << 3;
    height = gIwram_6540.field_32;
    width = gIwram_6540.field_30;
    y = 0;
    while (y < height) {
        x = 0;
        while (x < width) {
            *dst++ = *src++;
            x = (u16)(x + 1);
        }
        dst += gIwram_60A0.field_1a - width;
        y = (u16)(y + 1);
    }

    ScaleAnim_BlitFrameToVram((u8)gIwram_6540.field_32, (u8)gIwram_6540.field_30, gIwram_6480.field_34,
                              gIwram_6480.field_36, 2,
                              ((struct Unk11984Elem *)((u8 *)elems + ((idx8 - idx) << 2)))->field_10, 0x0600F000);
}
#endif /* NON_MATCHING */
