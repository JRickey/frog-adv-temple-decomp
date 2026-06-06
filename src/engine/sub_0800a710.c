#include "macros.h"
#include "types.h"

/* Cluster of six helpers living between Entity_InitShadow and EntityHitbox_FindPoint.
 *
 * Entity_Init is a 10-argument struct initializer called from
 * Entity_InitShadow (still asm). The remaining five are tiny flag/field
 * helpers on the same struct, all sharing the +0x34 flag halfword.
 *
 * The struct type isn't yet identified — the layout below covers only
 * the fields these six helpers touch.
 *
 * Matching notes:
 *   - This whole .c is compiled with old_agbcc (Makefile override).
 *     Entity_TestFlags has two return paths that converge at a `bx lr`;
 *     the newer agbcc wraps such functions in a spurious
 *     `push {lr}; ...; pop {r1}; bx r1` frame. Entity_ClearFlags likewise
 *     needs old_agbcc to emit the `bics r2, r1; adds r1, r2, #0;
 *     strh r1, [r0, #52]` route-through-r1 (newer agbcc strh's r2
 *     directly). See docs/codegen-notes.md "old_agbcc vs agbcc".
 *   - Entity_Init takes 10 args; six arrive on the stack. The four
 *     stack args used last (stored at dest +22, +23, +26, +52) spill
 *     into r8/r9/sl/r4 — agbcc runs out of low callee-saved registers
 *     mid-prologue. First two stack args (+6, +20) stay in r5/r6.
 *   - Entity_ClearTargetFlag uses `& 0xffbf` (not `& ~0x40`); the literal lands
 *     in the pool just past the function's bx lr. */

struct ClusterA710 {
    u8 _field_00;
    u8 _pad01;
    u16 x;
    u16 y;
    u8 matchKey;
    u8 _pad07[5];
    u16 _field_0C;
    u16 _field_0E;
    u16 _field_10;
    u8 _pad12[2];
    u16 _field_14;
    u8 _field_16;
    u8 _field_17;
    u8 _pad18[2];
    u8 dispatchState;
    u8 _pad1B[0x19];
    u16 flags;
};

void Entity_Init(struct ClusterA710 *p, u8 a, u16 x, u16 y, u8 actorId, u16 e, u8 f, u8 g, u8 state, u16 initFlags)
{
    p->_field_00 = a;
    p->x = x;
    p->y = y;
    p->matchKey = actorId;
    p->_field_14 = e;
    p->_field_16 = f;
    p->_field_17 = g;
    p->dispatchState = state;
    p->flags = initFlags | 2;
}

void Entity_SetFlags(struct ClusterA710 *p, u16 mask)
{
    p->flags |= mask;
}

void Entity_ClearFlags(struct ClusterA710 *p, u16 mask)
{
    p->flags &= ~mask;
}

u8 Entity_TestFlags(struct ClusterA710 *p, u16 mask)
{
    if ((p->flags & mask) != 0)
        return 1;
    return 0;
}

void Entity_SetTargetPos(struct ClusterA710 *p, u16 a, u16 b, u16 c)
{
    p->_field_0C = a;
    p->_field_0E = b;
    p->_field_10 = c;
    p->flags |= 0x40;
}

void Entity_ClearTargetFlag(struct ClusterA710 *p)
{
    p->flags &= 0xffbf;
}

typedef struct EntityHitbox {
    u32 count;
    u32 points;
    u32 flags;
} EntityHitbox;

extern const EntityHitbox sEntityHitboxTable[];

s8 EntityHitbox_FindPoint(s8 a, s16 x, s16 y)
{
    s8 i;

    for (i = 0; i < (s8)sEntityHitboxTable[a].count; i++) {
        if (x == ((const s16 *)(u32)sEntityHitboxTable[a].points + i * 2)[0] &&
            y == ((const s16 *)(u32)sEntityHitboxTable[a].points + i * 2)[1])
            return i;
    }
    return -1;
}
