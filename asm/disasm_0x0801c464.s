@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801c464, 0x0801c6e4)  (640 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801c464 --end 0x801c6e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801c464: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801c466: 464f        mov	r7, r9
@   0x0801c468: 4646        mov	r6, r8
@   0x0801c46a: b4c0        push	{r6, r7}
@   0x0801c46c: 20b1        movs	r0, #177	@ 0xb1
@   0x0801c46e: 0200        lsls	r0, r0, #8
@   0x0801c470: 4680        mov	r8, r0
@   0x0801c472: 491f        ldr	r1, [pc, #124]	@ (0x1c4f0)
@   0x0801c474: 4689        mov	r9, r1
@   0x0801c476: 2300        movs	r3, #0
@   0x0801c478: 2080        movs	r0, #128	@ 0x80
@   0x0801c47a: 00c0        lsls	r0, r0, #3
@   0x0801c47c: 4684        mov	ip, r0
@   0x0801c47e: 4667        mov	r7, ip
@   0x0801c480: 3702        adds	r7, #2
@   0x0801c482: 4e1c        ldr	r6, [pc, #112]	@ (0x1c4f4)
@   0x0801c484: 2200        movs	r2, #0
@   0x0801c486: 0199        lsls	r1, r3, #6
@   0x0801c488: 0058        lsls	r0, r3, #1
@   0x0801c48a: 19cd        adds	r5, r1, r7
@   0x0801c48c: 18c0        adds	r0, r0, r3
@   0x0801c48e: 4641        mov	r1, r8
@   0x0801c490: 180c        adds	r4, r1, r0
@   0x0801c492: 0050        lsls	r0, r2, #1
@   0x0801c494: 1940        adds	r0, r0, r5
@   0x0801c496: 1980        adds	r0, r0, r6
@   0x0801c498: 18a1        adds	r1, r4, r2
@   0x0801c49a: 8001        strh	r1, [r0, #0]
@   0x0801c49c: 1c50        adds	r0, r2, #1
@   0x0801c49e: 0600        lsls	r0, r0, #24
@   0x0801c4a0: 0e02        lsrs	r2, r0, #24
@   0x0801c4a2: 2a02        cmp	r2, #2
@   0x0801c4a4: d9f5        bls.n	0x1c492
@   0x0801c4a6: 1c58        adds	r0, r3, #1
@   0x0801c4a8: 0600        lsls	r0, r0, #24
@   0x0801c4aa: 0e03        lsrs	r3, r0, #24
@   0x0801c4ac: 2b02        cmp	r3, #2
@   0x0801c4ae: d9e9        bls.n	0x1c484
@   0x0801c4b0: 2300        movs	r3, #0
@   0x0801c4b2: 4667        mov	r7, ip
@   0x0801c4b4: 3728        adds	r7, #40	@ 0x28
@   0x0801c4b6: 4e0f        ldr	r6, [pc, #60]	@ (0x1c4f4)
@   0x0801c4b8: 2200        movs	r2, #0
@   0x0801c4ba: 0199        lsls	r1, r3, #6
@   0x0801c4bc: 0058        lsls	r0, r3, #1
@   0x0801c4be: 1c5d        adds	r5, r3, #1
@   0x0801c4c0: 19cc        adds	r4, r1, r7
@   0x0801c4c2: 18c0        adds	r0, r0, r3
@   0x0801c4c4: 4649        mov	r1, r9
@   0x0801c4c6: 180b        adds	r3, r1, r0
@   0x0801c4c8: 0050        lsls	r0, r2, #1
@   0x0801c4ca: 1900        adds	r0, r0, r4
@   0x0801c4cc: 1980        adds	r0, r0, r6
@   0x0801c4ce: 1899        adds	r1, r3, r2
@   0x0801c4d0: 8001        strh	r1, [r0, #0]
@   0x0801c4d2: 1c50        adds	r0, r2, #1
@   0x0801c4d4: 0600        lsls	r0, r0, #24
@   0x0801c4d6: 0e02        lsrs	r2, r0, #24
@   0x0801c4d8: 2a02        cmp	r2, #2
@   0x0801c4da: d9f5        bls.n	0x1c4c8
@   0x0801c4dc: 0628        lsls	r0, r5, #24
@   0x0801c4de: 0e03        lsrs	r3, r0, #24
@   0x0801c4e0: 2b02        cmp	r3, #2
@   0x0801c4e2: d9e9        bls.n	0x1c4b8
@   0x0801c4e4: bc18        pop	{r3, r4}
@   0x0801c4e6: 4698        mov	r8, r3
@   0x0801c4e8: 46a1        mov	r9, r4
@   0x0801c4ea: bcf0        pop	{r4, r5, r6, r7}
@   0x0801c4ec: bc01        pop	{r0}
@   0x0801c4ee: 4700        bx	r0
@   0x0801c4f0: a109        add	r1, pc, #36	@ (adr r1, 0x1c518)
@   0x0801c4f2: 0000        movs	r0, r0
@   0x0801c4f4: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801c4f8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801c4fa: 4657        mov	r7, sl
@   0x0801c4fc: 464e        mov	r6, r9
@   0x0801c4fe: 4645        mov	r5, r8
@   0x0801c500: b4e0        push	{r5, r6, r7}
@   0x0801c502: b085        sub	sp, #20
@   0x0801c504: 4680        mov	r8, r0
@   0x0801c506: 1c0e        adds	r6, r1, #0
@   0x0801c508: 0600        lsls	r0, r0, #24
@   0x0801c50a: 0e00        lsrs	r0, r0, #24
@   0x0801c50c: 4680        mov	r8, r0
@   0x0801c50e: 0636        lsls	r6, r6, #24
@   0x0801c510: 0e36        lsrs	r6, r6, #24
@   0x0801c512: 0610        lsls	r0, r2, #24
@   0x0801c514: 0e00        lsrs	r0, r0, #24
@   0x0801c516: 9004        str	r0, [sp, #16]
@   0x0801c518: 2588        movs	r5, #136	@ 0x88
@   0x0801c51a: 00ed        lsls	r5, r5, #3
@   0x0801c51c: 4951        ldr	r1, [pc, #324]	@ (0x1c664)
@   0x0801c51e: 1868        adds	r0, r5, r1
@   0x0801c520: 4951        ldr	r1, [pc, #324]	@ (0x1c668)
@   0x0801c522: 8001        strh	r1, [r0, #0]
@   0x0801c524: 4951        ldr	r1, [pc, #324]	@ (0x1c66c)
@   0x0801c526: 1868        adds	r0, r5, r1
@   0x0801c528: 4951        ldr	r1, [pc, #324]	@ (0x1c670)
@   0x0801c52a: 8001        strh	r1, [r0, #0]
@   0x0801c52c: 4951        ldr	r1, [pc, #324]	@ (0x1c674)
@   0x0801c52e: 1868        adds	r0, r5, r1
@   0x0801c530: 4951        ldr	r1, [pc, #324]	@ (0x1c678)
@   0x0801c532: 8001        strh	r1, [r0, #0]
@   0x0801c534: 4951        ldr	r1, [pc, #324]	@ (0x1c67c)
@   0x0801c536: 1868        adds	r0, r5, r1
@   0x0801c538: 4951        ldr	r1, [pc, #324]	@ (0x1c680)
@   0x0801c53a: 8001        strh	r1, [r0, #0]
@   0x0801c53c: 278b        movs	r7, #139	@ 0x8b
@   0x0801c53e: 007f        lsls	r7, r7, #1
@   0x0801c540: 9700        str	r7, [sp, #0]
@   0x0801c542: 200e        movs	r0, #14
@   0x0801c544: 4682        mov	sl, r0
@   0x0801c546: 9001        str	r0, [sp, #4]
@   0x0801c548: 2103        movs	r1, #3
@   0x0801c54a: 4689        mov	r9, r1
@   0x0801c54c: 9102        str	r1, [sp, #8]
@   0x0801c54e: 484d        ldr	r0, [pc, #308]	@ (0x1c684)
@   0x0801c550: 2104        movs	r1, #4
@   0x0801c552: 2207        movs	r2, #7
@   0x0801c554: 2311        movs	r3, #17
@   0x0801c556: f7ff        fc91 	bl	0x1be7c
@   0x0801c55a: 1c30        adds	r0, r6, #0
@   0x0801c55c: 210a        movs	r1, #10
@   0x0801c55e: f017        fcc1 	bl	0x33ee4
@   0x0801c562: 1c04        adds	r4, r0, #0
@   0x0801c564: 0624        lsls	r4, r4, #24
@   0x0801c566: 0e24        lsrs	r4, r4, #24
@   0x0801c568: 1c30        adds	r0, r6, #0
@   0x0801c56a: 210a        movs	r1, #10
@   0x0801c56c: f017        fcf6 	bl	0x33f5c
@   0x0801c570: 0600        lsls	r0, r0, #24
@   0x0801c572: 0e00        lsrs	r0, r0, #24
@   0x0801c574: a903        add	r1, sp, #12
@   0x0801c576: 3430        adds	r4, #48	@ 0x30
@   0x0801c578: 700c        strb	r4, [r1, #0]
@   0x0801c57a: 3030        adds	r0, #48	@ 0x30
@   0x0801c57c: 7048        strb	r0, [r1, #1]
@   0x0801c57e: 9700        str	r7, [sp, #0]
@   0x0801c580: 4650        mov	r0, sl
@   0x0801c582: 9001        str	r0, [sp, #4]
@   0x0801c584: 4649        mov	r1, r9
@   0x0801c586: 9102        str	r1, [sp, #8]
@   0x0801c588: a803        add	r0, sp, #12
@   0x0801c58a: 2102        movs	r1, #2
@   0x0801c58c: 2209        movs	r2, #9
@   0x0801c58e: 2311        movs	r3, #17
@   0x0801c590: f7ff        fc74 	bl	0x1be7c
@   0x0801c594: 493c        ldr	r1, [pc, #240]	@ (0x1c688)
@   0x0801c596: 1868        adds	r0, r5, r1
@   0x0801c598: 4933        ldr	r1, [pc, #204]	@ (0x1c668)
@   0x0801c59a: 8001        strh	r1, [r0, #0]
@   0x0801c59c: 493b        ldr	r1, [pc, #236]	@ (0x1c68c)
@   0x0801c59e: 1868        adds	r0, r5, r1
@   0x0801c5a0: 4933        ldr	r1, [pc, #204]	@ (0x1c670)
@   0x0801c5a2: 8001        strh	r1, [r0, #0]
@   0x0801c5a4: 493a        ldr	r1, [pc, #232]	@ (0x1c690)
@   0x0801c5a6: 1868        adds	r0, r5, r1
@   0x0801c5a8: 4933        ldr	r1, [pc, #204]	@ (0x1c678)
@   0x0801c5aa: 8001        strh	r1, [r0, #0]
@   0x0801c5ac: 4839        ldr	r0, [pc, #228]	@ (0x1c694)
@   0x0801c5ae: 182d        adds	r5, r5, r0
@   0x0801c5b0: 3101        adds	r1, #1
@   0x0801c5b2: 8029        strh	r1, [r5, #0]
@   0x0801c5b4: 9700        str	r7, [sp, #0]
@   0x0801c5b6: 4650        mov	r0, sl
@   0x0801c5b8: 9001        str	r0, [sp, #4]
@   0x0801c5ba: 4649        mov	r1, r9
@   0x0801c5bc: 9102        str	r1, [sp, #8]
@   0x0801c5be: 4831        ldr	r0, [pc, #196]	@ (0x1c684)
@   0x0801c5c0: 2104        movs	r1, #4
@   0x0801c5c2: 221a        movs	r2, #26
@   0x0801c5c4: 2311        movs	r3, #17
@   0x0801c5c6: f7ff        fc59 	bl	0x1be7c
@   0x0801c5ca: 4640        mov	r0, r8
@   0x0801c5cc: 210a        movs	r1, #10
@   0x0801c5ce: f017        fc89 	bl	0x33ee4
@   0x0801c5d2: 1c04        adds	r4, r0, #0
@   0x0801c5d4: 0624        lsls	r4, r4, #24
@   0x0801c5d6: 0e24        lsrs	r4, r4, #24
@   0x0801c5d8: 4640        mov	r0, r8
@   0x0801c5da: 210a        movs	r1, #10
@   0x0801c5dc: f017        fcbe 	bl	0x33f5c
@   0x0801c5e0: 0600        lsls	r0, r0, #24
@   0x0801c5e2: 0e00        lsrs	r0, r0, #24
@   0x0801c5e4: a903        add	r1, sp, #12
@   0x0801c5e6: 3430        adds	r4, #48	@ 0x30
@   0x0801c5e8: 700c        strb	r4, [r1, #0]
@   0x0801c5ea: 3030        adds	r0, #48	@ 0x30
@   0x0801c5ec: 7048        strb	r0, [r1, #1]
@   0x0801c5ee: 9700        str	r7, [sp, #0]
@   0x0801c5f0: 4650        mov	r0, sl
@   0x0801c5f2: 9001        str	r0, [sp, #4]
@   0x0801c5f4: 4649        mov	r1, r9
@   0x0801c5f6: 9102        str	r1, [sp, #8]
@   0x0801c5f8: a803        add	r0, sp, #12
@   0x0801c5fa: 2102        movs	r1, #2
@   0x0801c5fc: 221c        movs	r2, #28
@   0x0801c5fe: 2311        movs	r3, #17
@   0x0801c600: f7ff        fc3c 	bl	0x1be7c
@   0x0801c604: 4824        ldr	r0, [pc, #144]	@ (0x1c698)
@   0x0801c606: 9700        str	r7, [sp, #0]
@   0x0801c608: 4651        mov	r1, sl
@   0x0801c60a: 9101        str	r1, [sp, #4]
@   0x0801c60c: 4649        mov	r1, r9
@   0x0801c60e: 9102        str	r1, [sp, #8]
@   0x0801c610: 2104        movs	r1, #4
@   0x0801c612: 220c        movs	r2, #12
@   0x0801c614: 2301        movs	r3, #1
@   0x0801c616: f7ff        fc31 	bl	0x1be7c
@   0x0801c61a: 9804        ldr	r0, [sp, #16]
@   0x0801c61c: 210a        movs	r1, #10
@   0x0801c61e: f017        fc61 	bl	0x33ee4
@   0x0801c622: 1c04        adds	r4, r0, #0
@   0x0801c624: 0624        lsls	r4, r4, #24
@   0x0801c626: 0e24        lsrs	r4, r4, #24
@   0x0801c628: 9804        ldr	r0, [sp, #16]
@   0x0801c62a: 210a        movs	r1, #10
@   0x0801c62c: f017        fc96 	bl	0x33f5c
@   0x0801c630: 0600        lsls	r0, r0, #24
@   0x0801c632: 0e00        lsrs	r0, r0, #24
@   0x0801c634: a903        add	r1, sp, #12
@   0x0801c636: 3430        adds	r4, #48	@ 0x30
@   0x0801c638: 700c        strb	r4, [r1, #0]
@   0x0801c63a: 3030        adds	r0, #48	@ 0x30
@   0x0801c63c: 7048        strb	r0, [r1, #1]
@   0x0801c63e: 9700        str	r7, [sp, #0]
@   0x0801c640: 4650        mov	r0, sl
@   0x0801c642: 9001        str	r0, [sp, #4]
@   0x0801c644: 4649        mov	r1, r9
@   0x0801c646: 9102        str	r1, [sp, #8]
@   0x0801c648: a803        add	r0, sp, #12
@   0x0801c64a: 2102        movs	r1, #2
@   0x0801c64c: 2211        movs	r2, #17
@   0x0801c64e: 2301        movs	r3, #1
@   0x0801c650: f7ff        fc14 	bl	0x1be7c
@   0x0801c654: b005        add	sp, #20
@   0x0801c656: bc38        pop	{r3, r4, r5}
@   0x0801c658: 4698        mov	r8, r3
@   0x0801c65a: 46a1        mov	r9, r4
@   0x0801c65c: 46aa        mov	sl, r5
@   0x0801c65e: bcf0        pop	{r4, r5, r6, r7}
@   0x0801c660: bc01        pop	{r0}
@   0x0801c662: 4700        bx	r0
@   0x0801c664: f80a        0600 	strb.w	r0, [sl, <undefined>]
@   0x0801c668: c112        stmia	r1!, {r1, r4}
@   0x0801c66a: 0000        movs	r0, r0
@   0x0801c66c: f80c        0600 	strb.w	r0, [ip, <undefined>]
@   0x0801c670: c113        stmia	r1!, {r0, r1, r4}
@   0x0801c672: 0000        movs	r0, r0
@   0x0801c674: f84a        0600 	str.w	r0, [sl, <undefined>]
@   0x0801c678: c114        stmia	r1!, {r2, r4}
@   0x0801c67a: 0000        movs	r0, r0
@   0x0801c67c: f84c        0600 	str.w	r0, [ip, <undefined>]
@   0x0801c680: c115        stmia	r1!, {r0, r2, r4}
@   0x0801c682: 0000        movs	r0, r0
@   0x0801c684: e040        b.n	0x1c708
@   0x0801c686: 081b        lsrs	r3, r3, #32
@   0x0801c688: f830        0600 	ldrh.w	r0, [r0, <undefined>]
@   0x0801c68c: f832        0600 	ldrh.w	r0, [r2, <undefined>]
@   0x0801c690: f870        0600 	ldr??.w	r0, [r0, <undefined>]
@   0x0801c694: f872        0600 	ldr??.w	r0, [r2, <undefined>]
@   0x0801c698: e044        b.n	0x1c724
@   0x0801c69a: 081b        lsrs	r3, r3, #32
@   0x0801c69c: b081        sub	sp, #4
@   0x0801c69e: 0600        lsls	r0, r0, #24
@   0x0801c6a0: 0e00        lsrs	r0, r0, #24
@   0x0801c6a2: 2380        movs	r3, #128	@ 0x80
@   0x0801c6a4: 04db        lsls	r3, r3, #19
@   0x0801c6a6: 881a        ldrh	r2, [r3, #0]
@   0x0801c6a8: 490e        ldr	r1, [pc, #56]	@ (0x1c6e4)
@   0x0801c6aa: 4011        ands	r1, r2
@   0x0801c6ac: 8019        strh	r1, [r3, #0]
@   0x0801c6ae: 490e        ldr	r1, [pc, #56]	@ (0x1c6e8)
@   0x0801c6b0: 2200        movs	r2, #0
@   0x0801c6b2: 800a        strh	r2, [r1, #0]
@   0x0801c6b4: 3104        adds	r1, #4
@   0x0801c6b6: 800a        strh	r2, [r1, #0]
@   0x0801c6b8: 21a0        movs	r1, #160	@ 0xa0
@   0x0801c6ba: 04c9        lsls	r1, r1, #19
@   0x0801c6bc: 800a        strh	r2, [r1, #0]
@   0x0801c6be: 4669        mov	r1, sp
@   0x0801c6c0: 2000        movs	r0, #0
@   0x0801c6c2: 8008        strh	r0, [r1, #0]
@   0x0801c6c4: 4909        ldr	r1, [pc, #36]	@ (0x1c6ec)
@   0x0801c6c6: 4668        mov	r0, sp
@   0x0801c6c8: 6008        str	r0, [r1, #0]
@   0x0801c6ca: 4809        ldr	r0, [pc, #36]	@ (0x1c6f0)
@   0x0801c6cc: 6048        str	r0, [r1, #4]
@   0x0801c6ce: 4809        ldr	r0, [pc, #36]	@ (0x1c6f4)
@   0x0801c6d0: 6088        str	r0, [r1, #8]
@   0x0801c6d2: 6888        ldr	r0, [r1, #8]
@   0x0801c6d4: 2280        movs	r2, #128	@ 0x80
@   0x0801c6d6: 04d2        lsls	r2, r2, #19
@   0x0801c6d8: 8811        ldrh	r1, [r2, #0]
@   0x0801c6da: 4807        ldr	r0, [pc, #28]	@ (0x1c6f8)
@   0x0801c6dc: 4008        ands	r0, r1
@   0x0801c6de: 8010        strh	r0, [r2, #0]
@   0x0801c6e0: b001        add	sp, #4
@   0x0801c6e2: 4770        bx	lr

        thumb_func_start sub_0801C464
sub_0801C464: @ 0x0801c464
        .incbin "frog_us_baserom.gba", 0x1c464, 0x94
        thumb_func_end sub_0801C464

        thumb_func_start sub_0801C4F8
sub_0801C4F8: @ 0x0801c4f8
        .incbin "frog_us_baserom.gba", 0x1c4f8, 0x1ec
        thumb_func_end sub_0801C4F8
