@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802c3e4, 0x0802c75c)  (888 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802c3e4 --end 0x802c75c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802c3e4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802c3e6: 4657        mov	r7, sl
@   0x0802c3e8: 464e        mov	r6, r9
@   0x0802c3ea: 4645        mov	r5, r8
@   0x0802c3ec: b4e0        push	{r5, r6, r7}
@   0x0802c3ee: b086        sub	sp, #24
@   0x0802c3f0: 0600        lsls	r0, r0, #24
@   0x0802c3f2: 0e00        lsrs	r0, r0, #24
@   0x0802c3f4: 4681        mov	r9, r0
@   0x0802c3f6: 0609        lsls	r1, r1, #24
@   0x0802c3f8: 0e09        lsrs	r1, r1, #24
@   0x0802c3fa: 468a        mov	sl, r1
@   0x0802c3fc: 0612        lsls	r2, r2, #24
@   0x0802c3fe: 0e15        lsrs	r5, r2, #24
@   0x0802c400: 00e8        lsls	r0, r5, #3
@   0x0802c402: 1b40        subs	r0, r0, r5
@   0x0802c404: 00c0        lsls	r0, r0, #3
@   0x0802c406: 4906        ldr	r1, [pc, #24]	@ (0x2c420)
@   0x0802c408: 1846        adds	r6, r0, r1
@   0x0802c40a: 4806        ldr	r0, [pc, #24]	@ (0x2c424)
@   0x0802c40c: 3033        adds	r0, #51	@ 0x33
@   0x0802c40e: 7800        ldrb	r0, [r0, #0]
@   0x0802c410: 2802        cmp	r0, #2
@   0x0802c412: d011        beq.n	0x2c438
@   0x0802c414: 2802        cmp	r0, #2
@   0x0802c416: dc07        bgt.n	0x2c428
@   0x0802c418: 2800        cmp	r0, #0
@   0x0802c41a: d008        beq.n	0x2c42e
@   0x0802c41c: e017        b.n	0x2c44e
@   0x0802c41e: 0000        movs	r0, r0
@   0x0802c420: 38e0        subs	r0, #224	@ 0xe0
@   0x0802c422: 0300        lsls	r0, r0, #12
@   0x0802c424: 6110        str	r0, [r2, #16]
@   0x0802c426: 0300        lsls	r0, r0, #12
@   0x0802c428: 2803        cmp	r0, #3
@   0x0802c42a: d00a        beq.n	0x2c442
@   0x0802c42c: e00f        b.n	0x2c44e
@   0x0802c42e: 2002        movs	r0, #2
@   0x0802c430: f7d4        f998 	bl	0x764
@   0x0802c434: 3004        adds	r0, #4
@   0x0802c436: e008        b.n	0x2c44a
@   0x0802c438: 2001        movs	r0, #1
@   0x0802c43a: f7d4        f993 	bl	0x764
@   0x0802c43e: 3007        adds	r0, #7
@   0x0802c440: e003        b.n	0x2c44a
@   0x0802c442: 2003        movs	r0, #3
@   0x0802c444: f7d4        f98e 	bl	0x764
@   0x0802c448: 3005        adds	r0, #5
@   0x0802c44a: 0600        lsls	r0, r0, #24
@   0x0802c44c: 0e07        lsrs	r7, r0, #24
@   0x0802c44e: 2002        movs	r0, #2
@   0x0802c450: 4680        mov	r8, r0
@   0x0802c452: 4c11        ldr	r4, [pc, #68]	@ (0x2c498)
@   0x0802c454: 2001        movs	r0, #1
@   0x0802c456: 4240        negs	r0, r0
@   0x0802c458: 17c1        asrs	r1, r0, #31
@   0x0802c45a: 6160        str	r0, [r4, #20]
@   0x0802c45c: 61a1        str	r1, [r4, #24]
@   0x0802c45e: 61e0        str	r0, [r4, #28]
@   0x0802c460: 6221        str	r1, [r4, #32]
@   0x0802c462: 2d05        cmp	r5, #5
@   0x0802c464: d83c        bhi.n	0x2c4e0
@   0x0802c466: 2002        movs	r0, #2
@   0x0802c468: f7d4        f97c 	bl	0x764
@   0x0802c46c: 0069        lsls	r1, r5, #1
@   0x0802c46e: 0600        lsls	r0, r0, #24
@   0x0802c470: 0e00        lsrs	r0, r0, #24
@   0x0802c472: 1809        adds	r1, r1, r0
@   0x0802c474: 3101        adds	r1, #1
@   0x0802c476: 0048        lsls	r0, r1, #1
@   0x0802c478: 1840        adds	r0, r0, r1
@   0x0802c47a: 04c0        lsls	r0, r0, #19
@   0x0802c47c: 21b0        movs	r1, #176	@ 0xb0
@   0x0802c47e: 0309        lsls	r1, r1, #12
@   0x0802c480: 1840        adds	r0, r0, r1
@   0x0802c482: 0c02        lsrs	r2, r0, #16
@   0x0802c484: 1c20        adds	r0, r4, #0
@   0x0802c486: 3033        adds	r0, #51	@ 0x33
@   0x0802c488: 7800        ldrb	r0, [r0, #0]
@   0x0802c48a: 2803        cmp	r0, #3
@   0x0802c48c: d106        bne.n	0x2c49c
@   0x0802c48e: 2406        movs	r4, #6
@   0x0802c490: 216b        movs	r1, #107	@ 0x6b
@   0x0802c492: 2301        movs	r3, #1
@   0x0802c494: 4698        mov	r8, r3
@   0x0802c496: e003        b.n	0x2c4a0
@   0x0802c498: 6110        str	r0, [r2, #16]
@   0x0802c49a: 0300        lsls	r0, r0, #12
@   0x0802c49c: 2400        movs	r4, #0
@   0x0802c49e: 2153        movs	r1, #83	@ 0x53
@   0x0802c4a0: 0412        lsls	r2, r2, #16
@   0x0802c4a2: 1412        asrs	r2, r2, #16
@   0x0802c4a4: 040b        lsls	r3, r1, #16
@   0x0802c4a6: 141b        asrs	r3, r3, #16
@   0x0802c4a8: 469c        mov	ip, r3
@   0x0802c4aa: 2103        movs	r1, #3
@   0x0802c4ac: 9100        str	r1, [sp, #0]
@   0x0802c4ae: 0568        lsls	r0, r5, #21
@   0x0802c4b0: 2385        movs	r3, #133	@ 0x85
@   0x0802c4b2: 041b        lsls	r3, r3, #16
@   0x0802c4b4: 18c0        adds	r0, r0, r3
@   0x0802c4b6: 0c00        lsrs	r0, r0, #16
@   0x0802c4b8: 9001        str	r0, [sp, #4]
@   0x0802c4ba: 9102        str	r1, [sp, #8]
@   0x0802c4bc: 4640        mov	r0, r8
@   0x0802c4be: 9003        str	r0, [sp, #12]
@   0x0802c4c0: 9404        str	r4, [sp, #16]
@   0x0802c4c2: 2010        movs	r0, #16
@   0x0802c4c4: 9005        str	r0, [sp, #20]
@   0x0802c4c6: 1c30        adds	r0, r6, #0
@   0x0802c4c8: 4649        mov	r1, r9
@   0x0802c4ca: 4663        mov	r3, ip
@   0x0802c4cc: f7de        f920 	bl	0xa710
@   0x0802c4d0: 0639        lsls	r1, r7, #24
@   0x0802c4d2: 1609        asrs	r1, r1, #24
@   0x0802c4d4: 1c30        adds	r0, r6, #0
@   0x0802c4d6: 2200        movs	r2, #0
@   0x0802c4d8: 2301        movs	r3, #1
@   0x0802c4da: f7de        f851 	bl	0xa580
@   0x0802c4de: e06d        b.n	0x2c5bc
@   0x0802c4e0: 2d09        cmp	r5, #9
@   0x0802c4e2: d833        bhi.n	0x2c54c
@   0x0802c4e4: 0068        lsls	r0, r5, #1
@   0x0802c4e6: 3808        subs	r0, #8
@   0x0802c4e8: 0041        lsls	r1, r0, #1
@   0x0802c4ea: 1809        adds	r1, r1, r0
@   0x0802c4ec: 00c9        lsls	r1, r1, #3
@   0x0802c4ee: 310b        adds	r1, #11
@   0x0802c4f0: 0409        lsls	r1, r1, #16
@   0x0802c4f2: 0c09        lsrs	r1, r1, #16
@   0x0802c4f4: 1c20        adds	r0, r4, #0
@   0x0802c4f6: 3033        adds	r0, #51	@ 0x33
@   0x0802c4f8: 7800        ldrb	r0, [r0, #0]
@   0x0802c4fa: 2803        cmp	r0, #3
@   0x0802c4fc: d104        bne.n	0x2c508
@   0x0802c4fe: 2407        movs	r4, #7
@   0x0802c500: 2223        movs	r2, #35	@ 0x23
@   0x0802c502: 2301        movs	r3, #1
@   0x0802c504: 4698        mov	r8, r3
@   0x0802c506: e001        b.n	0x2c50c
@   0x0802c508: 2402        movs	r4, #2
@   0x0802c50a: 220b        movs	r2, #11
@   0x0802c50c: 0412        lsls	r2, r2, #16
@   0x0802c50e: 1412        asrs	r2, r2, #16
@   0x0802c510: 040b        lsls	r3, r1, #16
@   0x0802c512: 141b        asrs	r3, r3, #16
@   0x0802c514: 469c        mov	ip, r3
@   0x0802c516: 2103        movs	r1, #3
@   0x0802c518: 9100        str	r1, [sp, #0]
@   0x0802c51a: 0568        lsls	r0, r5, #21
@   0x0802c51c: 2385        movs	r3, #133	@ 0x85
@   0x0802c51e: 041b        lsls	r3, r3, #16
@   0x0802c520: 18c0        adds	r0, r0, r3
@   0x0802c522: 0c00        lsrs	r0, r0, #16
@   0x0802c524: 9001        str	r0, [sp, #4]
@   0x0802c526: 9102        str	r1, [sp, #8]
@   0x0802c528: 4640        mov	r0, r8
@   0x0802c52a: 9003        str	r0, [sp, #12]
@   0x0802c52c: 9404        str	r4, [sp, #16]
@   0x0802c52e: 2010        movs	r0, #16
@   0x0802c530: 9005        str	r0, [sp, #20]
@   0x0802c532: 1c30        adds	r0, r6, #0
@   0x0802c534: 4649        mov	r1, r9
@   0x0802c536: 4663        mov	r3, ip
@   0x0802c538: f7de        f8ea 	bl	0xa710
@   0x0802c53c: 0639        lsls	r1, r7, #24
@   0x0802c53e: 1609        asrs	r1, r1, #24
@   0x0802c540: 1c30        adds	r0, r6, #0
@   0x0802c542: 2201        movs	r2, #1
@   0x0802c544: 2300        movs	r3, #0
@   0x0802c546: f7de        f81b 	bl	0xa580
@   0x0802c54a: e037        b.n	0x2c5bc
@   0x0802c54c: 0068        lsls	r0, r5, #1
@   0x0802c54e: 380f        subs	r0, #15
@   0x0802c550: 0041        lsls	r1, r0, #1
@   0x0802c552: 1809        adds	r1, r1, r0
@   0x0802c554: 04c9        lsls	r1, r1, #19
@   0x0802c556: 22b0        movs	r2, #176	@ 0xb0
@   0x0802c558: 0312        lsls	r2, r2, #12
@   0x0802c55a: 1889        adds	r1, r1, r2
@   0x0802c55c: 0c09        lsrs	r1, r1, #16
@   0x0802c55e: 1c20        adds	r0, r4, #0
@   0x0802c560: 3033        adds	r0, #51	@ 0x33
@   0x0802c562: 7800        ldrb	r0, [r0, #0]
@   0x0802c564: 2803        cmp	r0, #3
@   0x0802c566: d107        bne.n	0x2c578
@   0x0802c568: 2408        movs	r4, #8
@   0x0802c56a: 4a02        ldr	r2, [pc, #8]	@ (0x2c574)
@   0x0802c56c: 2301        movs	r3, #1
@   0x0802c56e: 4698        mov	r8, r3
@   0x0802c570: e004        b.n	0x2c57c
@   0x0802c572: 0000        movs	r0, r0
@   0x0802c574: 012b        lsls	r3, r5, #4
@   0x0802c576: 0000        movs	r0, r0
@   0x0802c578: 2404        movs	r4, #4
@   0x0802c57a: 4a17        ldr	r2, [pc, #92]	@ (0x2c5d8)
@   0x0802c57c: 0412        lsls	r2, r2, #16
@   0x0802c57e: 1412        asrs	r2, r2, #16
@   0x0802c580: 040b        lsls	r3, r1, #16
@   0x0802c582: 141b        asrs	r3, r3, #16
@   0x0802c584: 469c        mov	ip, r3
@   0x0802c586: 2103        movs	r1, #3
@   0x0802c588: 9100        str	r1, [sp, #0]
@   0x0802c58a: 0568        lsls	r0, r5, #21
@   0x0802c58c: 2385        movs	r3, #133	@ 0x85
@   0x0802c58e: 041b        lsls	r3, r3, #16
@   0x0802c590: 18c0        adds	r0, r0, r3
@   0x0802c592: 0c00        lsrs	r0, r0, #16
@   0x0802c594: 9001        str	r0, [sp, #4]
@   0x0802c596: 9102        str	r1, [sp, #8]
@   0x0802c598: 4640        mov	r0, r8
@   0x0802c59a: 9003        str	r0, [sp, #12]
@   0x0802c59c: 9404        str	r4, [sp, #16]
@   0x0802c59e: 2010        movs	r0, #16
@   0x0802c5a0: 9005        str	r0, [sp, #20]
@   0x0802c5a2: 1c30        adds	r0, r6, #0
@   0x0802c5a4: 4649        mov	r1, r9
@   0x0802c5a6: 4663        mov	r3, ip
@   0x0802c5a8: f7de        f8b2 	bl	0xa710
@   0x0802c5ac: 0639        lsls	r1, r7, #24
@   0x0802c5ae: 1609        asrs	r1, r1, #24
@   0x0802c5b0: 2201        movs	r2, #1
@   0x0802c5b2: 4252        negs	r2, r2
@   0x0802c5b4: 1c30        adds	r0, r6, #0
@   0x0802c5b6: 2300        movs	r3, #0
@   0x0802c5b8: f7dd        ffe2 	bl	0xa580
@   0x0802c5bc: 4807        ldr	r0, [pc, #28]	@ (0x2c5dc)
@   0x0802c5be: 4652        mov	r2, sl
@   0x0802c5c0: 1951        adds	r1, r2, r5
@   0x0802c5c2: f7da        f9d3 	bl	0x696c
@   0x0802c5c6: b006        add	sp, #24
@   0x0802c5c8: bc38        pop	{r3, r4, r5}
@   0x0802c5ca: 4698        mov	r8, r3
@   0x0802c5cc: 46a1        mov	r9, r4
@   0x0802c5ce: 46aa        mov	sl, r5
@   0x0802c5d0: bcf0        pop	{r4, r5, r6, r7}
@   0x0802c5d2: bc01        pop	{r0}
@   0x0802c5d4: 4700        bx	r0
@   0x0802c5d6: 0000        movs	r0, r0
@   0x0802c5d8: 0143        lsls	r3, r0, #5
@   0x0802c5da: 0000        movs	r0, r0
@   0x0802c5dc: 6110        str	r0, [r2, #16]
@   0x0802c5de: 0300        lsls	r0, r0, #12
@   0x0802c5e0: 0600        lsls	r0, r0, #24
@   0x0802c5e2: 0e00        lsrs	r0, r0, #24
@   0x0802c5e4: 0609        lsls	r1, r1, #24
@   0x0802c5e6: 0e0a        lsrs	r2, r1, #24
@   0x0802c5e8: 1880        adds	r0, r0, r2
@   0x0802c5ea: 00c1        lsls	r1, r0, #3
@   0x0802c5ec: 1a09        subs	r1, r1, r0
@   0x0802c5ee: 00c9        lsls	r1, r1, #3
@   0x0802c5f0: 4805        ldr	r0, [pc, #20]	@ (0x2c608)
@   0x0802c5f2: 180b        adds	r3, r1, r0
@   0x0802c5f4: 2a05        cmp	r2, #5
@   0x0802c5f6: d809        bhi.n	0x2c60c
@   0x0802c5f8: 2184        movs	r1, #132	@ 0x84
@   0x0802c5fa: 0049        lsls	r1, r1, #1
@   0x0802c5fc: 2204        movs	r2, #4
@   0x0802c5fe: 5e98        ldrsh	r0, [r3, r2]
@   0x0802c600: 4288        cmp	r0, r1
@   0x0802c602: da1b        bge.n	0x2c63c
@   0x0802c604: e018        b.n	0x2c638
@   0x0802c606: 0000        movs	r0, r0
@   0x0802c608: 3720        adds	r7, #32
@   0x0802c60a: 0300        lsls	r0, r0, #12
@   0x0802c60c: 2a09        cmp	r2, #9
@   0x0802c60e: d80f        bhi.n	0x2c630
@   0x0802c610: 4806        ldr	r0, [pc, #24]	@ (0x2c62c)
@   0x0802c612: 3033        adds	r0, #51	@ 0x33
@   0x0802c614: 2190        movs	r1, #144	@ 0x90
@   0x0802c616: 0049        lsls	r1, r1, #1
@   0x0802c618: 7800        ldrb	r0, [r0, #0]
@   0x0802c61a: 2802        cmp	r0, #2
@   0x0802c61c: d100        bne.n	0x2c620
@   0x0802c61e: 390a        subs	r1, #10
@   0x0802c620: 2202        movs	r2, #2
@   0x0802c622: 5e98        ldrsh	r0, [r3, r2]
@   0x0802c624: 4288        cmp	r0, r1
@   0x0802c626: da09        bge.n	0x2c63c
@   0x0802c628: e006        b.n	0x2c638
@   0x0802c62a: 0000        movs	r0, r0
@   0x0802c62c: 6110        str	r0, [r2, #16]
@   0x0802c62e: 0300        lsls	r0, r0, #12
@   0x0802c630: 2102        movs	r1, #2
@   0x0802c632: 5e58        ldrsh	r0, [r3, r1]
@   0x0802c634: 2830        cmp	r0, #48	@ 0x30
@   0x0802c636: dd01        ble.n	0x2c63c
@   0x0802c638: 2000        movs	r0, #0
@   0x0802c63a: e000        b.n	0x2c63e
@   0x0802c63c: 2001        movs	r0, #1
@   0x0802c63e: 4770        bx	lr
@   0x0802c640: b530        push	{r4, r5, lr}
@   0x0802c642: 0600        lsls	r0, r0, #24
@   0x0802c644: 0e03        lsrs	r3, r0, #24
@   0x0802c646: 0609        lsls	r1, r1, #24
@   0x0802c648: 0e08        lsrs	r0, r1, #24
@   0x0802c64a: 2805        cmp	r0, #5
@   0x0802c64c: d80e        bhi.n	0x2c66c
@   0x0802c64e: 4a06        ldr	r2, [pc, #24]	@ (0x2c668)
@   0x0802c650: 1819        adds	r1, r3, r0
@   0x0802c652: 00c8        lsls	r0, r1, #3
@   0x0802c654: 1a40        subs	r0, r0, r1
@   0x0802c656: 00c0        lsls	r0, r0, #3
@   0x0802c658: 1882        adds	r2, r0, r2
@   0x0802c65a: 1c0c        adds	r4, r1, #0
@   0x0802c65c: 7e90        ldrb	r0, [r2, #26]
@   0x0802c65e: 2801        cmp	r0, #1
@   0x0802c660: d024        beq.n	0x2c6ac
@   0x0802c662: 2001        movs	r0, #1
@   0x0802c664: e01d        b.n	0x2c6a2
@   0x0802c666: 0000        movs	r0, r0
@   0x0802c668: 3720        adds	r7, #32
@   0x0802c66a: 0300        lsls	r0, r0, #12
@   0x0802c66c: 2809        cmp	r0, #9
@   0x0802c66e: d80d        bhi.n	0x2c68c
@   0x0802c670: 4a05        ldr	r2, [pc, #20]	@ (0x2c688)
@   0x0802c672: 1819        adds	r1, r3, r0
@   0x0802c674: 00c8        lsls	r0, r1, #3
@   0x0802c676: 1a40        subs	r0, r0, r1
@   0x0802c678: 00c0        lsls	r0, r0, #3
@   0x0802c67a: 1882        adds	r2, r0, r2
@   0x0802c67c: 1c0c        adds	r4, r1, #0
@   0x0802c67e: 7e90        ldrb	r0, [r2, #26]
@   0x0802c680: 2803        cmp	r0, #3
@   0x0802c682: d013        beq.n	0x2c6ac
@   0x0802c684: 2003        movs	r0, #3
@   0x0802c686: e00c        b.n	0x2c6a2
@   0x0802c688: 3720        adds	r7, #32
@   0x0802c68a: 0300        lsls	r0, r0, #12
@   0x0802c68c: 4a29        ldr	r2, [pc, #164]	@ (0x2c734)
@   0x0802c68e: 1819        adds	r1, r3, r0
@   0x0802c690: 00c8        lsls	r0, r1, #3
@   0x0802c692: 1a40        subs	r0, r0, r1
@   0x0802c694: 00c0        lsls	r0, r0, #3
@   0x0802c696: 1882        adds	r2, r0, r2
@   0x0802c698: 1c0c        adds	r4, r1, #0
@   0x0802c69a: 7e90        ldrb	r0, [r2, #26]
@   0x0802c69c: 2805        cmp	r0, #5
@   0x0802c69e: d005        beq.n	0x2c6ac
@   0x0802c6a0: 2005        movs	r0, #5
@   0x0802c6a2: 7690        strb	r0, [r2, #26]
@   0x0802c6a4: 2002        movs	r0, #2
@   0x0802c6a6: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0802c6a8: 4308        orrs	r0, r1
@   0x0802c6aa: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802c6ac: 4821        ldr	r0, [pc, #132]	@ (0x2c734)
@   0x0802c6ae: 00e1        lsls	r1, r4, #3
@   0x0802c6b0: 1b09        subs	r1, r1, r4
@   0x0802c6b2: 00c9        lsls	r1, r1, #3
@   0x0802c6b4: 1809        adds	r1, r1, r0
@   0x0802c6b6: 2002        movs	r0, #2
@   0x0802c6b8: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x0802c6ba: 4010        ands	r0, r2
@   0x0802c6bc: 2800        cmp	r0, #0
@   0x0802c6be: d00a        beq.n	0x2c6d6
@   0x0802c6c0: 481d        ldr	r0, [pc, #116]	@ (0x2c738)
@   0x0802c6c2: 3033        adds	r0, #51	@ 0x33
@   0x0802c6c4: 7800        ldrb	r0, [r0, #0]
@   0x0802c6c6: 2800        cmp	r0, #0
@   0x0802c6c8: d105        bne.n	0x2c6d6
@   0x0802c6ca: 1c08        adds	r0, r1, #0
@   0x0802c6cc: 217d        movs	r1, #125	@ 0x7d
@   0x0802c6ce: 2202        movs	r2, #2
@   0x0802c6d0: 2302        movs	r3, #2
@   0x0802c6d2: f7f4        fb03 	bl	0x20cdc
@   0x0802c6d6: 4817        ldr	r0, [pc, #92]	@ (0x2c734)
@   0x0802c6d8: 00e1        lsls	r1, r4, #3
@   0x0802c6da: 1b09        subs	r1, r1, r4
@   0x0802c6dc: 00c9        lsls	r1, r1, #3
@   0x0802c6de: 180a        adds	r2, r1, r0
@   0x0802c6e0: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0802c6e2: 2080        movs	r0, #128	@ 0x80
@   0x0802c6e4: 0200        lsls	r0, r0, #8
@   0x0802c6e6: 4008        ands	r0, r1
@   0x0802c6e8: 2800        cmp	r0, #0
@   0x0802c6ea: d029        beq.n	0x2c740
@   0x0802c6ec: 2008        movs	r0, #8
@   0x0802c6ee: 4308        orrs	r0, r1
@   0x0802c6f0: 4912        ldr	r1, [pc, #72]	@ (0x2c73c)
@   0x0802c6f2: 4008        ands	r0, r1
@   0x0802c6f4: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802c6f6: 4d10        ldr	r5, [pc, #64]	@ (0x2c738)
@   0x0802c6f8: 1c28        adds	r0, r5, #0
@   0x0802c6fa: 2103        movs	r1, #3
@   0x0802c6fc: 2206        movs	r2, #6
@   0x0802c6fe: f7da        f84d 	bl	0x679c
@   0x0802c702: 0600        lsls	r0, r0, #24
@   0x0802c704: 2800        cmp	r0, #0
@   0x0802c706: d01b        beq.n	0x2c740
@   0x0802c708: f000        f9da 	bl	0x2cac0
@   0x0802c70c: 2800        cmp	r0, #0
@   0x0802c70e: d017        beq.n	0x2c740
@   0x0802c710: 1c28        adds	r0, r5, #0
@   0x0802c712: 2103        movs	r1, #3
@   0x0802c714: 2200        movs	r2, #0
@   0x0802c716: f7d9        ffd5 	bl	0x66c4
@   0x0802c71a: 1c28        adds	r0, r5, #0
@   0x0802c71c: 2103        movs	r1, #3
@   0x0802c71e: 2201        movs	r2, #1
@   0x0802c720: f7d9        ff6e 	bl	0x6600
@   0x0802c724: 1c28        adds	r0, r5, #0
@   0x0802c726: 2103        movs	r1, #3
@   0x0802c728: 2206        movs	r2, #6
@   0x0802c72a: f7d9        ffcb 	bl	0x66c4
@   0x0802c72e: 2001        movs	r0, #1
@   0x0802c730: e00e        b.n	0x2c750
@   0x0802c732: 0000        movs	r0, r0
@   0x0802c734: 3720        adds	r7, #32
@   0x0802c736: 0300        lsls	r0, r0, #12
@   0x0802c738: 6110        str	r0, [r2, #16]
@   0x0802c73a: 0300        lsls	r0, r0, #12
@   0x0802c73c: 7fff        ldrb	r7, [r7, #31]
@   0x0802c73e: 0000        movs	r0, r0
@   0x0802c740: 00e0        lsls	r0, r4, #3
@   0x0802c742: 1b00        subs	r0, r0, r4
@   0x0802c744: 00c0        lsls	r0, r0, #3
@   0x0802c746: 4904        ldr	r1, [pc, #16]	@ (0x2c758)
@   0x0802c748: 1840        adds	r0, r0, r1
@   0x0802c74a: f7d9        f93b 	bl	0x59c4
@   0x0802c74e: 2000        movs	r0, #0
@   0x0802c750: bc30        pop	{r4, r5}
@   0x0802c752: bc02        pop	{r1}
@   0x0802c754: 4708        bx	r1
@   0x0802c756: 0000        movs	r0, r0
@   0x0802c758: 3720        adds	r7, #32
@   0x0802c75a: 0300        lsls	r0, r0, #12

        thumb_func_start EntityPool_SpawnEntry
EntityPool_SpawnEntry: @ 0x0802c3e4
        .incbin "frog_us_baserom.gba", 0x2c3e4, 0x1fc
        thumb_func_end EntityPool_SpawnEntry

        thumb_func_start EntityPool_CheckSpawnable
EntityPool_CheckSpawnable: @ 0x0802c5e0
        .incbin "frog_us_baserom.gba", 0x2c5e0, 0x60
        thumb_func_end EntityPool_CheckSpawnable

        thumb_func_start EntityPool_AdvancePhase
EntityPool_AdvancePhase: @ 0x0802c640
        .incbin "frog_us_baserom.gba", 0x2c640, 0x11c
        thumb_func_end EntityPool_AdvancePhase
