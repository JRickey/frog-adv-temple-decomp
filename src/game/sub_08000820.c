#include "types.h"

/* GBA hardware register addresses used by this function. Eventually these
 * move into a shared include/gba/*.h once that header is scaffolded.
 *
 * The DMA channel is exposed as a struct so agbcc emits a single base
 * `ldr` plus offset stores — the baserom uses one base register for all
 * three writes to SAD/DAD/CNT.
 */
typedef struct {
    void *src; /* +0 — DMA3SAD */
    void *dst; /* +4 — DMA3DAD */
    vu32 cnt;  /* +8 — DMA3CNT (count|control) */
} DmaChannel;
#define REG_DMA3     (*(volatile DmaChannel *)0x040000D4)

#define REG_DISPSTAT (*(volatile u16 *)0x04000004)
#define REG_IE       (*(volatile u16 *)0x04000200)
#define REG_IF       (*(volatile u16 *)0x04000202)
#define REG_IME      (*(volatile u16 *)0x04000208)

/* BIOS user-IRQ vector slot at the top of IWRAM. The BIOS dispatcher
 * reads a function pointer from this address when an interrupt fires. */
typedef void (*IntrFunc)(void);
#define INTR_VECTOR (*(IntrFunc *)0x03007FFC)

extern void IntrMain(void);
extern u32 sub_08033910(u8, void *);

/* Called from Init1. Copies the ROM-resident IntrMain handler into IWRAM
 * at 0x030058A0 via DMA3, points the BIOS IRQ vector at the copy, then
 * enables VBlank IRQ (REG_IE = 0x2011, REG_DISPSTAT bit 3 = VBlank-IRQ
 * enable). The sub_08033910(3, table) call sets some unrelated mode-3
 * state — see the disasm of that function for details.
 */
void sub_08000820(void)
{
    REG_DMA3.src = (void *)IntrMain;
    REG_DMA3.dst = (void *)0x030058A0;
    REG_DMA3.cnt = 0x80000400;
    (void)REG_DMA3.cnt;
    sub_08033910(3, (void *)0x08035DB4);
    INTR_VECTOR = (IntrFunc)0x030058A0;
    REG_IME = 1;
    REG_IF = 0;
    REG_IE = 0x2011;
    REG_DISPSTAT = 8;
}

/* Two empty stub functions sitting in the gap between sub_08000820's literal
 * pool and the raw .text blob at 0x0800088c. Their callers are not yet
 * identified — kept as separate symbols so the surrounding layout stays
 * byte-identical. The compiler emits `bx lr` (2 bytes) per function; the
 * Makefile's trailing `.align 2, 0` produces the `0x0000` halfword pad the
 * baserom has between them. See docs/codegen-notes.md.
 */
void sub_08000884(void)
{}

void sub_08000888(void)
{}
