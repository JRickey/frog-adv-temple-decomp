#include "types.h"

/* Sound-system mutation lock — acquire (sub_0802E418) and release
 * (sub_0802E3F8).
 *
 * The sound subsystem keeps a refcount byte at SoundSystem+0xbb that
 * brackets every mutator of the SoundState block (per-channel envelope
 * ticks, the mixer tick, the per-slot pan/fade emitters). On the 0->1
 * acquire transition the underlying ARM trampoline at 0x08035d8c
 * disables the sound IRQ; on the 1->0 release transition the trampoline
 * at 0x08035d94 re-enables it.
 *
 * Together these form the critical-section primitive used throughout
 * the sound engine to keep the per-VBlank tick from racing the audio
 * DMA. See docs/subsystems.md "Audio / sound" for the broader cluster
 * picture.
 *
 * The three slot-descriptor helpers below (sub_0802E43C / sub_0802E470 /
 * sub_0802E4B4) take a packed descriptor word: bits 16..23 are a slot
 * index, the low 16 bits a per-channel work index.
 *   sub_0802E43C: point slotStateA[idx] at the slot's slice of mixTable.
 *   sub_0802E470: tear that wiring back down (clear slotStateA[idx], the
 *                 chanWork entry, and the slot's flags).
 *   sub_0802E4B4: set a slot's pan byte and flag it dirty for the mixer.
 */

typedef struct SoundSlot {
    u8 _pad00[0x38];
    u32 flags;   /* +0x38 — dirty/active bitfield */
    u8 panCache; /* +0x3c — last emitted pan byte */
} SoundSlot;

typedef struct SoundSystem {
    u8 _pad00[0xba];
    u8 panBits;      /* +0xba — hi byte of REG_SOUNDCNT_L cache */
    u8 lockRefCount; /* +0xbb */
    u8 _padbc[4];
    u32 *mixTable;      /* +0xc0 — per-slot mix-state pool (28-byte stride) */
    u32 *slotStateA;    /* +0xc4 — per-slot mix-state pointer table */
    SoundSlot *swSlots; /* +0xc8 — software-mixed slot array (64-byte stride) */
    u8 _padcc[0x58];
    u32 chanWork[1]; /* +0x124 — per-channel work table */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

/* Thumb-callable interwork veneers that branch to the ARM-mode
 * sound-IRQ toggle routines. Both are 8-byte `bx pc; nop; b TARGET`
 * thunks living at the named addresses. */
extern void sub_08035D8C(void); /* sound-IRQ disable; b 0x08032e38 */
extern void sub_08035D94(void); /* sound-IRQ enable;  b 0x08032e1c */

void sub_0802E3F8(void)
{
    u8 *p = &gpSoundSystem->lockRefCount;
    s32 v = *p - 1;
    *p = v;
    if ((u8)v == 0)
        sub_08035D94();
}

void sub_0802E418(void)
{
    u8 *p = &gpSoundSystem->lockRefCount;
    s32 v = *p + 1;
    *p = v;
    if ((u8)v == 1)
        sub_08035D8C();
}

void sub_0802E43C(u32 desc)
{
    s32 idx;
    SoundSystem *ss;

    if (desc == 0)
        return;

    idx = (desc >> 16) & 0xff;
    ss = gpSoundSystem;
    ss->slotStateA[idx] = (u32)(ss->mixTable + idx * 7);
}

void sub_0802E470(u32 desc)
{
    s32 idx;
    s32 lo;
    SoundSystem *ss;

    if (desc == 0)
        return;

    lo = desc & 0xffff;
    idx = (desc >> 16) & 0xff;
    ss = gpSoundSystem;
    ss->slotStateA[idx] = 0;
    ss->chanWork[lo] = 0;
    ss->swSlots[idx].flags = 0;
}

/* `pPool` keeps &gpSoundSystem (not the deref'd base) so each
 * `(*pPool)->swSlots[idx]` reloads the pool word — the baserom derefs
 * gpSoundSystem twice. Caching the base in one local lets agbcc CSE the
 * second reload away and breaks the match. */
void sub_0802E4B4(u32 desc, u32 pan)
{
    SoundSystem **pPool;
    s32 idx;

    if (desc == 0)
        return;

    idx = (desc >> 16) & 0xff;
    pPool = &gpSoundSystem;
    (*pPool)->swSlots[idx].panCache = pan;
    (*pPool)->swSlots[idx].flags |= 0x80;
}

void sub_0802E4E8(u32 desc, u32 enable)
{
    register s32 idx asm("r1");
    register SoundSystem *ss asm("r3");
    register SoundSystem *mixBase asm("r2");
    u8 *dst;
    register u32 value asm("r0");
    register u32 enableReg asm("r4") = enable;

    if (desc == 0)
        return;

    idx = (desc >> 16) & 0xff;
    ss = gpSoundSystem;
    mixBase = ss;
    dst = (u8 *)mixBase->mixTable + idx * 28;
    if (enableReg != 0) {
        mixBase = (SoundSystem *)((u8 *)ss + 0x10e);
        value = *(u8 *)mixBase;
    } else {
        value = 0;
    }
    dst[27] = value;
}
