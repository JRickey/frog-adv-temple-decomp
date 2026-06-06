#include "gba/dma.h"
#include "iwram.h"
#include "types.h"

extern void Credits_DmaLoadTiles(u8 arg);
extern u32 Sound_Play(u32 sound);

void Credits_InitStateA(u8 arg)
{
    u8 *state;
    u32 tableBase;
    register u8 b1 asm("r5");
    const u32 *const *entryPtr;
    const u32 *base;
    register u32 sum asm("r2");
    u8 byteZero;
    u16 halfZero;
    vu16 fill;
    vu32 *dma;

    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600FBC2;
    *(u32 *)(state + 36) = 0x0600FBC2 + 0x80;

    tableBase = 0x080C1254;
    asm volatile("" : "+r"(tableBase));
    entryPtr = (const u32 *const *)(gIwram_34B0._data * 24 + tableBase);

    {
        register const u8 *p asm("r2") = (const u8 *)0x03003540;
        tableBase = p[12];
        b1 = p[1];
        asm volatile("" : "+r"(p));
    }
    sum = tableBase + b1;
    base = entryPtr[0];
    sum = (sum << 2) + (u32)base;
    *(u32 *)(state + 12) = *(const u32 *)(sum + 0x38);

    byteZero = 0;
    halfZero = 0;
    asm volatile("" : "+r"(byteZero), "+r"(halfZero));
    state[8] = byteZero;
    *(u16 *)(state + 44) = halfZero;
    *(u16 *)(state + 48) = halfZero;
    *(u16 *)(state + 50) = halfZero;
    state[11] = 8;

    fill = halfZero;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&fill;
    dma[1] = 0x0600F800;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)dma[2];

    Credits_DmaLoadTiles(arg);
    Sound_Play(*(const u32 *)0x081BDA70);
}

void Credits_InitStateB(u8 a0)
{
    /* plain local for arg: agbcc allocates to r4 with 3-insn zero-extend
     * (adds r4,r0,#0; lsls r4,r4,#24; lsrs r4,r4,#24) rather than
     * the 2-insn form that register u8 arg asm("r4") = a0 would emit */
    u8 arg;
    u8 *state;
    register u8 b1 asm("r5");
    const u32 *const *entryPtr;
    const u32 *base;
    register u32 sum asm("r1");
    u8 byteZero;
    u16 halfZero;
    vu16 fill;
    vu32 *dma;

    arg = a0;
    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600F84C;
    *(u32 *)(state + 36) = 0x0600F84C + 0x80;

    {
        u32 tableBase = 0x080C1254;
        asm volatile("" : "+r"(tableBase));
        entryPtr = (const u32 *const *)(gIwram_34B0._data * 24 + tableBase);
    }

    {
        register const u8 *p asm("r1") = (const u8 *)0x03003540;
        u32 b2 = p[12];
        b1 = p[1];
        asm volatile("" : "+r"(p));
        sum = b2 + b1;
    }
    base = entryPtr[0];
    sum = (sum << 2) + (u32)base;
    *(u32 *)(state + 12) = *(const u32 *)(sum + 0x38);

    byteZero = 0;
    halfZero = 0;
    asm volatile("" : "+r"(byteZero), "+r"(halfZero));
    state[8] = byteZero;
    *(u16 *)(state + 44) = halfZero;
    *(u16 *)(state + 48) = halfZero;
    *(u16 *)(state + 50) = halfZero;
    state[11] = 8;

    fill = halfZero;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&fill;
    dma[1] = 0x0600FBC0;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)dma[2];

    Credits_DmaLoadTiles(arg);
    {
        const u32 *tbl;
        u32 idx;
        /* barrier keeps tbl load before idx computation so agbcc emits
         * adds r4,#1; lsls r4,r4,#2 rather than folding +1 into the
         * pool address and using ldr r0,[r4,#4] */
        tbl = (const u32 *)0x081BDA70;
        asm volatile("" : "+r"(tbl));
        idx = (u32)arg + 1;
        Sound_Play(tbl[idx]);
    }
}

/* --- Credits_RunScript: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
extern u16 Input_Poll(void);
extern void Credits_InitStateB(u8 arg);

extern const u8 sCreditsTilemapEng[];
extern u16 gIwram_5398;

/* opcodes in the credits-roll tilemap script (state->pc points into the stream) */
#define CREDIT_OP_LITERAL_RUN 0xFFFD /* operand indexes sCreditsTilemapEng, 3 halfwords/glyph */
#define CREDIT_OP_WAIT_A      0xFFFC /* clear input, wait, dispatch a row builder */
#define CREDIT_OP_WAIT_B      0xFFFE /* wait for input in place */
#define CREDIT_OP_END         0xFFFF /* end of script: flip pages, wait, clear */

#define CREDIT_TILE_PROMPT    0xE0E4 /* flashing "press button" prompt tile */
#define CREDIT_GLYPH_BASE     0xE0E7 /* operand - this = glyph index into the tilemap */

#define CREDIT_KEY_UP         16
#define CREDIT_KEY_RIGHT      32

struct CreditsState {
    u8 _pad00[12];
    const u16 *pc; /* +0x0C: script cursor into sCreditsTilemapEng */
    u8 _pad10[4];
    u16 *front; /* +0x14: front BG double-buffer */
    u8 _pad18[28];
    u16 *back; /* +0x24: back BG double-buffer */
    u8 _pad28[4];
    u16 cursor;  /* +0x30: column within the current row */
    u16 swapped; /* +0x32: page-flip latch */
};

u8 Credits_RunScript(u8 a0)
{
    register u8 arg asm("r8");
    register vu16 *in asm("r9");
    struct CreditsState *state;
    const u16 *op;
    const u16 *table;
    u32 frameStart;
    u32 flash;
    u16 input;
    u16 *oldFront;
    u16 *oldBack;
    vu16 wait;
    vu32 *dma;

    arg = a0;
    state = (struct CreditsState *)0x03006440;
    in = &gIwram_5398;
    if (*state->pc == CREDIT_OP_END)
        goto end_script;

loop:
    op = state->pc;
    if (*op == CREDIT_OP_WAIT_B) {
        frameStart = 0;
        flash = 0;
        input = *in;
        if (input == CREDIT_KEY_UP)
            goto exit_fe;
        if (input == CREDIT_KEY_RIGHT)
            goto exit_fe;
        state = (struct CreditsState *)0x03006440;
        in = &gIwram_5398;
        do {
            while (gGameStuff._unk00 - frameStart > 3) {
                if (flash != 0)
                    *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
                else
                    *(u16 *)((u8 *)state->front + 108) = (u16)flash;
                flash = (flash != 0) ? 0 : 1;
                frameStart = gGameStuff._unk00;
                *in = Input_Poll();
            }
            input = *in;
            if (input == CREDIT_KEY_UP)
                goto exit_fe;
        } while (input != CREDIT_KEY_RIGHT);
        goto exit_fe;
    }

    if (*op == CREDIT_OP_WAIT_A) {
        *in = 0;
        frameStart = 0;
        flash = 0;
        state = (struct CreditsState *)0x03006440;
        in = &gIwram_5398;
        for (;;) {
            while (gGameStuff._unk00 - frameStart > 3) {
                if (flash != 0)
                    *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
                else
                    *(u16 *)((u8 *)state->front + 108) = (u16)flash;
                flash = (flash != 0) ? 0 : 1;
                frameStart = gGameStuff._unk00;
                *in = Input_Poll();
            }
            input = *in;
            if (input == CREDIT_KEY_UP)
                break;
            if (input == CREDIT_KEY_RIGHT)
                break;
        }
        if (input == CREDIT_KEY_RIGHT)
            goto exit_fe;

        if (*(u32 *)0x03003544 == 0) {
            *(u32 *)0x03003544 = 1;
            (*(u8 *)0x03003541)++;
            Credits_InitStateA(arg);
        } else {
            *(u32 *)0x03003544 = 0;
            (*(u8 *)0x03003541)++;
            Credits_InitStateB(arg);
        }
        goto after_dispatch;
    }

    if (*op == CREDIT_OP_LITERAL_RUN) {
        u32 glyph;

        table = (const u16 *)sCreditsTilemapEng;
        state->pc = op + 1;
        glyph = (u16)(op[1] - CREDIT_GLYPH_BASE);
        *(u16 *)((u8 *)state->front + state->cursor * 2) = table[glyph * 3 + 1];
        *(u16 *)((u8 *)state->front + state->cursor * 2 + 64) = table[glyph * 3 + 2];
        state->pc = op + 2;
    } else {
        *(u16 *)((u8 *)state->front + state->cursor * 2) = 0;
        *(u16 *)((u8 *)state->front + state->cursor * 2 + 64) = *op;
        state->pc = op + 1;
    }

    state->cursor++;
    if (*state->pc != CREDIT_OP_END)
        goto loop;

after_dispatch:
    state = (struct CreditsState *)0x03006440;
    if (*state->pc != CREDIT_OP_END)
        goto bump_pc;

end_script:
    state->cursor = 0;
    if (state->swapped == 0) {
        state->swapped = 1;
        oldBack = state->back;
        state->back = state->front;
        state->front = oldBack;
        goto bump_pc;
    }

    frameStart = 0;
    flash = 0;
    in = &gIwram_5398;
    input = *in;
    if (input == CREDIT_KEY_UP)
        goto do_swap;
    if (input == CREDIT_KEY_RIGHT)
        goto do_swap;
    do {
        while (gGameStuff._unk00 - frameStart > 3) {
            if (flash != 0)
                *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
            else
                *(u16 *)((u8 *)state->front + 108) = (u16)flash;
            flash = (flash != 0) ? 0 : 1;
            frameStart = gGameStuff._unk00;
            *in = Input_Poll();
        }
        input = *in;
        in = &gIwram_5398;
        if (input == CREDIT_KEY_RIGHT)
            goto exit_fe;
        if (input == CREDIT_KEY_UP)
            goto do_swap;
    } while (input != CREDIT_KEY_RIGHT);

do_swap:
    state = (struct CreditsState *)0x03006440;
    state->swapped = 0;
    oldBack = state->back;
    oldFront = state->front;
    state->back = oldFront;
    state->front = oldBack;

    wait = 0;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&wait;
    dma[1] = (u32)oldFront;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)((u8 *)oldFront + 64);
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)oldBack;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)((u8 *)oldBack + 64);
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

bump_pc:
    state->pc++;
    *in = 0;
    return 0;

exit_fe:
    *in = 0;
    return 0xFE;
}

void sub_0801B098(u8 arg)
{
    gGameStuff.mode = arg + 8;
}
#endif /* NON_MATCHING */
