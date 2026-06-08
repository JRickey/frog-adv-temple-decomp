#include "iwram.h"
#include "types.h"

/* Slots written here are the canonical struct Entity (iwram.h). */
extern void MotionDesc_Set(struct Entity *e, s8 param, s8 deltaX, s8 deltaY);

void InitSpecialEntitySlots(void)
{
    u8 *base = (u8 *)gEntities;
    struct Entity *slot;
    s32 offset;
    u8 *addr;
    register s32 value asm("r0");
    register u16 mask asm("r1");
    u8 *addr54;
    u16 *flags;
    s32 initFlags;
    s32 initKind;
    s32 initField16;
    s32 initField17;
    s32 initMatchKey;
    s32 zero;
    s32 i;

    initFlags = 16;
    initKind = 15;
    slot = (struct Entity *)(base + 0xf18);
    initField16 = 12;
    initField17 = 3;
    initMatchKey = 2;
    i = 1;
    do {
        slot->status = initFlags;
        slot->kind = initKind;
        slot->field_16 = initField16;
        slot->field_17 = initField17;
        slot->actorId = initMatchKey;
        slot++;
    } while (--i >= 0);

    offset = 0xf2c;
    addr = base + offset;
    zero = 0;
    value = 0x175;
    *(u16 *)addr = value;

    addr = base + 0xf64;
    value = 0x185;
    *(u16 *)addr = value;

    offset -= 18;
    addr = base + offset;
    value -= 66;
    *(u16 *)addr = value;

    addr = base + 0xf1c;
    value = 0x2f4;
    *(u16 *)addr = value;

    offset += 56;
    addr = base + offset;
    value = 0x15b;
    *(u16 *)addr = value;

    value = 0xf54;
    addr54 = base + value;
    /* Preserve old_agbcc's coloring of the direct slot-70 y offset. */
    if (offset != value)
        value = 0x33a;
    else
        value = 0x33a;
    *(u16 *)addr54 = value;

    *(u8 *)(base + 0xf32) = zero;

    flags = (u16 *)(base + 0xf4c);
    mask = 2;
    *flags |= mask;

    offset = 0xf6a;
    *(u8 *)(base + offset) = zero;

    offset += 26;
    {
        u8 *flagAddr = base + offset;
        u16 oldFlags = *(u16 *)flagAddr;
        mask |= oldFlags;
        *(u16 *)flagAddr = mask;
    }

    MotionDesc_Set((struct Entity *)(base + 0xf18), 4, 0, 1);
    MotionDesc_Set((struct Entity *)(base + 0xf50), 4, 0, 1);
}
