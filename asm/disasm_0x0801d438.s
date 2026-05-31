@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d438, 0x0801d4cc)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d438 --end 0x801d4cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d438: b510        push	{r4, lr}
@   0x0801d43a: b081        sub	sp, #4
@   0x0801d43c: 0600        lsls	r0, r0, #24
@   0x0801d43e: 0e00        lsrs	r0, r0, #24
@   0x0801d440: 4b1a        ldr	r3, [pc, #104]	@ (0x1d4ac)
@   0x0801d442: 491b        ldr	r1, [pc, #108]	@ (0x1d4b0)
@   0x0801d444: 6159        str	r1, [r3, #20]
@   0x0801d446: 3180        adds	r1, #128	@ 0x80
@   0x0801d448: 6259        str	r1, [r3, #36]	@ 0x24
@   0x0801d44a: 4c1a        ldr	r4, [pc, #104]	@ (0x1d4b4)
@   0x0801d44c: 491a        ldr	r1, [pc, #104]	@ (0x1d4b8)
@   0x0801d44e: 680a        ldr	r2, [r1, #0]
@   0x0801d450: 0051        lsls	r1, r2, #1
@   0x0801d452: 1889        adds	r1, r1, r2
@   0x0801d454: 00c9        lsls	r1, r1, #3
@   0x0801d456: 1909        adds	r1, r1, r4
@   0x0801d458: 680a        ldr	r2, [r1, #0]
@   0x0801d45a: 0081        lsls	r1, r0, #2
@   0x0801d45c: 1889        adds	r1, r1, r2
@   0x0801d45e: 319c        adds	r1, #156	@ 0x9c
@   0x0801d460: 6809        ldr	r1, [r1, #0]
@   0x0801d462: 60d9        str	r1, [r3, #12]
@   0x0801d464: 2100        movs	r1, #0
@   0x0801d466: 2400        movs	r4, #0
@   0x0801d468: 7219        strb	r1, [r3, #8]
@   0x0801d46a: 859c        strh	r4, [r3, #44]	@ 0x2c
@   0x0801d46c: 861c        strh	r4, [r3, #48]	@ 0x30
@   0x0801d46e: 865c        strh	r4, [r3, #50]	@ 0x32
@   0x0801d470: 2108        movs	r1, #8
@   0x0801d472: 72d9        strb	r1, [r3, #11]
@   0x0801d474: 4669        mov	r1, sp
@   0x0801d476: 800c        strh	r4, [r1, #0]
@   0x0801d478: 4910        ldr	r1, [pc, #64]	@ (0x1d4bc)
@   0x0801d47a: 466a        mov	r2, sp
@   0x0801d47c: 600a        str	r2, [r1, #0]
@   0x0801d47e: 4a10        ldr	r2, [pc, #64]	@ (0x1d4c0)
@   0x0801d480: 604a        str	r2, [r1, #4]
@   0x0801d482: 4b10        ldr	r3, [pc, #64]	@ (0x1d4c4)
@   0x0801d484: 608b        str	r3, [r1, #8]
@   0x0801d486: 688a        ldr	r2, [r1, #8]
@   0x0801d488: 466a        mov	r2, sp
@   0x0801d48a: 8014        strh	r4, [r2, #0]
@   0x0801d48c: 600a        str	r2, [r1, #0]
@   0x0801d48e: 4a0e        ldr	r2, [pc, #56]	@ (0x1d4c8)
@   0x0801d490: 604a        str	r2, [r1, #4]
@   0x0801d492: 608b        str	r3, [r1, #8]
@   0x0801d494: 6889        ldr	r1, [r1, #8]
@   0x0801d496: f7ff        ff51 	bl	0x1d33c
@   0x0801d49a: f010        fe4f 	bl	0x2e13c
@   0x0801d49e: 204b        movs	r0, #75	@ 0x4b
@   0x0801d4a0: f003        fbea 	bl	0x20c78
@   0x0801d4a4: b001        add	sp, #4
@   0x0801d4a6: bc10        pop	{r4}
@   0x0801d4a8: bc01        pop	{r0}
@   0x0801d4aa: 4700        bx	r0
@   0x0801d4ac: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801d4ae: 0300        lsls	r0, r0, #12
@   0x0801d4b0: fbc2        0600 	smlal	r0, r6, r2, r0
@   0x0801d4b4: 1254        asrs	r4, r2, #9
@   0x0801d4b6: 080c        lsrs	r4, r1, #32
@   0x0801d4b8: 34b0        adds	r4, #176	@ 0xb0
@   0x0801d4ba: 0300        lsls	r0, r0, #12
@   0x0801d4bc: 00d4        lsls	r4, r2, #3
@   0x0801d4be: 0400        lsls	r0, r0, #16
@   0x0801d4c0: fbc0        0600 	smlal	r0, r6, r0, r0
@   0x0801d4c4: 00c0        lsls	r0, r0, #3
@   0x0801d4c6: 8100        strh	r0, [r0, #8]
@   0x0801d4c8: f800        0600 	strb.w	r0, [r0, <undefined>]

        thumb_func_start sub_0801D438
sub_0801D438: @ 0x0801d438
        .incbin "frog_us_baserom.gba", 0x1d438, 0x94
        thumb_func_end sub_0801D438
