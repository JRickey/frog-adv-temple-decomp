@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080221fc, 0x080222bc)  (192 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80221fc --end 0x80222bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080221fc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080221fe: 4647        mov	r7, r8
@   0x08022200: b480        push	{r7}
@   0x08022202: b084        sub	sp, #16
@   0x08022204: 2600        movs	r6, #0
@   0x08022206: 4811        ldr	r0, [pc, #68]	@ (0x2224c)
@   0x08022208: 4680        mov	r8, r0
@   0x0802220a: 2703        movs	r7, #3
@   0x0802220c: 2001        movs	r0, #1
@   0x0802220e: 4030        ands	r0, r6
@   0x08022210: 2800        cmp	r0, #0
@   0x08022212: d11d        bne.n	0x22250
@   0x08022214: 1c35        adds	r5, r6, #0
@   0x08022216: 3536        adds	r5, #54	@ 0x36
@   0x08022218: 00b0        lsls	r0, r6, #2
@   0x0802221a: 4440        add	r0, r8
@   0x0802221c: 6804        ldr	r4, [r0, #0]
@   0x0802221e: 1c30        adds	r0, r6, #0
@   0x08022220: 2107        movs	r1, #7
@   0x08022222: f011        fe9b 	bl	0x33f5c
@   0x08022226: 0600        lsls	r0, r0, #24
@   0x08022228: 0900        lsrs	r0, r0, #4
@   0x0802222a: 21f5        movs	r1, #245	@ 0xf5
@   0x0802222c: 0409        lsls	r1, r1, #16
@   0x0802222e: 1840        adds	r0, r0, r1
@   0x08022230: 0c00        lsrs	r0, r0, #16
@   0x08022232: 9000        str	r0, [sp, #0]
@   0x08022234: 2006        movs	r0, #6
@   0x08022236: 9001        str	r0, [sp, #4]
@   0x08022238: 9702        str	r7, [sp, #8]
@   0x0802223a: 9703        str	r7, [sp, #12]
@   0x0802223c: 1c28        adds	r0, r5, #0
@   0x0802223e: 1c21        adds	r1, r4, #0
@   0x08022240: 2210        movs	r2, #16
@   0x08022242: 2308        movs	r3, #8
@   0x08022244: f7fe        ff2c 	bl	0x210a0
@   0x08022248: e01c        b.n	0x22284
@   0x0802224a: 0000        movs	r0, r0
@   0x0802224c: 0dd4        lsrs	r4, r2, #23
@   0x0802224e: 0831        lsrs	r1, r6, #32
@   0x08022250: 1c35        adds	r5, r6, #0
@   0x08022252: 3536        adds	r5, #54	@ 0x36
@   0x08022254: 00b0        lsls	r0, r6, #2
@   0x08022256: 4440        add	r0, r8
@   0x08022258: 6804        ldr	r4, [r0, #0]
@   0x0802225a: 1c30        adds	r0, r6, #0
@   0x0802225c: 2107        movs	r1, #7
@   0x0802225e: f011        fe7d 	bl	0x33f5c
@   0x08022262: 0600        lsls	r0, r0, #24
@   0x08022264: 0900        lsrs	r0, r0, #4
@   0x08022266: 21f5        movs	r1, #245	@ 0xf5
@   0x08022268: 0409        lsls	r1, r1, #16
@   0x0802226a: 1840        adds	r0, r0, r1
@   0x0802226c: 0c00        lsrs	r0, r0, #16
@   0x0802226e: 9000        str	r0, [sp, #0]
@   0x08022270: 2005        movs	r0, #5
@   0x08022272: 9001        str	r0, [sp, #4]
@   0x08022274: 9702        str	r7, [sp, #8]
@   0x08022276: 9703        str	r7, [sp, #12]
@   0x08022278: 1c28        adds	r0, r5, #0
@   0x0802227a: 1c21        adds	r1, r4, #0
@   0x0802227c: 2210        movs	r2, #16
@   0x0802227e: 2307        movs	r3, #7
@   0x08022280: f7fe        ff0e 	bl	0x210a0
@   0x08022284: 1c70        adds	r0, r6, #1
@   0x08022286: 0600        lsls	r0, r0, #24
@   0x08022288: 0e06        lsrs	r6, r0, #24
@   0x0802228a: 2e07        cmp	r6, #7
@   0x0802228c: d9be        bls.n	0x2220c
@   0x0802228e: 2605        movs	r6, #5
@   0x08022290: 4b09        ldr	r3, [pc, #36]	@ (0x222b8)
@   0x08022292: 2202        movs	r2, #2
@   0x08022294: 1c30        adds	r0, r6, #0
@   0x08022296: 3036        adds	r0, #54	@ 0x36
@   0x08022298: 00c1        lsls	r1, r0, #3
@   0x0802229a: 1a09        subs	r1, r1, r0
@   0x0802229c: 00c9        lsls	r1, r1, #3
@   0x0802229e: 18c9        adds	r1, r1, r3
@   0x080222a0: 718a        strb	r2, [r1, #6]
@   0x080222a2: 1c70        adds	r0, r6, #1
@   0x080222a4: 0600        lsls	r0, r0, #24
@   0x080222a6: 0e06        lsrs	r6, r0, #24
@   0x080222a8: 2e07        cmp	r6, #7
@   0x080222aa: d9f3        bls.n	0x22294
@   0x080222ac: b004        add	sp, #16
@   0x080222ae: bc08        pop	{r3}
@   0x080222b0: 4698        mov	r8, r3
@   0x080222b2: bcf0        pop	{r4, r5, r6, r7}
@   0x080222b4: bc01        pop	{r0}
@   0x080222b6: 4700        bx	r0
@   0x080222b8: 3720        adds	r7, #32
@   0x080222ba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080221FC
sub_080221FC: @ 0x080221fc
        .incbin "frog_us_baserom.gba", 0x221fc, 0xc0
        thumb_func_end sub_080221FC
