#include "types.h"
#include "macros.h"

/* sub_08020E98 — broadcast a 7-bit value to all live sound-channel handles.
 *
 * The struct at 0x03003570 holds a sound-channel handle table starting at
 * offset 4: 12 entries × 8 B, each `{ s32 fieldA; u32 fieldB; }`. Entries
 * with fieldA == -1 are unused slots; for each live slot, fieldB is the
 * handle to forward into sub_0802DC1C. */

typedef struct {
    s32 fieldA;
    u32 fieldB;
} SoundChannelEntry;

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
    SoundChannelEntry entries[12];
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern void sub_0802DC1C(u32 handle, u8 val);

void sub_08020E98(u32 arg)
{
    u8 i;
    StructAt3003570 *p;
    u32 *fieldB_arr;
    u32 m_shifted;
    u32 offset;

    arg = arg << 24;
    do {
        i = 0;
        p = &gStructAt3003570;
        fieldB_arr = &p->entries[0].fieldB;
        m_shifted = arg & 0x7F000000;
        do {
            offset = (u32)i << 3;
            /* Keep the field-A base in r0 so agbcc emits the baserom's offset-first add. */
            {
                u32 fieldAAddr = (u32)&p->entries[0].fieldA;

                if (*(s32 *)(offset + fieldAAddr) != -1) {
                    sub_0802DC1C(fieldB_arr[i * 2], (u8)(m_shifted >> 24));
                }
            }
            i++;
        } while (i <= 11);
    } while (0);
}

/* Setter for the offset-3 counter byte that sub_08020EE4 (++) and
 * sub_08020F08 (--) maintain. The value arrives in the second argument
 * register (r1); r0 is unused on entry and is reused to hold the base. */
void sub_08020ED8(u32 unused, u32 value)
{
    gStructAt3003570.d = value;
}
