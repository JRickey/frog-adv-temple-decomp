@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d558, 0x0802d890)  (824 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d558 --end 0x802d890 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d558: df0c        svc	12
@   0x0802d55a: 4770        bx	lr
@   0x0802d55c: df0e        svc	14
@   0x0802d55e: 4770        bx	lr
@   0x0802d560: df0f        svc	15
@   0x0802d562: 4770        bx	lr
@   0x0802d564: df10        svc	16
@   0x0802d566: 4770        bx	lr
@   0x0802d568: df11        svc	17
@   0x0802d56a: 4770        bx	lr
@   0x0802d56c: b403        push	{r0, r1}
@   0x0802d56e: df12        svc	18
@   0x0802d570: bc04        pop	{r2}
@   0x0802d572: 7953        ldrb	r3, [r2, #5]
@   0x0802d574: 7992        ldrb	r2, [r2, #6]
@   0x0802d576: 0212        lsls	r2, r2, #8
@   0x0802d578: 18d2        adds	r2, r2, r3
@   0x0802d57a: bc08        pop	{r3}
@   0x0802d57c: 801a        strh	r2, [r3, #0]
@   0x0802d57e: 4770        bx	lr
@   0x0802d580: df13        svc	19
@   0x0802d582: 4770        bx	lr
@   0x0802d584: df14        svc	20
@   0x0802d586: 4770        bx	lr
@   0x0802d588: df15        svc	21
@   0x0802d58a: 4770        bx	lr
@   0x0802d58c: df16        svc	22
@   0x0802d58e: 4770        bx	lr
@   0x0802d590: df17        svc	23
@   0x0802d592: 4770        bx	lr
@   0x0802d594: df18        svc	24
@   0x0802d596: 4770        bx	lr
@   0x0802d598: df19        svc	25
@   0x0802d59a: 4770        bx	lr
@   0x0802d59c: 2001        movs	r0, #1
@   0x0802d59e: df19        svc	25
@   0x0802d5a0: 4770        bx	lr
@   0x0802d5a2: 2000        movs	r0, #0
@   0x0802d5a4: df19        svc	25
@   0x0802d5a6: 4770        bx	lr
@   0x0802d5a8: df1a        svc	26
@   0x0802d5aa: 4770        bx	lr
@   0x0802d5ac: df1b        svc	27
@   0x0802d5ae: 4770        bx	lr
@   0x0802d5b0: df1c        svc	28
@   0x0802d5b2: 4770        bx	lr
@   0x0802d5b4: df1d        svc	29
@   0x0802d5b6: 4770        bx	lr
@   0x0802d5b8: df1e        svc	30
@   0x0802d5ba: 4770        bx	lr
@   0x0802d5bc: df28        svc	40	@ 0x28
@   0x0802d5be: 4770        bx	lr
@   0x0802d5c0: df29        svc	41	@ 0x29
@   0x0802d5c2: 4770        bx	lr
@   0x0802d5c4: df1f        svc	31
@   0x0802d5c6: 4770        bx	lr
@   0x0802d5c8: df20        svc	32
@   0x0802d5ca: 4770        bx	lr
@   0x0802d5cc: df21        svc	33	@ 0x21
@   0x0802d5ce: 4770        bx	lr
@   0x0802d5d0: df22        svc	34	@ 0x22
@   0x0802d5d2: 4770        bx	lr
@   0x0802d5d4: df23        svc	35	@ 0x23
@   0x0802d5d6: 4770        bx	lr
@   0x0802d5d8: df24        svc	36	@ 0x24
@   0x0802d5da: 4770        bx	lr
@   0x0802d5dc: 2101        movs	r1, #1
@   0x0802d5de: df25        svc	37	@ 0x25
@   0x0802d5e0: 4770        bx	lr
@   0x0802d5e2: 0000        movs	r0, r0
@   0x0802d5e4: 0208        lsls	r0, r1, #8
@   0x0802d5e6: 0400        lsls	r0, r0, #16
@   0x0802d5e8: 7f00        ldrb	r0, [r0, #28]
@   0x0802d5ea: 0300        lsls	r0, r0, #12
@   0x0802d5ec: b570        push	{r4, r5, r6, lr}
@   0x0802d5ee: 1c05        adds	r5, r0, #0
@   0x0802d5f0: 1c0e        adds	r6, r1, #0
@   0x0802d5f2: 6830        ldr	r0, [r6, #0]
@   0x0802d5f4: 2103        movs	r1, #3
@   0x0802d5f6: 4008        ands	r0, r1
@   0x0802d5f8: 2800        cmp	r0, #0
@   0x0802d5fa: d000        beq.n	0x2d5fe
@   0x0802d5fc: e0b4        b.n	0x2d768
@   0x0802d5fe: 6870        ldr	r0, [r6, #4]
@   0x0802d600: 4008        ands	r0, r1
@   0x0802d602: 2800        cmp	r0, #0
@   0x0802d604: d000        beq.n	0x2d608
@   0x0802d606: e0af        b.n	0x2d768
@   0x0802d608: 68b0        ldr	r0, [r6, #8]
@   0x0802d60a: 4008        ands	r0, r1
@   0x0802d60c: 2800        cmp	r0, #0
@   0x0802d60e: d000        beq.n	0x2d612
@   0x0802d610: e0aa        b.n	0x2d768
@   0x0802d612: 68f0        ldr	r0, [r6, #12]
@   0x0802d614: 4008        ands	r0, r1
@   0x0802d616: 2800        cmp	r0, #0
@   0x0802d618: d000        beq.n	0x2d61c
@   0x0802d61a: e0a5        b.n	0x2d768
@   0x0802d61c: f000        ff92 	bl	0x2e544
@   0x0802d620: 4850        ldr	r0, [pc, #320]	@ (0x2d764)
@   0x0802d622: 6831        ldr	r1, [r6, #0]
@   0x0802d624: 6001        str	r1, [r0, #0]
@   0x0802d626: 249a        movs	r4, #154	@ 0x9a
@   0x0802d628: 0064        lsls	r4, r4, #1
@   0x0802d62a: 2000        movs	r0, #0
@   0x0802d62c: 7008        strb	r0, [r1, #0]
@   0x0802d62e: 3101        adds	r1, #1
@   0x0802d630: 3c01        subs	r4, #1
@   0x0802d632: 2c00        cmp	r4, #0
@   0x0802d634: d1fa        bne.n	0x2d62c
@   0x0802d636: 4b4b        ldr	r3, [pc, #300]	@ (0x2d764)
@   0x0802d638: 6818        ldr	r0, [r3, #0]
@   0x0802d63a: 2101        movs	r1, #1
@   0x0802d63c: 6041        str	r1, [r0, #4]
@   0x0802d63e: 30ba        adds	r0, #186	@ 0xba
@   0x0802d640: 21ff        movs	r1, #255	@ 0xff
@   0x0802d642: 7001        strb	r1, [r0, #0]
@   0x0802d644: 6818        ldr	r0, [r3, #0]
@   0x0802d646: 3111        adds	r1, #17
@   0x0802d648: 1842        adds	r2, r0, r1
@   0x0802d64a: 68a9        ldr	r1, [r5, #8]
@   0x0802d64c: 6011        str	r1, [r2, #0]
@   0x0802d64e: 30bb        adds	r0, #187	@ 0xbb
@   0x0802d650: 7004        strb	r4, [r0, #0]
@   0x0802d652: 681a        ldr	r2, [r3, #0]
@   0x0802d654: 2180        movs	r1, #128	@ 0x80
@   0x0802d656: 0049        lsls	r1, r1, #1
@   0x0802d658: 8191        strh	r1, [r2, #12]
@   0x0802d65a: 81d1        strh	r1, [r2, #14]
@   0x0802d65c: 1c10        adds	r0, r2, #0
@   0x0802d65e: 30bc        adds	r0, #188	@ 0xbc
@   0x0802d660: 8001        strh	r1, [r0, #0]
@   0x0802d662: 3002        adds	r0, #2
@   0x0802d664: 8001        strh	r1, [r0, #0]
@   0x0802d666: 6830        ldr	r0, [r6, #0]
@   0x0802d668: 249a        movs	r4, #154	@ 0x9a
@   0x0802d66a: 0064        lsls	r4, r4, #1
@   0x0802d66c: 1901        adds	r1, r0, r4
@   0x0802d66e: 3c20        subs	r4, #32
@   0x0802d670: 1910        adds	r0, r2, r4
@   0x0802d672: 6001        str	r1, [r0, #0]
@   0x0802d674: 78aa        ldrb	r2, [r5, #2]
@   0x0802d676: 0110        lsls	r0, r2, #4
@   0x0802d678: 3040        adds	r0, #64	@ 0x40
@   0x0802d67a: 1c0a        adds	r2, r1, #0
@   0x0802d67c: 2800        cmp	r0, #0
@   0x0802d67e: d005        beq.n	0x2d68c
@   0x0802d680: 2400        movs	r4, #0
@   0x0802d682: 7014        strb	r4, [r2, #0]
@   0x0802d684: 3201        adds	r2, #1
@   0x0802d686: 3801        subs	r0, #1
@   0x0802d688: 2800        cmp	r0, #0
@   0x0802d68a: d1fa        bne.n	0x2d682
@   0x0802d68c: 78a8        ldrb	r0, [r5, #2]
@   0x0802d68e: 3004        adds	r0, #4
@   0x0802d690: 0100        lsls	r0, r0, #4
@   0x0802d692: 1809        adds	r1, r1, r0
@   0x0802d694: 6818        ldr	r0, [r3, #0]
@   0x0802d696: 30c4        adds	r0, #196	@ 0xc4
@   0x0802d698: 6001        str	r1, [r0, #0]
@   0x0802d69a: 78ac        ldrb	r4, [r5, #2]
@   0x0802d69c: 00a0        lsls	r0, r4, #2
@   0x0802d69e: 1c0a        adds	r2, r1, #0
@   0x0802d6a0: 2800        cmp	r0, #0
@   0x0802d6a2: d005        beq.n	0x2d6b0
@   0x0802d6a4: 2400        movs	r4, #0
@   0x0802d6a6: 7014        strb	r4, [r2, #0]
@   0x0802d6a8: 3201        adds	r2, #1
@   0x0802d6aa: 3801        subs	r0, #1
@   0x0802d6ac: 2800        cmp	r0, #0
@   0x0802d6ae: d1fa        bne.n	0x2d6a6
@   0x0802d6b0: 78aa        ldrb	r2, [r5, #2]
@   0x0802d6b2: 0090        lsls	r0, r2, #2
@   0x0802d6b4: 1809        adds	r1, r1, r0
@   0x0802d6b6: 6818        ldr	r0, [r3, #0]
@   0x0802d6b8: 30c0        adds	r0, #192	@ 0xc0
@   0x0802d6ba: 6001        str	r1, [r0, #0]
@   0x0802d6bc: 78ac        ldrb	r4, [r5, #2]
@   0x0802d6be: 00e0        lsls	r0, r4, #3
@   0x0802d6c0: 1b00        subs	r0, r0, r4
@   0x0802d6c2: 0080        lsls	r0, r0, #2
@   0x0802d6c4: 1c0a        adds	r2, r1, #0
@   0x0802d6c6: 2800        cmp	r0, #0
@   0x0802d6c8: d005        beq.n	0x2d6d6
@   0x0802d6ca: 2400        movs	r4, #0
@   0x0802d6cc: 7014        strb	r4, [r2, #0]
@   0x0802d6ce: 3201        adds	r2, #1
@   0x0802d6d0: 3801        subs	r0, #1
@   0x0802d6d2: 2800        cmp	r0, #0
@   0x0802d6d4: d1fa        bne.n	0x2d6cc
@   0x0802d6d6: 78aa        ldrb	r2, [r5, #2]
@   0x0802d6d8: 00d0        lsls	r0, r2, #3
@   0x0802d6da: 1a80        subs	r0, r0, r2
@   0x0802d6dc: 0080        lsls	r0, r0, #2
@   0x0802d6de: 1809        adds	r1, r1, r0
@   0x0802d6e0: 6818        ldr	r0, [r3, #0]
@   0x0802d6e2: 30cc        adds	r0, #204	@ 0xcc
@   0x0802d6e4: 6001        str	r1, [r0, #0]
@   0x0802d6e6: 78ac        ldrb	r4, [r5, #2]
@   0x0802d6e8: 00a0        lsls	r0, r4, #2
@   0x0802d6ea: 1c0a        adds	r2, r1, #0
@   0x0802d6ec: 2800        cmp	r0, #0
@   0x0802d6ee: d005        beq.n	0x2d6fc
@   0x0802d6f0: 2400        movs	r4, #0
@   0x0802d6f2: 7014        strb	r4, [r2, #0]
@   0x0802d6f4: 3201        adds	r2, #1
@   0x0802d6f6: 3801        subs	r0, #1
@   0x0802d6f8: 2800        cmp	r0, #0
@   0x0802d6fa: d1fa        bne.n	0x2d6f2
@   0x0802d6fc: 78aa        ldrb	r2, [r5, #2]
@   0x0802d6fe: 0090        lsls	r0, r2, #2
@   0x0802d700: 1809        adds	r1, r1, r0
@   0x0802d702: 6818        ldr	r0, [r3, #0]
@   0x0802d704: 30c8        adds	r0, #200	@ 0xc8
@   0x0802d706: 6001        str	r1, [r0, #0]
@   0x0802d708: 78ac        ldrb	r4, [r5, #2]
@   0x0802d70a: 01a0        lsls	r0, r4, #6
@   0x0802d70c: 1c0a        adds	r2, r1, #0
@   0x0802d70e: 2800        cmp	r0, #0
@   0x0802d710: d005        beq.n	0x2d71e
@   0x0802d712: 2400        movs	r4, #0
@   0x0802d714: 7014        strb	r4, [r2, #0]
@   0x0802d716: 3201        adds	r2, #1
@   0x0802d718: 3801        subs	r0, #1
@   0x0802d71a: 2800        cmp	r0, #0
@   0x0802d71c: d1fa        bne.n	0x2d714
@   0x0802d71e: 78aa        ldrb	r2, [r5, #2]
@   0x0802d720: 0190        lsls	r0, r2, #6
@   0x0802d722: 1809        adds	r1, r1, r0
@   0x0802d724: 6818        ldr	r0, [r3, #0]
@   0x0802d726: 2490        movs	r4, #144	@ 0x90
@   0x0802d728: 0064        lsls	r4, r4, #1
@   0x0802d72a: 1900        adds	r0, r0, r4
@   0x0802d72c: 6001        str	r1, [r0, #0]
@   0x0802d72e: 78aa        ldrb	r2, [r5, #2]
@   0x0802d730: 0090        lsls	r0, r2, #2
@   0x0802d732: 3010        adds	r0, #16
@   0x0802d734: 1c0a        adds	r2, r1, #0
@   0x0802d736: 2800        cmp	r0, #0
@   0x0802d738: d005        beq.n	0x2d746
@   0x0802d73a: 2300        movs	r3, #0
@   0x0802d73c: 7013        strb	r3, [r2, #0]
@   0x0802d73e: 3201        adds	r2, #1
@   0x0802d740: 3801        subs	r0, #1
@   0x0802d742: 2800        cmp	r0, #0
@   0x0802d744: d1fa        bne.n	0x2d73c
@   0x0802d746: 78a8        ldrb	r0, [r5, #2]
@   0x0802d748: 3004        adds	r0, #4
@   0x0802d74a: 0080        lsls	r0, r0, #2
@   0x0802d74c: 1809        adds	r1, r1, r0
@   0x0802d74e: 1c28        adds	r0, r5, #0
@   0x0802d750: f005        f9a6 	bl	0x32aa0
@   0x0802d754: 2800        cmp	r0, #0
@   0x0802d756: d007        beq.n	0x2d768
@   0x0802d758: 1c28        adds	r0, r5, #0
@   0x0802d75a: 1c31        adds	r1, r6, #0
@   0x0802d75c: f002        f9ac 	bl	0x2fab8
@   0x0802d760: 2001        movs	r0, #1
@   0x0802d762: e002        b.n	0x2d76a
@   0x0802d764: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d766: 0300        lsls	r0, r0, #12
@   0x0802d768: 2000        movs	r0, #0
@   0x0802d76a: bc70        pop	{r4, r5, r6}
@   0x0802d76c: bc02        pop	{r1}
@   0x0802d76e: 4708        bx	r1
@   0x0802d770: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d772: 0600        lsls	r0, r0, #24
@   0x0802d774: 0e03        lsrs	r3, r0, #24
@   0x0802d776: 4921        ldr	r1, [pc, #132]	@ (0x2d7fc)
@   0x0802d778: 6808        ldr	r0, [r1, #0]
@   0x0802d77a: 1c02        adds	r2, r0, #0
@   0x0802d77c: 32bc        adds	r2, #188	@ 0xbc
@   0x0802d77e: 8815        ldrh	r5, [r2, #0]
@   0x0802d780: 8013        strh	r3, [r2, #0]
@   0x0802d782: 1c0c        adds	r4, r1, #0
@   0x0802d784: 2b00        cmp	r3, #0
@   0x0802d786: d001        beq.n	0x2d78c
@   0x0802d788: 1c58        adds	r0, r3, #1
@   0x0802d78a: 8010        strh	r0, [r2, #0]
@   0x0802d78c: 6820        ldr	r0, [r4, #0]
@   0x0802d78e: 30bc        adds	r0, #188	@ 0xbc
@   0x0802d790: 8800        ldrh	r0, [r0, #0]
@   0x0802d792: 42a8        cmp	r0, r5
@   0x0802d794: d02f        beq.n	0x2d7f6
@   0x0802d796: 2300        movs	r3, #0
@   0x0802d798: 1c27        adds	r7, r4, #0
@   0x0802d79a: 2680        movs	r6, #128	@ 0x80
@   0x0802d79c: 0276        lsls	r6, r6, #9
@   0x0802d79e: 2580        movs	r5, #128	@ 0x80
@   0x0802d7a0: 6838        ldr	r0, [r7, #0]
@   0x0802d7a2: 0099        lsls	r1, r3, #2
@   0x0802d7a4: 3010        adds	r0, #16
@   0x0802d7a6: 1842        adds	r2, r0, r1
@   0x0802d7a8: 6811        ldr	r1, [r2, #0]
@   0x0802d7aa: 1c08        adds	r0, r1, #0
@   0x0802d7ac: 4030        ands	r0, r6
@   0x0802d7ae: 2800        cmp	r0, #0
@   0x0802d7b0: d101        bne.n	0x2d7b6
@   0x0802d7b2: 4329        orrs	r1, r5
@   0x0802d7b4: 6011        str	r1, [r2, #0]
@   0x0802d7b6: 3301        adds	r3, #1
@   0x0802d7b8: 2b03        cmp	r3, #3
@   0x0802d7ba: ddf1        ble.n	0x2d7a0
@   0x0802d7bc: 2300        movs	r3, #0
@   0x0802d7be: 6820        ldr	r0, [r4, #0]
@   0x0802d7c0: 7800        ldrb	r0, [r0, #0]
@   0x0802d7c2: 4283        cmp	r3, r0
@   0x0802d7c4: da17        bge.n	0x2d7f6
@   0x0802d7c6: 1c27        adds	r7, r4, #0
@   0x0802d7c8: 2680        movs	r6, #128	@ 0x80
@   0x0802d7ca: 0276        lsls	r6, r6, #9
@   0x0802d7cc: 2580        movs	r5, #128	@ 0x80
@   0x0802d7ce: 6838        ldr	r0, [r7, #0]
@   0x0802d7d0: 30cc        adds	r0, #204	@ 0xcc
@   0x0802d7d2: 6801        ldr	r1, [r0, #0]
@   0x0802d7d4: 0098        lsls	r0, r3, #2
@   0x0802d7d6: 1840        adds	r0, r0, r1
@   0x0802d7d8: 6802        ldr	r2, [r0, #0]
@   0x0802d7da: 2a00        cmp	r2, #0
@   0x0802d7dc: d006        beq.n	0x2d7ec
@   0x0802d7de: 6b91        ldr	r1, [r2, #56]	@ 0x38
@   0x0802d7e0: 1c08        adds	r0, r1, #0
@   0x0802d7e2: 4030        ands	r0, r6
@   0x0802d7e4: 2800        cmp	r0, #0
@   0x0802d7e6: d101        bne.n	0x2d7ec
@   0x0802d7e8: 4329        orrs	r1, r5
@   0x0802d7ea: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802d7ec: 3301        adds	r3, #1
@   0x0802d7ee: 6820        ldr	r0, [r4, #0]
@   0x0802d7f0: 7800        ldrb	r0, [r0, #0]
@   0x0802d7f2: 4283        cmp	r3, r0
@   0x0802d7f4: dbeb        blt.n	0x2d7ce
@   0x0802d7f6: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d7f8: bc01        pop	{r0}
@   0x0802d7fa: 4700        bx	r0
@   0x0802d7fc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d7fe: 0300        lsls	r0, r0, #12
@   0x0802d800: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d802: 0600        lsls	r0, r0, #24
@   0x0802d804: 0e03        lsrs	r3, r0, #24
@   0x0802d806: 4921        ldr	r1, [pc, #132]	@ (0x2d88c)
@   0x0802d808: 6808        ldr	r0, [r1, #0]
@   0x0802d80a: 1c02        adds	r2, r0, #0
@   0x0802d80c: 32be        adds	r2, #190	@ 0xbe
@   0x0802d80e: 8815        ldrh	r5, [r2, #0]
@   0x0802d810: 8013        strh	r3, [r2, #0]
@   0x0802d812: 1c0c        adds	r4, r1, #0
@   0x0802d814: 2b00        cmp	r3, #0
@   0x0802d816: d001        beq.n	0x2d81c
@   0x0802d818: 1c58        adds	r0, r3, #1
@   0x0802d81a: 8010        strh	r0, [r2, #0]
@   0x0802d81c: 6820        ldr	r0, [r4, #0]
@   0x0802d81e: 30be        adds	r0, #190	@ 0xbe
@   0x0802d820: 8800        ldrh	r0, [r0, #0]
@   0x0802d822: 42a8        cmp	r0, r5
@   0x0802d824: d02f        beq.n	0x2d886
@   0x0802d826: 2300        movs	r3, #0
@   0x0802d828: 1c27        adds	r7, r4, #0
@   0x0802d82a: 2680        movs	r6, #128	@ 0x80
@   0x0802d82c: 0276        lsls	r6, r6, #9
@   0x0802d82e: 2580        movs	r5, #128	@ 0x80
@   0x0802d830: 6838        ldr	r0, [r7, #0]
@   0x0802d832: 0099        lsls	r1, r3, #2
@   0x0802d834: 3010        adds	r0, #16
@   0x0802d836: 1842        adds	r2, r0, r1
@   0x0802d838: 6811        ldr	r1, [r2, #0]
@   0x0802d83a: 1c08        adds	r0, r1, #0
@   0x0802d83c: 4030        ands	r0, r6
@   0x0802d83e: 2800        cmp	r0, #0
@   0x0802d840: d001        beq.n	0x2d846
@   0x0802d842: 4329        orrs	r1, r5
@   0x0802d844: 6011        str	r1, [r2, #0]
@   0x0802d846: 3301        adds	r3, #1
@   0x0802d848: 2b03        cmp	r3, #3
@   0x0802d84a: ddf1        ble.n	0x2d830
@   0x0802d84c: 2300        movs	r3, #0
@   0x0802d84e: 6820        ldr	r0, [r4, #0]
@   0x0802d850: 7800        ldrb	r0, [r0, #0]
@   0x0802d852: 4283        cmp	r3, r0
@   0x0802d854: da17        bge.n	0x2d886
@   0x0802d856: 1c27        adds	r7, r4, #0
@   0x0802d858: 2680        movs	r6, #128	@ 0x80
@   0x0802d85a: 0276        lsls	r6, r6, #9
@   0x0802d85c: 2580        movs	r5, #128	@ 0x80
@   0x0802d85e: 6838        ldr	r0, [r7, #0]
@   0x0802d860: 30cc        adds	r0, #204	@ 0xcc
@   0x0802d862: 6801        ldr	r1, [r0, #0]
@   0x0802d864: 0098        lsls	r0, r3, #2
@   0x0802d866: 1840        adds	r0, r0, r1
@   0x0802d868: 6802        ldr	r2, [r0, #0]
@   0x0802d86a: 2a00        cmp	r2, #0
@   0x0802d86c: d006        beq.n	0x2d87c
@   0x0802d86e: 6b91        ldr	r1, [r2, #56]	@ 0x38
@   0x0802d870: 1c08        adds	r0, r1, #0
@   0x0802d872: 4030        ands	r0, r6
@   0x0802d874: 2800        cmp	r0, #0
@   0x0802d876: d001        beq.n	0x2d87c
@   0x0802d878: 4329        orrs	r1, r5
@   0x0802d87a: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802d87c: 3301        adds	r3, #1
@   0x0802d87e: 6820        ldr	r0, [r4, #0]
@   0x0802d880: 7800        ldrb	r0, [r0, #0]
@   0x0802d882: 4283        cmp	r3, r0
@   0x0802d884: dbeb        blt.n	0x2d85e
@   0x0802d886: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d888: bc01        pop	{r0}
@   0x0802d88a: 4700        bx	r0
@   0x0802d88c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d88e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802D558
sub_0802D558: @ 0x0802d558
        .incbin "frog_us_baserom.gba", 0x2d558, 0x338
        thumb_func_end sub_0802D558
