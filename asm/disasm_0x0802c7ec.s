@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802c7ec, 0x0802c910)  (292 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802c7ec --end 0x802c910 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802c7ec: b530        push	{r4, r5, lr}
@   0x0802c7ee: b081        sub	sp, #4
@   0x0802c7f0: 4c2a        ldr	r4, [pc, #168]	@ (0x2c89c)
@   0x0802c7f2: 1c20        adds	r0, r4, #0
@   0x0802c7f4: 2103        movs	r1, #3
@   0x0802c7f6: 2201        movs	r2, #1
@   0x0802c7f8: f7d9        ffd0 	bl	0x679c
@   0x0802c7fc: 0600        lsls	r0, r0, #24
@   0x0802c7fe: 2800        cmp	r0, #0
@   0x0802c800: d010        beq.n	0x2c824
@   0x0802c802: f7ff        ffab 	bl	0x2c75c
@   0x0802c806: 1c20        adds	r0, r4, #0
@   0x0802c808: 2103        movs	r1, #3
@   0x0802c80a: 2207        movs	r2, #7
@   0x0802c80c: f7d9        fef8 	bl	0x6600
@   0x0802c810: 1c20        adds	r0, r4, #0
@   0x0802c812: 2103        movs	r1, #3
@   0x0802c814: 2201        movs	r2, #1
@   0x0802c816: f7d9        ff55 	bl	0x66c4
@   0x0802c81a: 4821        ldr	r0, [pc, #132]	@ (0x2c8a0)
@   0x0802c81c: 30d4        adds	r0, #212	@ 0xd4
@   0x0802c81e: 4921        ldr	r1, [pc, #132]	@ (0x2c8a4)
@   0x0802c820: 6809        ldr	r1, [r1, #0]
@   0x0802c822: 6001        str	r1, [r0, #0]
@   0x0802c824: 1c20        adds	r0, r4, #0
@   0x0802c826: 2103        movs	r1, #3
@   0x0802c828: 2207        movs	r2, #7
@   0x0802c82a: f7d9        ffb7 	bl	0x679c
@   0x0802c82e: 0600        lsls	r0, r0, #24
@   0x0802c830: 2800        cmp	r0, #0
@   0x0802c832: d067        beq.n	0x2c904
@   0x0802c834: 481b        ldr	r0, [pc, #108]	@ (0x2c8a4)
@   0x0802c836: 4d1a        ldr	r5, [pc, #104]	@ (0x2c8a0)
@   0x0802c838: 1c29        adds	r1, r5, #0
@   0x0802c83a: 31d4        adds	r1, #212	@ 0xd4
@   0x0802c83c: 6800        ldr	r0, [r0, #0]
@   0x0802c83e: 6809        ldr	r1, [r1, #0]
@   0x0802c840: 1a40        subs	r0, r0, r1
@   0x0802c842: 28f0        cmp	r0, #240	@ 0xf0
@   0x0802c844: d932        bls.n	0x2c8ac
@   0x0802c846: 1c20        adds	r0, r4, #0
@   0x0802c848: 2103        movs	r1, #3
@   0x0802c84a: 2202        movs	r2, #2
@   0x0802c84c: f7d9        fed8 	bl	0x6600
@   0x0802c850: 2308        movs	r3, #8
@   0x0802c852: 1c29        adds	r1, r5, #0
@   0x0802c854: 31dc        adds	r1, #220	@ 0xdc
@   0x0802c856: 2204        movs	r2, #4
@   0x0802c858: 8808        ldrh	r0, [r1, #0]
@   0x0802c85a: 4318        orrs	r0, r3
@   0x0802c85c: 8008        strh	r0, [r1, #0]
@   0x0802c85e: 3138        adds	r1, #56	@ 0x38
@   0x0802c860: 3a01        subs	r2, #1
@   0x0802c862: 2a00        cmp	r2, #0
@   0x0802c864: daf8        bge.n	0x2c858
@   0x0802c866: 4c0d        ldr	r4, [pc, #52]	@ (0x2c89c)
@   0x0802c868: 1c20        adds	r0, r4, #0
@   0x0802c86a: 2103        movs	r1, #3
@   0x0802c86c: 2207        movs	r2, #7
@   0x0802c86e: f7d9        ff29 	bl	0x66c4
@   0x0802c872: 1c20        adds	r0, r4, #0
@   0x0802c874: 2103        movs	r1, #3
@   0x0802c876: 2202        movs	r2, #2
@   0x0802c878: f7d9        ff24 	bl	0x66c4
@   0x0802c87c: 206a        movs	r0, #106	@ 0x6a
@   0x0802c87e: f7f4        f9fb 	bl	0x20c78
@   0x0802c882: 1c20        adds	r0, r4, #0
@   0x0802c884: 2103        movs	r1, #3
@   0x0802c886: 2209        movs	r2, #9
@   0x0802c888: f7d9        feba 	bl	0x6600
@   0x0802c88c: 4804        ldr	r0, [pc, #16]	@ (0x2c8a0)
@   0x0802c88e: 4906        ldr	r1, [pc, #24]	@ (0x2c8a8)
@   0x0802c890: 1840        adds	r0, r0, r1
@   0x0802c892: 4904        ldr	r1, [pc, #16]	@ (0x2c8a4)
@   0x0802c894: 6809        ldr	r1, [r1, #0]
@   0x0802c896: 6001        str	r1, [r0, #0]
@   0x0802c898: e034        b.n	0x2c904
@   0x0802c89a: 0000        movs	r0, r0
@   0x0802c89c: 6110        str	r0, [r2, #16]
@   0x0802c89e: 0300        lsls	r0, r0, #12
@   0x0802c8a0: 3720        adds	r7, #32
@   0x0802c8a2: 0300        lsls	r0, r0, #12
@   0x0802c8a4: 5330        strh	r0, [r6, r4]
@   0x0802c8a6: 0300        lsls	r0, r0, #12
@   0x0802c8a8: 0b48        lsrs	r0, r1, #13
@   0x0802c8aa: 0000        movs	r0, r0
@   0x0802c8ac: 1c20        adds	r0, r4, #0
@   0x0802c8ae: 3033        adds	r0, #51	@ 0x33
@   0x0802c8b0: 7800        ldrb	r0, [r0, #0]
@   0x0802c8b2: 2801        cmp	r0, #1
@   0x0802c8b4: d00e        beq.n	0x2c8d4
@   0x0802c8b6: 2801        cmp	r0, #1
@   0x0802c8b8: dc02        bgt.n	0x2c8c0
@   0x0802c8ba: 2800        cmp	r0, #0
@   0x0802c8bc: d005        beq.n	0x2c8ca
@   0x0802c8be: e021        b.n	0x2c904
@   0x0802c8c0: 2802        cmp	r0, #2
@   0x0802c8c2: d00b        beq.n	0x2c8dc
@   0x0802c8c4: 2803        cmp	r0, #3
@   0x0802c8c6: d015        beq.n	0x2c8f4
@   0x0802c8c8: e01c        b.n	0x2c904
@   0x0802c8ca: 4901        ldr	r1, [pc, #4]	@ (0x2c8d0)
@   0x0802c8cc: e008        b.n	0x2c8e0
@   0x0802c8ce: 0000        movs	r0, r0
@   0x0802c8d0: 807c        strh	r4, [r7, #2]
@   0x0802c8d2: 0831        lsrs	r1, r6, #32
@   0x0802c8d4: 4900        ldr	r1, [pc, #0]	@ (0x2c8d8)
@   0x0802c8d6: e002        b.n	0x2c8de
@   0x0802c8d8: 80ac        strh	r4, [r5, #4]
@   0x0802c8da: 0831        lsrs	r1, r6, #32
@   0x0802c8dc: 4904        ldr	r1, [pc, #16]	@ (0x2c8f0)
@   0x0802c8de: 2000        movs	r0, #0
@   0x0802c8e0: 9000        str	r0, [sp, #0]
@   0x0802c8e2: 2003        movs	r0, #3
@   0x0802c8e4: 2204        movs	r2, #4
@   0x0802c8e6: 1c23        adds	r3, r4, #0
@   0x0802c8e8: f7f4        fe12 	bl	0x21510
@   0x0802c8ec: e00a        b.n	0x2c904
@   0x0802c8ee: 0000        movs	r0, r0
@   0x0802c8f0: 80dc        strh	r4, [r3, #6]
@   0x0802c8f2: 0831        lsrs	r1, r6, #32
@   0x0802c8f4: 4905        ldr	r1, [pc, #20]	@ (0x2c90c)
@   0x0802c8f6: 2000        movs	r0, #0
@   0x0802c8f8: 9000        str	r0, [sp, #0]
@   0x0802c8fa: 2003        movs	r0, #3
@   0x0802c8fc: 2204        movs	r2, #4
@   0x0802c8fe: 1c23        adds	r3, r4, #0
@   0x0802c900: f7f4        fe06 	bl	0x21510
@   0x0802c904: b001        add	sp, #4
@   0x0802c906: bc30        pop	{r4, r5}
@   0x0802c908: bc01        pop	{r0}
@   0x0802c90a: 4700        bx	r0
@   0x0802c90c: 810c        strh	r4, [r1, #8]
@   0x0802c90e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802C7EC
sub_0802C7EC: @ 0x0802c7ec
        .incbin "frog_us_baserom.gba", 0x2c7ec, 0x124
        thumb_func_end sub_0802C7EC
