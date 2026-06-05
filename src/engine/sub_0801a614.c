#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Sibling script-step advance of sub_080179B8 (which uses gScriptPtrTable_08307fec).
 * These two tables are still inside the ROM data blob; useTableA picks which one,
 * index picks an entry. Each entry points at a byte-stream of opcodes. */
extern const u8 *const gScriptPtrTable_08308164[];
extern const u8 *const gScriptPtrTable_083081A0[];

u32 sub_08000900(void);
u32 __udivsi3(u32 num, u32 den);

int sub_0801A614(u8 index, int useTableA)
{
    /* Pins mirror the matching sibling sub_080179B8: script, the cursor state and
     * the opcode all stay live across the two BLs, giving the push {r4,r5,r6,lr}. */
    const u8 *script;
    struct IwramAt34C0 *s;
    register int op asm("r4");

    if (useTableA != 0) {
        script = gScriptPtrTable_08308164[index];
    } else {
        script = gScriptPtrTable_083081A0[index];
    }

    s = &gIwram_34C0;
    if (s->delay != 0) {
        if (__udivsi3(sub_08000900() - s->stepTick, 60) < s->delay) {
            goto ret_zero;
        }
    }

    s->delay = 0;
    s->stepTick = 0;

    op = script[s->cursor];
    if (op == 0xFE) {
        s->holdFlag = 1;
    } else if (op == 0xFD) {
        s->holdFlag = 0;
    }

    s = &gIwram_34C0;
    {
        /* Advancing the cursor: the flat (u32)script + idx address (idx pinned to
         * r0) keeps script untouched in r6 and lands the sum in r0, matching the
         * baserom's `adds r0, r6, r0; ldrb`. */
        register u8 cursor asm("r0") = s->cursor;
        register u8 c1 asm("r1") = cursor + 1;
        register u32 idx asm("r0");
        s->cursor = c1;
        op = script[(u8)cursor];
        if (op == 0) {
            s->cursor = c1 + 1;
            idx = (u8)c1;
            idx = (u32)script + idx;
            s->delay = *(u8 *)idx;
            s->stepTick = sub_08000900();
            return op;
        }
    }

    if ((u8)(op + 3) <= 1) {
        goto ret_zero;
    }

    if (op != 0xFF) {
        return op;
    }

    {
        /* Reset on 0xFF. z (r0) feeds the two byte stores; holdFlag is written from
         * a separate literal 0 (agbcc reuses z's r0) so the SImode str never forces
         * a QImode subreg copy. z then carries the 0xFF return value into r0, which
         * cross-jumps to the bare-pop epilogue past the shared `adds r0, r4, #0`. */
        register int z asm("r0") = 0;
        s->cursor = z;
        s->delay = z;
        s->holdFlag = 0;
        z = 0xFF;
        return z;
    }

ret_zero:
    op = 0;
    return op;
}
