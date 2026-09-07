#include "game.h"
#include "iwram.h"
#include "types.h"

extern void SpawnControl_Dispatch(void);
extern void Entity22_Update(void);

void sub_0802CA54(void)
{
    SpawnControl_Dispatch();
    Entity22_Update();
}
