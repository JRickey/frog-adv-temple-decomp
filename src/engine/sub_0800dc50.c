#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* --- sub_0800DC50: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

#define SPAWN_FLAG_DONE    1
#define SPAWN_FLAG_WAITING 2

typedef struct EntityInitDesc {
    s8 spawnCount;
    u8 settleLimit;
    u8 waitLimit;
    u8 _pad3;
    const s16 *points;
} EntityInitDesc;

extern const EntityInitDesc sEntityInitTable[];

extern void sub_0800A520(void);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
/* s16 (NOT u16) params -> register-offset ldrsh at the call site -> correct 304 B size */
extern u32 sub_0800A458(s16 x, s16 y);

void sub_0800DC50(void)
{
    u8 flags;
    u32 origin;
    s8 i;
    u8 result;

    flags = 0;
    origin = gGameStuff._unk00;

    while ((gGameStuff._unk00 - origin) < sEntityInitTable[gGameStuff.pendingMode].settleLimit &&
           gEntities[0].field_1A <= 3) {
        sub_0800A520();
        sub_0800A2D8();
        sub_080008DC();
        sub_0800A328();
    }

    if (sEntityInitTable[gGameStuff.pendingMode].spawnCount == 0) {
        return;
    }

    for (i = 0; i < sEntityInitTable[gGameStuff.pendingMode].spawnCount; i++) {
        flags &= ~SPAWN_FLAG_DONE;
        while ((flags & SPAWN_FLAG_DONE) == 0) {
            if (flags & SPAWN_FLAG_WAITING) {
                if ((gGameStuff._unk00 - origin) > sEntityInitTable[gGameStuff.pendingMode].waitLimit) {
                    flags &= ~SPAWN_FLAG_WAITING;
                }
            } else {
                const s16 *points = sEntityInitTable[gGameStuff.pendingMode].points + i * 2;
                result = (u8)sub_0800A458(points[0], points[1]);
                if (result == 0xff) {
                    origin = gGameStuff._unk00;
                    flags |= SPAWN_FLAG_WAITING;
                }
                if (result == 1) {
                    flags |= SPAWN_FLAG_DONE;
                }
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
        }
    }
}
#endif /* NON_MATCHING */
