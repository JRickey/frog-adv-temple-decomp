@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801ac84, 0x0801ad10)  (140 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801ac84 --end 0x801ad10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801ac84: b530        push	{r4, r5, lr}
@   0x0801ac86: b081        sub	sp, #4
@   0x0801ac88: 0600        lsls	r0, r0, #24
@   0x0801ac8a: 0e00        lsrs	r0, r0, #24
@   0x0801ac8c: 4b17        ldr	r3, [pc, #92]	@ (0x1acec)
@   0x0801ac8e: 4918        ldr	r1, [pc, #96]	@ (0x1acf0)
@   0x0801ac90: 6159        str	r1, [r3, #20]
@   0x0801ac92: 3180        adds	r1, #128	@ 0x80
@   0x0801ac94: 6259        str	r1, [r3, #36]	@ 0x24
@   0x0801ac96: 4c17        ldr	r4, [pc, #92]	@ (0x1acf4)
@   0x0801ac98: 4917        ldr	r1, [pc, #92]	@ (0x1acf8)
@   0x0801ac9a: 680a        ldr	r2, [r1, #0]
@   0x0801ac9c: 0051        lsls	r1, r2, #1
@   0x0801ac9e: 1889        adds	r1, r1, r2
@   0x0801aca0: 00c9        lsls	r1, r1, #3
@   0x0801aca2: 1909        adds	r1, r1, r4
@   0x0801aca4: 4a15        ldr	r2, [pc, #84]	@ (0x1acfc)
@   0x0801aca6: 7b14        ldrb	r4, [r2, #12]
@   0x0801aca8: 7855        ldrb	r5, [r2, #1]
@   0x0801acaa: 1962        adds	r2, r4, r5
@   0x0801acac: 6809        ldr	r1, [r1, #0]
@   0x0801acae: 0092        lsls	r2, r2, #2
@   0x0801acb0: 1852        adds	r2, r2, r1
@   0x0801acb2: 6b91        ldr	r1, [r2, #56]	@ 0x38
@   0x0801acb4: 60d9        str	r1, [r3, #12]
@   0x0801acb6: 2100        movs	r1, #0
@   0x0801acb8: 2200        movs	r2, #0
@   0x0801acba: 7219        strb	r1, [r3, #8]
@   0x0801acbc: 859a        strh	r2, [r3, #44]	@ 0x2c
@   0x0801acbe: 861a        strh	r2, [r3, #48]	@ 0x30
@   0x0801acc0: 865a        strh	r2, [r3, #50]	@ 0x32
@   0x0801acc2: 2108        movs	r1, #8
@   0x0801acc4: 72d9        strb	r1, [r3, #11]
@   0x0801acc6: 4669        mov	r1, sp
@   0x0801acc8: 800a        strh	r2, [r1, #0]
@   0x0801acca: 4a0d        ldr	r2, [pc, #52]	@ (0x1ad00)
@   0x0801accc: 6011        str	r1, [r2, #0]
@   0x0801acce: 490d        ldr	r1, [pc, #52]	@ (0x1ad04)
@   0x0801acd0: 6051        str	r1, [r2, #4]
@   0x0801acd2: 490d        ldr	r1, [pc, #52]	@ (0x1ad08)
@   0x0801acd4: 6091        str	r1, [r2, #8]
@   0x0801acd6: 6891        ldr	r1, [r2, #8]
@   0x0801acd8: f7ff        fec2 	bl	0x1aa60
@   0x0801acdc: 480b        ldr	r0, [pc, #44]	@ (0x1ad0c)
@   0x0801acde: 6800        ldr	r0, [r0, #0]
@   0x0801ace0: f005        ffca 	bl	0x20c78
@   0x0801ace4: b001        add	sp, #4
@   0x0801ace6: bc30        pop	{r4, r5}
@   0x0801ace8: bc01        pop	{r0}
@   0x0801acea: 4700        bx	r0
@   0x0801acec: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801acee: 0300        lsls	r0, r0, #12
@   0x0801acf0: fbc2        0600 	smlal	r0, r6, r2, r0
@   0x0801acf4: 1254        asrs	r4, r2, #9
@   0x0801acf6: 080c        lsrs	r4, r1, #32
@   0x0801acf8: 34b0        adds	r4, #176	@ 0xb0
@   0x0801acfa: 0300        lsls	r0, r0, #12
@   0x0801acfc: 3540        adds	r5, #64	@ 0x40
@   0x0801acfe: 0300        lsls	r0, r0, #12
@   0x0801ad00: 00d4        lsls	r4, r2, #3
@   0x0801ad02: 0400        lsls	r0, r0, #16
@   0x0801ad04: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801ad08: 00c0        lsls	r0, r0, #3
@   0x0801ad0a: 8100        strh	r0, [r0, #8]
@   0x0801ad0c: da70        bge.n	0x1adf0
@   0x0801ad0e: 081b        lsrs	r3, r3, #32

        thumb_func_start sub_0801AC84
sub_0801AC84: @ 0x0801ac84
        .incbin "frog_us_baserom.gba", 0x1ac84, 0x8c
        thumb_func_end sub_0801AC84
