#include "iwram.h"
#include "types.h"

extern void EntityMover_Tick(u8 idx);
extern void Entity_FollowPath(void *obj, u8 idx);
extern void Entity_Update(void *p);

void Entity_InitFromLayout(void *obj, u8 idx)
{
    EntityMover_Tick(idx);
    Entity_FollowPath(obj, idx);
    Entity_Update((u8 *)gEntities + idx * 56);
}

void DirToMotion(u8 dir, s8 *outX, s8 *outY)
{
    *outX = 0;
    *outY = 0;

    switch (dir) {
    case 1:
        *outY = -1;
        break;
    case 2:
        *outY = 1;
        break;
    case 3:
        *outX = -1;
        break;
    case 4:
        *outX = 1;
        break;
    }
}
