@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080309a0, 0x08030a44)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80309a0 --end 0x8030a44 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080309a0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080309a2: 1c03        adds	r3, r0, #0
@   0x080309a4: 1c0e        adds	r6, r1, #0
@   0x080309a6: 6835        ldr	r5, [r6, #0]
@   0x080309a8: 2b02        cmp	r3, #2
@   0x080309aa: d115        bne.n	0x309d8
@   0x080309ac: 4809        ldr	r0, [pc, #36]	@ (0x309d4)
@   0x080309ae: 6800        ldr	r0, [r0, #0]
@   0x080309b0: 2188        movs	r1, #136	@ 0x88
@   0x080309b2: 0049        lsls	r1, r1, #1
@   0x080309b4: 1840        adds	r0, r0, r1
@   0x080309b6: 6802        ldr	r2, [r0, #0]
@   0x080309b8: 69d0        ldr	r0, [r2, #28]
@   0x080309ba: 886d        ldrh	r5, [r5, #2]
@   0x080309bc: 00a9        lsls	r1, r5, #2
@   0x080309be: 1810        adds	r0, r2, r0
@   0x080309c0: 1809        adds	r1, r1, r0
@   0x080309c2: 6808        ldr	r0, [r1, #0]
@   0x080309c4: 1810        adds	r0, r2, r0
@   0x080309c6: 7ac1        ldrb	r1, [r0, #11]
@   0x080309c8: 2901        cmp	r1, #1
@   0x080309ca: d134        bne.n	0x30a36
@   0x080309cc: f7fe        ffb0 	bl	0x2f930
@   0x080309d0: e031        b.n	0x30a36
@   0x080309d2: 0000        movs	r0, r0
@   0x080309d4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080309d6: 0300        lsls	r0, r0, #12
@   0x080309d8: 2b03        cmp	r3, #3
@   0x080309da: dd2c        ble.n	0x30a36
@   0x080309dc: 88e8        ldrh	r0, [r5, #6]
@   0x080309de: 0404        lsls	r4, r0, #16
@   0x080309e0: 88a9        ldrh	r1, [r5, #4]
@   0x080309e2: 430c        orrs	r4, r1
@   0x080309e4: 786f        ldrb	r7, [r5, #1]
@   0x080309e6: 2c00        cmp	r4, #0
@   0x080309e8: d01e        beq.n	0x30a28
@   0x080309ea: 480c        ldr	r0, [pc, #48]	@ (0x30a1c)
@   0x080309ec: 6800        ldr	r0, [r0, #0]
@   0x080309ee: 218c        movs	r1, #140	@ 0x8c
@   0x080309f0: 0049        lsls	r1, r1, #1
@   0x080309f2: 1840        adds	r0, r0, r1
@   0x080309f4: 6800        ldr	r0, [r0, #0]
@   0x080309f6: 3908        subs	r1, #8
@   0x080309f8: 1840        adds	r0, r0, r1
@   0x080309fa: 6801        ldr	r1, [r0, #0]
@   0x080309fc: 0058        lsls	r0, r3, #1
@   0x080309fe: 18c0        adds	r0, r0, r3
@   0x08030a00: 0080        lsls	r0, r0, #2
@   0x08030a02: 1840        adds	r0, r0, r1
@   0x08030a04: 7a02        ldrb	r2, [r0, #8]
@   0x08030a06: 2a00        cmp	r2, #0
@   0x08030a08: d000        beq.n	0x30a0c
@   0x08030a0a: 3201        adds	r2, #1
@   0x08030a0c: 2080        movs	r0, #128	@ 0x80
@   0x08030a0e: 4038        ands	r0, r7
@   0x08030a10: 2800        cmp	r0, #0
@   0x08030a12: d105        bne.n	0x30a20
@   0x08030a14: 1c20        adds	r0, r4, #0
@   0x08030a16: 4350        muls	r0, r2
@   0x08030a18: 09c4        lsrs	r4, r0, #7
@   0x08030a1a: e005        b.n	0x30a28
@   0x08030a1c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030a1e: 0300        lsls	r0, r0, #12
@   0x08030a20: 1c20        adds	r0, r4, #0
@   0x08030a22: 4350        muls	r0, r2
@   0x08030a24: 09c0        lsrs	r0, r0, #7
@   0x08030a26: 1a24        subs	r4, r4, r0
@   0x08030a28: 1f18        subs	r0, r3, #4
@   0x08030a2a: 8869        ldrh	r1, [r5, #2]
@   0x08030a2c: 2301        movs	r3, #1
@   0x08030a2e: 403b        ands	r3, r7
@   0x08030a30: 1c22        adds	r2, r4, #0
@   0x08030a32: f7ff        ff3d 	bl	0x308b0
@   0x08030a36: 6830        ldr	r0, [r6, #0]
@   0x08030a38: 3008        adds	r0, #8
@   0x08030a3a: 6030        str	r0, [r6, #0]
@   0x08030a3c: 2001        movs	r0, #1
@   0x08030a3e: bcf0        pop	{r4, r5, r6, r7}
@   0x08030a40: bc02        pop	{r1}
@   0x08030a42: 4708        bx	r1

        thumb_func_start sub_080309A0
sub_080309A0: @ 0x080309a0
        .incbin "frog_us_baserom.gba", 0x309a0, 0xa4
        thumb_func_end sub_080309A0
