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

/* Function attribute: emit no prologue/epilogue. Body must be a single
 * inline asm("…") block that preserves the AAPCS contract by hand.
 * Used for functions whose baserom assembly uses high registers
 * (sl/r10, sb/r9, r8) for loop state — agbcc 2.x's register allocator
 * won't produce that shape from any plausible C input. See
 * docs/codegen-notes.md "High registers — corpus-validated unmatchable".
 */
#define NAKED __attribute__((naked))

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
