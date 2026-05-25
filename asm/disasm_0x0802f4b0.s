@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f4b0, 0x0802f730)  (640 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f4b0 --end 0x802f730 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f4b0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802f4b2: 4657        mov	r7, sl
@   0x0802f4b4: 464e        mov	r6, r9
@   0x0802f4b6: 4645        mov	r5, r8
@   0x0802f4b8: b4e0        push	{r5, r6, r7}
@   0x0802f4ba: b083        sub	sp, #12
@   0x0802f4bc: f002        f88c 	bl	0x315d8
@   0x0802f4c0: f7ff        fa38 	bl	0x2e934
@   0x0802f4c4: f7ff        fadc 	bl	0x2ea80
@   0x0802f4c8: f7ff        fbd8 	bl	0x2ec7c
@   0x0802f4cc: f7ff        fc46 	bl	0x2ed5c
@   0x0802f4d0: f7ff        fc8e 	bl	0x2edf0
@   0x0802f4d4: f7ff        fdbe 	bl	0x2f054
@   0x0802f4d8: f7ff        ff10 	bl	0x2f2fc
@   0x0802f4dc: 2000        movs	r0, #0
@   0x0802f4de: 4681        mov	r9, r0
@   0x0802f4e0: 2400        movs	r4, #0
@   0x0802f4e2: 482a        ldr	r0, [pc, #168]	@ (0x2f58c)
@   0x0802f4e4: 6803        ldr	r3, [r0, #0]
@   0x0802f4e6: 464a        mov	r2, r9
@   0x0802f4e8: 0091        lsls	r1, r2, #2
@   0x0802f4ea: 1c18        adds	r0, r3, #0
@   0x0802f4ec: 3010        adds	r0, #16
@   0x0802f4ee: 1842        adds	r2, r0, r1
@   0x0802f4f0: 6811        ldr	r1, [r2, #0]
@   0x0802f4f2: 2040        movs	r0, #64	@ 0x40
@   0x0802f4f4: 4008        ands	r0, r1
@   0x0802f4f6: 2800        cmp	r0, #0
@   0x0802f4f8: d018        beq.n	0x2f52c
@   0x0802f4fa: 2041        movs	r0, #65	@ 0x41
@   0x0802f4fc: 4240        negs	r0, r0
@   0x0802f4fe: 4001        ands	r1, r0
@   0x0802f500: 6011        str	r1, [r2, #0]
@   0x0802f502: 1918        adds	r0, r3, r4
@   0x0802f504: 8c03        ldrh	r3, [r0, #32]
@   0x0802f506: 8c41        ldrh	r1, [r0, #34]	@ 0x22
@   0x0802f508: 185a        adds	r2, r3, r1
@   0x0802f50a: 8c83        ldrh	r3, [r0, #36]	@ 0x24
@   0x0802f50c: 189a        adds	r2, r3, r2
@   0x0802f50e: 8d81        ldrh	r1, [r0, #44]	@ 0x2c
@   0x0802f510: 188a        adds	r2, r1, r2
@   0x0802f512: 8e83        ldrh	r3, [r0, #52]	@ 0x34
@   0x0802f514: 189a        adds	r2, r3, r2
@   0x0802f516: 8f80        ldrh	r0, [r0, #60]	@ 0x3c
@   0x0802f518: 1882        adds	r2, r0, r2
@   0x0802f51a: 0412        lsls	r2, r2, #16
@   0x0802f51c: 0e10        lsrs	r0, r2, #24
@   0x0802f51e: 21ff        movs	r1, #255	@ 0xff
@   0x0802f520: 0409        lsls	r1, r1, #16
@   0x0802f522: 4011        ands	r1, r2
@   0x0802f524: 1409        asrs	r1, r1, #16
@   0x0802f526: 464a        mov	r2, r9
@   0x0802f528: f7ff        f856 	bl	0x2e5d8
@   0x0802f52c: 3424        adds	r4, #36	@ 0x24
@   0x0802f52e: 2001        movs	r0, #1
@   0x0802f530: 4481        add	r9, r0
@   0x0802f532: 4649        mov	r1, r9
@   0x0802f534: 2902        cmp	r1, #2
@   0x0802f536: ddd4        ble.n	0x2f4e2
@   0x0802f538: 2200        movs	r2, #0
@   0x0802f53a: 4691        mov	r9, r2
@   0x0802f53c: 2500        movs	r5, #0
@   0x0802f53e: 4813        ldr	r0, [pc, #76]	@ (0x2f58c)
@   0x0802f540: 6804        ldr	r4, [r0, #0]
@   0x0802f542: 1c20        adds	r0, r4, #0
@   0x0802f544: 3010        adds	r0, #16
@   0x0802f546: 1942        adds	r2, r0, r5
@   0x0802f548: 6811        ldr	r1, [r2, #0]
@   0x0802f54a: 2080        movs	r0, #128	@ 0x80
@   0x0802f54c: 4008        ands	r0, r1
@   0x0802f54e: 2800        cmp	r0, #0
@   0x0802f550: d028        beq.n	0x2f5a4
@   0x0802f552: 2381        movs	r3, #129	@ 0x81
@   0x0802f554: 425b        negs	r3, r3
@   0x0802f556: 400b        ands	r3, r1
@   0x0802f558: 6013        str	r3, [r2, #0]
@   0x0802f55a: 4649        mov	r1, r9
@   0x0802f55c: 00c8        lsls	r0, r1, #3
@   0x0802f55e: 1822        adds	r2, r4, r0
@   0x0802f560: 1c10        adds	r0, r2, #0
@   0x0802f562: 3090        adds	r0, #144	@ 0x90
@   0x0802f564: 8800        ldrh	r0, [r0, #0]
@   0x0802f566: 0a01        lsrs	r1, r0, #8
@   0x0802f568: 2900        cmp	r1, #0
@   0x0802f56a: d000        beq.n	0x2f56e
@   0x0802f56c: 3101        adds	r1, #1
@   0x0802f56e: 1c10        adds	r0, r2, #0
@   0x0802f570: 3093        adds	r0, #147	@ 0x93
@   0x0802f572: 7800        ldrb	r0, [r0, #0]
@   0x0802f574: 4348        muls	r0, r1
@   0x0802f576: 0200        lsls	r0, r0, #8
@   0x0802f578: 0c01        lsrs	r1, r0, #16
@   0x0802f57a: 2080        movs	r0, #128	@ 0x80
@   0x0802f57c: 0240        lsls	r0, r0, #9
@   0x0802f57e: 4003        ands	r3, r0
@   0x0802f580: 2b00        cmp	r3, #0
@   0x0802f582: d005        beq.n	0x2f590
@   0x0802f584: 1c20        adds	r0, r4, #0
@   0x0802f586: 30be        adds	r0, #190	@ 0xbe
@   0x0802f588: e004        b.n	0x2f594
@   0x0802f58a: 0000        movs	r0, r0
@   0x0802f58c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f58e: 0300        lsls	r0, r0, #12
@   0x0802f590: 1c20        adds	r0, r4, #0
@   0x0802f592: 30bc        adds	r0, #188	@ 0xbc
@   0x0802f594: 8800        ldrh	r0, [r0, #0]
@   0x0802f596: 4348        muls	r0, r1
@   0x0802f598: 0200        lsls	r0, r0, #8
@   0x0802f59a: 0c01        lsrs	r1, r0, #16
@   0x0802f59c: 1c08        adds	r0, r1, #0
@   0x0802f59e: 4649        mov	r1, r9
@   0x0802f5a0: f7ff        f870 	bl	0x2e684
@   0x0802f5a4: 4a0d        ldr	r2, [pc, #52]	@ (0x2f5dc)
@   0x0802f5a6: 6813        ldr	r3, [r2, #0]
@   0x0802f5a8: 1c18        adds	r0, r3, #0
@   0x0802f5aa: 3010        adds	r0, #16
@   0x0802f5ac: 1940        adds	r0, r0, r5
@   0x0802f5ae: 6801        ldr	r1, [r0, #0]
@   0x0802f5b0: 2080        movs	r0, #128	@ 0x80
@   0x0802f5b2: 0080        lsls	r0, r0, #2
@   0x0802f5b4: 4001        ands	r1, r0
@   0x0802f5b6: 1c16        adds	r6, r2, #0
@   0x0802f5b8: 2900        cmp	r1, #0
@   0x0802f5ba: d022        beq.n	0x2f602
@   0x0802f5bc: 464a        mov	r2, r9
@   0x0802f5be: 2a03        cmp	r2, #3
@   0x0802f5c0: d010        beq.n	0x2f5e4
@   0x0802f5c2: 4807        ldr	r0, [pc, #28]	@ (0x2f5e0)
@   0x0802f5c4: 1828        adds	r0, r5, r0
@   0x0802f5c6: 6802        ldr	r2, [r0, #0]
@   0x0802f5c8: 4649        mov	r1, r9
@   0x0802f5ca: 0048        lsls	r0, r1, #1
@   0x0802f5cc: 1c19        adds	r1, r3, #0
@   0x0802f5ce: 31b4        adds	r1, #180	@ 0xb4
@   0x0802f5d0: 1809        adds	r1, r1, r0
@   0x0802f5d2: 2380        movs	r3, #128	@ 0x80
@   0x0802f5d4: 021b        lsls	r3, r3, #8
@   0x0802f5d6: 1c18        adds	r0, r3, #0
@   0x0802f5d8: 8809        ldrh	r1, [r1, #0]
@   0x0802f5da: e009        b.n	0x2f5f0
@   0x0802f5dc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f5de: 0300        lsls	r0, r0, #12
@   0x0802f5e0: da1c        bge.n	0x2f61c
@   0x0802f5e2: 083d        lsrs	r5, r7, #32
@   0x0802f5e4: 4835        ldr	r0, [pc, #212]	@ (0x2f6bc)
@   0x0802f5e6: 68c2        ldr	r2, [r0, #12]
@   0x0802f5e8: 8810        ldrh	r0, [r2, #0]
@   0x0802f5ea: 2380        movs	r3, #128	@ 0x80
@   0x0802f5ec: 021b        lsls	r3, r3, #8
@   0x0802f5ee: 1c19        adds	r1, r3, #0
@   0x0802f5f0: 4308        orrs	r0, r1
@   0x0802f5f2: 8010        strh	r0, [r2, #0]
@   0x0802f5f4: 6830        ldr	r0, [r6, #0]
@   0x0802f5f6: 3010        adds	r0, #16
@   0x0802f5f8: 1940        adds	r0, r0, r5
@   0x0802f5fa: 6801        ldr	r1, [r0, #0]
@   0x0802f5fc: 4a30        ldr	r2, [pc, #192]	@ (0x2f6c0)
@   0x0802f5fe: 4011        ands	r1, r2
@   0x0802f600: 6001        str	r1, [r0, #0]
@   0x0802f602: 3504        adds	r5, #4
@   0x0802f604: 2001        movs	r0, #1
@   0x0802f606: 4481        add	r9, r0
@   0x0802f608: 4649        mov	r1, r9
@   0x0802f60a: 2903        cmp	r1, #3
@   0x0802f60c: dd97        ble.n	0x2f53e
@   0x0802f60e: 2200        movs	r2, #0
@   0x0802f610: 4691        mov	r9, r2
@   0x0802f612: 1c31        adds	r1, r6, #0
@   0x0802f614: 6808        ldr	r0, [r1, #0]
@   0x0802f616: 7800        ldrb	r0, [r0, #0]
@   0x0802f618: 4581        cmp	r9, r0
@   0x0802f61a: db00        blt.n	0x2f61e
@   0x0802f61c: e0e4        b.n	0x2f7e8
@   0x0802f61e: 2300        movs	r3, #0
@   0x0802f620: 9300        str	r3, [sp, #0]
@   0x0802f622: 2000        movs	r0, #0
@   0x0802f624: 9001        str	r0, [sp, #4]
@   0x0802f626: 468a        mov	sl, r1
@   0x0802f628: 6808        ldr	r0, [r1, #0]
@   0x0802f62a: 30cc        adds	r0, #204	@ 0xcc
@   0x0802f62c: 6800        ldr	r0, [r0, #0]
@   0x0802f62e: 9901        ldr	r1, [sp, #4]
@   0x0802f630: 1808        adds	r0, r1, r0
@   0x0802f632: 6805        ldr	r5, [r0, #0]
@   0x0802f634: 2d00        cmp	r5, #0
@   0x0802f636: d100        bne.n	0x2f63a
@   0x0802f638: e0c8        b.n	0x2f7cc
@   0x0802f63a: 8ee8        ldrh	r0, [r5, #54]	@ 0x36
@   0x0802f63c: 2800        cmp	r0, #0
@   0x0802f63e: d008        beq.n	0x2f652
@   0x0802f640: 1c28        adds	r0, r5, #0
@   0x0802f642: 303f        adds	r0, #63	@ 0x3f
@   0x0802f644: 8eea        ldrh	r2, [r5, #54]	@ 0x36
@   0x0802f646: 7800        ldrb	r0, [r0, #0]
@   0x0802f648: 1a10        subs	r0, r2, r0
@   0x0802f64a: 2800        cmp	r0, #0
@   0x0802f64c: da00        bge.n	0x2f650
@   0x0802f64e: 2000        movs	r0, #0
@   0x0802f650: 86e8        strh	r0, [r5, #54]	@ 0x36
@   0x0802f652: 6ba9        ldr	r1, [r5, #56]	@ 0x38
@   0x0802f654: 2080        movs	r0, #128	@ 0x80
@   0x0802f656: 4008        ands	r0, r1
@   0x0802f658: 2800        cmp	r0, #0
@   0x0802f65a: d100        bne.n	0x2f65e
@   0x0802f65c: e07f        b.n	0x2f75e
@   0x0802f65e: 2081        movs	r0, #129	@ 0x81
@   0x0802f660: 4240        negs	r0, r0
@   0x0802f662: 4001        ands	r1, r0
@   0x0802f664: 63a9        str	r1, [r5, #56]	@ 0x38
@   0x0802f666: 8d2b        ldrh	r3, [r5, #40]	@ 0x28
@   0x0802f668: 0a1c        lsrs	r4, r3, #8
@   0x0802f66a: 2c00        cmp	r4, #0
@   0x0802f66c: d000        beq.n	0x2f670
@   0x0802f66e: 3401        adds	r4, #1
@   0x0802f670: 1c28        adds	r0, r5, #0
@   0x0802f672: 302b        adds	r0, #43	@ 0x2b
@   0x0802f674: 7800        ldrb	r0, [r0, #0]
@   0x0802f676: 4360        muls	r0, r4
@   0x0802f678: 0200        lsls	r0, r0, #8
@   0x0802f67a: 0c03        lsrs	r3, r0, #16
@   0x0802f67c: 1c28        adds	r0, r5, #0
@   0x0802f67e: 302a        adds	r0, #42	@ 0x2a
@   0x0802f680: 7003        strb	r3, [r0, #0]
@   0x0802f682: 6830        ldr	r0, [r6, #0]
@   0x0802f684: 30c0        adds	r0, #192	@ 0xc0
@   0x0802f686: 6800        ldr	r0, [r0, #0]
@   0x0802f688: 9900        ldr	r1, [sp, #0]
@   0x0802f68a: 1840        adds	r0, r0, r1
@   0x0802f68c: 4680        mov	r8, r0
@   0x0802f68e: 1c2a        adds	r2, r5, #0
@   0x0802f690: 323c        adds	r2, #60	@ 0x3c
@   0x0802f692: 7810        ldrb	r0, [r2, #0]
@   0x0802f694: 0601        lsls	r1, r0, #24
@   0x0802f696: 0e08        lsrs	r0, r1, #24
@   0x0802f698: 283f        cmp	r0, #63	@ 0x3f
@   0x0802f69a: d819        bhi.n	0x2f6d0
@   0x0802f69c: 7812        ldrb	r2, [r2, #0]
@   0x0802f69e: 2040        movs	r0, #64	@ 0x40
@   0x0802f6a0: 1a80        subs	r0, r0, r2
@   0x0802f6a2: 4908        ldr	r1, [pc, #32]	@ (0x2f6c4)
@   0x0802f6a4: 4348        muls	r0, r1
@   0x0802f6a6: 1180        asrs	r0, r0, #6
@   0x0802f6a8: 4907        ldr	r1, [pc, #28]	@ (0x2f6c8)
@   0x0802f6aa: 1840        adds	r0, r0, r1
@   0x0802f6ac: 4358        muls	r0, r3
@   0x0802f6ae: 1400        asrs	r0, r0, #16
@   0x0802f6b0: 0600        lsls	r0, r0, #24
@   0x0802f6b2: 0e07        lsrs	r7, r0, #24
@   0x0802f6b4: 4805        ldr	r0, [pc, #20]	@ (0x2f6cc)
@   0x0802f6b6: 4350        muls	r0, r2
@   0x0802f6b8: 1180        asrs	r0, r0, #6
@   0x0802f6ba: e01b        b.n	0x2f6f4
@   0x0802f6bc: da1c        bge.n	0x2f6f8
@   0x0802f6be: 083d        lsrs	r5, r7, #32
@   0x0802f6c0: fdff        ffff 			@ <UNDEFINED> instruction: 0xfdffffff
@   0x0802f6c4: 4ac8        ldr	r2, [pc, #800]	@ (0x2f9e8)
@   0x0802f6c6: 0000        movs	r0, r0
@   0x0802f6c8: b538        push	{r3, r4, r5, lr}
@   0x0802f6ca: 0000        movs	r0, r0
@   0x0802f6cc: b818        @ <UNDEFINED> instruction: 0xb818
@   0x0802f6ce: 0000        movs	r0, r0
@   0x0802f6d0: 2900        cmp	r1, #0
@   0x0802f6d2: db1b        blt.n	0x2f70c
@   0x0802f6d4: 7812        ldrb	r2, [r2, #0]
@   0x0802f6d6: 207f        movs	r0, #127	@ 0x7f
@   0x0802f6d8: 1a80        subs	r0, r0, r2
@   0x0802f6da: 4909        ldr	r1, [pc, #36]	@ (0x2f700)
@   0x0802f6dc: 4348        muls	r0, r1
@   0x0802f6de: 1180        asrs	r0, r0, #6
@   0x0802f6e0: 4358        muls	r0, r3
@   0x0802f6e2: 1400        asrs	r0, r0, #16
@   0x0802f6e4: 0600        lsls	r0, r0, #24
@   0x0802f6e6: 0e07        lsrs	r7, r0, #24
@   0x0802f6e8: 3a3f        subs	r2, #63	@ 0x3f
@   0x0802f6ea: 4806        ldr	r0, [pc, #24]	@ (0x2f704)
@   0x0802f6ec: 4350        muls	r0, r2
@   0x0802f6ee: 1180        asrs	r0, r0, #6
@   0x0802f6f0: 4a05        ldr	r2, [pc, #20]	@ (0x2f708)
@   0x0802f6f2: 1880        adds	r0, r0, r2
@   0x0802f6f4: 4358        muls	r0, r3
@   0x0802f6f6: 1400        asrs	r0, r0, #16
@   0x0802f6f8: 0600        lsls	r0, r0, #24
@   0x0802f6fa: 0e06        lsrs	r6, r0, #24
@   0x0802f6fc: 2200        movs	r2, #0
@   0x0802f6fe: e00c        b.n	0x2f71a
@   0x0802f700: b818        @ <UNDEFINED> instruction: 0xb818
@   0x0802f702: 0000        movs	r0, r0
@   0x0802f704: 4ac8        ldr	r2, [pc, #800]	@ (0x2fa28)
@   0x0802f706: 0000        movs	r0, r0
@   0x0802f708: b538        push	{r3, r4, r5, lr}
@   0x0802f70a: 0000        movs	r0, r0
@   0x0802f70c: 4808        ldr	r0, [pc, #32]	@ (0x2f730)
@   0x0802f70e: 4358        muls	r0, r3
@   0x0802f710: 1400        asrs	r0, r0, #16
@   0x0802f712: 0600        lsls	r0, r0, #24
@   0x0802f714: 0e06        lsrs	r6, r0, #24
@   0x0802f716: 1c37        adds	r7, r6, #0
@   0x0802f718: 2201        movs	r2, #1
@   0x0802f71a: 6ba8        ldr	r0, [r5, #56]	@ 0x38
@   0x0802f71c: 2180        movs	r1, #128	@ 0x80
@   0x0802f71e: 0249        lsls	r1, r1, #9
@   0x0802f720: 4008        ands	r0, r1
@   0x0802f722: 2800        cmp	r0, #0
@   0x0802f724: d006        beq.n	0x2f734
@   0x0802f726: 4653        mov	r3, sl
@   0x0802f728: 6818        ldr	r0, [r3, #0]
@   0x0802f72a: 30be        adds	r0, #190	@ 0xbe
@   0x0802f72c: e005        b.n	0x2f73a

        thumb_func_start sub_0802F4B0
sub_0802F4B0: @ 0x0802f4b0
        .incbin "frog_us_baserom.gba", 0x2f4b0, 0x280
        thumb_func_end sub_0802F4B0
