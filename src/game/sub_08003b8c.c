#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void SpriteAsset_LoadSheet(u32 a, u32 b);
extern void EntityDispatch_RunFrame(void);
extern void BgMap_WriteTileAttr(u8 col, u8 row, u32 a, u32 b, u32 c);

void Mode12_Init(void)
{
    struct IwramAt35E0 *p35E0;
    s32 b;
    s32 i;

    ModeControl_Init(&gIwram_6110, 0x80, 12, (const void *)0x082f9b2c, 1, 5);
    SpriteAsset_LoadSheet(12, 0);
    EntityDispatch_RunFrame();

    i = 0;
    p35E0 = &gIwram_35E0;
    for (b = 0x5D0000; i <= 5; b += 0x10000, i++) {
        BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 6, b >> 16, 13);
        BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 7, b >> 16, 14);
    }
}
