#ifndef GUARD_GBA_SYSCALL_H
#define GUARD_GBA_SYSCALL_H

#include "types.h"

/*
 * BIOS SWI wrapper declarations (libagbsyscall).
 *
 * Attribution: public agbcc-era decompilation projects, including
 * pret/pokeemerald's libagbsyscall/libagbsyscall.s, preserve the SDK wrapper
 * names, order, and SWI numbers used here. GBATEK's public BIOS SWI
 * documentation was used to cross-check names and call signatures. The linked
 * wrapper bodies in this project are reconstructed from this ROM's own
 * disassembly; no leaked Konami or Nintendo source was referenced.
 */

#define RESET_EWRAM            0x01
#define RESET_IWRAM            0x02
#define RESET_PALETTE          0x04
#define RESET_VRAM             0x08
#define RESET_OAM              0x10
#define RESET_SIO_REGS         0x20
#define RESET_SOUND_REGS       0x40
#define RESET_REGS             0x80
#define RESET_ALL              0xFF

#define CPU_SET_SRC_FIXED      0x01000000
#define CPU_SET_16BIT          0x00000000
#define CPU_SET_32BIT          0x04000000
#define CPU_FAST_SET_SRC_FIXED 0x01000000

void SoftResetExram(void);
void RegisterRamReset(u32 resetFlags);
void IntrWait(u8 discardCurrent, u16 flags);
void VBlankIntrWait(void);
s32 Div(s32 numerator, s32 denominator);
s32 DivArm(s32 denominator, s32 numerator);
s32 Mod(s32 numerator, s32 denominator);
s32 ModArm(s32 denominator, s32 numerator);
u16 Sqrt(u32 num);
s16 ArcTan(s16 tan);
u16 ArcTan2(s16 x, s16 y);
void CpuSet(const void *src, void *dst, u32 control);
void CpuFastSet(const void *src, void *dst, u32 control);
void BgAffineSet(const void *src, void *dst, s32 count);
void ObjAffineSet(const void *src, void *dst, s32 count, s32 offset);
void BitUnPack(const void *src, void *dst, const void *info);
void LZ77UnCompWram(const void *src, void *dst);
void LZ77UnCompVramAndGetSize(const void *src, void *dst);
void HuffUnComp(const void *src, void *dst);
void RLUnCompWram(const void *src, void *dst);
void RLUnCompVram(const void *src, void *dst);
void Diff8bitUnFilterWram(const void *src, void *dst);
void Diff8bitUnFilterVram(const void *src, void *dst);
void Diff16bitUnFilter(const void *src, void *dst);
void SoundBiasChange(u32 value);
void SoundBiasSet(void);
void SoundBiasReset(void);
void SoundDriverInit(void *soundInfo);
void SoundDriverMode(u32 mode);
void SoundDriverMain(void);
void SoundDriverVSync(void);
void SoundChannelClear(void);
void SoundDriverVSyncOff(void);
void SoundDriverVSyncOn(void);
u32 MidiKey2Freq(void *wa, u8 mk, u8 fp);
void MusicPlayerOpen(void *mplayInfo, void *track, u8 trackCount);
void MusicPlayerStart(void *mplayInfo, void *songHeader);
void MusicPlayerStop(void *mplayInfo);
void MusicPlayerContinue(void *mplayInfo);
void MusicPlayerFadeOut(void *mplayInfo, u16 speed);
s32 MultiBoot(void *mb, u32 mode);

void sub_0802D514(void);
void sub_0802D524(u32 resetFlags);
void sub_0802D528(u8 discardCurrent, u16 flags);
void sub_0802D52E(void);
s32 sub_0802D534(s32 numerator, s32 denominator);
s32 sub_0802D538(s32 denominator, s32 numerator);
s32 sub_0802D53C(s32 numerator, s32 denominator);
s32 sub_0802D542(s32 denominator, s32 numerator);
u16 sub_0802D548(u32 num);
s16 sub_0802D54C(s16 tan);
u16 sub_0802D550(s16 x, s16 y);
void sub_0802D554(const void *src, void *dst, u32 control);
void sub_0802D558(const void *src, void *dst, u32 control);
void sub_0802D55C(const void *src, void *dst, s32 count);
void sub_0802D560(const void *src, void *dst, s32 count, s32 offset);
void sub_0802D564(const void *src, void *dst, const void *info);
void sub_0802D568(const void *src, void *dst);
void sub_0802D56C(const void *src, void *dst);
void sub_0802D580(const void *src, void *dst);
void sub_0802D584(const void *src, void *dst);
void sub_0802D588(const void *src, void *dst);
void sub_0802D58C(const void *src, void *dst);
void sub_0802D590(const void *src, void *dst);
void sub_0802D594(const void *src, void *dst);
void sub_0802D598(u32 value);
void sub_0802D59C(void);
void sub_0802D5A2(void);
void sub_0802D5A8(void *soundInfo);
void sub_0802D5AC(u32 mode);
void sub_0802D5B0(void);
void sub_0802D5B4(void);
void sub_0802D5B8(void);
void sub_0802D5BC(void);
void sub_0802D5C0(void);
u32 sub_0802D5C4(void *wa, u8 mk, u8 fp);
void sub_0802D5C8(void *mplayInfo, void *track, u8 trackCount);
void sub_0802D5CC(void *mplayInfo, void *songHeader);
void sub_0802D5D0(void *mplayInfo);
void sub_0802D5D4(void *mplayInfo);
void sub_0802D5D8(void *mplayInfo, u16 speed);
s32 sub_0802D5DC(void *mb, u32 mode);

/* Aliases applied by the call-graph rename, kept until call sites migrate. */
void Bios_CpuSet(const void *src, void *dst, u32 control);
void BiosSwiTable(const void *src, void *dst, u32 control);

#endif /* GUARD_GBA_SYSCALL_H */
