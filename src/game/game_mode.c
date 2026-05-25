#include "types.h"

/* Game-state structure at 0x03005330 in EWRAM. Layout is being discovered
 * incrementally — only the mode byte is named for now. */
typedef struct {
    u8 _pad0[10];
    u8 mode;
} GameStuff;

#define gGameStuff (*(GameStuff *)0x03005330)

void SetGameMode_06(void)
{
    gGameStuff.mode = 6;
}
