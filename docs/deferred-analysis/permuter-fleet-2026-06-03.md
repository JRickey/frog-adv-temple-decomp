# Permuter fleet seeds — NON_MATCHING functions (2026-06-03)

Lower-diff near-match C bodies the tuned-weights permuter fleet found for
currently-NAKED `#ifdef NON_MATCHING` functions. The readable bodies in `src/`
are intentionally kept; these are the lower-diff RESUME SEEDS (permuter-mutated,
so lightly mangled). Score is old_agbcc permuter units (0 = true match).

## sub_08000E0C — score 220 (down from 285)

Win: drop the `coord` temp, inline the four `*(u32*)(&gIwram_35E0 + 8)` loads.

```c
void sub_08000E0C(void *ent, u32 arg1)
{
  u8 tile;
  u32 coord;
  sub_0800B918(ent, arg1, 3);
  if ((gEntities[0].status & 4) != 0)
  {
    return;
  }
  tile = (u8) sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
  if ((gIwram_35E0._field_10 & 0x10) != 0)
  {
    sub_0800C358(tile);
    sub_0800B8A8(ent, arg1, 3, tile);
  }
  if (((u8) sub_08006BA4(&gIwram_35E0, 0x40)) == 0)
  {
    return;
  }
  ;
  if ((*((u32 *) (((u8 *) (&gIwram_35E0)) + 8))) == 0x001c0006)
  {
    *(((u8 *) gEntities) + 6) = 2;
  }
  if ((*((u32 *) (((u8 *) (&gIwram_35E0)) + 8))) == 0x001c0007)
  {
    *(((u8 *) gEntities) + 6) = 3;
  }
  if ((*((u32 *) (((u8 *) (&gIwram_35E0)) + 8))) == 0x001c000d)
  {
    *(((u8 *) gEntities) + 6) = 3;
  }
  if ((*((u32 *) (((u8 *) (&gIwram_35E0)) + 8))) == 0x001c000e)
  {
    *(((u8 *) gEntities) + 6) = 2;
  }
}
```

## sub_08021E34 — score 200 (down from 205, marginal)

Only 1 field off the readable form; a `dx` duplicate-assignment mutation. Probably
not worth the mangling — noted for completeness.

```c
u8 sub_08021E34(struct Entity *s, u8 halfW, u8 halfH)
{
  s16 tileX = (s16) (((s16) s->x) / 24);
  s16 tileY = (s16) (((s16) s->y) / 24);
  u16 dx;
  s16 new_var;
  u16 dy;
  if ((gIwram_35E0._field_8 - tileX) >= 0)
  {
    dx = (u16) (gIwram_35E0._field_8 - tileX);
  }
  else
  {
    dx = (u16) (tileX - gIwram_35E0._field_8);
    dx = (u16) (tileX - gIwram_35E0._field_8);
  }
  new_var = (s16) dx;
  if ((gIwram_35E0._field_A - tileY) >= 0)
  {
    dy = (u16) (gIwram_35E0._field_A - tileY);
  }
  else
  {
    dy = (u16) (tileY - gIwram_35E0._field_A);
  }
  if (new_var > halfW)
  {
    return 0;
  }
  if (((s16) dy) > halfH)
  {
    return 0;
  }
  return 1;
}
```
