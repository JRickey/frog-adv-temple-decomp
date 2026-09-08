#include "entity.h"
#include "entity_motion.h"
#include "iwram.h"
#include "types.h"

/* idxB is declared u32 (not u8) so agbcc passes idxReg straight through in r2
 * (mov r2,r9) instead of re-masking it at every call site — idxReg is already
 * a clean byte from each (u8)(...) assignment. */
extern u8 Entity_WaypointDirectionCompare(Entry *base, u8 idxA, u32 idxB);

/* Seeds entity[dstIdx] from src record `idx`. `selector` chooses how the
 * comparison index (result, via Entity_WaypointDirectionCompare) is derived; `result` then picks a
 * unit step into the 2-byte (dx,dy) scratch handed to MotionDesc_Set.
 *
 * The four small params are int (not u8) so the selector dispatch stays a signed
 * `cmp/bgt` over r2 and cmpVal lands in a caller-saved reg. dyPtr aliases &buf[1]
 * across the result switch so its writes don't recopy sl each time; the leading
 * `zero` local forces the constant load ahead of the address in the first store
 * pair. */
void Entity_AdvanceWaypoint(u8 *src, int dstIdxArg, int selectorArg, int idxArg, int cmpValArg)
{
    u32 idxReg;
    int dstIdx;
    u8 selector;
    u8 idx;
    int cmpVal;
    u8 result;
    s8 buf[2];
    s8 *p;
    s8 *dxPtr;
    s8 *dyPtr;
    struct Entity *entity;
    u8 *srcRecord;
    s8 zero;

    dstIdx = (u8)dstIdxArg;
    selector = (u8)selectorArg;
    idx = (u8)idxArg;
    cmpVal = (u8)cmpValArg;

    zero = 0;
    buf[0] = zero;
    p = &buf[1];
    *p = zero;
    dyPtr = p;

    switch (selector) {
    case 1:
        if (idx == 2) {
            result = src[2];
            idxReg = 3;
            break;
        }
        if (idx == cmpVal + 1) {
            idx = 2;
            idxReg = 3;
            result = Entity_WaypointDirectionCompare((Entry *)src, 2, idxReg);
            break;
        }
        idxReg = (u8)(idx + 1);
        result = Entity_WaypointDirectionCompare((Entry *)src, idx, idxReg);
        break;
    case 2:
        if (idx == cmpVal + 1)
            idxReg = 2;
        else
            idxReg = (u8)(idx + 1);
        result = Entity_WaypointDirectionCompare((Entry *)src, idx, idxReg);
        break;
    case 3:
        if (idx == cmpVal + 1)
            gEntities[dstIdx].status |= 0x800;
        if (idx == 2)
            gEntities[dstIdx].status &= 0xf7ff;
        if (gEntities[dstIdx].status & 0x800)
            idxReg = (u8)(idx - 1);
        else
            idxReg = (u8)(idx + 1);
        result = Entity_WaypointDirectionCompare((Entry *)src, idx, idxReg);
        break;
    default:
        break;
    }

    dxPtr = &buf[0];
    *dxPtr = 0;
    *dyPtr = 0;
    switch (result) {
    case 1:
        *dyPtr = -1;
        break;
    case 2:
        *dyPtr = 1;
        break;
    case 3:
        *dxPtr = -1;
        break;
    case 4:
        *dxPtr = 1;
        break;
    default:
        break;
    }

    entity = &gEntities[dstIdx];
    srcRecord = &src[idx * 8];
    MotionDesc_Set(entity, srcRecord[4], buf[0], *dyPtr);
    entity->x = *(u16 *)&srcRecord[0];
    entity->y = *(u16 *)&srcRecord[2];
    entity->state = result;
    entity->status |= 2;
    entity->field_33 = idxReg;
}
