#include "macros.h"
#include "entity_motion.h"
#include "types.h"

/* --- Entity22_Update: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void DirToMotion(u8 dir, s8 *outX, s8 *outY);
extern void Entity_Update(void *p);

void Entity22_Update(void)
{
    struct Entity *entity = &gEntities[22];
    s8 out[2];
    u8 nextState;

    switch (entity->state) {
    case 0:
        MotionDesc_Set((struct MotionDesc *)entity, 0, 0, 0);
        if ((entity->status & 0x8000) == 0)
            goto done;

        entity->state = *((u8 *)entity + 0x6aa);
        entity->status |= 2;
        {
            u8 dir = entity->state;
            register s8 *outY asm("r4") = &out[1];
            DirToMotion(dir, &out[0], outY);
            MotionDesc_Set((struct MotionDesc *)entity, 2, out[0], *outY);
        }
        entity->status &= 0x7fff;
        goto done;

    case 3: {
        u16 status;
        EntityMover_Tick(22);
        status = entity->status;
        if (status & 0x8000) {
            /* r0 pin threads the (2|status)&0x7fff accumulator through r0,
               matching `movs r0,#2; orrs r0,r1; ldr r1,=0x7fff; ands r0,r1`. */
            register u16 t asm("r0");
            t = 2;
            t |= status;
            t &= 0x7fff;
            entity->status = t;
        }

        if (entity->x > 0x77)
            goto done;
        nextState = 4;
        break;
    }

    case 4: {
        u16 status;
        EntityMover_Tick(22);
        status = entity->status;
        if (status & 0x8000) {
            register u16 t asm("r0");
            t = 2;
            t |= status;
            t &= 0x7fff;
            entity->status = t;
        }

        if (entity->x <= 0xc0)
            goto done;
        nextState = 3;
        break;
    }

    default:
        goto done;
    }

    entity->state = nextState;
    *((u8 *)entity + 0x6aa) = nextState;
    {
        u8 dir = entity->state;
        register s8 *outY asm("r4") = &out[1];
        DirToMotion(dir, &out[0], outY);
        MotionDesc_Set((struct MotionDesc *)entity, 2, out[0], *outY);
    }
    entity->status |= 2;

done:
    Entity_Update(entity);
}
#else
NAKED void Entity22_Update(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x2c910, 0x144\n");
}
#endif /* NON_MATCHING */
