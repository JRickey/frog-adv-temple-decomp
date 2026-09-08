#ifndef GUARD_LEVEL_LAYOUT_H
#define GUARD_LEVEL_LAYOUT_H

#include "types.h"

/* Scalar widths follow the register and stack argument conversions at 0x08021140. */
void LevelLayout_WalkRecords(u16 slot, const void *records, u16 flags, u8 kind, u16 field14, u8 field16, u8 field17);

#endif /* GUARD_LEVEL_LAYOUT_H */
