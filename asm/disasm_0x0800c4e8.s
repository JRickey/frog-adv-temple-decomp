@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800c4e8, 0x0800c978)  (1168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800c4e8 --end 0x800c978 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800c4e8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800c4ea: 4657        mov	r7, sl
@   0x0800c4ec: 464e        mov	r6, r9
@   0x0800c4ee: 4645        mov	r5, r8
@   0x0800c4f0: b4e0        push	{r5, r6, r7}
@   0x0800c4f2: b086        sub	sp, #24
@   0x0800c4f4: 9c0e        ldr	r4, [sp, #56]	@ 0x38
@   0x0800c4f6: 0600        lsls	r0, r0, #24
@   0x0800c4f8: 0e00        lsrs	r0, r0, #24
@   0x0800c4fa: 4681        mov	r9, r0
@   0x0800c4fc: 0609        lsls	r1, r1, #24
@   0x0800c4fe: 0e09        lsrs	r1, r1, #24
@   0x0800c500: 4688        mov	r8, r1
@   0x0800c502: 0412        lsls	r2, r2, #16
@   0x0800c504: 0c17        lsrs	r7, r2, #16
@   0x0800c506: 041b        lsls	r3, r3, #16
@   0x0800c508: 0c1d        lsrs	r5, r3, #16
@   0x0800c50a: 0624        lsls	r4, r4, #24
@   0x0800c50c: 0e24        lsrs	r4, r4, #24
@   0x0800c50e: 1e60        subs	r0, r4, #1
@   0x0800c510: 280f        cmp	r0, #15
@   0x0800c512: d900        bls.n	0xc516
@   0x0800c514: e227        b.n	0xc966
@   0x0800c516: 0080        lsls	r0, r0, #2
@   0x0800c518: 4901        ldr	r1, [pc, #4]	@ (0xc520)
@   0x0800c51a: 1840        adds	r0, r0, r1
@   0x0800c51c: 6800        ldr	r0, [r0, #0]
@   0x0800c51e: 4687        mov	pc, r0
@   0x0800c520: c524        stmia	r5!, {r2, r5}
@   0x0800c522: 0800        lsrs	r0, r0, #32
@   0x0800c524: c564        stmia	r5!, {r2, r5, r6}
@   0x0800c526: 0800        lsrs	r0, r0, #32
@   0x0800c528: c5a8        stmia	r5!, {r3, r5, r7}
@   0x0800c52a: 0800        lsrs	r0, r0, #32
@   0x0800c52c: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c52e: 0800        lsrs	r0, r0, #32
@   0x0800c530: c5f0        stmia	r5!, {r4, r5, r6, r7}
@   0x0800c532: 0800        lsrs	r0, r0, #32
@   0x0800c534: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c536: 0800        lsrs	r0, r0, #32
@   0x0800c538: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c53a: 0800        lsrs	r0, r0, #32
@   0x0800c53c: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c53e: 0800        lsrs	r0, r0, #32
@   0x0800c540: c634        stmia	r6!, {r2, r4, r5}
@   0x0800c542: 0800        lsrs	r0, r0, #32
@   0x0800c544: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c546: 0800        lsrs	r0, r0, #32
@   0x0800c548: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c54a: 0800        lsrs	r0, r0, #32
@   0x0800c54c: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c54e: 0800        lsrs	r0, r0, #32
@   0x0800c550: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c552: 0800        lsrs	r0, r0, #32
@   0x0800c554: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c556: 0800        lsrs	r0, r0, #32
@   0x0800c558: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c55a: 0800        lsrs	r0, r0, #32
@   0x0800c55c: c966        ldmia	r1, {r1, r2, r5, r6}
@   0x0800c55e: 0800        lsrs	r0, r0, #32
@   0x0800c560: c674        stmia	r6!, {r2, r4, r5, r6}
@   0x0800c562: 0800        lsrs	r0, r0, #32
@   0x0800c564: 0428        lsls	r0, r5, #16
@   0x0800c566: 1402        asrs	r2, r0, #16
@   0x0800c568: 1e50        subs	r0, r2, #1
@   0x0800c56a: 2800        cmp	r0, #0
@   0x0800c56c: da00        bge.n	0xc570
@   0x0800c56e: e1ad        b.n	0xc8cc
@   0x0800c570: 490b        ldr	r1, [pc, #44]	@ (0xc5a0)
@   0x0800c572: 464b        mov	r3, r9
@   0x0800c574: 00d8        lsls	r0, r3, #3
@   0x0800c576: 1840        adds	r0, r0, r1
@   0x0800c578: 7900        ldrb	r0, [r0, #4]
@   0x0800c57a: 4342        muls	r2, r0
@   0x0800c57c: 0439        lsls	r1, r7, #16
@   0x0800c57e: 13c9        asrs	r1, r1, #15
@   0x0800c580: 4644        mov	r4, r8
@   0x0800c582: 00a0        lsls	r0, r4, #2
@   0x0800c584: 4440        add	r0, r8
@   0x0800c586: 0300        lsls	r0, r0, #12
@   0x0800c588: 0052        lsls	r2, r2, #1
@   0x0800c58a: 1880        adds	r0, r0, r2
@   0x0800c58c: 1809        adds	r1, r1, r0
@   0x0800c58e: 4d05        ldr	r5, [pc, #20]	@ (0xc5a4)
@   0x0800c590: 1949        adds	r1, r1, r5
@   0x0800c592: 2008        movs	r0, #8
@   0x0800c594: 8809        ldrh	r1, [r1, #0]
@   0x0800c596: 4008        ands	r0, r1
@   0x0800c598: 0400        lsls	r0, r0, #16
@   0x0800c59a: 0cc0        lsrs	r0, r0, #19
@   0x0800c59c: e1e3        b.n	0xc966
@   0x0800c59e: 0000        movs	r0, r0
@   0x0800c5a0: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c5a2: 0830        lsrs	r0, r6, #32
@   0x0800c5a4: 0000        movs	r0, r0
@   0x0800c5a6: 0203        lsls	r3, r0, #8
@   0x0800c5a8: 0428        lsls	r0, r5, #16
@   0x0800c5aa: 1403        asrs	r3, r0, #16
@   0x0800c5ac: 1c5a        adds	r2, r3, #1
@   0x0800c5ae: 490e        ldr	r1, [pc, #56]	@ (0xc5e8)
@   0x0800c5b0: 464e        mov	r6, r9
@   0x0800c5b2: 00f0        lsls	r0, r6, #3
@   0x0800c5b4: 1840        adds	r0, r0, r1
@   0x0800c5b6: 7941        ldrb	r1, [r0, #5]
@   0x0800c5b8: 428a        cmp	r2, r1
@   0x0800c5ba: db00        blt.n	0xc5be
@   0x0800c5bc: e186        b.n	0xc8cc
@   0x0800c5be: 7900        ldrb	r0, [r0, #4]
@   0x0800c5c0: 1c02        adds	r2, r0, #0
@   0x0800c5c2: 435a        muls	r2, r3
@   0x0800c5c4: 0439        lsls	r1, r7, #16
@   0x0800c5c6: 13c9        asrs	r1, r1, #15
@   0x0800c5c8: 4643        mov	r3, r8
@   0x0800c5ca: 0098        lsls	r0, r3, #2
@   0x0800c5cc: 4440        add	r0, r8
@   0x0800c5ce: 0300        lsls	r0, r0, #12
@   0x0800c5d0: 0052        lsls	r2, r2, #1
@   0x0800c5d2: 1880        adds	r0, r0, r2
@   0x0800c5d4: 1809        adds	r1, r1, r0
@   0x0800c5d6: 4c05        ldr	r4, [pc, #20]	@ (0xc5ec)
@   0x0800c5d8: 1909        adds	r1, r1, r4
@   0x0800c5da: 2004        movs	r0, #4
@   0x0800c5dc: 8809        ldrh	r1, [r1, #0]
@   0x0800c5de: 4008        ands	r0, r1
@   0x0800c5e0: 0400        lsls	r0, r0, #16
@   0x0800c5e2: 0c80        lsrs	r0, r0, #18
@   0x0800c5e4: e1bf        b.n	0xc966
@   0x0800c5e6: 0000        movs	r0, r0
@   0x0800c5e8: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c5ea: 0830        lsrs	r0, r6, #32
@   0x0800c5ec: 0000        movs	r0, r0
@   0x0800c5ee: 0203        lsls	r3, r0, #8
@   0x0800c5f0: 0438        lsls	r0, r7, #16
@   0x0800c5f2: 1403        asrs	r3, r0, #16
@   0x0800c5f4: 1e58        subs	r0, r3, #1
@   0x0800c5f6: 2800        cmp	r0, #0
@   0x0800c5f8: da00        bge.n	0xc5fc
@   0x0800c5fa: e167        b.n	0xc8cc
@   0x0800c5fc: 0429        lsls	r1, r5, #16
@   0x0800c5fe: 1409        asrs	r1, r1, #16
@   0x0800c600: 4a0a        ldr	r2, [pc, #40]	@ (0xc62c)
@   0x0800c602: 464d        mov	r5, r9
@   0x0800c604: 00e8        lsls	r0, r5, #3
@   0x0800c606: 1880        adds	r0, r0, r2
@   0x0800c608: 7900        ldrb	r0, [r0, #4]
@   0x0800c60a: 4341        muls	r1, r0
@   0x0800c60c: 005a        lsls	r2, r3, #1
@   0x0800c60e: 4646        mov	r6, r8
@   0x0800c610: 00b0        lsls	r0, r6, #2
@   0x0800c612: 4440        add	r0, r8
@   0x0800c614: 0300        lsls	r0, r0, #12
@   0x0800c616: 0049        lsls	r1, r1, #1
@   0x0800c618: 1840        adds	r0, r0, r1
@   0x0800c61a: 1812        adds	r2, r2, r0
@   0x0800c61c: 4f04        ldr	r7, [pc, #16]	@ (0xc630)
@   0x0800c61e: 19d2        adds	r2, r2, r7
@   0x0800c620: 2002        movs	r0, #2
@   0x0800c622: 8812        ldrh	r2, [r2, #0]
@   0x0800c624: 4010        ands	r0, r2
@   0x0800c626: 0400        lsls	r0, r0, #16
@   0x0800c628: 0c40        lsrs	r0, r0, #17
@   0x0800c62a: e19c        b.n	0xc966
@   0x0800c62c: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c62e: 0830        lsrs	r0, r6, #32
@   0x0800c630: 0000        movs	r0, r0
@   0x0800c632: 0203        lsls	r3, r0, #8
@   0x0800c634: 0438        lsls	r0, r7, #16
@   0x0800c636: 1403        asrs	r3, r0, #16
@   0x0800c638: 1c5a        adds	r2, r3, #1
@   0x0800c63a: 490c        ldr	r1, [pc, #48]	@ (0xc66c)
@   0x0800c63c: 464c        mov	r4, r9
@   0x0800c63e: 00e0        lsls	r0, r4, #3
@   0x0800c640: 1840        adds	r0, r0, r1
@   0x0800c642: 7901        ldrb	r1, [r0, #4]
@   0x0800c644: 428a        cmp	r2, r1
@   0x0800c646: db00        blt.n	0xc64a
@   0x0800c648: e140        b.n	0xc8cc
@   0x0800c64a: 0428        lsls	r0, r5, #16
@   0x0800c64c: 1400        asrs	r0, r0, #16
@   0x0800c64e: 4341        muls	r1, r0
@   0x0800c650: 005a        lsls	r2, r3, #1
@   0x0800c652: 4645        mov	r5, r8
@   0x0800c654: 00a8        lsls	r0, r5, #2
@   0x0800c656: 4440        add	r0, r8
@   0x0800c658: 0300        lsls	r0, r0, #12
@   0x0800c65a: 0049        lsls	r1, r1, #1
@   0x0800c65c: 1840        adds	r0, r0, r1
@   0x0800c65e: 1812        adds	r2, r2, r0
@   0x0800c660: 4e03        ldr	r6, [pc, #12]	@ (0xc670)
@   0x0800c662: 1992        adds	r2, r2, r6
@   0x0800c664: 2001        movs	r0, #1
@   0x0800c666: 7812        ldrb	r2, [r2, #0]
@   0x0800c668: 4010        ands	r0, r2
@   0x0800c66a: e17c        b.n	0xc966
@   0x0800c66c: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c66e: 0830        lsrs	r0, r6, #32
@   0x0800c670: 0000        movs	r0, r0
@   0x0800c672: 0203        lsls	r3, r0, #8
@   0x0800c674: 4804        ldr	r0, [pc, #16]	@ (0xc688)
@   0x0800c676: 7e86        ldrb	r6, [r0, #26]
@   0x0800c678: 2e01        cmp	r6, #1
@   0x0800c67a: d06d        beq.n	0xc758
@   0x0800c67c: 2e01        cmp	r6, #1
@   0x0800c67e: dc05        bgt.n	0xc68c
@   0x0800c680: 2e00        cmp	r6, #0
@   0x0800c682: d00a        beq.n	0xc69a
@   0x0800c684: e16f        b.n	0xc966
@   0x0800c686: 0000        movs	r0, r0
@   0x0800c688: 3720        adds	r7, #32
@   0x0800c68a: 0300        lsls	r0, r0, #12
@   0x0800c68c: 2e02        cmp	r6, #2
@   0x0800c68e: d100        bne.n	0xc692
@   0x0800c690: e0c0        b.n	0xc814
@   0x0800c692: 2e03        cmp	r6, #3
@   0x0800c694: d100        bne.n	0xc698
@   0x0800c696: e10d        b.n	0xc8b4
@   0x0800c698: e165        b.n	0xc966
@   0x0800c69a: 0428        lsls	r0, r5, #16
@   0x0800c69c: 1406        asrs	r6, r0, #16
@   0x0800c69e: 1eb1        subs	r1, r6, #2
@   0x0800c6a0: 1c05        adds	r5, r0, #0
@   0x0800c6a2: 2900        cmp	r1, #0
@   0x0800c6a4: da00        bge.n	0xc6a8
@   0x0800c6a6: e111        b.n	0xc8cc
@   0x0800c6a8: 4829        ldr	r0, [pc, #164]	@ (0xc750)
@   0x0800c6aa: 4649        mov	r1, r9
@   0x0800c6ac: 00cc        lsls	r4, r1, #3
@   0x0800c6ae: 1820        adds	r0, r4, r0
@   0x0800c6b0: 7900        ldrb	r0, [r0, #4]
@   0x0800c6b2: 9001        str	r0, [sp, #4]
@   0x0800c6b4: 1c03        adds	r3, r0, #0
@   0x0800c6b6: 1c30        adds	r0, r6, #0
@   0x0800c6b8: 4358        muls	r0, r3
@   0x0800c6ba: 043b        lsls	r3, r7, #16
@   0x0800c6bc: 13df        asrs	r7, r3, #15
@   0x0800c6be: 9702        str	r7, [sp, #8]
@   0x0800c6c0: 4641        mov	r1, r8
@   0x0800c6c2: 008a        lsls	r2, r1, #2
@   0x0800c6c4: 1851        adds	r1, r2, r1
@   0x0800c6c6: 0309        lsls	r1, r1, #12
@   0x0800c6c8: 9103        str	r1, [sp, #12]
@   0x0800c6ca: 0040        lsls	r0, r0, #1
@   0x0800c6cc: 1808        adds	r0, r1, r0
@   0x0800c6ce: 1838        adds	r0, r7, r0
@   0x0800c6d0: 4f20        ldr	r7, [pc, #128]	@ (0xc754)
@   0x0800c6d2: 19c0        adds	r0, r0, r7
@   0x0800c6d4: 2108        movs	r1, #8
@   0x0800c6d6: 8800        ldrh	r0, [r0, #0]
@   0x0800c6d8: 4001        ands	r1, r0
@   0x0800c6da: 46a2        mov	sl, r4
@   0x0800c6dc: 469c        mov	ip, r3
@   0x0800c6de: 1c17        adds	r7, r2, #0
@   0x0800c6e0: 2900        cmp	r1, #0
@   0x0800c6e2: d00f        beq.n	0xc704
@   0x0800c6e4: 1e70        subs	r0, r6, #1
@   0x0800c6e6: 9901        ldr	r1, [sp, #4]
@   0x0800c6e8: 4348        muls	r0, r1
@   0x0800c6ea: 0040        lsls	r0, r0, #1
@   0x0800c6ec: 9b03        ldr	r3, [sp, #12]
@   0x0800c6ee: 1818        adds	r0, r3, r0
@   0x0800c6f0: 9c02        ldr	r4, [sp, #8]
@   0x0800c6f2: 1820        adds	r0, r4, r0
@   0x0800c6f4: 4e17        ldr	r6, [pc, #92]	@ (0xc754)
@   0x0800c6f6: 1980        adds	r0, r0, r6
@   0x0800c6f8: 2108        movs	r1, #8
@   0x0800c6fa: 8800        ldrh	r0, [r0, #0]
@   0x0800c6fc: 4001        ands	r1, r0
@   0x0800c6fe: 2900        cmp	r1, #0
@   0x0800c700: d000        beq.n	0xc704
@   0x0800c702: e126        b.n	0xc952
@   0x0800c704: 4660        mov	r0, ip
@   0x0800c706: 1406        asrs	r6, r0, #16
@   0x0800c708: 142c        asrs	r4, r5, #16
@   0x0800c70a: 2001        movs	r0, #1
@   0x0800c70c: 9000        str	r0, [sp, #0]
@   0x0800c70e: 4648        mov	r0, r9
@   0x0800c710: 4641        mov	r1, r8
@   0x0800c712: 1c32        adds	r2, r6, #0
@   0x0800c714: 1c23        adds	r3, r4, #0
@   0x0800c716: f000        f92f 	bl	0xc978
@   0x0800c71a: 0600        lsls	r0, r0, #24
@   0x0800c71c: 0e00        lsrs	r0, r0, #24
@   0x0800c71e: 2801        cmp	r0, #1
@   0x0800c720: d000        beq.n	0xc724
@   0x0800c722: e0d3        b.n	0xc8cc
@   0x0800c724: 1e61        subs	r1, r4, #1
@   0x0800c726: 480a        ldr	r0, [pc, #40]	@ (0xc750)
@   0x0800c728: 4450        add	r0, sl
@   0x0800c72a: 7900        ldrb	r0, [r0, #4]
@   0x0800c72c: 4341        muls	r1, r0
@   0x0800c72e: 0072        lsls	r2, r6, #1
@   0x0800c730: 4643        mov	r3, r8
@   0x0800c732: 18f8        adds	r0, r7, r3
@   0x0800c734: 0300        lsls	r0, r0, #12
@   0x0800c736: 0049        lsls	r1, r1, #1
@   0x0800c738: 1840        adds	r0, r0, r1
@   0x0800c73a: 1812        adds	r2, r2, r0
@   0x0800c73c: 4c05        ldr	r4, [pc, #20]	@ (0xc754)
@   0x0800c73e: 1912        adds	r2, r2, r4
@   0x0800c740: 2008        movs	r0, #8
@   0x0800c742: 8812        ldrh	r2, [r2, #0]
@   0x0800c744: 4010        ands	r0, r2
@   0x0800c746: 2800        cmp	r0, #0
@   0x0800c748: d000        beq.n	0xc74c
@   0x0800c74a: e102        b.n	0xc952
@   0x0800c74c: e0be        b.n	0xc8cc
@   0x0800c74e: 0000        movs	r0, r0
@   0x0800c750: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c752: 0830        lsrs	r0, r6, #32
@   0x0800c754: 0000        movs	r0, r0
@   0x0800c756: 0203        lsls	r3, r0, #8
@   0x0800c758: 042a        lsls	r2, r5, #16
@   0x0800c75a: 1414        asrs	r4, r2, #16
@   0x0800c75c: 1ca3        adds	r3, r4, #2
@   0x0800c75e: 482b        ldr	r0, [pc, #172]	@ (0xc80c)
@   0x0800c760: 464d        mov	r5, r9
@   0x0800c762: 00e9        lsls	r1, r5, #3
@   0x0800c764: 1808        adds	r0, r1, r0
@   0x0800c766: 1c15        adds	r5, r2, #0
@   0x0800c768: 468a        mov	sl, r1
@   0x0800c76a: 7946        ldrb	r6, [r0, #5]
@   0x0800c76c: 42b3        cmp	r3, r6
@   0x0800c76e: db00        blt.n	0xc772
@   0x0800c770: e0ac        b.n	0xc8cc
@   0x0800c772: 7900        ldrb	r0, [r0, #4]
@   0x0800c774: 9004        str	r0, [sp, #16]
@   0x0800c776: 1c01        adds	r1, r0, #0
@   0x0800c778: 1c20        adds	r0, r4, #0
@   0x0800c77a: 4348        muls	r0, r1
@   0x0800c77c: 043b        lsls	r3, r7, #16
@   0x0800c77e: 13de        asrs	r6, r3, #15
@   0x0800c780: 9605        str	r6, [sp, #20]
@   0x0800c782: 4647        mov	r7, r8
@   0x0800c784: 00ba        lsls	r2, r7, #2
@   0x0800c786: 19d1        adds	r1, r2, r7
@   0x0800c788: 030e        lsls	r6, r1, #12
@   0x0800c78a: 0040        lsls	r0, r0, #1
@   0x0800c78c: 1830        adds	r0, r6, r0
@   0x0800c78e: 9905        ldr	r1, [sp, #20]
@   0x0800c790: 1808        adds	r0, r1, r0
@   0x0800c792: 4f1f        ldr	r7, [pc, #124]	@ (0xc810)
@   0x0800c794: 19c0        adds	r0, r0, r7
@   0x0800c796: 2104        movs	r1, #4
@   0x0800c798: 8800        ldrh	r0, [r0, #0]
@   0x0800c79a: 4001        ands	r1, r0
@   0x0800c79c: 469c        mov	ip, r3
@   0x0800c79e: 1c17        adds	r7, r2, #0
@   0x0800c7a0: 2900        cmp	r1, #0
@   0x0800c7a2: d00e        beq.n	0xc7c2
@   0x0800c7a4: 1c60        adds	r0, r4, #1
@   0x0800c7a6: 9904        ldr	r1, [sp, #16]
@   0x0800c7a8: 4348        muls	r0, r1
@   0x0800c7aa: 0040        lsls	r0, r0, #1
@   0x0800c7ac: 1830        adds	r0, r6, r0
@   0x0800c7ae: 9b05        ldr	r3, [sp, #20]
@   0x0800c7b0: 1818        adds	r0, r3, r0
@   0x0800c7b2: 4c17        ldr	r4, [pc, #92]	@ (0xc810)
@   0x0800c7b4: 1900        adds	r0, r0, r4
@   0x0800c7b6: 2104        movs	r1, #4
@   0x0800c7b8: 8800        ldrh	r0, [r0, #0]
@   0x0800c7ba: 4001        ands	r1, r0
@   0x0800c7bc: 2900        cmp	r1, #0
@   0x0800c7be: d000        beq.n	0xc7c2
@   0x0800c7c0: e0c7        b.n	0xc952
@   0x0800c7c2: 4660        mov	r0, ip
@   0x0800c7c4: 1406        asrs	r6, r0, #16
@   0x0800c7c6: 142c        asrs	r4, r5, #16
@   0x0800c7c8: 2002        movs	r0, #2
@   0x0800c7ca: 9000        str	r0, [sp, #0]
@   0x0800c7cc: 4648        mov	r0, r9
@   0x0800c7ce: 4641        mov	r1, r8
@   0x0800c7d0: 1c32        adds	r2, r6, #0
@   0x0800c7d2: 1c23        adds	r3, r4, #0
@   0x0800c7d4: f000        f8d0 	bl	0xc978
@   0x0800c7d8: 0600        lsls	r0, r0, #24
@   0x0800c7da: 0e00        lsrs	r0, r0, #24
@   0x0800c7dc: 2801        cmp	r0, #1
@   0x0800c7de: d175        bne.n	0xc8cc
@   0x0800c7e0: 1c61        adds	r1, r4, #1
@   0x0800c7e2: 480a        ldr	r0, [pc, #40]	@ (0xc80c)
@   0x0800c7e4: 4450        add	r0, sl
@   0x0800c7e6: 7900        ldrb	r0, [r0, #4]
@   0x0800c7e8: 4341        muls	r1, r0
@   0x0800c7ea: 0072        lsls	r2, r6, #1
@   0x0800c7ec: 4643        mov	r3, r8
@   0x0800c7ee: 18f8        adds	r0, r7, r3
@   0x0800c7f0: 0300        lsls	r0, r0, #12
@   0x0800c7f2: 0049        lsls	r1, r1, #1
@   0x0800c7f4: 1840        adds	r0, r0, r1
@   0x0800c7f6: 1812        adds	r2, r2, r0
@   0x0800c7f8: 4c05        ldr	r4, [pc, #20]	@ (0xc810)
@   0x0800c7fa: 1912        adds	r2, r2, r4
@   0x0800c7fc: 2004        movs	r0, #4
@   0x0800c7fe: 8812        ldrh	r2, [r2, #0]
@   0x0800c800: 4010        ands	r0, r2
@   0x0800c802: 2800        cmp	r0, #0
@   0x0800c804: d000        beq.n	0xc808
@   0x0800c806: e0a4        b.n	0xc952
@   0x0800c808: e060        b.n	0xc8cc
@   0x0800c80a: 0000        movs	r0, r0
@   0x0800c80c: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c80e: 0830        lsrs	r0, r6, #32
@   0x0800c810: 0000        movs	r0, r0
@   0x0800c812: 0203        lsls	r3, r0, #8
@   0x0800c814: 0438        lsls	r0, r7, #16
@   0x0800c816: 1402        asrs	r2, r0, #16
@   0x0800c818: 1e91        subs	r1, r2, #2
@   0x0800c81a: 4684        mov	ip, r0
@   0x0800c81c: 2900        cmp	r1, #0
@   0x0800c81e: db55        blt.n	0xc8cc
@   0x0800c820: 042d        lsls	r5, r5, #16
@   0x0800c822: 1429        asrs	r1, r5, #16
@   0x0800c824: 4820        ldr	r0, [pc, #128]	@ (0xc8a8)
@   0x0800c826: 464f        mov	r7, r9
@   0x0800c828: 00fc        lsls	r4, r7, #3
@   0x0800c82a: 1820        adds	r0, r4, r0
@   0x0800c82c: 7900        ldrb	r0, [r0, #4]
@   0x0800c82e: 4341        muls	r1, r0
@   0x0800c830: 0052        lsls	r2, r2, #1
@   0x0800c832: 4640        mov	r0, r8
@   0x0800c834: 0083        lsls	r3, r0, #2
@   0x0800c836: 1818        adds	r0, r3, r0
@   0x0800c838: 0300        lsls	r0, r0, #12
@   0x0800c83a: 0049        lsls	r1, r1, #1
@   0x0800c83c: 1840        adds	r0, r0, r1
@   0x0800c83e: 1812        adds	r2, r2, r0
@   0x0800c840: 4f1a        ldr	r7, [pc, #104]	@ (0xc8ac)
@   0x0800c842: 19d1        adds	r1, r2, r7
@   0x0800c844: 1c30        adds	r0, r6, #0
@   0x0800c846: 8809        ldrh	r1, [r1, #0]
@   0x0800c848: 4008        ands	r0, r1
@   0x0800c84a: 0840        lsrs	r0, r0, #1
@   0x0800c84c: 46a2        mov	sl, r4
@   0x0800c84e: 1c1f        adds	r7, r3, #0
@   0x0800c850: 2800        cmp	r0, #0
@   0x0800c852: d006        beq.n	0xc862
@   0x0800c854: 4916        ldr	r1, [pc, #88]	@ (0xc8b0)
@   0x0800c856: 1850        adds	r0, r2, r1
@   0x0800c858: 8800        ldrh	r0, [r0, #0]
@   0x0800c85a: 4006        ands	r6, r0
@   0x0800c85c: 0870        lsrs	r0, r6, #1
@   0x0800c85e: 2800        cmp	r0, #0
@   0x0800c860: d177        bne.n	0xc952
@   0x0800c862: 4663        mov	r3, ip
@   0x0800c864: 141e        asrs	r6, r3, #16
@   0x0800c866: 142c        asrs	r4, r5, #16
@   0x0800c868: 2004        movs	r0, #4
@   0x0800c86a: 9000        str	r0, [sp, #0]
@   0x0800c86c: 4648        mov	r0, r9
@   0x0800c86e: 4641        mov	r1, r8
@   0x0800c870: 1c32        adds	r2, r6, #0
@   0x0800c872: 1c23        adds	r3, r4, #0
@   0x0800c874: f000        f880 	bl	0xc978
@   0x0800c878: 0600        lsls	r0, r0, #24
@   0x0800c87a: 0e00        lsrs	r0, r0, #24
@   0x0800c87c: 2801        cmp	r0, #1
@   0x0800c87e: d125        bne.n	0xc8cc
@   0x0800c880: 4809        ldr	r0, [pc, #36]	@ (0xc8a8)
@   0x0800c882: 4450        add	r0, sl
@   0x0800c884: 7900        ldrb	r0, [r0, #4]
@   0x0800c886: 1c01        adds	r1, r0, #0
@   0x0800c888: 4361        muls	r1, r4
@   0x0800c88a: 0072        lsls	r2, r6, #1
@   0x0800c88c: 4644        mov	r4, r8
@   0x0800c88e: 1938        adds	r0, r7, r4
@   0x0800c890: 0300        lsls	r0, r0, #12
@   0x0800c892: 0049        lsls	r1, r1, #1
@   0x0800c894: 1840        adds	r0, r0, r1
@   0x0800c896: 1812        adds	r2, r2, r0
@   0x0800c898: 4d05        ldr	r5, [pc, #20]	@ (0xc8b0)
@   0x0800c89a: 1952        adds	r2, r2, r5
@   0x0800c89c: 2002        movs	r0, #2
@   0x0800c89e: 8812        ldrh	r2, [r2, #0]
@   0x0800c8a0: 4010        ands	r0, r2
@   0x0800c8a2: 2800        cmp	r0, #0
@   0x0800c8a4: d155        bne.n	0xc952
@   0x0800c8a6: e011        b.n	0xc8cc
@   0x0800c8a8: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c8aa: 0830        lsrs	r0, r6, #32
@   0x0800c8ac: 0000        movs	r0, r0
@   0x0800c8ae: 0203        lsls	r3, r0, #8
@   0x0800c8b0: fffe        0202 	vmovn.i<illegal width 128>	d16, q1
@   0x0800c8b4: 043a        lsls	r2, r7, #16
@   0x0800c8b6: 1417        asrs	r7, r2, #16
@   0x0800c8b8: 1cbb        adds	r3, r7, #2
@   0x0800c8ba: 4805        ldr	r0, [pc, #20]	@ (0xc8d0)
@   0x0800c8bc: 464e        mov	r6, r9
@   0x0800c8be: 00f1        lsls	r1, r6, #3
@   0x0800c8c0: 1808        adds	r0, r1, r0
@   0x0800c8c2: 7906        ldrb	r6, [r0, #4]
@   0x0800c8c4: 468a        mov	sl, r1
@   0x0800c8c6: 4694        mov	ip, r2
@   0x0800c8c8: 42b3        cmp	r3, r6
@   0x0800c8ca: db03        blt.n	0xc8d4
@   0x0800c8cc: 2000        movs	r0, #0
@   0x0800c8ce: e04a        b.n	0xc966
@   0x0800c8d0: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c8d2: 0830        lsrs	r0, r6, #32
@   0x0800c8d4: 042c        lsls	r4, r5, #16
@   0x0800c8d6: 1420        asrs	r0, r4, #16
@   0x0800c8d8: 1c01        adds	r1, r0, #0
@   0x0800c8da: 4371        muls	r1, r6
@   0x0800c8dc: 007a        lsls	r2, r7, #1
@   0x0800c8de: 4647        mov	r7, r8
@   0x0800c8e0: 00bb        lsls	r3, r7, #2
@   0x0800c8e2: 19d8        adds	r0, r3, r7
@   0x0800c8e4: 0300        lsls	r0, r0, #12
@   0x0800c8e6: 0049        lsls	r1, r1, #1
@   0x0800c8e8: 1840        adds	r0, r0, r1
@   0x0800c8ea: 1812        adds	r2, r2, r0
@   0x0800c8ec: 481a        ldr	r0, [pc, #104]	@ (0xc958)
@   0x0800c8ee: 1811        adds	r1, r2, r0
@   0x0800c8f0: 2601        movs	r6, #1
@   0x0800c8f2: 1c30        adds	r0, r6, #0
@   0x0800c8f4: 8809        ldrh	r1, [r1, #0]
@   0x0800c8f6: 4008        ands	r0, r1
@   0x0800c8f8: 1c25        adds	r5, r4, #0
@   0x0800c8fa: 1c1f        adds	r7, r3, #0
@   0x0800c8fc: 2800        cmp	r0, #0
@   0x0800c8fe: d006        beq.n	0xc90e
@   0x0800c900: 4b16        ldr	r3, [pc, #88]	@ (0xc95c)
@   0x0800c902: 18d1        adds	r1, r2, r3
@   0x0800c904: 1c30        adds	r0, r6, #0
@   0x0800c906: 8809        ldrh	r1, [r1, #0]
@   0x0800c908: 4008        ands	r0, r1
@   0x0800c90a: 2800        cmp	r0, #0
@   0x0800c90c: d121        bne.n	0xc952
@   0x0800c90e: 4664        mov	r4, ip
@   0x0800c910: 1426        asrs	r6, r4, #16
@   0x0800c912: 142c        asrs	r4, r5, #16
@   0x0800c914: 2008        movs	r0, #8
@   0x0800c916: 9000        str	r0, [sp, #0]
@   0x0800c918: 4648        mov	r0, r9
@   0x0800c91a: 4641        mov	r1, r8
@   0x0800c91c: 1c32        adds	r2, r6, #0
@   0x0800c91e: 1c23        adds	r3, r4, #0
@   0x0800c920: f000        f82a 	bl	0xc978
@   0x0800c924: 0600        lsls	r0, r0, #24
@   0x0800c926: 0e03        lsrs	r3, r0, #24
@   0x0800c928: 2b01        cmp	r3, #1
@   0x0800c92a: d11b        bne.n	0xc964
@   0x0800c92c: 480c        ldr	r0, [pc, #48]	@ (0xc960)
@   0x0800c92e: 4450        add	r0, sl
@   0x0800c930: 7900        ldrb	r0, [r0, #4]
@   0x0800c932: 1c01        adds	r1, r0, #0
@   0x0800c934: 4361        muls	r1, r4
@   0x0800c936: 0072        lsls	r2, r6, #1
@   0x0800c938: 4645        mov	r5, r8
@   0x0800c93a: 1978        adds	r0, r7, r5
@   0x0800c93c: 0300        lsls	r0, r0, #12
@   0x0800c93e: 0049        lsls	r1, r1, #1
@   0x0800c940: 1840        adds	r0, r0, r1
@   0x0800c942: 1812        adds	r2, r2, r0
@   0x0800c944: 4e05        ldr	r6, [pc, #20]	@ (0xc95c)
@   0x0800c946: 1992        adds	r2, r2, r6
@   0x0800c948: 1c18        adds	r0, r3, #0
@   0x0800c94a: 8812        ldrh	r2, [r2, #0]
@   0x0800c94c: 4010        ands	r0, r2
@   0x0800c94e: 2800        cmp	r0, #0
@   0x0800c950: d008        beq.n	0xc964
@   0x0800c952: 2001        movs	r0, #1
@   0x0800c954: e007        b.n	0xc966
@   0x0800c956: 0000        movs	r0, r0
@   0x0800c958: 0000        movs	r0, r0
@   0x0800c95a: 0203        lsls	r3, r0, #8
@   0x0800c95c: 0002        movs	r2, r0
@   0x0800c95e: 0203        lsls	r3, r0, #8
@   0x0800c960: 6444        str	r4, [r0, #68]	@ 0x44
@   0x0800c962: 0830        lsrs	r0, r6, #32
@   0x0800c964: 2000        movs	r0, #0
@   0x0800c966: b006        add	sp, #24
@   0x0800c968: bc38        pop	{r3, r4, r5}
@   0x0800c96a: 4698        mov	r8, r3
@   0x0800c96c: 46a1        mov	r9, r4
@   0x0800c96e: 46aa        mov	sl, r5
@   0x0800c970: bcf0        pop	{r4, r5, r6, r7}
@   0x0800c972: bc02        pop	{r1}
@   0x0800c974: 4708        bx	r1

        thumb_func_start sub_0800C4E8
sub_0800C4E8: @ 0x0800c4e8
        .incbin "frog_us_baserom.gba", 0xc4e8, 0x490
        thumb_func_end sub_0800C4E8
