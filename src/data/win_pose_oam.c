#include "macros.h"
#include "types.h"

/* Win-pose / level-intro OAM sprite data at 0x081bd910..0x081bda44.
 *
 * Surfaced by tools/agent/refcount_pool_loads.py: address 0x081bd918 with
 * 5 pool-load references and 0x081bd92c with 4 — both feeding the
 * still-asm sprite-setup routine starting at 0x08018cb0. The wider region
 * up through 0x081bda44 is a related cluster of OAM/coord tables and a
 * trailing tile-stream byte buffer.
 *
 * Consumer pattern (extract of 0x08018cd0):
 *
 *     if (gGameStuff.mode == 27)        { table = &sWinPoseSpriteCoords[0]; count = 5; }
 *     else if (gGameStuff.mode == 4)    { table = &sWinPoseSpriteCoords[10]; count = 3; }
 *     ldrh r0, [table + gGameStuff[20]*4 + 0]   -- x
 *     ldrh r0, [table + gGameStuff[20]*4 + 2]   -- y
 *     subs r0, #16                              -- bias to OAM origin (0,0)
 *     ldrb r0, [table + gGameStuff[20]*4 + 0]   -- low byte (size/shape bits)
 *     ldrb r0, [table + gGameStuff[20]*4 + 2]   -- low byte
 *     ... stores to [oam + 0..31] = attr0/attr1/attr2 + extras
 *
 * Game modes 27 (0x1b, post-game "win pose") and 4 (an early game-state
 * variant — likely the title-screen flourish) each use a different
 * starting offset into sWinPoseSpriteCoords with gGameStuff[20] naming
 * the sprite-within-the-pose.
 *
 * Sub-tables, in baserom address order:
 *
 *   0x081bd910 sWinPoseHeader[4]         (8 B)   3 u16 misc + pad
 *   0x081bd918 sWinPoseSpriteCoords[16]  (32 B)  16 u16 packed (x, y) pairs.
 *                                                Mode 27 reads from index 0
 *                                                (anchor 0x081bd918, 5 refs).
 *                                                Mode 4 reads from index 10
 *                                                (anchor 0x081bd92c, 4 refs).
 *   0x081bd938 sWinPoseAnimDeltaSeq[8]   (8 B)   small signed deltas
 *                                                {0x00, 0xff, 0xfe, 0xff,
 *                                                 0x00, 0x01, 0x02, 0x01}
 *                                                — looks like a 4-frame
 *                                                (dx, dy) wobble.
 *   0x081bd940 sWinPoseScreenCoords[17]  (68 B)  17 u32 packed (u16, u16)
 *                                                pairs in pixel range
 *                                                0x44..0x194 (240x160 screen).
 *   0x081bd984 sWinPoseTileStream        (192 B) u8 byte stream used as a
 *                                                BG-tilemap stamp source.
 *
 * Promote sub-tables to typed structs once the 0x08018cb0 consumer lands
 * in C.
 */

const u16 sWinPoseHeader[4] = INCBIN_U16("data/ui/win_pose_header.bin");
const u16 sWinPoseSpriteCoords[16] = INCBIN_U16("data/ui/win_pose_sprite_coords.bin");
const u8 sWinPoseAnimDeltaSeq[8] = INCBIN_U8("data/ui/win_pose_anim_delta_seq.bin");
const u32 sWinPoseScreenCoords[17] = INCBIN_U32("data/ui/win_pose_screen_coords.bin");
const u8 sWinPoseTileStream[192] = INCBIN_U8("data/ui/win_pose_tile_stream.bin");
