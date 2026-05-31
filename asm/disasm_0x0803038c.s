@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803038c, 0x0803045c)  (208 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803038c --end 0x803045c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803038c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0803038e: 4647        mov	r7, r8
@   0x08030390: b480        push	{r7}
@   0x08030392: 1c05        adds	r5, r0, #0
@   0x08030394: 1c0f        adds	r7, r1, #0
@   0x08030396: 6838        ldr	r0, [r7, #0]
@   0x08030398: 4684        mov	ip, r0
@   0x0803039a: 2d03        cmp	r5, #3
@   0x0803039c: dc26        bgt.n	0x303ec
@   0x0803039e: 4b09        ldr	r3, [pc, #36]	@ (0x303c4)
@   0x080303a0: 00e8        lsls	r0, r5, #3
@   0x080303a2: 308c        adds	r0, #140	@ 0x8c
@   0x080303a4: 681c        ldr	r4, [r3, #0]
@   0x080303a6: 1826        adds	r6, r4, r0
@   0x080303a8: 00aa        lsls	r2, r5, #2
@   0x080303aa: 1c20        adds	r0, r4, #0
@   0x080303ac: 3010        adds	r0, #16
@   0x080303ae: 1880        adds	r0, r0, r2
@   0x080303b0: 6801        ldr	r1, [r0, #0]
@   0x080303b2: 2080        movs	r0, #128	@ 0x80
@   0x080303b4: 0240        lsls	r0, r0, #9
@   0x080303b6: 4001        ands	r1, r0
@   0x080303b8: 4698        mov	r8, r3
@   0x080303ba: 2900        cmp	r1, #0
@   0x080303bc: d004        beq.n	0x303c8
@   0x080303be: 89e0        ldrh	r0, [r4, #14]
@   0x080303c0: e003        b.n	0x303ca
@   0x080303c2: 0000        movs	r0, r0
@   0x080303c4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080303c6: 0300        lsls	r0, r0, #12
@   0x080303c8: 89a0        ldrh	r0, [r4, #12]
@   0x080303ca: 2800        cmp	r0, #0
@   0x080303cc: d000        beq.n	0x303d0
@   0x080303ce: 3001        adds	r0, #1
@   0x080303d0: 4661        mov	r1, ip
@   0x080303d2: 7849        ldrb	r1, [r1, #1]
@   0x080303d4: 4348        muls	r0, r1
@   0x080303d6: 0a00        lsrs	r0, r0, #8
@   0x080303d8: 71f0        strb	r0, [r6, #7]
@   0x080303da: 4643        mov	r3, r8
@   0x080303dc: 6819        ldr	r1, [r3, #0]
@   0x080303de: 3110        adds	r1, #16
@   0x080303e0: 1889        adds	r1, r1, r2
@   0x080303e2: 6808        ldr	r0, [r1, #0]
@   0x080303e4: 2280        movs	r2, #128	@ 0x80
@   0x080303e6: 4310        orrs	r0, r2
@   0x080303e8: 6008        str	r0, [r1, #0]
@   0x080303ea: e02e        b.n	0x3044a
@   0x080303ec: 3d04        subs	r5, #4
@   0x080303ee: 4a09        ldr	r2, [pc, #36]	@ (0x30414)
@   0x080303f0: 6813        ldr	r3, [r2, #0]
@   0x080303f2: 1c18        adds	r0, r3, #0
@   0x080303f4: 30c8        adds	r0, #200	@ 0xc8
@   0x080303f6: 01a9        lsls	r1, r5, #6
@   0x080303f8: 6800        ldr	r0, [r0, #0]
@   0x080303fa: 1840        adds	r0, r0, r1
@   0x080303fc: 1c06        adds	r6, r0, #0
@   0x080303fe: 3624        adds	r6, #36	@ 0x24
@   0x08030400: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x08030402: 2180        movs	r1, #128	@ 0x80
@   0x08030404: 0249        lsls	r1, r1, #9
@   0x08030406: 4008        ands	r0, r1
@   0x08030408: 4690        mov	r8, r2
@   0x0803040a: 2800        cmp	r0, #0
@   0x0803040c: d004        beq.n	0x30418
@   0x0803040e: 89d8        ldrh	r0, [r3, #14]
@   0x08030410: e003        b.n	0x3041a
@   0x08030412: 0000        movs	r0, r0
@   0x08030414: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030416: 0300        lsls	r0, r0, #12
@   0x08030418: 8998        ldrh	r0, [r3, #12]
@   0x0803041a: 2800        cmp	r0, #0
@   0x0803041c: d000        beq.n	0x30420
@   0x0803041e: 3001        adds	r0, #1
@   0x08030420: 4661        mov	r1, ip
@   0x08030422: 7849        ldrb	r1, [r1, #1]
@   0x08030424: 4348        muls	r0, r1
@   0x08030426: 0a00        lsrs	r0, r0, #8
@   0x08030428: 0042        lsls	r2, r0, #1
@   0x0803042a: 71f2        strb	r2, [r6, #7]
@   0x0803042c: 0610        lsls	r0, r2, #24
@   0x0803042e: 2800        cmp	r0, #0
@   0x08030430: d001        beq.n	0x30436
@   0x08030432: 1c50        adds	r0, r2, #1
@   0x08030434: 71f0        strb	r0, [r6, #7]
@   0x08030436: 4642        mov	r2, r8
@   0x08030438: 6810        ldr	r0, [r2, #0]
@   0x0803043a: 30c8        adds	r0, #200	@ 0xc8
@   0x0803043c: 6800        ldr	r0, [r0, #0]
@   0x0803043e: 01a9        lsls	r1, r5, #6
@   0x08030440: 1809        adds	r1, r1, r0
@   0x08030442: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x08030444: 2280        movs	r2, #128	@ 0x80
@   0x08030446: 4310        orrs	r0, r2
@   0x08030448: 6388        str	r0, [r1, #56]	@ 0x38
@   0x0803044a: 6838        ldr	r0, [r7, #0]
@   0x0803044c: 3002        adds	r0, #2
@   0x0803044e: 6038        str	r0, [r7, #0]
@   0x08030450: 2001        movs	r0, #1
@   0x08030452: bc08        pop	{r3}
@   0x08030454: 4698        mov	r8, r3
@   0x08030456: bcf0        pop	{r4, r5, r6, r7}
@   0x08030458: bc02        pop	{r1}
@   0x0803045a: 4708        bx	r1

        thumb_func_start sub_0803038C
sub_0803038C: @ 0x0803038c
        .incbin "frog_us_baserom.gba", 0x3038c, 0xd0
        thumb_func_end sub_0803038C
