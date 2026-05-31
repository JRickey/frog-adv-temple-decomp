@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f870, 0x0802f8f0)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f870 --end 0x802f8f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f870: 4a03        ldr	r2, [pc, #12]	@ (0x2f880)
@   0x0802f872: 0089        lsls	r1, r1, #2
@   0x0802f874: 1889        adds	r1, r1, r2
@   0x0802f876: 6809        ldr	r1, [r1, #0]
@   0x0802f878: 0180        lsls	r0, r0, #6
@   0x0802f87a: 7008        strb	r0, [r1, #0]
@   0x0802f87c: 4770        bx	lr
@   0x0802f87e: 0000        movs	r0, r0
@   0x0802f880: da2c        bge.n	0x2f8dc
@   0x0802f882: 083d        lsrs	r5, r7, #32
@   0x0802f884: 4901        ldr	r1, [pc, #4]	@ (0x2f88c)
@   0x0802f886: 68c9        ldr	r1, [r1, #12]
@   0x0802f888: 7008        strb	r0, [r1, #0]
@   0x0802f88a: 4770        bx	lr
@   0x0802f88c: da1c        bge.n	0x2f8c8
@   0x0802f88e: 083d        lsrs	r5, r7, #32
@   0x0802f890: b510        push	{r4, lr}
@   0x0802f892: 0600        lsls	r0, r0, #24
@   0x0802f894: 0e04        lsrs	r4, r0, #24
@   0x0802f896: 2008        movs	r0, #8
@   0x0802f898: 4020        ands	r0, r4
@   0x0802f89a: 2800        cmp	r0, #0
@   0x0802f89c: d10e        bne.n	0x2f8bc
@   0x0802f89e: 4805        ldr	r0, [pc, #20]	@ (0x2f8b4)
@   0x0802f8a0: 008b        lsls	r3, r1, #2
@   0x0802f8a2: 1818        adds	r0, r3, r0
@   0x0802f8a4: 6802        ldr	r2, [r0, #0]
@   0x0802f8a6: 8811        ldrh	r1, [r2, #0]
@   0x0802f8a8: 4803        ldr	r0, [pc, #12]	@ (0x2f8b8)
@   0x0802f8aa: 4008        ands	r0, r1
@   0x0802f8ac: 0221        lsls	r1, r4, #8
@   0x0802f8ae: 4308        orrs	r0, r1
@   0x0802f8b0: 8010        strh	r0, [r2, #0]
@   0x0802f8b2: e00a        b.n	0x2f8ca
@   0x0802f8b4: da2c        bge.n	0x2f910
@   0x0802f8b6: 083d        lsrs	r5, r7, #32
@   0x0802f8b8: f0c0        0000 			@ <UNDEFINED> instruction: 0xf0c00000
@   0x0802f8bc: 480a        ldr	r0, [pc, #40]	@ (0x2f8e8)
@   0x0802f8be: 008a        lsls	r2, r1, #2
@   0x0802f8c0: 1810        adds	r0, r2, r0
@   0x0802f8c2: 6801        ldr	r1, [r0, #0]
@   0x0802f8c4: 0220        lsls	r0, r4, #8
@   0x0802f8c6: 8008        strh	r0, [r1, #0]
@   0x0802f8c8: 1c13        adds	r3, r2, #0
@   0x0802f8ca: 4808        ldr	r0, [pc, #32]	@ (0x2f8ec)
@   0x0802f8cc: 6802        ldr	r2, [r0, #0]
@   0x0802f8ce: 3210        adds	r2, #16
@   0x0802f8d0: 18d2        adds	r2, r2, r3
@   0x0802f8d2: 6810        ldr	r0, [r2, #0]
@   0x0802f8d4: 21a2        movs	r1, #162	@ 0xa2
@   0x0802f8d6: 4249        negs	r1, r1
@   0x0802f8d8: 4008        ands	r0, r1
@   0x0802f8da: 2180        movs	r1, #128	@ 0x80
@   0x0802f8dc: 0089        lsls	r1, r1, #2
@   0x0802f8de: 4308        orrs	r0, r1
@   0x0802f8e0: 6010        str	r0, [r2, #0]
@   0x0802f8e2: bc10        pop	{r4}
@   0x0802f8e4: bc01        pop	{r0}
@   0x0802f8e6: 4700        bx	r0
@   0x0802f8e8: da2c        bge.n	0x2f944
@   0x0802f8ea: 083d        lsrs	r5, r7, #32
@   0x0802f8ec: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f8ee: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802F870
sub_0802F870: @ 0x0802f870
        .incbin "frog_us_baserom.gba", 0x2f870, 0x80
        thumb_func_end sub_0802F870
