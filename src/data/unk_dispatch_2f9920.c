#include "macros.h"
#include "types.h"

/* Small dispatch cluster at [0x082f9920..0x082f9994).
 *
 * The 2-entry pointer pair at 0x082f998c is the anchor: it has 2
 * pool-load references from consumers at 0x08000cb6 and 0x0801a104,
 * both of which pass it as `r3` to a setup helper at 0x0800658c
 * which stores it as a field at offset 0x34 of a struct based at
 * `0x03006110` (an IWRAM gGameStuff region). The setup helper
 * pattern is roughly:
 *
 *     0x08000cb0: r0 = 0x03006110; r3 = sUnkPtrPair_82F998C;
 *                 bl 0x658c(struct=r0, ..., listPtr=r3);
 *     0x0801a102: ditto (different invocation context, r3 same).
 *
 * The pair pointers index into the preceding 9-row data block at
 * 0x082f9920:
 *
 *   sUnkPtrPair_82F998C[0] = &sUnkDispatchData_82F9920[0]   (row 0)
 *   sUnkPtrPair_82F998C[1] = &sUnkDispatchData_82F9920[8]   (row 8)
 *
 * sUnkDispatchData_82F9920 is 9 stride-12 records:
 *
 *     [0..5]  active records: {u16 a0, u16 a1, u32 flags, u32 z}
 *             with flags in {0x00030300, 0x00030303, 0x00030301,
 *             0x01020203, 0x01020200} and trailing word in {0, 1}.
 *     [6]     all-zero record (terminator or hole separating the
 *             two sub-lists -- consumer at 0x658c likely walks
 *             until zero).
 *     [7]     one further record (flags=0x01010201, z=1).
 *     [8]     the row pointed to by sUnkPtrPair_82F998C[1]
 *             (a single record, flags=0x02020300, z=0). Likely a
 *             different sub-list head.
 *
 * Sub-list A is rows [0..7] inclusive (the zero at row 6 may be
 * a sentinel inside the list rather than between lists); sub-list
 * B is the single row [8]. The pair indexes which list the
 * dispatcher walks at runtime.
 *
 * TODO: refine field types and rename once one of the consumers
 * (0x08000cb0 or 0x0801a104) lands in C. Both are still in
 * asm/text/text_0x080000c0.s / text_0x0801a0a4.s slices; the
 * setup helper at 0x0800658c is still in
 * asm/text/text_0x080065d8.s. The names here remain `Unk` until
 * the dispatcher purpose is clear -- candidates include sprite
 * priority list, particle effect spawner list, or HUD element
 * activation list. No semantic dimension has been confirmed.
 *
 * --- Cluster context (NOT extracted here) ---
 *
 * The preceding 0x082f8ec4..0x082f9920 region contains a much
 * larger stride-16 descriptor table (rows of shape
 * {u32 a, u32 b, u32 c=0x00000802, u32 ptr_to_subarray}) with
 * sub-arrays of u16 pairs. That cluster has no direct pool-load
 * references in the still-asm code (it is reached through other
 * function-pointer paths) and is left in the text blob
 * (text_0x082f8ec4.s) until its consumer surfaces.
 *
 * Similarly, 0x082f9994..0x082f99e8 holds another stride-12 data
 * block with its own 1-entry pointer record at 0x082f99e8; it is
 * left unextracted for the same reason (no current pool refs).
 */

const u32 sUnkDispatchData_82F9920[9 * 3] = INCBIN_U32("data/game/unk_dispatch_data_2f9920.bin");

const u32 *const sUnkPtrPair_82F998C[2] = {
    &sUnkDispatchData_82F9920[0],
    &sUnkDispatchData_82F9920[8 * 3], /* row 8 = byte offset 0x60 */
};
