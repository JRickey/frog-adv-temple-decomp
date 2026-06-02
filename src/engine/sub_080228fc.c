#include "iwram.h"
#include "types.h"

extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern const u32 sLevelLayout_310C44[12];

void sub_080228FC(void)
{
    sub_08021510(0x47, sLevelLayout_310C44, 16, &gIwram_6110, 0);
}

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_3113C8[8];
extern const u32 sLevelLayoutPtrs_31118C[7];
extern const u32 sLevelLayout_310DF4[8];
extern const u32 sLevelLayout_310E14[12];
extern const u32 sLevelLayout_310E44[12];
extern const u32 sLevelLayout_310E74[8];
extern const u32 sLevelLayout_310E94[8];
extern const u32 sLevelLayout_310B54[4];

void sub_08022920(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_3113C8[i], i + 0x4c);
        i++;
    } while (i <= 7);

    sub_08020FE4(0x4c, 0x53);
    sub_08005D10(0x4c, 0x53);
}

extern void sub_08021140(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern const u32 sLevelLayout_311418[10];
extern const u32 sLevelLayout_311440[4];

void sub_08022958(void)
{
    sub_08021140(2, sLevelLayout_311418, 0x10, 2, 0x51, 2, 0x14);
}

void sub_08022980(void)
{
    sub_08021510(2, sLevelLayout_311418, 2, &gIwram_6110, 0x14);
}

void sub_080229A4(void)
{
    sub_08021140(6, sLevelLayout_311440, 0, 0xb, 0xd1, 7, 10);
}

void sub_080229CC(void)
{
    sub_08021510(6, sLevelLayout_311440, 0xb, &gIwram_6110, 10);
}

void sub_080229F0(void)
{
    u8 i;

    i = 0;
    do {
        sub_080219BC((const void *)sLevelLayoutPtrs_31118C[i], i + 0x3e);
        i++;
    } while (i <= 6);

    sub_08020FE4(0x3e, 0x44);
    sub_08005D10(0x3e, 0x44);
}

extern int sub_0800D028(u8 a0);
extern void sub_08021EEC(const void *a0, u8 a1);

void sub_08022A28(void)
{
    if (sub_0800D028(0x31) != 0)
        sub_08021EEC(sLevelLayout_310DF4, 0x31);

    if (sub_0800D028(0x32) != 0)
        sub_08021EEC(sLevelLayout_310E14, 0x32);

    if (sub_0800D028(0x33) != 0)
        sub_08021EEC(sLevelLayout_310E44, 0x33);

    if (sub_0800D028(0x34) != 0)
        sub_08021EEC(sLevelLayout_310E74, 0x34);

    if (sub_0800D028(0x35) != 0)
        sub_08021EEC(sLevelLayout_310E94, 0x35);
}

void sub_08022A9C(void)
{
    sub_08021140(0x59, sLevelLayout_310B54, 0, 0x4c, 0x1c5, 13, 0);
}

void sub_08022AC8(void)
{
    sub_08021510(0x59, sLevelLayout_310B54, 0x4c, &gIwram_6110, 0);
}

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
} SoundChannelTable;

#define gSoundChannelTable (*(SoundChannelTable *)0x03003570)

extern const SoundChannelEntry sLevelLayoutManifest_311450[7];

extern void sub_08022730(void);
extern void sub_080221FC(void);
extern void sub_080222BC(void);
extern void sub_08022884(void);
extern void sub_080227B4(void);
extern void sub_0802205C(void);
extern void sub_08022838(void);
extern void sub_080220C4(void);
extern void sub_08022360(void);
extern void sub_080228D0(void);
extern void sub_08021F64(void);

void sub_08022AEC(void)
{
    u8 i;

    i = 0;
    do {
        gSoundChannelTable.entries[i] = sLevelLayoutManifest_311450[i];
        i++;
    } while (i <= 6);

    sub_08022730();
    sub_080221FC();
    sub_080222BC();
    sub_08022884();
    sub_080227B4();
    sub_0802205C();
    sub_08022838();
    sub_080220C4();
    sub_08022360();
    sub_080228D0();
    sub_08021F64();
    sub_08022A9C();
}
