@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080313fc, 0x080314ac)  (176 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80313fc --end 0x80314ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080313fc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080313fe: 1c04        adds	r4, r0, #0
@   0x08031400: 1c0e        adds	r6, r1, #0
@   0x08031402: 6833        ldr	r3, [r6, #0]
@   0x08031404: 4a09        ldr	r2, [pc, #36]	@ (0x3142c)
@   0x08031406: 6810        ldr	r0, [r2, #0]
@   0x08031408: 218c        movs	r1, #140	@ 0x8c
@   0x0803140a: 0049        lsls	r1, r1, #1
@   0x0803140c: 1840        adds	r0, r0, r1
@   0x0803140e: 6801        ldr	r1, [r0, #0]
@   0x08031410: 2788        movs	r7, #136	@ 0x88
@   0x08031412: 007f        lsls	r7, r7, #1
@   0x08031414: 19c9        adds	r1, r1, r7
@   0x08031416: 0060        lsls	r0, r4, #1
@   0x08031418: 1900        adds	r0, r0, r4
@   0x0803141a: 0080        lsls	r0, r0, #2
@   0x0803141c: 6809        ldr	r1, [r1, #0]
@   0x0803141e: 180d        adds	r5, r1, r0
@   0x08031420: 7858        ldrb	r0, [r3, #1]
@   0x08031422: 2800        cmp	r0, #0
@   0x08031424: d104        bne.n	0x31430
@   0x08031426: 8899        ldrh	r1, [r3, #4]
@   0x08031428: 79af        ldrb	r7, [r5, #6]
@   0x0803142a: e003        b.n	0x31434
@   0x0803142c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803142e: 0300        lsls	r0, r0, #12
@   0x08031430: 8899        ldrh	r1, [r3, #4]
@   0x08031432: 7a2f        ldrb	r7, [r5, #8]
@   0x08031434: 1c08        adds	r0, r1, #0
@   0x08031436: 4378        muls	r0, r7
@   0x08031438: 1200        asrs	r0, r0, #8
@   0x0803143a: 2102        movs	r1, #2
@   0x0803143c: 5659        ldrsb	r1, [r3, r1]
@   0x0803143e: 1843        adds	r3, r0, r1
@   0x08031440: 2b00        cmp	r3, #0
@   0x08031442: da01        bge.n	0x31448
@   0x08031444: 2300        movs	r3, #0
@   0x08031446: e002        b.n	0x3144e
@   0x08031448: 2b7f        cmp	r3, #127	@ 0x7f
@   0x0803144a: dd00        ble.n	0x3144e
@   0x0803144c: 237f        movs	r3, #127	@ 0x7f
@   0x0803144e: 71ab        strb	r3, [r5, #6]
@   0x08031450: 2c03        cmp	r4, #3
@   0x08031452: dc0d        bgt.n	0x31470
@   0x08031454: 00e0        lsls	r0, r4, #3
@   0x08031456: 308c        adds	r0, #140	@ 0x8c
@   0x08031458: 6811        ldr	r1, [r2, #0]
@   0x0803145a: 1809        adds	r1, r1, r0
@   0x0803145c: 71cb        strb	r3, [r1, #7]
@   0x0803145e: 6811        ldr	r1, [r2, #0]
@   0x08031460: 00a0        lsls	r0, r4, #2
@   0x08031462: 3110        adds	r1, #16
@   0x08031464: 1809        adds	r1, r1, r0
@   0x08031466: 6808        ldr	r0, [r1, #0]
@   0x08031468: 2280        movs	r2, #128	@ 0x80
@   0x0803146a: 4310        orrs	r0, r2
@   0x0803146c: 6008        str	r0, [r1, #0]
@   0x0803146e: e016        b.n	0x3149e
@   0x08031470: 3c04        subs	r4, #4
@   0x08031472: 6810        ldr	r0, [r2, #0]
@   0x08031474: 30c8        adds	r0, #200	@ 0xc8
@   0x08031476: 01a4        lsls	r4, r4, #6
@   0x08031478: 6800        ldr	r0, [r0, #0]
@   0x0803147a: 1900        adds	r0, r0, r4
@   0x0803147c: 1c01        adds	r1, r0, #0
@   0x0803147e: 3124        adds	r1, #36	@ 0x24
@   0x08031480: 005b        lsls	r3, r3, #1
@   0x08031482: 71cb        strb	r3, [r1, #7]
@   0x08031484: 0618        lsls	r0, r3, #24
@   0x08031486: 2800        cmp	r0, #0
@   0x08031488: d001        beq.n	0x3148e
@   0x0803148a: 1c58        adds	r0, r3, #1
@   0x0803148c: 71c8        strb	r0, [r1, #7]
@   0x0803148e: 6810        ldr	r0, [r2, #0]
@   0x08031490: 30c8        adds	r0, #200	@ 0xc8
@   0x08031492: 6801        ldr	r1, [r0, #0]
@   0x08031494: 1861        adds	r1, r4, r1
@   0x08031496: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x08031498: 2280        movs	r2, #128	@ 0x80
@   0x0803149a: 4310        orrs	r0, r2
@   0x0803149c: 6388        str	r0, [r1, #56]	@ 0x38
@   0x0803149e: 6830        ldr	r0, [r6, #0]
@   0x080314a0: 3006        adds	r0, #6
@   0x080314a2: 6030        str	r0, [r6, #0]
@   0x080314a4: 2001        movs	r0, #1
@   0x080314a6: bcf0        pop	{r4, r5, r6, r7}
@   0x080314a8: bc02        pop	{r1}
@   0x080314aa: 4708        bx	r1

        thumb_func_start sub_080313FC
sub_080313FC: @ 0x080313fc
        .incbin "baserom.gba", 0x313fc, 0xb0
        thumb_func_end sub_080313FC
