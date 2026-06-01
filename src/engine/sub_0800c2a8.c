#include "types.h"

/* Copies one (x, y) hitbox point — the 4-byte pair at index `point` of
 * sEntityHitboxTable[type].points — into *out.
 *
 * Returns `out`: the baserom epilogue is `pop {r1}; bx r1`, keeping r0 the
 * live return register. A void variant frees r0 and agbcc reuses it for the
 * bx scratch (`pop {r0}; bx r0`) — 2 bytes off. Returning `out` pins r0. */

typedef struct EntityHitbox {
    u32 count;
    u32 points;
    u32 flags;
} EntityHitbox;

extern const EntityHitbox sEntityHitboxTable[];

u32 *EntityHitbox_GetPoint(u32 *out, s8 type, s8 point)
{
    *out = ((const u32 *)sEntityHitboxTable[type].points)[point];
    return out;
}

extern int sub_0800CB80(int xTile, int mode, int x, int y, int flags);

/* Looks up sEntityHitboxTable[type] and calls sub_0800CB80 with the (x, y)
 * pair at index `subtype` and the flags byte (low or high byte, controlled
 * by useAltFlags). Two pool loads of the same table address are required (one per
 * branch), which naturally arises from the two branches.
 *
 * Matching: r4=table, r1=offset (type*12), r0=pa (address scratch).
 * `pa = offset + pa` produces `adds r0, r1, r0` (r1=Rn) rather than the
 * compound `adds r0, r0, r1` because pa (r0) is the destination and the
 * expression left-operand (offset/r1) becomes Rn. */
void EntityHitbox_RegisterHitPoint(u8 type, u8 xTile, u8 mode, u8 subtype, u8 useAltFlags)
{
    register const EntityHitbox *table asm("r4");
    register u32 offset asm("r1");
    register u32 pa asm("r0");
    u32 pointsPtr;
    s32 x;
    s32 y;
    u32 flagByte;

    if (useAltFlags == 0) {
        table = sEntityHitboxTable;
        offset = (u32)((s32)(s8)type * (s32)sizeof(EntityHitbox));
        pa = (u32)table + 4u;
        pa = offset + pa;
        pointsPtr = *(u32 *)pa;
        pa = (u32)subtype << 2;
        pa += pointsPtr;
        x = ((const s16 *)pa)[0];
        y = ((const s16 *)pa)[1];
        flagByte = *(u8 *)(offset + (u32)table + 8u);
        sub_0800CB80(xTile, mode, x, y, flagByte);
    } else {
        table = sEntityHitboxTable;
        offset = (u32)((s32)(s8)type * (s32)sizeof(EntityHitbox));
        pa = (u32)table + 4u;
        pa = offset + pa;
        pointsPtr = *(u32 *)pa;
        pa = (u32)subtype << 2;
        pa += pointsPtr;
        x = ((const s16 *)pa)[0];
        y = ((const s16 *)pa)[1];
        flagByte = *(u8 *)(offset + (u32)table + 9u);
        sub_0800CB80(xTile, mode, x, y, flagByte);
    }
}
