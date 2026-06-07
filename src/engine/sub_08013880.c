#include "macros.h"
#include "gfx.h"
#include "types.h"

extern void BgLayer_Init(void);
extern void BgScrollBlit(u8 arg);

void BgLayer_InitAndCommit(void)
{
    BgLayer_Init();
    BgScrollBlit(2);
    BgLayer_Disable(2);
}
