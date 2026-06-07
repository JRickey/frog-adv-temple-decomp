#include "iwram.h"
#include "sound.h"
#include "types.h"

extern void Entity_Update(void *p);

/* Slot-12 state machine over gEntities[12]. The matching code keeps the
 * gEntities base in a register and reaches the slot-12 fields with the full
 * byte offsets (state at 0x2ba, status at 0x2d4 = 12*0x38 + field offset),
 * rather than folding to the slot base 0x030039c0 with small offsets. */
enum {
    SLOT12_STATE_OFFSET = 0x2ba,  /* &gEntities[12].state - (u8 *)gEntities */
    SLOT12_STATUS_OFFSET = 0x2d4, /* &gEntities[12].status   - (u8 *)gEntities */
    ENTITY_STATUS_QUEUED = 0x0002,
    ENTITY_STATUS_BUSY = 0x8000,
    ENTITY_STATUS_BUSY_CLEAR = 0x7fff,
};

/* The per-variable register pins reproduce the original allocator's coloring:
 * statePtr survives in a scratch reg (r3) to the shared commit, while the
 * commit's statusPtr is the callee-saved r4. status/queued/newStatus pin the
 * r1/r2/r0 working set so cases 0 and 1 stay distinct from the case-2/commit
 * tail (an unpinned shape lets agbcc cross-jump-merge them and shortens the
 * function). */
void Entity12_TickStateMachine(void)
{
    u8 *base;
    u8 *statePtr;
    register u16 *statusPtr asm("r4");
    register u16 status asm("r1");
    register u16 queued asm("r2");
    register u16 newStatus asm("r0");

    base = (u8 *)gEntities;
    statePtr = base + SLOT12_STATE_OFFSET;

    switch (*statePtr) {
    case 0: {
        register u16 *sp asm("r2") = (u16 *)(base + SLOT12_STATUS_OFFSET);
        status = *sp;
        if (status & ENTITY_STATUS_QUEUED)
            break;
        if (!(status & ENTITY_STATUS_BUSY))
            break;
        /* staged store: reuse status's dead reg for the 0x7fff mask so agbcc
         * emits orr/and in place instead of an extra copy */
        newStatus = status | ENTITY_STATUS_QUEUED;
        status = ENTITY_STATUS_BUSY_CLEAR;
        newStatus &= status;
        *sp = newStatus;
        break;
    }
    case 1: {
        u32 q;
        statusPtr = (u16 *)(base + SLOT12_STATUS_OFFSET);
        status = *statusPtr;
        /* compute (status & 2) through the r0-pinned working reg so the mask
         * lands in r0 (matching case 2, which reuses the dispatch constant);
         * the u32 q keeps case 1 distinct from case 2 (prevents a merge). */
        newStatus = ENTITY_STATUS_QUEUED;
        q = newStatus & status;
        queued = (u16)q;
        if (queued)
            break;
        goto commit;
    }
    case 2:
        statusPtr = (u16 *)(base + SLOT12_STATUS_OFFSET);
        status = *statusPtr;
        queued = (u16)(status & ENTITY_STATUS_QUEUED);
        if (queued) {
            Sound_Play(0x22);
            break;
        }
    commit:
        if (!(status & ENTITY_STATUS_BUSY))
            break;
        *statePtr = (u8)queued;
        newStatus = status | ENTITY_STATUS_QUEUED;
        status = ENTITY_STATUS_BUSY_CLEAR;
        newStatus &= status;
        *statusPtr = newStatus;
        break;
    case 3: {
        register u16 *sp asm("r3") = (u16 *)(base + SLOT12_STATUS_OFFSET);
        queued = *sp;
        if (queued & ENTITY_STATUS_QUEUED) {
            Sound_Play(0x73);
            break;
        }
        if (!(queued & ENTITY_STATUS_BUSY))
            break;
        gIwram_6110.inputFlags |= 8;
        *sp = queued & ENTITY_STATUS_BUSY_CLEAR;
        break;
    }
    }

    Entity_Update(&gEntities[12]);
}
