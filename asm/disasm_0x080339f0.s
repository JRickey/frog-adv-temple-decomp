@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080339f0, 0x08033a70)  (128 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80339f0 --end 0x8033a70 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080339f0: b570        push	{r4, r5, r6, lr}
@   0x080339f2: 0412        lsls	r2, r2, #16
@   0x080339f4: 0c12        lsrs	r2, r2, #16
@   0x080339f6: 4c16        ldr	r4, [pc, #88]	@ (0x33a50)
@   0x080339f8: 8823        ldrh	r3, [r4, #0]
@   0x080339fa: 1c1e        adds	r6, r3, #0
@   0x080339fc: 2300        movs	r3, #0
@   0x080339fe: 8023        strh	r3, [r4, #0]
@   0x08033a00: 4d14        ldr	r5, [pc, #80]	@ (0x33a54)
@   0x08033a02: 882c        ldrh	r4, [r5, #0]
@   0x08033a04: 4b14        ldr	r3, [pc, #80]	@ (0x33a58)
@   0x08033a06: 401c        ands	r4, r3
@   0x08033a08: 4b14        ldr	r3, [pc, #80]	@ (0x33a5c)
@   0x08033a0a: 681b        ldr	r3, [r3, #0]
@   0x08033a0c: 88db        ldrh	r3, [r3, #6]
@   0x08033a0e: 4323        orrs	r3, r4
@   0x08033a10: 802b        strh	r3, [r5, #0]
@   0x08033a12: 4b13        ldr	r3, [pc, #76]	@ (0x33a60)
@   0x08033a14: 6018        str	r0, [r3, #0]
@   0x08033a16: 4813        ldr	r0, [pc, #76]	@ (0x33a64)
@   0x08033a18: 6001        str	r1, [r0, #0]
@   0x08033a1a: 4913        ldr	r1, [pc, #76]	@ (0x33a68)
@   0x08033a1c: 2080        movs	r0, #128	@ 0x80
@   0x08033a1e: 0600        lsls	r0, r0, #24
@   0x08033a20: 4302        orrs	r2, r0
@   0x08033a22: 600a        str	r2, [r1, #0]
@   0x08033a24: 3102        adds	r1, #2
@   0x08033a26: 2280        movs	r2, #128	@ 0x80
@   0x08033a28: 0212        lsls	r2, r2, #8
@   0x08033a2a: 1c10        adds	r0, r2, #0
@   0x08033a2c: 8809        ldrh	r1, [r1, #0]
@   0x08033a2e: 4008        ands	r0, r1
@   0x08033a30: 2800        cmp	r0, #0
@   0x08033a32: d007        beq.n	0x33a44
@   0x08033a34: 4a0d        ldr	r2, [pc, #52]	@ (0x33a6c)
@   0x08033a36: 2080        movs	r0, #128	@ 0x80
@   0x08033a38: 0200        lsls	r0, r0, #8
@   0x08033a3a: 1c01        adds	r1, r0, #0
@   0x08033a3c: 8810        ldrh	r0, [r2, #0]
@   0x08033a3e: 4008        ands	r0, r1
@   0x08033a40: 2800        cmp	r0, #0
@   0x08033a42: d1fb        bne.n	0x33a3c
@   0x08033a44: 4802        ldr	r0, [pc, #8]	@ (0x33a50)
@   0x08033a46: 8006        strh	r6, [r0, #0]
@   0x08033a48: bc70        pop	{r4, r5, r6}
@   0x08033a4a: bc01        pop	{r0}
@   0x08033a4c: 4700        bx	r0
@   0x08033a4e: 0000        movs	r0, r0
@   0x08033a50: 0208        lsls	r0, r1, #8
@   0x08033a52: 0400        lsls	r0, r0, #16
@   0x08033a54: 0204        lsls	r4, r0, #8
@   0x08033a56: 0400        lsls	r0, r0, #16
@   0x08033a58: f8ff        0000 	ldr??.w	r0, [pc]	@ 0x33a5c
@   0x08033a5c: 65e4        str	r4, [r4, #92]	@ 0x5c
@   0x08033a5e: 0300        lsls	r0, r0, #12
@   0x08033a60: 00d4        lsls	r4, r2, #3
@   0x08033a62: 0400        lsls	r0, r0, #16
@   0x08033a64: 00d8        lsls	r0, r3, #3
@   0x08033a66: 0400        lsls	r0, r0, #16
@   0x08033a68: 00dc        lsls	r4, r3, #3
@   0x08033a6a: 0400        lsls	r0, r0, #16
@   0x08033a6c: 00de        lsls	r6, r3, #3
@   0x08033a6e: 0400        lsls	r0, r0, #16

        thumb_func_start sub_080339F0
sub_080339F0: @ 0x080339f0
        .incbin "baserom.gba", 0x339f0, 0x80
        thumb_func_end sub_080339F0
