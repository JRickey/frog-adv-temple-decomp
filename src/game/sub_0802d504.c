#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Entity2_Tick(void);
extern void sub_0802D170(void);

void sub_0802D504(void)
{
    Entity2_Tick();
    sub_0802D170();
}
