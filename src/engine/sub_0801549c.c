#include "macros.h"
#include "types.h"
#include "iwram.h"
#include "game.h"
#include "gba/dma.h"

struct DmaJob_1549C {
    u16 count;
    u16 _hw02;
    const void *const *frames;
    void *dest;
    u16 xferCount;
    u16 _hw0E;
};

struct SceneState_1549C {
    u8 state;
    u8 _pad01[5];
    u8 frame;
};

struct Queue_1549C {
    u8 _field_00;
    u8 _pad01[3];
    u32 _seed;
};

extern struct SceneState_1549C gIwram_3610;
extern struct Queue_1549C gIwram_64C0;
extern struct Queue_1549C gIwram_6580;
extern const struct DmaJob_1549C gDmaJob_08307D98;
extern const struct DmaJob_1549C gDmaJobTable_08307DA8[];

extern void sub_08012CAC(void);
extern u32 sub_08013C60(struct DmaJob_1549C job, u8 mode, struct Queue_1549C *queue);
extern u32 sub_08011884(void);

void sub_0801549C(void)
{
    const struct DmaJob_1549C *job;

    switch (gIwram_3610.state) {
    case 0: {
        /* r0 table anchor makes case 0 load 0x08307da8 before reading the cached state byte. */
        const struct DmaJob_1549C *table;
        /* r3 offset anchor fixes the final add operand order: `adds r3, r3, r0`. */
        register u32 offset asm("r3");

        table = gDmaJobTable_08307DA8;
        offset = gIwram_3610.state << 4;
        job = (const struct DmaJob_1549C *)(offset + (u32)table);
        goto transfer_64c0;
    }
    case 1:
        sub_08012CAC();
        goto reload_transfer_64c0;
    case 2:
        job = &gDmaJob_08307D98;
        sub_08013C60(*job, ((const u8 *)job)[2], (struct Queue_1549C *)0x03006580);
    reload_transfer_64c0: {
        /* r1 table anchor keeps the reload path as `ldr r1, table; ldr r0, state`. */
        const struct DmaJob_1549C *table;
        /* r3 offset anchor fixes the final add operand order: `adds r3, r3, r1`. */
        register u32 offset asm("r3");

        table = gDmaJobTable_08307DA8;
        offset = gIwram_3610.state << 4;
        job = (const struct DmaJob_1549C *)(offset + (u32)table);
    }
    transfer_64c0:
        sub_08013C60(*job, ((const u8 *)job)[2], &gIwram_64C0);
        break;
    case 3: {
        /* r0 table anchor gives case 3 the baserom's table-load before state-load order. */
        const struct DmaJob_1549C *table;
        /* r3 offset anchor fixes the final add operand order: `adds r3, r3, r0`. */
        register u32 offset asm("r3");

        table = gDmaJobTable_08307DA8;
        offset = gIwram_3610.state << 4;
        job = (const struct DmaJob_1549C *)(offset + (u32)table);
        if (sub_08013C60(*job, ((const u8 *)job)[2], &gIwram_64C0) != 0)
            gIwram_3610.state = 0xff;
        sub_08011884();
        break;
    }
    case 4:
        sub_08012CAC();
        if (gGameStuff._unk00 - gIwram_64C0._seed > 7) {
            struct SceneState_1549C *scene;
            const struct DmaJob_1549C *cfg;
            /* r3 keeps the frame-table load before the DMA3 MMIO base literal. */
            const void *const *frames;

            scene = &gIwram_3610;
            cfg = (const struct DmaJob_1549C *)0x08306f08;
            if (scene->frame >= cfg->count)
                scene->frame = 0;

            frames = cfg->frames;
            REG_DMA3.src = frames[scene->frame++];
            REG_DMA3.dst = cfg->dest;
            REG_DMA3.cnt = (cfg->xferCount >> 1) | DMA_ENABLE;
            (void)REG_DMA3.cnt;
        }
        {
            /* r1 table anchor keeps case 4's final transfer as `ldr r1, table; ldr r0, state`. */
            const struct DmaJob_1549C *table;
            /* r3 offset anchor fixes the final add operand order: `adds r3, r3, r1`. */
            register u32 offset asm("r3");

            table = gDmaJobTable_08307DA8;
            offset = gIwram_3610.state << 4;
            job = (const struct DmaJob_1549C *)(offset + (u32)table);
        }
        sub_08013C60(*job, ((const u8 *)job)[2], &gIwram_64C0);
        break;
    }
}
