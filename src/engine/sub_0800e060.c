#include "game.h"
#include "sound.h"
#include "gba/dma.h"
#include "types.h"

extern void SoundSystem_StopAll(void);

/* Scene/mode teardown dispatched on gGameStuff.sceneType. Modes 3, 6, 9, 15
 * additionally clear REG_BLDCNT before the shared teardown body; all other
 * sceneType values (and any out-of-range) skip straight to the body.
 *
 * Shared body:
 *   - DMA3 halfword-fill 0x400 halfwords at OBJ-VRAM 0x0600F800 from a
 *     stack-local halfword seed of 0xF039.
 *   - Reset five bytes in the 0x03005370 control struct (offsets 0/4/8/12/16).
 *   - Set the 0x03005328 control byte to 1.
 *   - DMA3 copy from ROM 0x080E3AB6 to BG-VRAM 0x06008000 (0x2000 halfwords).
 *   - If *(u32 *)0x030034B0 is nonzero, DMA3 copy a second tile blob
 *     pointed to by g_TileBlobTable[*(u32 *)0x030034B0 - 1] into the same
 *     BG-VRAM region (0xA00 halfwords).
 *   - Call SoundSystem_StopAll(), then Sound_Play(3).
 *   - Set gGameStuff._unk18 |= 1 and gGameStuff._unk04 = 6.
 *
 * Matching notes (agbcc 2.x):
 *   - The 16-entry casesi jump table at e080 comes from `switch (sceneType)`
 *     with explicit empty cases 1..16 (so agbcc keeps the dense
 *     `subs #1; cmp #15; bhi default` dispatch instead of folding the four
 *     active cases into an if-chain).
 *   - The empty `tileTable` barrier blocks agbcc from CSE-folding
 *     `&tileTable[idx-1]` into `(tileTable - 4) + idx*4`. Without the
 *     barrier the pool literal stores 0x08308FA8 (= 0x08308FAC - 4) and
 *     the `subs r0, #1` step disappears.
 *   - The trailing `g` plus `flag` block keeps the post-BL recovery
 *     sequence in baserom's `ldr r0, [pool]; movs r1, #1; ldrb r2,
 *     [r0, #24]; orrs r1, r2; strb r1, [r0, #24]` shape.
 */

void Scene_LoadBg(void)
{
    vu16 seed;
    u8 *ctrl5370;
    u32 idx;
    const u32 *tileTable;

    switch (gGameStuff.sceneType) {
    case 3:
    case 6:
    case 9:
    case 15:
        *(vu16 *)0x04000050 = 0;
        break;
    case 1:
    case 2:
    case 4:
    case 5:
    case 7:
    case 8:
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 16:
    default:
        break;
    }

    seed = 0xF039;
    REG_DMA3.src = (const void *)&seed;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;

    ctrl5370 = (u8 *)0x03005370;
    ctrl5370[0] = 1;
    ctrl5370[4] = 3;
    ctrl5370[8] = 1;
    ctrl5370[12] = 9;
    ctrl5370[16] = 9;

    *(u8 *)0x03005328 = 1;

    REG_DMA3.src = (const void *)0x080E3AB6;
    REG_DMA3.dst = (void *)0x06008000;
    REG_DMA3.cnt = DMA_ENABLE | 0x2000;
    (void)REG_DMA3.cnt;

    idx = *(u32 *)0x030034B0;
    if (idx != 0) {
        tileTable = (const u32 *)0x08308FAC;
        asm volatile("" : "+r"(tileTable));
        idx -= 1;
        REG_DMA3.src = (const void *)tileTable[idx];
        REG_DMA3.dst = (void *)0x06008000;
        REG_DMA3.cnt = DMA_ENABLE | 0xA00;
        (void)REG_DMA3.cnt;
    }

    SoundSystem_StopAll();
    Sound_Play(3);

    {
        GameStuff *g;
        u8 flag;
        g = &gGameStuff;
        flag = 1;
        g->_unk18 |= flag;
        g->_unk04 = 6;
    }
}
