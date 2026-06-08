#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayout_310DF4[8];
extern const u32 sLevelLayout_310E14[12];
extern const u32 sLevelLayout_310E44[12];
extern const u32 sLevelLayout_310E74[8];
extern const u32 sLevelLayout_310E94[8];

void SpawnRowGroupEntities(void)
{
    Entity_InitSlotFromRecord(0x31, sLevelLayout_310DF4, 16, 13, 0xD5, 8, 2, 2);
    Entity_InitSlotFromRecord(0x32, sLevelLayout_310E14, 16, 13, 0xE5, 8, 3, 3);
    Entity_InitSlotFromRecord(0x33, sLevelLayout_310E44, 16, 13, 0xD5, 8, 3, 3);
    Entity_InitSlotFromRecord(0x34, sLevelLayout_310E74, 16, 13, 0xE5, 8, 3, 3);
    Entity_InitSlotFromRecord(0x35, sLevelLayout_310E94, 16, 13, 0xE5, 8, 2, 3);
}
