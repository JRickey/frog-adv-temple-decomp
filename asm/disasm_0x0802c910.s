@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802c910, 0x0802ca54)  (324 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802c910 --end 0x802ca54 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802c910: b530        push	{r4, r5, lr}
@   0x0802c912: b081        sub	sp, #4
@   0x0802c914: 4d04        ldr	r5, [pc, #16]	@ (0x2c928)
@   0x0802c916: 7ea8        ldrb	r0, [r5, #26]
@   0x0802c918: 2803        cmp	r0, #3
@   0x0802c91a: d035        beq.n	0x2c988
@   0x0802c91c: 2803        cmp	r0, #3
@   0x0802c91e: dc05        bgt.n	0x2c92c
@   0x0802c920: 2800        cmp	r0, #0
@   0x0802c922: d006        beq.n	0x2c932
@   0x0802c924: e071        b.n	0x2ca0a
@   0x0802c926: 0000        movs	r0, r0
@   0x0802c928: 3bf0        subs	r3, #240	@ 0xf0
@   0x0802c92a: 0300        lsls	r0, r0, #12
@   0x0802c92c: 2804        cmp	r0, #4
@   0x0802c92e: d041        beq.n	0x2c9b4
@   0x0802c930: e06b        b.n	0x2ca0a
@   0x0802c932: 1c28        adds	r0, r5, #0
@   0x0802c934: 2100        movs	r1, #0
@   0x0802c936: 2200        movs	r2, #0
@   0x0802c938: 2300        movs	r3, #0
@   0x0802c93a: f7dd        fe21 	bl	0xa580
@   0x0802c93e: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802c940: 2080        movs	r0, #128	@ 0x80
@   0x0802c942: 0200        lsls	r0, r0, #8
@   0x0802c944: 4008        ands	r0, r1
@   0x0802c946: 2800        cmp	r0, #0
@   0x0802c948: d05f        beq.n	0x2ca0a
@   0x0802c94a: 4a0d        ldr	r2, [pc, #52]	@ (0x2c980)
@   0x0802c94c: 18a8        adds	r0, r5, r2
@   0x0802c94e: 7800        ldrb	r0, [r0, #0]
@   0x0802c950: 76a8        strb	r0, [r5, #26]
@   0x0802c952: 2002        movs	r0, #2
@   0x0802c954: 4308        orrs	r0, r1
@   0x0802c956: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802c958: 7ea8        ldrb	r0, [r5, #26]
@   0x0802c95a: 466c        mov	r4, sp
@   0x0802c95c: 3401        adds	r4, #1
@   0x0802c95e: 4669        mov	r1, sp
@   0x0802c960: 1c22        adds	r2, r4, #0
@   0x0802c962: f7f5        fadb 	bl	0x21f1c
@   0x0802c966: 4668        mov	r0, sp
@   0x0802c968: 2200        movs	r2, #0
@   0x0802c96a: 5682        ldrsb	r2, [r0, r2]
@   0x0802c96c: 2300        movs	r3, #0
@   0x0802c96e: 56e3        ldrsb	r3, [r4, r3]
@   0x0802c970: 1c28        adds	r0, r5, #0
@   0x0802c972: 2102        movs	r1, #2
@   0x0802c974: f7dd        fe04 	bl	0xa580
@   0x0802c978: 4802        ldr	r0, [pc, #8]	@ (0x2c984)
@   0x0802c97a: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802c97c: 4008        ands	r0, r1
@   0x0802c97e: e043        b.n	0x2ca08
@   0x0802c980: 06aa        lsls	r2, r5, #26
@   0x0802c982: 0000        movs	r0, r0
@   0x0802c984: 7fff        ldrb	r7, [r7, #31]
@   0x0802c986: 0000        movs	r0, r0
@   0x0802c988: 2016        movs	r0, #22
@   0x0802c98a: f7f4        fad7 	bl	0x20f3c
@   0x0802c98e: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802c990: 2080        movs	r0, #128	@ 0x80
@   0x0802c992: 0200        lsls	r0, r0, #8
@   0x0802c994: 4008        ands	r0, r1
@   0x0802c996: 2800        cmp	r0, #0
@   0x0802c998: d004        beq.n	0x2c9a4
@   0x0802c99a: 2002        movs	r0, #2
@   0x0802c99c: 4308        orrs	r0, r1
@   0x0802c99e: 4904        ldr	r1, [pc, #16]	@ (0x2c9b0)
@   0x0802c9a0: 4008        ands	r0, r1
@   0x0802c9a2: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802c9a4: 2202        movs	r2, #2
@   0x0802c9a6: 5ea8        ldrsh	r0, [r5, r2]
@   0x0802c9a8: 2877        cmp	r0, #119	@ 0x77
@   0x0802c9aa: dc2e        bgt.n	0x2ca0a
@   0x0802c9ac: 2104        movs	r1, #4
@   0x0802c9ae: e014        b.n	0x2c9da
@   0x0802c9b0: 7fff        ldrb	r7, [r7, #31]
@   0x0802c9b2: 0000        movs	r0, r0
@   0x0802c9b4: 2016        movs	r0, #22
@   0x0802c9b6: f7f4        fac1 	bl	0x20f3c
@   0x0802c9ba: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802c9bc: 2080        movs	r0, #128	@ 0x80
@   0x0802c9be: 0200        lsls	r0, r0, #8
@   0x0802c9c0: 4008        ands	r0, r1
@   0x0802c9c2: 2800        cmp	r0, #0
@   0x0802c9c4: d004        beq.n	0x2c9d0
@   0x0802c9c6: 2002        movs	r0, #2
@   0x0802c9c8: 4308        orrs	r0, r1
@   0x0802c9ca: 4913        ldr	r1, [pc, #76]	@ (0x2ca18)
@   0x0802c9cc: 4008        ands	r0, r1
@   0x0802c9ce: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802c9d0: 2202        movs	r2, #2
@   0x0802c9d2: 5ea8        ldrsh	r0, [r5, r2]
@   0x0802c9d4: 28c0        cmp	r0, #192	@ 0xc0
@   0x0802c9d6: dd18        ble.n	0x2ca0a
@   0x0802c9d8: 2103        movs	r1, #3
@   0x0802c9da: 76a9        strb	r1, [r5, #26]
@   0x0802c9dc: 4a0f        ldr	r2, [pc, #60]	@ (0x2ca1c)
@   0x0802c9de: 18a8        adds	r0, r5, r2
@   0x0802c9e0: 7001        strb	r1, [r0, #0]
@   0x0802c9e2: 7ea8        ldrb	r0, [r5, #26]
@   0x0802c9e4: 466c        mov	r4, sp
@   0x0802c9e6: 3401        adds	r4, #1
@   0x0802c9e8: 4669        mov	r1, sp
@   0x0802c9ea: 1c22        adds	r2, r4, #0
@   0x0802c9ec: f7f5        fa96 	bl	0x21f1c
@   0x0802c9f0: 4668        mov	r0, sp
@   0x0802c9f2: 2200        movs	r2, #0
@   0x0802c9f4: 5682        ldrsb	r2, [r0, r2]
@   0x0802c9f6: 2300        movs	r3, #0
@   0x0802c9f8: 56e3        ldrsb	r3, [r4, r3]
@   0x0802c9fa: 1c28        adds	r0, r5, #0
@   0x0802c9fc: 2102        movs	r1, #2
@   0x0802c9fe: f7dd        fdbf 	bl	0xa580
@   0x0802ca02: 2002        movs	r0, #2
@   0x0802ca04: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802ca06: 4308        orrs	r0, r1
@   0x0802ca08: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802ca0a: 1c28        adds	r0, r5, #0
@   0x0802ca0c: f7d8        ffda 	bl	0x59c4
@   0x0802ca10: b001        add	sp, #4
@   0x0802ca12: bc30        pop	{r4, r5}
@   0x0802ca14: bc01        pop	{r0}
@   0x0802ca16: 4700        bx	r0
@   0x0802ca18: 7fff        ldrb	r7, [r7, #31]
@   0x0802ca1a: 0000        movs	r0, r0
@   0x0802ca1c: 06aa        lsls	r2, r5, #26
@   0x0802ca1e: 0000        movs	r0, r0
@   0x0802ca20: b530        push	{r4, r5, lr}
@   0x0802ca22: 2300        movs	r3, #0
@   0x0802ca24: 4d09        ldr	r5, [pc, #36]	@ (0x2ca4c)
@   0x0802ca26: 4c0a        ldr	r4, [pc, #40]	@ (0x2ca50)
@   0x0802ca28: 00d8        lsls	r0, r3, #3
@   0x0802ca2a: 1942        adds	r2, r0, r5
@   0x0802ca2c: 1900        adds	r0, r0, r4
@   0x0802ca2e: 6841        ldr	r1, [r0, #4]
@   0x0802ca30: 6800        ldr	r0, [r0, #0]
@   0x0802ca32: 6050        str	r0, [r2, #4]
@   0x0802ca34: 6091        str	r1, [r2, #8]
@   0x0802ca36: 1c58        adds	r0, r3, #1
@   0x0802ca38: 0600        lsls	r0, r0, #24
@   0x0802ca3a: 0e03        lsrs	r3, r0, #24
@   0x0802ca3c: 2b07        cmp	r3, #7
@   0x0802ca3e: d9f3        bls.n	0x2ca28
@   0x0802ca40: f000        f81e 	bl	0x2ca80
@   0x0802ca44: bc30        pop	{r4, r5}
@   0x0802ca46: bc01        pop	{r0}
@   0x0802ca48: 4700        bx	r0
@   0x0802ca4a: 0000        movs	r0, r0
@   0x0802ca4c: 3570        adds	r5, #112	@ 0x70
@   0x0802ca4e: 0300        lsls	r0, r0, #12
@   0x0802ca50: 801c        strh	r4, [r3, #0]
@   0x0802ca52: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802C910
sub_0802C910: @ 0x0802c910
        .incbin "frog_us_baserom.gba", 0x2c910, 0x144
        thumb_func_end sub_0802C910
