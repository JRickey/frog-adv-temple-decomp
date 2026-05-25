#include "types.h"

typedef struct {
    u8 _pad0[10];
    u8 mode;
} GameStuff;

#define gGameStuff (*(GameStuff *)0x03005330)

void SetGameMode_15(void)
{
    gGameStuff.mode = 15;
}
