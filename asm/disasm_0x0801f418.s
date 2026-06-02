@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801f418, 0x0801f684)  (620 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801f418 --end 0x801f684 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801f418: b530        push	{r4, r5, lr}
@   0x0801f41a: b088        sub	sp, #32
@   0x0801f41c: 2100        movs	r1, #0
@   0x0801f41e: 9104        str	r1, [sp, #16]
@   0x0801f420: 4815        ldr	r0, [pc, #84]	@ (0x1f478)
@   0x0801f422: 9005        str	r0, [sp, #20]
@   0x0801f424: 4a15        ldr	r2, [pc, #84]	@ (0x1f47c)
@   0x0801f426: 4816        ldr	r0, [pc, #88]	@ (0x1f480)
@   0x0801f428: 6800        ldr	r0, [r0, #0]
@   0x0801f42a: 0080        lsls	r0, r0, #2
@   0x0801f42c: 1880        adds	r0, r0, r2
@   0x0801f42e: 6800        ldr	r0, [r0, #0]
@   0x0801f430: 9006        str	r0, [sp, #24]
@   0x0801f432: 9107        str	r1, [sp, #28]
@   0x0801f434: 4813        ldr	r0, [pc, #76]	@ (0x1f484)
@   0x0801f436: 7501        strb	r1, [r0, #20]
@   0x0801f438: 4c13        ldr	r4, [pc, #76]	@ (0x1f488)
@   0x0801f43a: 68a0        ldr	r0, [r4, #8]
@   0x0801f43c: 2800        cmp	r0, #0
@   0x0801f43e: d135        bne.n	0x1f4ac
@   0x0801f440: f7f9        f804 	bl	0x1844c
@   0x0801f444: 4911        ldr	r1, [pc, #68]	@ (0x1f48c)
@   0x0801f446: 4812        ldr	r0, [pc, #72]	@ (0x1f490)
@   0x0801f448: 6008        str	r0, [r1, #0]
@   0x0801f44a: 20a0        movs	r0, #160	@ 0xa0
@   0x0801f44c: 04c0        lsls	r0, r0, #19
@   0x0801f44e: 6048        str	r0, [r1, #4]
@   0x0801f450: 4810        ldr	r0, [pc, #64]	@ (0x1f494)
@   0x0801f452: 6088        str	r0, [r1, #8]
@   0x0801f454: 6888        ldr	r0, [r1, #8]
@   0x0801f456: 4810        ldr	r0, [pc, #64]	@ (0x1f498)
@   0x0801f458: 6008        str	r0, [r1, #0]
@   0x0801f45a: 20c0        movs	r0, #192	@ 0xc0
@   0x0801f45c: 04c0        lsls	r0, r0, #19
@   0x0801f45e: 6048        str	r0, [r1, #4]
@   0x0801f460: 480e        ldr	r0, [pc, #56]	@ (0x1f49c)
@   0x0801f462: 6088        str	r0, [r1, #8]
@   0x0801f464: 6888        ldr	r0, [r1, #8]
@   0x0801f466: 480e        ldr	r0, [pc, #56]	@ (0x1f4a0)
@   0x0801f468: 6008        str	r0, [r1, #0]
@   0x0801f46a: 480e        ldr	r0, [pc, #56]	@ (0x1f4a4)
@   0x0801f46c: 6048        str	r0, [r1, #4]
@   0x0801f46e: 480e        ldr	r0, [pc, #56]	@ (0x1f4a8)
@   0x0801f470: 6088        str	r0, [r1, #8]
@   0x0801f472: 6888        ldr	r0, [r1, #8]
@   0x0801f474: e036        b.n	0x1f4e4
@   0x0801f476: 0000        movs	r0, r0
@   0x0801f478: 8b98        ldrh	r0, [r3, #28]
@   0x0801f47a: 081d        lsrs	r5, r3, #32
@   0x0801f47c: 8ef4        ldrh	r4, [r6, #54]	@ 0x36
@   0x0801f47e: 0830        lsrs	r0, r6, #32
@   0x0801f480: 34b0        adds	r4, #176	@ 0xb0
@   0x0801f482: 0300        lsls	r0, r0, #12
@   0x0801f484: 3480        adds	r4, #128	@ 0x80
@   0x0801f486: 0300        lsls	r0, r0, #12
@   0x0801f488: 34a0        adds	r4, #160	@ 0xa0
@   0x0801f48a: 0300        lsls	r0, r0, #12
@   0x0801f48c: 00d4        lsls	r4, r2, #3
@   0x0801f48e: 0400        lsls	r0, r0, #16
@   0x0801f490: ab98        add	r3, sp, #608	@ 0x260
@   0x0801f492: 081d        lsrs	r5, r3, #32
@   0x0801f494: 0100        lsls	r0, r0, #4
@   0x0801f496: 8000        strh	r0, [r0, #0]
@   0x0801f498: ad98        add	r5, sp, #608	@ 0x260
@   0x0801f49a: 081d        lsrs	r5, r3, #32
@   0x0801f49c: 4000        ands	r0, r0
@   0x0801f49e: 8000        strh	r0, [r0, #0]
@   0x0801f4a0: 4418        add	r0, r3
@   0x0801f4a2: 081e        lsrs	r6, r3, #32
@   0x0801f4a4: e000        b.n	0x1f4a8
@   0x0801f4a6: 0600        lsls	r0, r0, #24
@   0x0801f4a8: 0400        lsls	r0, r0, #16
@   0x0801f4aa: 8000        strh	r0, [r0, #0]
@   0x0801f4ac: 200e        movs	r0, #14
@   0x0801f4ae: f7f9        fbad 	bl	0x18c0c
@   0x0801f4b2: 2200        movs	r2, #0
@   0x0801f4b4: 68a0        ldr	r0, [r4, #8]
@   0x0801f4b6: 2800        cmp	r0, #0
@   0x0801f4b8: d100        bne.n	0x1f4bc
@   0x0801f4ba: 2201        movs	r2, #1
@   0x0801f4bc: 2002        movs	r0, #2
@   0x0801f4be: 9003        str	r0, [sp, #12]
@   0x0801f4c0: 4669        mov	r1, sp
@   0x0801f4c2: a805        add	r0, sp, #20
@   0x0801f4c4: c838        ldmia	r0!, {r3, r4, r5}
@   0x0801f4c6: c138        stmia	r1!, {r3, r4, r5}
@   0x0801f4c8: 9b04        ldr	r3, [sp, #16]
@   0x0801f4ca: 1c10        adds	r0, r2, #0
@   0x0801f4cc: 211d        movs	r1, #29
@   0x0801f4ce: 2206        movs	r2, #6
@   0x0801f4d0: f7f9        f9e2 	bl	0x18898
@   0x0801f4d4: 2280        movs	r2, #128	@ 0x80
@   0x0801f4d6: 04d2        lsls	r2, r2, #19
@   0x0801f4d8: 8810        ldrh	r0, [r2, #0]
@   0x0801f4da: 2380        movs	r3, #128	@ 0x80
@   0x0801f4dc: 011b        lsls	r3, r3, #4
@   0x0801f4de: 1c19        adds	r1, r3, #0
@   0x0801f4e0: 4308        orrs	r0, r1
@   0x0801f4e2: 8010        strh	r0, [r2, #0]
@   0x0801f4e4: 2280        movs	r2, #128	@ 0x80
@   0x0801f4e6: 04d2        lsls	r2, r2, #19
@   0x0801f4e8: 8810        ldrh	r0, [r2, #0]
@   0x0801f4ea: 2480        movs	r4, #128	@ 0x80
@   0x0801f4ec: 00a4        lsls	r4, r4, #2
@   0x0801f4ee: 1c21        adds	r1, r4, #0
@   0x0801f4f0: 4308        orrs	r0, r1
@   0x0801f4f2: 8010        strh	r0, [r2, #0]
@   0x0801f4f4: 4912        ldr	r1, [pc, #72]	@ (0x1f540)
@   0x0801f4f6: 4813        ldr	r0, [pc, #76]	@ (0x1f544)
@   0x0801f4f8: 6008        str	r0, [r1, #0]
@   0x0801f4fa: 4813        ldr	r0, [pc, #76]	@ (0x1f548)
@   0x0801f4fc: 6048        str	r0, [r1, #4]
@   0x0801f4fe: 4813        ldr	r0, [pc, #76]	@ (0x1f54c)
@   0x0801f500: 6088        str	r0, [r1, #8]
@   0x0801f502: 6888        ldr	r0, [r1, #8]
@   0x0801f504: f000        f8be 	bl	0x1f684
@   0x0801f508: 4811        ldr	r0, [pc, #68]	@ (0x1f550)
@   0x0801f50a: 6880        ldr	r0, [r0, #8]
@   0x0801f50c: 2800        cmp	r0, #0
@   0x0801f50e: d00f        beq.n	0x1f530
@   0x0801f510: 4910        ldr	r1, [pc, #64]	@ (0x1f554)
@   0x0801f512: 4811        ldr	r0, [pc, #68]	@ (0x1f558)
@   0x0801f514: 6800        ldr	r0, [r0, #0]
@   0x0801f516: 0080        lsls	r0, r0, #2
@   0x0801f518: 1840        adds	r0, r0, r1
@   0x0801f51a: 6800        ldr	r0, [r0, #0]
@   0x0801f51c: 6842        ldr	r2, [r0, #4]
@   0x0801f51e: 2000        movs	r0, #0
@   0x0801f520: 9000        str	r0, [sp, #0]
@   0x0801f522: 2001        movs	r0, #1
@   0x0801f524: 9001        str	r0, [sp, #4]
@   0x0801f526: 2000        movs	r0, #0
@   0x0801f528: 2106        movs	r1, #6
@   0x0801f52a: 231c        movs	r3, #28
@   0x0801f52c: f7fd        f9e8 	bl	0x1c900
@   0x0801f530: 490a        ldr	r1, [pc, #40]	@ (0x1f55c)
@   0x0801f532: 7888        ldrb	r0, [r1, #2]
@   0x0801f534: 3001        adds	r0, #1
@   0x0801f536: 7088        strb	r0, [r1, #2]
@   0x0801f538: b008        add	sp, #32
@   0x0801f53a: bc30        pop	{r4, r5}
@   0x0801f53c: bc01        pop	{r0}
@   0x0801f53e: 4700        bx	r0
@   0x0801f540: 00d4        lsls	r4, r2, #3
@   0x0801f542: 0400        lsls	r0, r0, #16
@   0x0801f544: 8b98        ldrh	r0, [r3, #28]
@   0x0801f546: 081d        lsrs	r5, r3, #32
@   0x0801f548: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801f54c: 0400        lsls	r0, r0, #16
@   0x0801f54e: 8000        strh	r0, [r0, #0]
@   0x0801f550: 34a0        adds	r4, #160	@ 0xa0
@   0x0801f552: 0300        lsls	r0, r0, #12
@   0x0801f554: 8110        strh	r0, [r2, #8]
@   0x0801f556: 0830        lsrs	r0, r6, #32
@   0x0801f558: 34b0        adds	r4, #176	@ 0xb0
@   0x0801f55a: 0300        lsls	r0, r0, #12
@   0x0801f55c: 3480        adds	r4, #128	@ 0x80
@   0x0801f55e: 0300        lsls	r0, r0, #12
@   0x0801f560: b510        push	{r4, lr}
@   0x0801f562: b082        sub	sp, #8
@   0x0801f564: f7e0        ffae 	bl	0x4c4
@   0x0801f568: 4904        ldr	r1, [pc, #16]	@ (0x1f57c)
@   0x0801f56a: 8008        strh	r0, [r1, #0]
@   0x0801f56c: 8808        ldrh	r0, [r1, #0]
@   0x0801f56e: 2802        cmp	r0, #2
@   0x0801f570: d049        beq.n	0x1f606
@   0x0801f572: 2802        cmp	r0, #2
@   0x0801f574: dc04        bgt.n	0x1f580
@   0x0801f576: 2801        cmp	r0, #1
@   0x0801f578: d036        beq.n	0x1f5e8
@   0x0801f57a: e04f        b.n	0x1f61c
@   0x0801f57c: 5398        strh	r0, [r3, r6]
@   0x0801f57e: 0300        lsls	r0, r0, #12
@   0x0801f580: 2810        cmp	r0, #16
@   0x0801f582: d001        beq.n	0x1f588
@   0x0801f584: 2840        cmp	r0, #64	@ 0x40
@   0x0801f586: d149        bne.n	0x1f61c
@   0x0801f588: 2001        movs	r0, #1
@   0x0801f58a: f001        fb75 	bl	0x20c78
@   0x0801f58e: 490e        ldr	r1, [pc, #56]	@ (0x1f5c8)
@   0x0801f590: 480e        ldr	r0, [pc, #56]	@ (0x1f5cc)
@   0x0801f592: 6800        ldr	r0, [r0, #0]
@   0x0801f594: 0080        lsls	r0, r0, #2
@   0x0801f596: 1840        adds	r0, r0, r1
@   0x0801f598: 6803        ldr	r3, [r0, #0]
@   0x0801f59a: 480d        ldr	r0, [pc, #52]	@ (0x1f5d0)
@   0x0801f59c: 4c0d        ldr	r4, [pc, #52]	@ (0x1f5d4)
@   0x0801f59e: 7d22        ldrb	r2, [r4, #20]
@   0x0801f5a0: 7800        ldrb	r0, [r0, #0]
@   0x0801f5a2: 4110        asrs	r0, r2
@   0x0801f5a4: 2101        movs	r1, #1
@   0x0801f5a6: 4008        ands	r0, r1
@   0x0801f5a8: 2800        cmp	r0, #0
@   0x0801f5aa: d015        beq.n	0x1f5d8
@   0x0801f5ac: 689a        ldr	r2, [r3, #8]
@   0x0801f5ae: 2000        movs	r0, #0
@   0x0801f5b0: 9000        str	r0, [sp, #0]
@   0x0801f5b2: 9001        str	r0, [sp, #4]
@   0x0801f5b4: 2106        movs	r1, #6
@   0x0801f5b6: 231c        movs	r3, #28
@   0x0801f5b8: f7fd        f9a2 	bl	0x1c900
@   0x0801f5bc: 0600        lsls	r0, r0, #24
@   0x0801f5be: 2800        cmp	r0, #0
@   0x0801f5c0: d02c        beq.n	0x1f61c
@   0x0801f5c2: 7d20        ldrb	r0, [r4, #20]
@   0x0801f5c4: e009        b.n	0x1f5da
@   0x0801f5c6: 0000        movs	r0, r0
@   0x0801f5c8: 8110        strh	r0, [r2, #8]
@   0x0801f5ca: 0830        lsrs	r0, r6, #32
@   0x0801f5cc: 34b0        adds	r4, #176	@ 0xb0
@   0x0801f5ce: 0300        lsls	r0, r0, #12
@   0x0801f5d0: 3500        adds	r5, #0
@   0x0801f5d2: 0300        lsls	r0, r0, #12
@   0x0801f5d4: 3480        adds	r4, #128	@ 0x80
@   0x0801f5d6: 0300        lsls	r0, r0, #12
@   0x0801f5d8: 1c10        adds	r0, r2, #0
@   0x0801f5da: f000        f96f 	bl	0x1f8bc
@   0x0801f5de: 2800        cmp	r0, #0
@   0x0801f5e0: d11c        bne.n	0x1f61c
@   0x0801f5e2: f000        f84f 	bl	0x1f684
@   0x0801f5e6: e019        b.n	0x1f61c
@   0x0801f5e8: 2002        movs	r0, #2
@   0x0801f5ea: f001        fb45 	bl	0x20c78
@   0x0801f5ee: 4903        ldr	r1, [pc, #12]	@ (0x1f5fc)
@   0x0801f5f0: 7d08        ldrb	r0, [r1, #20]
@   0x0801f5f2: 2800        cmp	r0, #0
@   0x0801f5f4: d104        bne.n	0x1f600
@   0x0801f5f6: 2003        movs	r0, #3
@   0x0801f5f8: 7508        strb	r0, [r1, #20]
@   0x0801f5fa: e00f        b.n	0x1f61c
@   0x0801f5fc: 3480        adds	r4, #128	@ 0x80
@   0x0801f5fe: 0300        lsls	r0, r0, #12
@   0x0801f600: 3801        subs	r0, #1
@   0x0801f602: 7508        strb	r0, [r1, #20]
@   0x0801f604: e00a        b.n	0x1f61c
@   0x0801f606: 2002        movs	r0, #2
@   0x0801f608: f001        fb36 	bl	0x20c78
@   0x0801f60c: 480e        ldr	r0, [pc, #56]	@ (0x1f648)
@   0x0801f60e: 7d01        ldrb	r1, [r0, #20]
@   0x0801f610: 3101        adds	r1, #1
@   0x0801f612: 7501        strb	r1, [r0, #20]
@   0x0801f614: 2103        movs	r1, #3
@   0x0801f616: 7d02        ldrb	r2, [r0, #20]
@   0x0801f618: 4011        ands	r1, r2
@   0x0801f61a: 7501        strb	r1, [r0, #20]
@   0x0801f61c: 490b        ldr	r1, [pc, #44]	@ (0x1f64c)
@   0x0801f61e: 8808        ldrh	r0, [r1, #0]
@   0x0801f620: 2820        cmp	r0, #32
@   0x0801f622: d117        bne.n	0x1f654
@   0x0801f624: 2000        movs	r0, #0
@   0x0801f626: 8008        strh	r0, [r1, #0]
@   0x0801f628: 2000        movs	r0, #0
@   0x0801f62a: f001        fb25 	bl	0x20c78
@   0x0801f62e: 4908        ldr	r1, [pc, #32]	@ (0x1f650)
@   0x0801f630: 2000        movs	r0, #0
@   0x0801f632: 6088        str	r0, [r1, #8]
@   0x0801f634: 211e        movs	r1, #30
@   0x0801f636: 2206        movs	r2, #6
@   0x0801f638: 2302        movs	r3, #2
@   0x0801f63a: f7f9        f805 	bl	0x18648
@   0x0801f63e: 4902        ldr	r1, [pc, #8]	@ (0x1f648)
@   0x0801f640: 7888        ldrb	r0, [r1, #2]
@   0x0801f642: 3001        adds	r0, #1
@   0x0801f644: 7088        strb	r0, [r1, #2]
@   0x0801f646: e017        b.n	0x1f678
@   0x0801f648: 3480        adds	r4, #128	@ 0x80
@   0x0801f64a: 0300        lsls	r0, r0, #12
@   0x0801f64c: 5398        strh	r0, [r3, r6]
@   0x0801f64e: 0300        lsls	r0, r0, #12
@   0x0801f650: 34a0        adds	r4, #160	@ 0xa0
@   0x0801f652: 0300        lsls	r0, r0, #12
@   0x0801f654: 2800        cmp	r0, #0
@   0x0801f656: d008        beq.n	0x1f66a
@   0x0801f658: 2810        cmp	r0, #16
@   0x0801f65a: d006        beq.n	0x1f66a
@   0x0801f65c: 2840        cmp	r0, #64	@ 0x40
@   0x0801f65e: d004        beq.n	0x1f66a
@   0x0801f660: 2000        movs	r0, #0
@   0x0801f662: 8008        strh	r0, [r1, #0]
@   0x0801f664: f000        f80e 	bl	0x1f684
@   0x0801f668: e006        b.n	0x1f678
@   0x0801f66a: 4b05        ldr	r3, [pc, #20]	@ (0x1f680)
@   0x0801f66c: 6818        ldr	r0, [r3, #0]
@   0x0801f66e: 6859        ldr	r1, [r3, #4]
@   0x0801f670: 689a        ldr	r2, [r3, #8]
@   0x0801f672: 68db        ldr	r3, [r3, #12]
@   0x0801f674: f7f8        ffa4 	bl	0x185c0
@   0x0801f678: b002        add	sp, #8
@   0x0801f67a: bc10        pop	{r4}
@   0x0801f67c: bc01        pop	{r0}
@   0x0801f67e: 4700        bx	r0
@   0x0801f680: 8100        strh	r0, [r0, #8]
@   0x0801f682: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_0801F418
sub_0801F418: @ 0x0801f418
        .incbin "frog_us_baserom.gba", 0x1f418, 0x26c
        thumb_func_end sub_0801F418
