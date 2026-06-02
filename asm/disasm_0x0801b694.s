@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b694, 0x0801b71c)  (136 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b694 --end 0x801b71c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b694: b530        push	{r4, r5, lr}
@   0x0801b696: b081        sub	sp, #4
@   0x0801b698: 0600        lsls	r0, r0, #24
@   0x0801b69a: 0e00        lsrs	r0, r0, #24
@   0x0801b69c: 4a17        ldr	r2, [pc, #92]	@ (0x1b6fc)
@   0x0801b69e: 1dc1        adds	r1, r0, #7
@   0x0801b6a0: 0089        lsls	r1, r1, #2
@   0x0801b6a2: 1889        adds	r1, r1, r2
@   0x0801b6a4: 680d        ldr	r5, [r1, #0]
@   0x0801b6a6: 4b16        ldr	r3, [pc, #88]	@ (0x1b700)
@   0x0801b6a8: 4916        ldr	r1, [pc, #88]	@ (0x1b704)
@   0x0801b6aa: 6159        str	r1, [r3, #20]
@   0x0801b6ac: 3180        adds	r1, #128	@ 0x80
@   0x0801b6ae: 6259        str	r1, [r3, #36]	@ 0x24
@   0x0801b6b0: 4c15        ldr	r4, [pc, #84]	@ (0x1b708)
@   0x0801b6b2: 4916        ldr	r1, [pc, #88]	@ (0x1b70c)
@   0x0801b6b4: 680a        ldr	r2, [r1, #0]
@   0x0801b6b6: 0051        lsls	r1, r2, #1
@   0x0801b6b8: 1889        adds	r1, r1, r2
@   0x0801b6ba: 00c9        lsls	r1, r1, #3
@   0x0801b6bc: 1909        adds	r1, r1, r4
@   0x0801b6be: 680a        ldr	r2, [r1, #0]
@   0x0801b6c0: 0081        lsls	r1, r0, #2
@   0x0801b6c2: 1889        adds	r1, r1, r2
@   0x0801b6c4: 6a09        ldr	r1, [r1, #32]
@   0x0801b6c6: 60d9        str	r1, [r3, #12]
@   0x0801b6c8: 2100        movs	r1, #0
@   0x0801b6ca: 2200        movs	r2, #0
@   0x0801b6cc: 7219        strb	r1, [r3, #8]
@   0x0801b6ce: 859a        strh	r2, [r3, #44]	@ 0x2c
@   0x0801b6d0: 861a        strh	r2, [r3, #48]	@ 0x30
@   0x0801b6d2: 865a        strh	r2, [r3, #50]	@ 0x32
@   0x0801b6d4: 2108        movs	r1, #8
@   0x0801b6d6: 72d9        strb	r1, [r3, #11]
@   0x0801b6d8: 4669        mov	r1, sp
@   0x0801b6da: 800a        strh	r2, [r1, #0]
@   0x0801b6dc: 4a0c        ldr	r2, [pc, #48]	@ (0x1b710)
@   0x0801b6de: 6011        str	r1, [r2, #0]
@   0x0801b6e0: 490c        ldr	r1, [pc, #48]	@ (0x1b714)
@   0x0801b6e2: 6051        str	r1, [r2, #4]
@   0x0801b6e4: 490c        ldr	r1, [pc, #48]	@ (0x1b718)
@   0x0801b6e6: 6091        str	r1, [r2, #8]
@   0x0801b6e8: 6891        ldr	r1, [r2, #8]
@   0x0801b6ea: f7ff        fea1 	bl	0x1b430
@   0x0801b6ee: 1c28        adds	r0, r5, #0
@   0x0801b6f0: f005        fac2 	bl	0x20c78
@   0x0801b6f4: b001        add	sp, #4
@   0x0801b6f6: bc30        pop	{r4, r5}
@   0x0801b6f8: bc01        pop	{r0}
@   0x0801b6fa: 4700        bx	r0
@   0x0801b6fc: da70        bge.n	0x1b7e0
@   0x0801b6fe: 081b        lsrs	r3, r3, #32
@   0x0801b700: 6440        str	r0, [r0, #68]	@ 0x44
@   0x0801b702: 0300        lsls	r0, r0, #12
@   0x0801b704: f84c        0600 	str.w	r0, [ip, <undefined>]
@   0x0801b708: 1254        asrs	r4, r2, #9
@   0x0801b70a: 080c        lsrs	r4, r1, #32
@   0x0801b70c: 34b0        adds	r4, #176	@ 0xb0
@   0x0801b70e: 0300        lsls	r0, r0, #12
@   0x0801b710: 00d4        lsls	r4, r2, #3
@   0x0801b712: 0400        lsls	r0, r0, #16
@   0x0801b714: fbc0        0600 	smlal	r0, r6, r0, r0
@   0x0801b718: 00c0        lsls	r0, r0, #3
@   0x0801b71a: 8100        strh	r0, [r0, #8]

        thumb_func_start sub_0801B694
sub_0801B694: @ 0x0801b694
        .incbin "frog_us_baserom.gba", 0x1b694, 0x88
        thumb_func_end sub_0801B694
