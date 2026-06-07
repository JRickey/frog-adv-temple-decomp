#include "types.h"
#include "game.h"
#include "iwram.h"

extern void CharLayers_Upload(unsigned int arg);
extern void FrogOam_Init(void);
extern void ResetBgAnimState(void);
extern void Scroll_UpdateCamera(unsigned int arg);
extern void BgScrollBlit(unsigned int arg);
extern void BgScrollAnim_Update(void);
extern void StatusBar_Update(void);
extern void BgLayer_Enable(u8 layer);
extern void sub_08010A44(u8 a, u8 b);
extern void ModeChannel_Apply(u8 a, u8 b);
extern void FrogStatusBar_Update(void);
extern u8 gIwram_53A0[];
extern u8 gIwram_549F[];
extern u8 gIwram_3610[];
extern u8 gIwram_60A0[];

struct TransferDesc_13D44 {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

extern void DmaJob_Advance(struct TransferDesc_13D44 desc, u8 mode, void *buf);

void InitScene3Layer(void)
{
    CharLayers_Upload(3);
    FrogOam_Init();
    ResetBgAnimState();
    Scroll_UpdateCamera(3);
    BgScrollBlit(3);
    BgScrollAnim_Update();
    StatusBar_Update();
}

void BgBlendTilemapUpdate(void)
{
    u8 *scrollBase;
    u8 *scrollFlag;
    u8 *control;
    const struct TransferDesc_13D44 *desc;

    scrollBase = gIwram_60A0;
    scrollFlag = scrollBase + 0x40;
    if ((*scrollFlag & 1) != 0) {
        *(u16 *)0x04000050 = 0x1744;
        *(u16 *)0x04000052 = 0x0C04;
        *scrollFlag &= 0xFE;
        BgLayer_Enable(2);
    }

    control = (u8 *)&gIwram_6110;
    if ((*(u16 *)(control + 0x26) & 1) != 0) {
        control[0x2A] |= 1;
    }

    sub_08010A44(1, 1);
    FrogStatusBar_Update();

    desc = (const struct TransferDesc_13D44 *)0x08307238;
    DmaJob_Advance(*desc, ((const u8 *)desc)[2], (void *)0x030064C0);
}

void InitScene2LayerA(void)
{
    CharLayers_Upload(2);
    FrogOam_Init();
    ModeChannel_Apply(1, 1);
    Scroll_UpdateCamera(2);
    BgScrollBlit(2);
    StatusBar_Update();
}

void PopulateRasterScrollBuffer(u8 n)
{
    u8 i;

    i = 0;
    while (i < n) {
        u8 *arr = gIwram_53A0;
        u8 *limit = arr + 0xFF;
        u8 *writeIdx = arr + 0xFE;
        u8 rnd = GetVcountRandom(*limit);
        u8 j = rnd;
        int dst;

        arr[rnd] = 1;
        dst = *writeIdx + 0x64;
        arr[dst] = gIwram_3610[rnd];
        (*writeIdx)++;

        if (rnd < *limit) {
            do {
                gIwram_3610[j] = gIwram_3610[j + 1];
                j++;
            } while (j < *gIwram_549F);
        }

        i++;
        (*limit)--;
    }
}
