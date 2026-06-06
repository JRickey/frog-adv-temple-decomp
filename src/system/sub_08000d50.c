#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Game_FrameEnd(void);

extern void SpriteAsset_LoadSheet(u32 a, u32 b);
extern void EntityDispatch_RunFrame(void);
extern void BgMap_WriteTileAttr(u8 col, u8 row, u32 a, u32 b, u32 c);

/* Thin forwarder to Game_FrameEnd (the mode-15 / "level-cleanup" handler also
 * called from mode_15.c case 8). One of Scene08_Main's mode-dispatch callees;
 * appears to be the "release / teardown" entry the dispatcher invokes from
 * its mode-handler table. */
void Mode8_Teardown(void)
{
    Game_FrameEnd();
}

void Mode8_Setup(void)
{
    struct IwramAt35E0 *p35E0;

    ModeControl_Init(&gIwram_6110, 0x64, 2, (const void *)0x082f99e8, 1, 5);
    SpriteAsset_LoadSheet(3, 0);
    EntityDispatch_RunFrame();

    p35E0 = &gIwram_35E0;
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 13, 36, 14);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 14, 36, 13);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 14, 35, 13);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 14, 34, 13);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 14, 33, 13);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 14, 32, 13);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 14, 31, 13);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 14, 30, 13);
}
