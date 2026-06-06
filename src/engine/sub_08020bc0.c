#include "types.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern u32 SoundSystem_IsActive(void);
extern void SoundSlot_QueueRequest(void);

/* When bit 1 of the 0x03003570 flags byte is set and SoundSystem_IsActive() reports
 * zero, poke SoundSlot_QueueRequest. Sibling of Sound_PlayIfEnabled in this cluster (same
 * push{lr}/bx-r0 void-tail epilogue).
 *
 * agbcc matching lever (same as Sound_PlayIfEnabled / Sound_Play): accumulate the
 * mask into its own variable (`mask = mask & p->flags`) so agbcc hoists
 * `movs r0, #2` ahead of the `ldrb`, and pin the base pointer to r1 / the
 * mask to r0 to fix the register colouring.
 */
void Sound_ServiceQueue(void)
{
    StructAt3003570 *p;
    int mask;

    p = &gStructAt3003570;
    mask = 2;
    mask = mask & p->flags;
    if (mask != 0) {
        if (SoundSystem_IsActive() == 0) {
            SoundSlot_QueueRequest();
        }
    }
}

/* Store the argument byte into the 0x03003570 struct's second field.
 * Arg is u32, not u8: the baserom stores the raw register (strb r0) without
 * the lsls/lsrs zero-extend agbcc emits for a u8 parameter. */
void SoundSlot_SetVolumeByte(u32 arg)
{
    gStructAt3003570.b = arg;
}

extern void SoundRequest_Drain(u32 a);

/* Clear bit 0 of gStructAt3003570.flags, then if SoundSystem_IsActive() is non-zero,
 * call SoundRequest_Drain(1). Sibling of Sound_ServiceQueue in this cluster.
 *
 * agbcc matching lever: base pointer pinned to r0, mask to r1 so agbcc emits
 * movs r1, #254 before ldrb r2, [r0, #0]; ands r1, r2; strb r1, [r0, #0].
 */
void Sound_ClearActiveFlag(void)
{
    StructAt3003570 *p;
    int mask;

    p = &gStructAt3003570;
    mask = 0xfe;
    mask = mask & p->flags;
    p->flags = mask;
    if (SoundSystem_IsActive()) {
        SoundRequest_Drain(1);
    }
}

extern void SoundSlot_Load(u32 arg);

/* Set bit 0 of gStructAt3003570.flags, then forward `arg` to SoundSlot_Load
 * and SoundSlot_QueueRequest. The flag write is always followed by the call
 * because setting bit 0 guarantees the subsequent `flags & 1` check is true.
 *
 * agbcc matching lever (same as Sound_PlayIfEnabled): register pins r1=pointer,
 * r0=mask so the code emits: adds r2,r0,#0; ldr r1,[pc]; movs r0,#1;
 * ldrb r3,[r1,#0]; orrs r0,r3; strb r0,[r1,#0]; movs r1,#1; ands r0,r1;
 * cmp r0,#0; beq; adds r0,r2,#0; bl; bl; pop{r0}; bx r0.
 */
void SoundSlot_EnableAndLoad(u32 arg)
{
    StructAt3003570 *p;
    register int mask asm("r0");
    StructAt3003570 s;

    p = &gStructAt3003570;
    mask = 1;
    s = *p;
    mask = mask | s.flags;
    p->flags = mask;
    mask = mask & 1;
    if (mask) {
        SoundSlot_Load(arg);
        SoundSlot_QueueRequest();
    }
}

extern void SoundChannel_BroadcastValue(u32 a);

/* Clear bit 4 of gStructAt3003570.flags after calling SoundChannel_BroadcastValue(0).
 * Register pins: r1=pointer, r0=mask (same layout as Sound_ServiceQueue). */
void Music_Stop(void)
{
    StructAt3003570 *p;
    int mask;

    SoundChannel_BroadcastValue(0);
    p = &gStructAt3003570;
    mask = 0xef;
    mask = mask & p->flags;
    p->flags = mask;
}

void Music_Resume(void)
{
    StructAt3003570 *p;
    register int mask asm("r0");

    p = &gStructAt3003570;
    mask = 0x7f;
    mask = mask & p->c;
    SoundChannel_BroadcastValue(mask);
    mask = 0x10;
    mask = mask | p->flags;
    p->flags = mask;
}
