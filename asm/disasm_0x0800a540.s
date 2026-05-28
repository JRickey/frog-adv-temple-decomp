@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a540, 0x0800a710)  (464 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a540 --end 0x800a710 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a540: b500        push	{lr}
@   0x0800a542: b086        sub	sp, #24
@   0x0800a544: 480d        ldr	r0, [pc, #52]	@ (0xa57c)
@   0x0800a546: 1c01        adds	r1, r0, #0
@   0x0800a548: 3938        subs	r1, #56	@ 0x38
@   0x0800a54a: 2302        movs	r3, #2
@   0x0800a54c: 5eca        ldrsh	r2, [r1, r3]
@   0x0800a54e: 888b        ldrh	r3, [r1, #4]
@   0x0800a550: 3b18        subs	r3, #24
@   0x0800a552: 041b        lsls	r3, r3, #16
@   0x0800a554: 141b        asrs	r3, r3, #16
@   0x0800a556: 2103        movs	r1, #3
@   0x0800a558: 9100        str	r1, [sp, #0]
@   0x0800a55a: 21f8        movs	r1, #248	@ 0xf8
@   0x0800a55c: 0089        lsls	r1, r1, #2
@   0x0800a55e: 9101        str	r1, [sp, #4]
@   0x0800a560: 210f        movs	r1, #15
@   0x0800a562: 9102        str	r1, [sp, #8]
@   0x0800a564: 2102        movs	r1, #2
@   0x0800a566: 9103        str	r1, [sp, #12]
@   0x0800a568: 2100        movs	r1, #0
@   0x0800a56a: 9104        str	r1, [sp, #16]
@   0x0800a56c: 2120        movs	r1, #32
@   0x0800a56e: 9105        str	r1, [sp, #20]
@   0x0800a570: 2154        movs	r1, #84	@ 0x54
@   0x0800a572: f000        f8cd 	bl	0xa710
@   0x0800a576: b006        add	sp, #24
@   0x0800a578: bc01        pop	{r0}
@   0x0800a57a: 4700        bx	r0
@   0x0800a57c: 3758        adds	r7, #88	@ 0x58
@   0x0800a57e: 0300        lsls	r0, r0, #12
@   0x0800a580: 4684        mov	ip, r0
@   0x0800a582: 0609        lsls	r1, r1, #24
@   0x0800a584: 0e09        lsrs	r1, r1, #24
@   0x0800a586: 0612        lsls	r2, r2, #24
@   0x0800a588: 0e12        lsrs	r2, r2, #24
@   0x0800a58a: 061b        lsls	r3, r3, #24
@   0x0800a58c: 0e1b        lsrs	r3, r3, #24
@   0x0800a58e: 302a        adds	r0, #42	@ 0x2a
@   0x0800a590: 7001        strb	r1, [r0, #0]
@   0x0800a592: 0609        lsls	r1, r1, #24
@   0x0800a594: 1608        asrs	r0, r1, #24
@   0x0800a596: 280d        cmp	r0, #13
@   0x0800a598: d900        bls.n	0xa59c
@   0x0800a59a: e0b7        b.n	0xa70c
@   0x0800a59c: 0080        lsls	r0, r0, #2
@   0x0800a59e: 4902        ldr	r1, [pc, #8]	@ (0xa5a8)
@   0x0800a5a0: 1840        adds	r0, r0, r1
@   0x0800a5a2: 6800        ldr	r0, [r0, #0]
@   0x0800a5a4: 4687        mov	pc, r0
@   0x0800a5a6: 0000        movs	r0, r0
@   0x0800a5a8: a5ac        add	r5, pc, #688	@ (adr r5, 0xa85c)
@   0x0800a5aa: 0800        lsrs	r0, r0, #32
@   0x0800a5ac: a6f8        add	r6, pc, #992	@ (adr r6, 0xa990)
@   0x0800a5ae: 0800        lsrs	r0, r0, #32
@   0x0800a5b0: a6e4        add	r6, pc, #912	@ (adr r6, 0xa944)
@   0x0800a5b2: 0800        lsrs	r0, r0, #32
@   0x0800a5b4: a6dc        add	r6, pc, #880	@ (adr r6, 0xa928)
@   0x0800a5b6: 0800        lsrs	r0, r0, #32
@   0x0800a5b8: a6d4        add	r6, pc, #848	@ (adr r6, 0xa90c)
@   0x0800a5ba: 0800        lsrs	r0, r0, #32
@   0x0800a5bc: a6cc        add	r6, pc, #816	@ (adr r6, 0xa8f0)
@   0x0800a5be: 0800        lsrs	r0, r0, #32
@   0x0800a5c0: a6b8        add	r6, pc, #736	@ (adr r6, 0xa8a4)
@   0x0800a5c2: 0800        lsrs	r0, r0, #32
@   0x0800a5c4: a694        add	r6, pc, #592	@ (adr r6, 0xa818)
@   0x0800a5c6: 0800        lsrs	r0, r0, #32
@   0x0800a5c8: a670        add	r6, pc, #448	@ (adr r6, 0xa78c)
@   0x0800a5ca: 0800        lsrs	r0, r0, #32
@   0x0800a5cc: a64c        add	r6, pc, #304	@ (adr r6, 0xa700)
@   0x0800a5ce: 0800        lsrs	r0, r0, #32
@   0x0800a5d0: a638        add	r6, pc, #224	@ (adr r6, 0xa6b4)
@   0x0800a5d2: 0800        lsrs	r0, r0, #32
@   0x0800a5d4: a614        add	r6, pc, #80	@ (adr r6, 0xa628)
@   0x0800a5d6: 0800        lsrs	r0, r0, #32
@   0x0800a5d8: a600        add	r6, pc, #0	@ (adr r6, 0xa5dc)
@   0x0800a5da: 0800        lsrs	r0, r0, #32
@   0x0800a5dc: a5f8        add	r5, pc, #992	@ (adr r5, 0xa9c0)
@   0x0800a5de: 0800        lsrs	r0, r0, #32
@   0x0800a5e0: a5e4        add	r5, pc, #912	@ (adr r5, 0xa974)
@   0x0800a5e2: 0800        lsrs	r0, r0, #32
@   0x0800a5e4: 4661        mov	r1, ip
@   0x0800a5e6: 3132        adds	r1, #50	@ 0x32
@   0x0800a5e8: 2002        movs	r0, #2
@   0x0800a5ea: 7008        strb	r0, [r1, #0]
@   0x0800a5ec: 0091        lsls	r1, r2, #2
@   0x0800a5ee: 4660        mov	r0, ip
@   0x0800a5f0: 3030        adds	r0, #48	@ 0x30
@   0x0800a5f2: 7001        strb	r1, [r0, #0]
@   0x0800a5f4: 0099        lsls	r1, r3, #2
@   0x0800a5f6: e087        b.n	0xa708
@   0x0800a5f8: 4661        mov	r1, ip
@   0x0800a5fa: 3132        adds	r1, #50	@ 0x32
@   0x0800a5fc: 2001        movs	r0, #1
@   0x0800a5fe: e074        b.n	0xa6ea
@   0x0800a600: 4661        mov	r1, ip
@   0x0800a602: 3132        adds	r1, #50	@ 0x32
@   0x0800a604: 2001        movs	r0, #1
@   0x0800a606: 7008        strb	r0, [r1, #0]
@   0x0800a608: 0051        lsls	r1, r2, #1
@   0x0800a60a: 4660        mov	r0, ip
@   0x0800a60c: 3030        adds	r0, #48	@ 0x30
@   0x0800a60e: 7001        strb	r1, [r0, #0]
@   0x0800a610: 0059        lsls	r1, r3, #1
@   0x0800a612: e079        b.n	0xa708
@   0x0800a614: 4661        mov	r1, ip
@   0x0800a616: 3132        adds	r1, #50	@ 0x32
@   0x0800a618: 2001        movs	r0, #1
@   0x0800a61a: 7008        strb	r0, [r1, #0]
@   0x0800a61c: 0610        lsls	r0, r2, #24
@   0x0800a61e: 1600        asrs	r0, r0, #24
@   0x0800a620: 0081        lsls	r1, r0, #2
@   0x0800a622: 1809        adds	r1, r1, r0
@   0x0800a624: 4660        mov	r0, ip
@   0x0800a626: 3030        adds	r0, #48	@ 0x30
@   0x0800a628: 7001        strb	r1, [r0, #0]
@   0x0800a62a: 0618        lsls	r0, r3, #24
@   0x0800a62c: 1600        asrs	r0, r0, #24
@   0x0800a62e: 0081        lsls	r1, r0, #2
@   0x0800a630: 1809        adds	r1, r1, r0
@   0x0800a632: 4660        mov	r0, ip
@   0x0800a634: 3031        adds	r0, #49	@ 0x31
@   0x0800a636: e068        b.n	0xa70a
@   0x0800a638: 4661        mov	r1, ip
@   0x0800a63a: 3132        adds	r1, #50	@ 0x32
@   0x0800a63c: 2001        movs	r0, #1
@   0x0800a63e: 7008        strb	r0, [r1, #0]
@   0x0800a640: 0091        lsls	r1, r2, #2
@   0x0800a642: 4660        mov	r0, ip
@   0x0800a644: 3030        adds	r0, #48	@ 0x30
@   0x0800a646: 7001        strb	r1, [r0, #0]
@   0x0800a648: 0099        lsls	r1, r3, #2
@   0x0800a64a: e05d        b.n	0xa708
@   0x0800a64c: 4661        mov	r1, ip
@   0x0800a64e: 3132        adds	r1, #50	@ 0x32
@   0x0800a650: 2001        movs	r0, #1
@   0x0800a652: 7008        strb	r0, [r1, #0]
@   0x0800a654: 0610        lsls	r0, r2, #24
@   0x0800a656: 1600        asrs	r0, r0, #24
@   0x0800a658: 0041        lsls	r1, r0, #1
@   0x0800a65a: 1809        adds	r1, r1, r0
@   0x0800a65c: 4660        mov	r0, ip
@   0x0800a65e: 3030        adds	r0, #48	@ 0x30
@   0x0800a660: 7001        strb	r1, [r0, #0]
@   0x0800a662: 0618        lsls	r0, r3, #24
@   0x0800a664: 1600        asrs	r0, r0, #24
@   0x0800a666: 0041        lsls	r1, r0, #1
@   0x0800a668: 1809        adds	r1, r1, r0
@   0x0800a66a: 4660        mov	r0, ip
@   0x0800a66c: 3031        adds	r0, #49	@ 0x31
@   0x0800a66e: e04c        b.n	0xa70a
@   0x0800a670: 4661        mov	r1, ip
@   0x0800a672: 3132        adds	r1, #50	@ 0x32
@   0x0800a674: 2002        movs	r0, #2
@   0x0800a676: 7008        strb	r0, [r1, #0]
@   0x0800a678: 0610        lsls	r0, r2, #24
@   0x0800a67a: 1600        asrs	r0, r0, #24
@   0x0800a67c: 0041        lsls	r1, r0, #1
@   0x0800a67e: 1809        adds	r1, r1, r0
@   0x0800a680: 4660        mov	r0, ip
@   0x0800a682: 3030        adds	r0, #48	@ 0x30
@   0x0800a684: 7001        strb	r1, [r0, #0]
@   0x0800a686: 0618        lsls	r0, r3, #24
@   0x0800a688: 1600        asrs	r0, r0, #24
@   0x0800a68a: 0041        lsls	r1, r0, #1
@   0x0800a68c: 1809        adds	r1, r1, r0
@   0x0800a68e: 4660        mov	r0, ip
@   0x0800a690: 3031        adds	r0, #49	@ 0x31
@   0x0800a692: e03a        b.n	0xa70a
@   0x0800a694: 4661        mov	r1, ip
@   0x0800a696: 3132        adds	r1, #50	@ 0x32
@   0x0800a698: 2002        movs	r0, #2
@   0x0800a69a: 7008        strb	r0, [r1, #0]
@   0x0800a69c: 0610        lsls	r0, r2, #24
@   0x0800a69e: 1600        asrs	r0, r0, #24
@   0x0800a6a0: 0041        lsls	r1, r0, #1
@   0x0800a6a2: 1809        adds	r1, r1, r0
@   0x0800a6a4: 4660        mov	r0, ip
@   0x0800a6a6: 3030        adds	r0, #48	@ 0x30
@   0x0800a6a8: 7001        strb	r1, [r0, #0]
@   0x0800a6aa: 0618        lsls	r0, r3, #24
@   0x0800a6ac: 1600        asrs	r0, r0, #24
@   0x0800a6ae: 0041        lsls	r1, r0, #1
@   0x0800a6b0: 1809        adds	r1, r1, r0
@   0x0800a6b2: 4660        mov	r0, ip
@   0x0800a6b4: 3031        adds	r0, #49	@ 0x31
@   0x0800a6b6: e028        b.n	0xa70a
@   0x0800a6b8: 4661        mov	r1, ip
@   0x0800a6ba: 3132        adds	r1, #50	@ 0x32
@   0x0800a6bc: 2002        movs	r0, #2
@   0x0800a6be: 7008        strb	r0, [r1, #0]
@   0x0800a6c0: 0051        lsls	r1, r2, #1
@   0x0800a6c2: 4660        mov	r0, ip
@   0x0800a6c4: 3030        adds	r0, #48	@ 0x30
@   0x0800a6c6: 7001        strb	r1, [r0, #0]
@   0x0800a6c8: 0059        lsls	r1, r3, #1
@   0x0800a6ca: e01d        b.n	0xa708
@   0x0800a6cc: 4661        mov	r1, ip
@   0x0800a6ce: 3132        adds	r1, #50	@ 0x32
@   0x0800a6d0: 2002        movs	r0, #2
@   0x0800a6d2: e00a        b.n	0xa6ea
@   0x0800a6d4: 4661        mov	r1, ip
@   0x0800a6d6: 3132        adds	r1, #50	@ 0x32
@   0x0800a6d8: 2003        movs	r0, #3
@   0x0800a6da: e006        b.n	0xa6ea
@   0x0800a6dc: 4661        mov	r1, ip
@   0x0800a6de: 3132        adds	r1, #50	@ 0x32
@   0x0800a6e0: 2004        movs	r0, #4
@   0x0800a6e2: e002        b.n	0xa6ea
@   0x0800a6e4: 4661        mov	r1, ip
@   0x0800a6e6: 3132        adds	r1, #50	@ 0x32
@   0x0800a6e8: 2005        movs	r0, #5
@   0x0800a6ea: 7008        strb	r0, [r1, #0]
@   0x0800a6ec: 4660        mov	r0, ip
@   0x0800a6ee: 3030        adds	r0, #48	@ 0x30
@   0x0800a6f0: 7002        strb	r2, [r0, #0]
@   0x0800a6f2: 3001        adds	r0, #1
@   0x0800a6f4: 7003        strb	r3, [r0, #0]
@   0x0800a6f6: e009        b.n	0xa70c
@   0x0800a6f8: 4661        mov	r1, ip
@   0x0800a6fa: 3132        adds	r1, #50	@ 0x32
@   0x0800a6fc: 20ff        movs	r0, #255	@ 0xff
@   0x0800a6fe: 7008        strb	r0, [r1, #0]
@   0x0800a700: 4660        mov	r0, ip
@   0x0800a702: 3030        adds	r0, #48	@ 0x30
@   0x0800a704: 2100        movs	r1, #0
@   0x0800a706: 7001        strb	r1, [r0, #0]
@   0x0800a708: 3001        adds	r0, #1
@   0x0800a70a: 7001        strb	r1, [r0, #0]
@   0x0800a70c: 4770        bx	lr

        thumb_func_start sub_0800A580
sub_0800A580: @ 0x0800a580
        .incbin "frog_us_baserom.gba", 0xa580, 0x190
        thumb_func_end sub_0800A580
