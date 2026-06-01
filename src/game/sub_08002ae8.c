#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_08013908(void);
extern void sub_08007874(s8 id);
extern u8 sub_0800A104(u8 *state, u32 callbackTable);

/* Mode entry that seeds the entity-dispatch state, ticks the per-frame
 * entity loop until its active-entity count (gIwram_3720._field_1B) falls
 * to <= 4, then runs a one-shot spawn + waits on the sub_0800A104 gesture
 * gate (the 0x0800A26D callback table, same one the other mode handlers
 * pass for their final-confirmation step). */
void sub_08002AE8(void)
{
    /* Pin the base to r1 (agbcc otherwise colours r2, which propagates into
     * every dependent load/store and the r4 loop-anchor copy). */
    register struct IwramAt3720 *p asm("r1") = &gIwram_3720;
    u8 state;
    u16 flags;

    p->_field_1A = 21;
    /* split into three statements so agbcc emits movs/ldrh/orrs/strh
     * instead of folding to ldrh/orrs/strh */
    flags = 2;
    flags |= p->_field_34;
    p->_field_34 = flags;

    if (gIwram_3720._field_1B <= 4) {
        register u32 count asm("r2");
        do {
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            count = gIwram_3720._field_1B;
        } while (count <= 4);
    }

    state = 0;
    sub_08013908();
    sub_08007874((s8)(gIwram_6110.spawnMask + 1));

    while (sub_0800A104(&state, 0x0800A26D) == 0) {
        sub_080008DC();
    }
}
