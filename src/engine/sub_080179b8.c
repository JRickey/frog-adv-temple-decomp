#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const u16 *const gScriptPtrTable_08307fec[];

u32 GetFrameTick(void);
u32 __udivsi3(u32 num, u32 den);

int ScriptTick(void)
{
    struct IwramAt34C0 *s;
    const u16 *script;
    register int op asm("r4");
    register GameStuff *gs asm("r2");
    register u8 cursor asm("r0");
    register u8 c1 asm("r1");
    register int idx asm("r0");
    int flag;

    {
        struct IwramAt34C0 *t = &gIwram_34C0;
        u32 delay = t->delay;

        s = t;
        if (delay != 0) {
            if (__udivsi3(GetFrameTick() - s->stepTick, 60) < s->delay) {
                goto ret_op_zero;
            }
        }
    }

    s->delay = 0;
    s->stepTick = 0;

    {
        register const u16 *const *tbl asm("r1") = gScriptPtrTable_08307fec;
        int m;

        gs = &gGameStuff;
        m = gs->sceneType - 1;
        script = tbl[m];
    }

    op = script[s->cursor];
    if (op == 0xFE) {
        s->holdFlag = 1;
    } else if (op == 0xFD) {
        s->holdFlag = 0;
    }

    flag = gIwram_35E0._field_10 & 1;
    s = &gIwram_34C0;
    if (flag) {
        if (s->holdFlag == 0) {
            goto ret_zero;
        }
    }

    cursor = s->cursor;
    c1 = cursor + 1;
    s->cursor = c1;
    op = script[(u8)cursor];
    if (op == 0) {
        s->cursor = c1 + 1;
        idx = c1 << 24;
        idx = (u32)idx >> 23;
        idx = idx + (u32)script;
        s->delay = (u8) * (u16 *)idx;
        s->stepTick = GetFrameTick();
        return op;
    }

    if ((u16)(op - 0xFD) <= 1)
        goto ret_op_zero;

    if (op != 0xFF) {
        return op;
    }

    gs->mode = GAME_MODE_ROUTER;
    gIwram_3480.subState = 4;
    goto ret_op_zero;

ret_zero:
    return 0;

ret_op_zero:
    op = 0;

ret:
    return op;
}
