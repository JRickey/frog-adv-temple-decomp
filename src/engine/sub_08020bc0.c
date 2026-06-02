#include "types.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern u32 sub_08032148(void);
extern void SoundSlot_QueueRequest(void);

/* When bit 1 of the 0x03003570 flags byte is set and sub_08032148() reports
 * zero, poke SoundSlot_QueueRequest. Sibling of sub_08020B88 in this cluster (same
 * push{lr}/bx-r0 void-tail epilogue).
 *
 * agbcc matching lever (same as sub_08020B88 / sub_08020C78): accumulate the
 * mask into its own variable (`mask = mask & p->flags`) so agbcc hoists
 * `movs r0, #2` ahead of the `ldrb`, and pin the base pointer to r1 / the
 * mask to r0 to fix the register colouring.
 */
void sub_08020BC0(void)
{
    register StructAt3003570 *p asm("r1");
    register int mask asm("r0");

    p = &gStructAt3003570;
    mask = 2;
    mask = mask & p->flags;
    if (mask != 0) {
        if (sub_08032148() == 0) {
            SoundSlot_QueueRequest();
        }
    }
}

/* Store the argument byte into the 0x03003570 struct's second field.
 * Arg is u32, not u8: the baserom stores the raw register (strb r0) without
 * the lsls/lsrs zero-extend agbcc emits for a u8 parameter. */
void sub_08020BE4(u32 arg)
{
    gStructAt3003570.b = arg;
}

extern void sub_08031FDC(u32 a);

/* Clear bit 0 of gStructAt3003570.flags, then if sub_08032148() is non-zero,
 * call sub_08031FDC(1). Sibling of sub_08020BC0 in this cluster.
 *
 * agbcc matching lever: base pointer pinned to r0, mask to r1 so agbcc emits
 * movs r1, #254 before ldrb r2, [r0, #0]; ands r1, r2; strb r1, [r0, #0].
 */
void sub_08020BF0(void)
{
    register StructAt3003570 *p asm("r0");
    register int mask asm("r1");

    p = &gStructAt3003570;
    mask = 0xfe;
    mask = mask & p->flags;
    p->flags = mask;
    if (sub_08032148()) {
        sub_08031FDC(1);
    }
}

extern void sub_08031E24(u32 arg);

/* Set bit 0 of gStructAt3003570.flags, then forward `arg` to sub_08031E24
 * and SoundSlot_QueueRequest. The flag write is always followed by the call
 * because setting bit 0 guarantees the subsequent `flags & 1` check is true.
 *
 * agbcc matching lever (same as sub_08020B88): register pins r1=pointer,
 * r0=mask so the code emits: adds r2,r0,#0; ldr r1,[pc]; movs r0,#1;
 * ldrb r3,[r1,#0]; orrs r0,r3; strb r0,[r1,#0]; movs r1,#1; ands r0,r1;
 * cmp r0,#0; beq; adds r0,r2,#0; bl; bl; pop{r0}; bx r0.
 */
void sub_08020C14(u32 arg)
{
    register StructAt3003570 *p asm("r1");
    register int mask asm("r0");
    StructAt3003570 s;

    p = &gStructAt3003570;
    mask = 1;
    s = *p;
    mask = mask | s.flags;
    p->flags = mask;
    mask = mask & 1;
    if (mask) {
        sub_08031E24(arg);
        SoundSlot_QueueRequest();
    }
}

extern void sub_08020E98(u32 a);

/* Clear bit 4 of gStructAt3003570.flags after calling sub_08020E98(0).
 * Register pins: r1=pointer, r0=mask (same layout as sub_08020BC0). */
void sub_08020C3C(void)
{
    register StructAt3003570 *p asm("r1");
    register int mask asm("r0");

    sub_08020E98(0);
    p = &gStructAt3003570;
    mask = 0xef;
    mask = mask & p->flags;
    p->flags = mask;
}

void sub_08020C58(void)
{
    register StructAt3003570 *p asm("r4");
    register int mask asm("r0");

    p = &gStructAt3003570;
    mask = 0x7f;
    mask = mask & p->c;
    sub_08020E98(mask);
    mask = 0x10;
    mask = mask | p->flags;
    p->flags = mask;
}
