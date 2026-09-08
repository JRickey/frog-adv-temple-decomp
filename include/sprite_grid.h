#ifndef GUARD_SPRITE_GRID_H
#define GUARD_SPRITE_GRID_H

#include "types.h"

/* The packed room grid stores the cell-class field in bits 4..9. */
void SpriteGrid_SetCellFlags(u8 gridId, u8 plane, s16 x, s16 y, u8 flags);

#endif /* GUARD_SPRITE_GRID_H */
