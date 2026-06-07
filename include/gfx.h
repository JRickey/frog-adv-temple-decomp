#ifndef GUARD_GFX_H
#define GUARD_GFX_H

#include "types.h"

/* Canonical prototypes for the graphics / sprite / tilemap / blend / screen
 * helpers in src/engine, centralized from per-caller ad-hoc externs
 * (see tools/agent/unify_prototype.py). */

u16 Blend_StartFade(u16 arg);

u32 SpriteAsset_LoadSheet(u8 a, u8 b);

u16 Screen_BeginFlash(u16 arg);

s32 Screen_TickFlash(void);

#endif /* GUARD_GFX_H */
