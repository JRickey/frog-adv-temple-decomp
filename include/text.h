#ifndef GUARD_TEXT_H
#define GUARD_TEXT_H

#include "types.h"

/* screenArg values 0..3 select VRAM screenblocks 28..31. */
void DrawTextGlyphs(const u8 *str, s32 countArg, s32 colArg, s32 rowArg, s32 tileBaseArg, s32 palBank, s32 screenArg);

s32 ParseDecimalStr(const char *str, u8 len);

#endif /* GUARD_TEXT_H */
