#include "entity.h"
#include "gfx.h"
extern void ModeControl_Init(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                             unsigned int f);
extern void EntityDispatch_RunFrame(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene20_UpdateParts(unsigned int a, unsigned int b, unsigned int c, unsigned int d);

struct Unk_03005330 {
    unsigned char unk0[20];
    unsigned int unk14;
};

void Scene14_Init(void)
{
    ModeControl_Init(0x03006110, 0x80, 14, 0x082F9B6C, 1, 3);
    SpriteAsset_LoadSheet(14, 0);
    EntityDispatch_RunFrame();
}

void Scene_FrameUpdateWithLayers(unsigned int a, unsigned int b, unsigned int c, unsigned int d, unsigned int e,
                                 unsigned int f, unsigned int g)
{
    Entity_RunScript(2, (void *)a);
    EntityScript_Advance(0, 3, b);
    EntityScript_Advance(1, 4, c);
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Scene20_UpdateParts(d, e, f, g);
    ((struct Unk_03005330 *)0x03005330)->unk14++;
}
