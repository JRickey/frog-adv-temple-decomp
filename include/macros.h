#ifndef GUARD_MACROS_H
#define GUARD_MACROS_H

#include "types.h"

#define ARRAY_SIZE(a)                 ((int)(sizeof((a)) / sizeof((a)[0])))
#define OFFSET_OF(type, mem)          ((int)&(((type *)0)->mem))

#define LOW_BYTE(v)                   ((v) & UCHAR_MAX)
#define HIGH_BYTE(v)                  (((v) & (UCHAR_MAX << 8)) >> 8)
#define LOW_SHORT(v)                  ((v) & USHORT_MAX)
#define HIGH_SHORT(v)                 ((v) >> 16)

#define CHECK_ALL_FLAGS(value, flags) (((value) & (flags)) == (flags))

/* INCBIN macros are recognized by tools/preproc and expanded into typed
 * arrays at compile time. Use the typed variants so the compiler knows the
 * element width. */
#define INCBIN_U8  INCBIN
#define INCBIN_U16 INCBIN
#define INCBIN_U32 INCBIN
#define INCBIN_S8  INCBIN
#define INCBIN_S16 INCBIN
#define INCBIN_S32 INCBIN

#endif /* GUARD_MACROS_H */
