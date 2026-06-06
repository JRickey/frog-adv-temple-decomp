#include "types.h"

extern void Scene_DisableBg2(void);
extern void Sound_Reset(void);
extern void SoundSystem_FadeOut(void);

void Attract_Cleanup(void)
{
    Scene_DisableBg2();
    Sound_Reset();
    SoundSystem_FadeOut();
}
