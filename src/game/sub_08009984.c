#include "game.h"
#include "entity.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Per-frame entity classifier / collision dispatch.
 *
 * Reads the current entity's tile-cache pair from gIwram_35E0 and feeds
 * it through two collision-style lookups (Tilemap_GetTileClass / TileCell_GetPropertyB),
 * conditioned on the bit-test result of IsFlagMaskSet. The lookup result
 * (`tile`) drives:
 *   - TileSound_Update(tile) — always called.
 *   - Player_HandleTileCollision(tile) — called if sub_06BA4 returned the bit-16 mask
 *     (probably "this tile is solid").
 *   - sub_06B88(gIwram_35E0, 0x800)  if tile == 7
 *   - sub_06B88(gIwram_35E0, 0x2000) if tile == 8 || tile == 11
 *
 * Entry-guard: if bit 4 of gEntities[0].status is set, the function
 * is a no-op. (That bit appears to be a "transition in progress" flag
 * raised by Player_UpdateTileCache's caller.)
 */

extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void TileSound_Update(u8 tile);
extern void Player_HandleTileCollision(u8 tile);
extern u32 TileCell_GetPropertyB(u8 col, u8 row, s32 tileX, s32 tileY);

void Player_CheckTileEvents(void)
{
    u8 tile;
    u8 tile2;

    if ((gEntities[0].status & 4) != 0)
        return;

    tile = (u8)Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                    gIwram_35E0._field_A);
    TileSound_Update(tile);

    if ((u8)IsFlagMaskSet(&gIwram_35E0, 16) != 0)
        Player_HandleTileCollision(tile);

    if ((u8)IsFlagMaskSet(&gIwram_35E0, 64) != 0) {
        tile2 = (u8)TileCell_GetPropertyB(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                          gIwram_35E0._field_A);
        if (tile2 == 1)
            gEntities[0].field_17 = tile2;
        if (tile2 == 2)
            gEntities[0].field_17 = tile2;
        if (tile2 == 3)
            gEntities[0].field_17 = tile2;
    }

    if (tile == 7) {
        if ((gIwram_35E0._field_C & 2) != 0)
            goto check8or11;
        if (gEntities[0].state > 3)
            goto check8or11;
        PlayerFlags_Set(&gIwram_35E0, 0x800);
        return;
    }
check8or11:
    if (tile != 8 && tile != 11)
        return;
    if ((gIwram_35E0._field_C & 2) != 0)
        return;
    if (gEntities[0].state > 3)
        return;
    PlayerFlags_Set(&gIwram_35E0, 0x2000);
}

/* Per-frame entity-vs-player AABB sweep.
 *
 * Iterates the entity array at 0x03003720 (stride 0x38, count at
 * 0x03006140[0]). For each entity:
 *   - Skip if bit 3 of entity[0x34] is already set (this-frame hit
 *     already recorded).
 *   - Skip and clear bit 0 of entity[0x34] if Entity_IsInProximity(idx) says
 *     the entity is not eligible.
 *   - Compute signed dx/dy between the entity center
 *     (entity[2], entity[4]) and the player center read once into the
 *     stack from 0x030060A0[12], 0x030060A0[16] at function entry,
 *     biased by half the entity's half-extents (entity[24], entity[25]).
 *     Store the biased deltas to entity[8] / entity[10].
 *   - Bounding-box gate the entity against a 240x160 window around the
 *     player center; on a hit set bits 0 and 8 of entity[0x34], append a
 *     {entity_idx, x_offset, 0xFFFF} record to the variable-stride hit
 *     log at 0x03006160 (count byte at 0x03006110[49]), and call
 *     ModeControl_SetBit(0x03006110, idx).
 *
 * Shipped NAKED. The baserom pins the loop's per-entity scratch into
 * the high registers sl (zero hold), r9 (pointer to the hit-count byte
 * at 0x03006110+49), r8 (loop index), and ip (sign-extended entity[4]).
 * Per docs/codegen-notes.md "High registers (sl/r10, sb/r9, r8, ip)
 * — corpus-validated unmatchable", agbcc 2.x will not promote loop
 * state into a high register from any plausible C input — pure-C is
 * unreachable. The reference body in the NON_MATCHING block documents
 * intent for the phase-3 PC port.
 */

#ifdef NON_MATCHING
void Entity_UpdateVisibility(void)
{
    s16 player_cx;
    s16 player_cy;
    u8 count;
    s32 idx;
    u8 *hits_count_ptr;
    u8 *entity;
    s32 i;
    s32 rx;
    s32 ry;
    s32 ex;
    s32 ey;
    s32 dx_raw;
    s32 dy_raw;
    u16 flags;
    u8 *slot;

    player_cx = (s16) * (u16 *)(0x030060A0 + 12);
    player_cy = (s16) * (u16 *)(0x030060A0 + 16);
    *(u8 *)(0x03006110 + 49) = 0;
    *(u32 *)(0x03006110 + 20) = 0;
    *(u32 *)(0x03006110 + 24) = 0;
    *(u32 *)(0x03006110 + 28) = 0;
    *(u32 *)(0x03006110 + 32) = 0;

    count = *(u8 *)(0x03006110 + 48);
    for (idx = 0; idx < count; idx++) {
        hits_count_ptr = (u8 *)(0x03006110 + 49);
        i = idx * 0x38;
        entity = (u8 *)(0x03003720 + i);
        if ((*(u16 *)(entity + 0x34) & 8) != 0)
            continue;
        if (Entity_IsInProximity(idx) == 0)
            goto clear_bit;

        rx = *(u8 *)(entity + 24) >> 1;
        ry = *(u8 *)(entity + 25) >> 1;
        ex = (s16) * (u16 *)(entity + 2);
        ey = (s16) * (u16 *)(entity + 4);
        *(u16 *)(entity + 8) = (u16)(ex - player_cx - ry);
        *(u16 *)(entity + 10) = (u16)(ey - player_cy - rx);

        if ((ex + ry) < player_cx)
            goto clear_bit;
        if ((ex - ry) > player_cx + 240)
            goto clear_bit;
        if ((ey + rx) < player_cy)
            goto clear_bit;
        if ((ey - rx) > player_cy + 160)
            goto clear_bit;

        flags = *(u16 *)(entity + 0x34);
        if ((flags & 1) == 0)
            *(u16 *)(entity + 0x34) = flags | 0x100 | 1;
        slot = (u8 *)(0x03006160 + (*hits_count_ptr << 3));
        slot[0] = (u8)idx;
        *(u16 *)(slot + 2) = (u16)(*(u16 *)(entity + 0x26) + ey);
        *(u16 *)(slot + 4) = 0xFFFF;
        (*hits_count_ptr)++;
        ModeControl_SetBit((void *)0x03006110, idx);
        continue;

    clear_bit:
        *(u16 *)(entity + 0x34) = (u16)(*(u16 *)(entity + 0x34) & 0xFFFE);
    }
}
#else
NAKED void Entity_UpdateVisibility(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #12\n"
        "    ldr     r0, _sub_08009A58_pool_60a0\n"
        "    ldrh    r1, [r0, #12]\n"
        "    str     r1, [sp, #0]\n"
        "    ldrh    r0, [r0, #16]\n"
        "    str     r0, [sp, #4]\n"
        "    ldr     r2, _sub_08009A58_pool_6110_b\n"
        "    adds    r3, r2, #0\n"
        "    adds    r3, #49\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r3, #0]\n"
        "    movs    r0, #0\n"
        "    movs    r1, #0\n"
        "    str     r0, [r2, #20]\n"
        "    str     r1, [r2, #24]\n"
        "    str     r0, [r2, #28]\n"
        "    str     r1, [r2, #32]\n"
        "    movs    r4, #0\n"
        "    mov     r8, r4\n"
        "    adds    r2, #48\n"
        "    ldrb    r0, [r2, #0]\n"
        "    cmp     r8, r0\n"
        "    bge     _sub_08009A58_epilogue\n"
        "    mov     r9, r3\n"
        "    movs    r1, #0\n"
        "    str     r1, [sp, #8]\n"
        "_sub_08009A58_loop:\n"
        "    ldr     r0, _sub_08009A58_pool_3720\n"
        "    ldr     r2, [sp, #8]\n"
        "    adds    r5, r2, r0\n"
        "    movs    r0, #8\n"
        "    ldrh    r3, [r5, #52]\n"
        "    ands    r0, r3\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08009A58_step\n"
        "    mov     r0, r8\n"
        "    bl      Entity_IsInProximity\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08009A58_clear_bit\n"
        "    ldrb    r4, [r5, #24]\n"
        "    lsrs    r2, r4, #1\n"
        "    ldrh    r1, [r5, #4]\n"
        "    movs    r0, #2\n"
        "    ldrsh   r7, [r5, r0]\n"
        "    ldr     r3, [sp, #0]\n"
        "    lsls    r0, r3, #16\n"
        "    asrs    r6, r0, #16\n"
        "    subs    r0, r7, r6\n"
        "    ldrb    r4, [r5, #25]\n"
        "    lsrs    r3, r4, #1\n"
        "    subs    r0, r0, r3\n"
        "    movs    r4, #0\n"
        "    mov     sl, r4\n"
        "    strh    r0, [r5, #8]\n"
        "    lsls    r1, r1, #16\n"
        "    asrs    r1, r1, #16\n"
        "    mov     ip, r1\n"
        "    ldr     r1, [sp, #4]\n"
        "    lsls    r0, r1, #16\n"
        "    asrs    r4, r0, #16\n"
        "    mov     r1, ip\n"
        "    subs    r0, r1, r4\n"
        "    subs    r0, r0, r2\n"
        "    strh    r0, [r5, #10]\n"
        "    adds    r0, r7, r3\n"
        "    cmp     r0, r6\n"
        "    blt     _sub_08009A58_call_696c\n"
        "    subs    r1, r7, r3\n"
        "    adds    r0, r6, #0\n"
        "    adds    r0, #240\n"
        "    cmp     r1, r0\n"
        "    bgt     _sub_08009A58_call_696c\n"
        "    mov     r3, ip\n"
        "    adds    r0, r3, r2\n"
        "    cmp     r0, r4\n"
        "    blt     _sub_08009A58_call_696c\n"
        "    subs    r1, r3, r2\n"
        "    adds    r0, r4, #0\n"
        "    adds    r0, #160\n"
        "    cmp     r1, r0\n"
        "    bgt     _sub_08009A58_call_696c\n"
        "    ldrh    r1, [r5, #52]\n"
        "    movs    r2, #1\n"
        "    movs    r0, #1\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08009A58_set_slot\n"
        "    movs    r4, #128\n"
        "    lsls    r4, r4, #1\n"
        "    adds    r0, r4, #0\n"
        "    orrs    r0, r1\n"
        "    orrs    r0, r2\n"
        "    strh    r0, [r5, #52]\n"
        "_sub_08009A58_set_slot:\n"
        "    mov     r1, r9\n"
        "    ldrb    r1, [r1, #0]\n"
        "    lsls    r0, r1, #3\n"
        "    ldr     r2, _sub_08009A58_pool_6160\n"
        "    adds    r0, r0, r2\n"
        "    mov     r3, r8\n"
        "    strb    r3, [r0, #0]\n"
        "    mov     r4, r9\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r0, r4, #3\n"
        "    adds    r0, r0, r2\n"
        "    ldrh    r1, [r5, #38]\n"
        "    add     r1, ip\n"
        "    strh    r1, [r0, #2]\n"
        "    mov     r1, r9\n"
        "    ldrb    r1, [r1, #0]\n"
        "    lsls    r0, r1, #3\n"
        "    adds    r0, r0, r2\n"
        "    ldr     r1, _sub_08009A58_pool_ffff\n"
        "    strh    r1, [r0, #4]\n"
        "    mov     r2, r9\n"
        "    ldrb    r0, [r2, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r2, #0]\n"
        "_sub_08009A58_call_696c:\n"
        "    ldr     r0, _sub_08009A58_pool_6110_b\n"
        "    mov     r1, r8\n"
        "    bl      ModeControl_SetBit\n"
        "    b       _sub_08009A58_step\n"
        "    .align  2, 0\n"
        "_sub_08009A58_pool_60a0:   .4byte 0x030060a0\n"
        "_sub_08009A58_pool_6110_b: .4byte 0x03006110\n"
        "_sub_08009A58_pool_3720:   .4byte 0x03003720\n"
        "_sub_08009A58_pool_6160:   .4byte 0x03006160\n"
        "_sub_08009A58_pool_ffff:   .4byte 0x0000ffff\n"
        "_sub_08009A58_clear_bit:\n"
        "    ldr     r3, _sub_08009A58_pool_fffe\n"
        "    adds    r0, r3, #0\n"
        "    ldrh    r4, [r5, #52]\n"
        "    ands    r0, r4\n"
        "    strh    r0, [r5, #52]\n"
        "_sub_08009A58_step:\n"
        "    ldr     r0, [sp, #8]\n"
        "    adds    r0, #56\n"
        "    str     r0, [sp, #8]\n"
        "    movs    r1, #1\n"
        "    add     r8, r1\n"
        "    ldr     r2, _sub_08009A58_pool_6140\n"
        "    ldrb    r2, [r2, #0]\n"
        "    cmp     r8, r2\n"
        "    blt     _sub_08009A58_loop\n"
        "_sub_08009A58_epilogue:\n"
        "    add     sp, #12\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "_sub_08009A58_pool_fffe:   .4byte 0x0000fffe\n"
        "_sub_08009A58_pool_6140:   .4byte 0x03006140\n"
        "    .syntax divided\n");
}
#endif
