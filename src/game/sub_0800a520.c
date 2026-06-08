#include "entity.h"
#include "game.h"
#include "macros.h"
#include "types.h"

/* Per-frame helper called once from Game_RunEntityFrame (the entity-dispatch
 * tail). Runs five fixed subsystem updates in sequence. The single
 * non-zero argument (24, 24) to Player_ProbeSpawnDir is preserved literally;
 * its meaning is unknown until that callee is decompiled.
 *
 * Lives in its own .c rather than dispatch_helpers.c because the
 * sibling Game_RunEntityFrame sits at 0x0800a2d8 with multiple intervening
 * asm functions before this one — one .o cannot span both slots
 * without -ffunction-sections, which agbcc isn't built with here.
 */

extern void Entity_ProcessEvents(void);
extern void Player_ProbeSpawnDir(u32 a, u32 b);
extern void Player_UpdatePhysics(void);
extern void Player_UpdateTileCache(void);
extern void Entity_UpdateSlot1Status(void);

void Game_UpdateSubsystems(void)
{
    Entity_ProcessEvents();
    Player_ProbeSpawnDir(24, 24);
    Player_UpdatePhysics();
    Player_UpdateTileCache();
    Entity_UpdateSlot1Status();
}

struct ClusterA710;
extern void Entity_Init(struct ClusterA710 *p, u8 a, s16 b, s16 c, u8 d, u16 e, u8 f, u8 g, u8 h, u16 i);

/* Seeds entity[1] (0x03003758) from entity[0] (0x03003720, one 0x38 stride
 * back): copies its position halfwords (offsets 2/4, the +4 value biased by
 * 24) into the 10-arg struct initializer with otherwise constant fields.
 *
 * dst anchors the only pool literal (0x03003758); src is derived by
 * subtracting the 0x38 stride at runtime so agbcc keeps one pool word and
 * emits register-offset ldrsh instead of folding to a second literal. The
 * b/c parameters are declared s16 here (the canonical Entity_Init stores
 * them into u16 fields) so the caller sign-extends the position values. */
void Entity_InitShadow(void)
{
    struct ClusterA710 *dst = (struct ClusterA710 *)0x03003758;
    u8 *src = (u8 *)dst - 0x38;

    Entity_Init(dst, 84, *(s16 *)(src + 2), (s16)(*(u16 *)(src + 4) - 24), 3, 992, 15, 2, 0, 32);
}
/* Records sel at offset 0x2a, then writes a 3-byte motion descriptor (mode at
 * 0x32, delta-x at 0x30, delta-y at 0x31) selected by sel. Each case scales the
 * two signed delta bytes a/b by a fixed per-case factor; sel outside 0..13
 * leaves the deltas untouched.
 *
 * Built with -ffixed-r4..r7 (per-TU CFLAGS) so agbcc keeps a/b in their incoming
 * r2/r3 and never spills into a callee-saved register: the function then needs no
 * push/pop frame and caches the record pointer in ip the whole way. Cases run
 * high-to-low to match the baserom's descending case-body layout. */
void MotionDesc_Set(struct MotionDesc *m, u8 sel, u8 a, u8 b)
{
    m->sel = sel;

    switch ((s8)sel) {
    case 13:
        m->mode = 2;
        m->dx = a << 2;
        m->dy = b << 2;
        break;
    case 12:
        m->mode = 1;
        m->dx = a;
        m->dy = b;
        break;
    case 11:
        m->mode = 1;
        m->dx = a << 1;
        m->dy = b << 1;
        break;
    case 10:
        m->mode = 1;
        m->dx = (s8)a * 5;
        m->dy = (s8)b * 5;
        break;
    case 9:
        m->mode = 1;
        m->dx = a << 2;
        m->dy = b << 2;
        break;
    case 8:
        m->mode = 1;
        m->dx = (s8)a * 3;
        m->dy = (s8)b * 3;
        break;
    case 7:
        m->mode = 2;
        m->dx = (s8)a * 3;
        m->dy = (s8)b * 3;
        break;
    case 6:
        m->mode = 2;
        m->dx = (s8)a * 3;
        m->dy = (s8)b * 3;
        break;
    case 5:
        m->mode = 2;
        m->dx = a << 1;
        m->dy = b << 1;
        break;
    case 4:
        m->mode = 2;
        m->dx = a;
        m->dy = b;
        break;
    case 3:
        m->mode = 3;
        m->dx = a;
        m->dy = b;
        break;
    case 2:
        m->mode = 4;
        m->dx = a;
        m->dy = b;
        break;
    case 1:
        m->mode = 5;
        m->dx = a;
        m->dy = b;
        break;
    case 0:
        m->mode = 0xff;
        m->dx = 0;
        m->dy = 0;
        break;
    }
}
