@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d924, 0x0800d9fc)  (216 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d924 --end 0x800d9fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d924: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800d926: 4657        mov	r7, sl
@   0x0800d928: 464e        mov	r6, r9
@   0x0800d92a: 4645        mov	r5, r8
@   0x0800d92c: b4e0        push	{r5, r6, r7}
@   0x0800d92e: b081        sub	sp, #4
@   0x0800d930: 4681        mov	r9, r0
@   0x0800d932: 1c0e        adds	r6, r1, #0
@   0x0800d934: 0612        lsls	r2, r2, #24
@   0x0800d936: 20ff        movs	r0, #255	@ 0xff
@   0x0800d938: 4682        mov	sl, r0
@   0x0800d93a: 2000        movs	r0, #0
@   0x0800d93c: 0e11        lsrs	r1, r2, #24
@   0x0800d93e: 4688        mov	r8, r1
@   0x0800d940: 1612        asrs	r2, r2, #24
@   0x0800d942: 4694        mov	ip, r2
@   0x0800d944: e00b        b.n	0xd95e
@   0x0800d946: 2001        movs	r0, #1
@   0x0800d948: 4030        ands	r0, r6
@   0x0800d94a: 2800        cmp	r0, #0
@   0x0800d94c: d003        beq.n	0xd956
@   0x0800d94e: 1c48        adds	r0, r1, #1
@   0x0800d950: 0600        lsls	r0, r0, #24
@   0x0800d952: 0e00        lsrs	r0, r0, #24
@   0x0800d954: 4682        mov	sl, r0
@   0x0800d956: 0876        lsrs	r6, r6, #1
@   0x0800d958: 1c68        adds	r0, r5, #1
@   0x0800d95a: 0600        lsls	r0, r0, #24
@   0x0800d95c: 0e00        lsrs	r0, r0, #24
@   0x0800d95e: 2300        movs	r3, #0
@   0x0800d960: 0600        lsls	r0, r0, #24
@   0x0800d962: 1605        asrs	r5, r0, #24
@   0x0800d964: 2d18        cmp	r5, #24
@   0x0800d966: dc00        bgt.n	0xd96a
@   0x0800d968: 2301        movs	r3, #1
@   0x0800d96a: 2200        movs	r2, #0
@   0x0800d96c: 4657        mov	r7, sl
@   0x0800d96e: 0638        lsls	r0, r7, #24
@   0x0800d970: 1601        asrs	r1, r0, #24
@   0x0800d972: 4647        mov	r7, r8
@   0x0800d974: 0638        lsls	r0, r7, #24
@   0x0800d976: 4561        cmp	r1, ip
@   0x0800d978: da00        bge.n	0xd97c
@   0x0800d97a: 2201        movs	r2, #1
@   0x0800d97c: 4013        ands	r3, r2
@   0x0800d97e: 2b00        cmp	r3, #0
@   0x0800d980: d1e1        bne.n	0xd946
@   0x0800d982: 1600        asrs	r0, r0, #24
@   0x0800d984: 4281        cmp	r1, r0
@   0x0800d986: d107        bne.n	0xd998
@   0x0800d988: 1e69        subs	r1, r5, #1
@   0x0800d98a: 0609        lsls	r1, r1, #24
@   0x0800d98c: 1609        asrs	r1, r1, #24
@   0x0800d98e: 4668        mov	r0, sp
@   0x0800d990: f7ff        fb6e 	bl	0xd070
@   0x0800d994: 9c00        ldr	r4, [sp, #0]
@   0x0800d996: e007        b.n	0xd9a8
@   0x0800d998: 4808        ldr	r0, [pc, #32]	@ (0xd9bc)
@   0x0800d99a: 4004        ands	r4, r0
@   0x0800d99c: 4808        ldr	r0, [pc, #32]	@ (0xd9c0)
@   0x0800d99e: 4304        orrs	r4, r0
@   0x0800d9a0: 3002        adds	r0, #2
@   0x0800d9a2: 4004        ands	r4, r0
@   0x0800d9a4: 4807        ldr	r0, [pc, #28]	@ (0xd9c4)
@   0x0800d9a6: 4304        orrs	r4, r0
@   0x0800d9a8: 4648        mov	r0, r9
@   0x0800d9aa: 6004        str	r4, [r0, #0]
@   0x0800d9ac: b001        add	sp, #4
@   0x0800d9ae: bc38        pop	{r3, r4, r5}
@   0x0800d9b0: 4698        mov	r8, r3
@   0x0800d9b2: 46a1        mov	r9, r4
@   0x0800d9b4: 46aa        mov	sl, r5
@   0x0800d9b6: bcf0        pop	{r4, r5, r6, r7}
@   0x0800d9b8: bc02        pop	{r1}
@   0x0800d9ba: 4708        bx	r1
@   0x0800d9bc: 0000        movs	r0, r0
@   0x0800d9be: ffff        fffd 			@ <UNDEFINED> instruction: 0xfffffffd
@   0x0800d9c2: 0000        movs	r0, r0
@   0x0800d9c4: 0000        movs	r0, r0
@   0x0800d9c6: fffd        b530 	vsli.32	d27, d16, #29
@   0x0800d9ca: f003        fd0d 	bl	0x113e8
@   0x0800d9ce: 4a07        ldr	r2, [pc, #28]	@ (0xd9ec)
@   0x0800d9d0: 4c07        ldr	r4, [pc, #28]	@ (0xd9f0)
@   0x0800d9d2: 8923        ldrh	r3, [r4, #8]
@   0x0800d9d4: 4d07        ldr	r5, [pc, #28]	@ (0xd9f4)
@   0x0800d9d6: 1951        adds	r1, r2, r5
@   0x0800d9d8: 800b        strh	r3, [r1, #0]
@   0x0800d9da: 8961        ldrh	r1, [r4, #10]
@   0x0800d9dc: 4b06        ldr	r3, [pc, #24]	@ (0xd9f8)
@   0x0800d9de: 18d2        adds	r2, r2, r3
@   0x0800d9e0: 8011        strh	r1, [r2, #0]
@   0x0800d9e2: f000        f845 	bl	0xda70
@   0x0800d9e6: bc30        pop	{r4, r5}
@   0x0800d9e8: bc02        pop	{r1}
@   0x0800d9ea: 4708        bx	r1
@   0x0800d9ec: 3720        adds	r7, #32
@   0x0800d9ee: 0300        lsls	r0, r0, #12
@   0x0800d9f0: 35e0        adds	r5, #224	@ 0xe0
@   0x0800d9f2: 0300        lsls	r0, r0, #12
@   0x0800d9f4: 0692        lsls	r2, r2, #26
@   0x0800d9f6: 0000        movs	r0, r0
@   0x0800d9f8: 0694        lsls	r4, r2, #26

        thumb_func_start sub_0800D924
sub_0800D924: @ 0x0800d924
        .incbin "frog_us_baserom.gba", 0xd924, 0xd8
        thumb_func_end sub_0800D924
