#include "macros.h"
#include "types.h"

extern void BgLayer_Init(void);
extern void BgScrollBlit(u8 arg);
extern void BgLayer_Disable(u8 layer);

void BgLayer_InitAndCommit(void)
{
    BgLayer_Init();
    BgScrollBlit(2);
    BgLayer_Disable(2);
}
