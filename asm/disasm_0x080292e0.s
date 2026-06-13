@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080292e0, 0x08029448)  (360 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80292e0 --end 0x8029448 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080292e0: b530        push	{r4, r5, lr}
@   0x080292e2: b084        sub	sp, #16
@   0x080292e4: 2400        movs	r4, #0
@   0x080292e6: 4d35        ldr	r5, [pc, #212]	@ (0x293bc)
@   0x080292e8: 1c20        adds	r0, r4, #0
@   0x080292ea: 3063        adds	r0, #99	@ 0x63
@   0x080292ec: 00a1        lsls	r1, r4, #2
@   0x080292ee: 1949        adds	r1, r1, r5
@   0x080292f0: 6809        ldr	r1, [r1, #0]
@   0x080292f2: 4a33        ldr	r2, [pc, #204]	@ (0x293c0)
@   0x080292f4: 9200        str	r2, [sp, #0]
@   0x080292f6: 220a        movs	r2, #10
@   0x080292f8: 9201        str	r2, [sp, #4]
@   0x080292fa: 2202        movs	r2, #2
@   0x080292fc: 9202        str	r2, [sp, #8]
@   0x080292fe: 2203        movs	r2, #3
@   0x08029300: 9203        str	r2, [sp, #12]
@   0x08029302: 2200        movs	r2, #0
@   0x08029304: 2344        movs	r3, #68	@ 0x44
@   0x08029306: f7f7        fecb 	bl	0x210a0
@   0x0802930a: 1c60        adds	r0, r4, #1
@   0x0802930c: 0600        lsls	r0, r0, #24
@   0x0802930e: 0e04        lsrs	r4, r0, #24
@   0x08029310: 2c01        cmp	r4, #1
@   0x08029312: d9e9        bls.n	0x292e8
@   0x08029314: 2402        movs	r4, #2
@   0x08029316: 4d29        ldr	r5, [pc, #164]	@ (0x293bc)
@   0x08029318: 1c20        adds	r0, r4, #0
@   0x0802931a: 3063        adds	r0, #99	@ 0x63
@   0x0802931c: 00a1        lsls	r1, r4, #2
@   0x0802931e: 1949        adds	r1, r1, r5
@   0x08029320: 6809        ldr	r1, [r1, #0]
@   0x08029322: 4a28        ldr	r2, [pc, #160]	@ (0x293c4)
@   0x08029324: 9200        str	r2, [sp, #0]
@   0x08029326: 220a        movs	r2, #10
@   0x08029328: 9201        str	r2, [sp, #4]
@   0x0802932a: 2202        movs	r2, #2
@   0x0802932c: 9202        str	r2, [sp, #8]
@   0x0802932e: 2203        movs	r2, #3
@   0x08029330: 9203        str	r2, [sp, #12]
@   0x08029332: 2200        movs	r2, #0
@   0x08029334: 2345        movs	r3, #69	@ 0x45
@   0x08029336: f7f7        feb3 	bl	0x210a0
@   0x0802933a: 1c60        adds	r0, r4, #1
@   0x0802933c: 0600        lsls	r0, r0, #24
@   0x0802933e: 0e04        lsrs	r4, r0, #24
@   0x08029340: 2c03        cmp	r4, #3
@   0x08029342: d9e9        bls.n	0x29318
@   0x08029344: 4820        ldr	r0, [pc, #128]	@ (0x293c8)
@   0x08029346: 2105        movs	r1, #5
@   0x08029348: 2204        movs	r2, #4
@   0x0802934a: f7dd        fa27 	bl	0x679c
@   0x0802934e: 0600        lsls	r0, r0, #24
@   0x08029350: 2800        cmp	r0, #0
@   0x08029352: d03d        beq.n	0x293d0
@   0x08029354: 2404        movs	r4, #4
@   0x08029356: 4d1d        ldr	r5, [pc, #116]	@ (0x293cc)
@   0x08029358: 1c20        adds	r0, r4, #0
@   0x0802935a: 3063        adds	r0, #99	@ 0x63
@   0x0802935c: 1f21        subs	r1, r4, #4
@   0x0802935e: 0089        lsls	r1, r1, #2
@   0x08029360: 1949        adds	r1, r1, r5
@   0x08029362: 6809        ldr	r1, [r1, #0]
@   0x08029364: 4a16        ldr	r2, [pc, #88]	@ (0x293c0)
@   0x08029366: 9200        str	r2, [sp, #0]
@   0x08029368: 220a        movs	r2, #10
@   0x0802936a: 9201        str	r2, [sp, #4]
@   0x0802936c: 2202        movs	r2, #2
@   0x0802936e: 9202        str	r2, [sp, #8]
@   0x08029370: 2203        movs	r2, #3
@   0x08029372: 9203        str	r2, [sp, #12]
@   0x08029374: 2208        movs	r2, #8
@   0x08029376: 2344        movs	r3, #68	@ 0x44
@   0x08029378: f7f7        fe92 	bl	0x210a0
@   0x0802937c: 1c60        adds	r0, r4, #1
@   0x0802937e: 0600        lsls	r0, r0, #24
@   0x08029380: 0e04        lsrs	r4, r0, #24
@   0x08029382: 2c07        cmp	r4, #7
@   0x08029384: d9e8        bls.n	0x29358
@   0x08029386: 2408        movs	r4, #8
@   0x08029388: 4d10        ldr	r5, [pc, #64]	@ (0x293cc)
@   0x0802938a: 1c20        adds	r0, r4, #0
@   0x0802938c: 3063        adds	r0, #99	@ 0x63
@   0x0802938e: 1f21        subs	r1, r4, #4
@   0x08029390: 0089        lsls	r1, r1, #2
@   0x08029392: 1949        adds	r1, r1, r5
@   0x08029394: 6809        ldr	r1, [r1, #0]
@   0x08029396: 4a0b        ldr	r2, [pc, #44]	@ (0x293c4)
@   0x08029398: 9200        str	r2, [sp, #0]
@   0x0802939a: 220a        movs	r2, #10
@   0x0802939c: 9201        str	r2, [sp, #4]
@   0x0802939e: 2202        movs	r2, #2
@   0x080293a0: 9202        str	r2, [sp, #8]
@   0x080293a2: 2203        movs	r2, #3
@   0x080293a4: 9203        str	r2, [sp, #12]
@   0x080293a6: 2208        movs	r2, #8
@   0x080293a8: 2345        movs	r3, #69	@ 0x45
@   0x080293aa: f7f7        fe79 	bl	0x210a0
@   0x080293ae: 1c60        adds	r0, r4, #1
@   0x080293b0: 0600        lsls	r0, r0, #24
@   0x080293b2: 0e04        lsrs	r4, r0, #24
@   0x080293b4: 2c0b        cmp	r4, #11
@   0x080293b6: d9e8        bls.n	0x2938a
@   0x080293b8: e03c        b.n	0x29434
@   0x080293ba: 0000        movs	r0, r0
@   0x080293bc: 7b1c        ldrb	r4, [r3, #12]
@   0x080293be: 0831        lsrs	r1, r6, #32
@   0x080293c0: 02f7        lsls	r7, r6, #11
@   0x080293c2: 0000        movs	r0, r0
@   0x080293c4: 0307        lsls	r7, r0, #12
@   0x080293c6: 0000        movs	r0, r0
@   0x080293c8: 6110        str	r0, [r2, #16]
@   0x080293ca: 0300        lsls	r0, r0, #12
@   0x080293cc: 7b2c        ldrb	r4, [r5, #12]
@   0x080293ce: 0831        lsrs	r1, r6, #32
@   0x080293d0: 2404        movs	r4, #4
@   0x080293d2: 4d1a        ldr	r5, [pc, #104]	@ (0x2943c)
@   0x080293d4: 1c20        adds	r0, r4, #0
@   0x080293d6: 3063        adds	r0, #99	@ 0x63
@   0x080293d8: 1f21        subs	r1, r4, #4
@   0x080293da: 0089        lsls	r1, r1, #2
@   0x080293dc: 1949        adds	r1, r1, r5
@   0x080293de: 6809        ldr	r1, [r1, #0]
@   0x080293e0: 4a17        ldr	r2, [pc, #92]	@ (0x29440)
@   0x080293e2: 9200        str	r2, [sp, #0]
@   0x080293e4: 220a        movs	r2, #10
@   0x080293e6: 9201        str	r2, [sp, #4]
@   0x080293e8: 2202        movs	r2, #2
@   0x080293ea: 9202        str	r2, [sp, #8]
@   0x080293ec: 2203        movs	r2, #3
@   0x080293ee: 9203        str	r2, [sp, #12]
@   0x080293f0: 2200        movs	r2, #0
@   0x080293f2: 2344        movs	r3, #68	@ 0x44
@   0x080293f4: f7f7        fe54 	bl	0x210a0
@   0x080293f8: 1c60        adds	r0, r4, #1
@   0x080293fa: 0600        lsls	r0, r0, #24
@   0x080293fc: 0e04        lsrs	r4, r0, #24
@   0x080293fe: 2c07        cmp	r4, #7
@   0x08029400: d9e8        bls.n	0x293d4
@   0x08029402: 2408        movs	r4, #8
@   0x08029404: 4d0d        ldr	r5, [pc, #52]	@ (0x2943c)
@   0x08029406: 1c20        adds	r0, r4, #0
@   0x08029408: 3063        adds	r0, #99	@ 0x63
@   0x0802940a: 1f21        subs	r1, r4, #4
@   0x0802940c: 0089        lsls	r1, r1, #2
@   0x0802940e: 1949        adds	r1, r1, r5
@   0x08029410: 6809        ldr	r1, [r1, #0]
@   0x08029412: 4a0c        ldr	r2, [pc, #48]	@ (0x29444)
@   0x08029414: 9200        str	r2, [sp, #0]
@   0x08029416: 220a        movs	r2, #10
@   0x08029418: 9201        str	r2, [sp, #4]
@   0x0802941a: 2202        movs	r2, #2
@   0x0802941c: 9202        str	r2, [sp, #8]
@   0x0802941e: 2203        movs	r2, #3
@   0x08029420: 9203        str	r2, [sp, #12]
@   0x08029422: 2200        movs	r2, #0
@   0x08029424: 2345        movs	r3, #69	@ 0x45
@   0x08029426: f7f7        fe3b 	bl	0x210a0
@   0x0802942a: 1c60        adds	r0, r4, #1
@   0x0802942c: 0600        lsls	r0, r0, #24
@   0x0802942e: 0e04        lsrs	r4, r0, #24
@   0x08029430: 2c0b        cmp	r4, #11
@   0x08029432: d9e8        bls.n	0x29406
@   0x08029434: b004        add	sp, #16
@   0x08029436: bc30        pop	{r4, r5}
@   0x08029438: bc01        pop	{r0}
@   0x0802943a: 4700        bx	r0
@   0x0802943c: 7b2c        ldrb	r4, [r5, #12]
@   0x0802943e: 0831        lsrs	r1, r6, #32
@   0x08029440: 02f7        lsls	r7, r6, #11
@   0x08029442: 0000        movs	r0, r0
@   0x08029444: 0307        lsls	r7, r0, #12

        thumb_func_start sub_080292E0
sub_080292E0: @ 0x080292e0
        .incbin "baserom.gba", 0x292e0, 0x168
        thumb_func_end sub_080292E0
