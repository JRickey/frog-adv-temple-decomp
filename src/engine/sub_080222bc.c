#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayout_310DF4[8];
extern const u32 sLevelLayout_310E14[12];
extern const u32 sLevelLayout_310E44[12];
extern const u32 sLevelLayout_310E74[8];
extern const u32 sLevelLayout_310E94[8];

void sub_080222BC(void)
{
    sub_080210A0(0x31, sLevelLayout_310DF4, 16, 13, 0xD5, 8, 2, 2);
    sub_080210A0(0x32, sLevelLayout_310E14, 16, 13, 0xE5, 8, 3, 3);
    sub_080210A0(0x33, sLevelLayout_310E44, 16, 13, 0xD5, 8, 3, 3);
    sub_080210A0(0x34, sLevelLayout_310E74, 16, 13, 0xE5, 8, 3, 3);
    sub_080210A0(0x35, sLevelLayout_310E94, 16, 13, 0xE5, 8, 2, 3);
}
