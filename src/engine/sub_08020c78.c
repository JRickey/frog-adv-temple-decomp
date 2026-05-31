#include "types.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void sub_0802DC1C(u32 handle, u8 val);

/* Returns -1 unless bit 4 of the 0x03003570 flags byte is set, in which
 * case it (re)starts `sound` via sub_0802D9EC and returns the new handle.
 *
 * Same matching lever as the sibling sub_08020B88: accumulate the mask
 * into its own variable (`mask = mask & p->flags`) so agbcc hoists
 * `movs r0, #16` ahead of the `ldrb`, and pin the base pointer to r1 /
 * the mask to r0 to fix the register colouring.
 */
u32 sub_08020C78(u32 sound)
{
    register StructAt3003570 *p asm("r1");
    register int mask asm("r0");
    u32 handle;

    handle = -1;
    p = &gStructAt3003570;
    mask = 0x10;
    mask = mask & p->flags;
    if (mask != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
    }
    return handle;
}

u32 sub_08020CA4(u32 sound)
{
    register u32 snd asm("r1");
    register u32 handle asm("r0");
    register u32 pan asm("r1");
    register u32 result asm("r4");
    StructAt3003570 *p;

    snd = sound;
    result = -1;
    p = &gStructAt3003570;
    handle = 0x10;
    handle = handle & p->flags;
    if (handle != 0) {
        handle = sub_0802D9EC(snd, 0xff, 0xff, 0xff);
        result = handle;
        pan = 0x7f;

        /* The pan byte read is the last use of `p`, so overwrite `p`'s own
         * register with the loaded byte (ldrb r5, [r5, #2]) instead of
         * spilling a fresh scratch — agbcc only reuses the dying base when
         * the load destination IS the pointer var. `p` must stay UNPINNED
         * for the allocator to colour it r5; pinning it forces ldrb r2. */
        p = (StructAt3003570 *)(u32)p->c;
        pan &= (u32)p;
        sub_0802DC1C(handle, pan);
    }
    return result;
}

#include "iwram.h"

extern u8 sub_08021E34(struct IwramAt3720 *s, u8 halfW, u8 halfH);

u32 sub_08020CDC(struct IwramAt3720 *entity, u32 sound, u8 halfW, u8 halfH)
{
    register u32 r asm("r0");
    register u32 result asm("r4");
    register u32 snd asm("r6");
    register u32 handle asm("r0");
    register u32 pan asm("r1");
    StructAt3003570 *p;

    snd = sound;
    r = sub_08021E34(entity, halfW, halfH);
    r <<= 24;
    if (!r)
        return r;
    result = -1;
    p = &gStructAt3003570;
    handle = 0x10;
    handle = handle & p->flags;
    if (handle) {
        handle = sub_0802D9EC(snd, 0xff, 0xff, 0xff);
        result = handle;
        pan = 0x7f;
        p = (StructAt3003570 *)(u32)p->c;
        pan &= (u32)p;
        sub_0802DC1C(handle, pan);
    }
    return result;
}

u32 sub_08020D2C(struct IwramAt3720 *entity, u32 sound, u8 halfW, u8 halfH)
{
    register u32 r asm("r0");
    register u32 result asm("r4");
    register u32 snd asm("r6");
    register u32 bit asm("r2");
    register u32 f34 asm("r1");
    register u32 handle asm("r0");
    register u32 pan asm("r1");
    StructAt3003570 *p;

    snd = sound;
    r = sub_08021E34(entity, halfW, halfH);
    r <<= 24;
    if (r) {
        f34 = entity->_field_34;
        bit = 0x80;
        bit <<= 6;
        r = bit;
        r &= f34;
        if (r)
            return r;

        r = bit;
        r |= f34;
        entity->_field_34 = r;
        result = -1;
        p = &gStructAt3003570;
        handle = 0x10;
        handle = handle & p->flags;
        if (handle) {
            handle = sub_0802D9EC(snd, 0xff, 0xff, 0xff);
            result = handle;
            pan = 0x7f;
            p = (StructAt3003570 *)(u32)p->c;
            pan &= (u32)p;
            sub_0802DC1C(handle, pan);
        }
        return result;
    }
    r = 0x0000dfff;
    f34 = entity->_field_34;
    r &= f34;
    entity->_field_34 = r;
    return r;
}
