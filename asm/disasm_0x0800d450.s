@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d450, 0x0800d808)  (952 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d450 --end 0x800d808 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d450: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800d452: 4657        mov	r7, sl
@   0x0800d454: 464e        mov	r6, r9
@   0x0800d456: 4645        mov	r5, r8
@   0x0800d458: b4e0        push	{r5, r6, r7}
@   0x0800d45a: b08b        sub	sp, #44	@ 0x2c
@   0x0800d45c: 0400        lsls	r0, r0, #16
@   0x0800d45e: 0c00        lsrs	r0, r0, #16
@   0x0800d460: 9001        str	r0, [sp, #4]
@   0x0800d462: 0409        lsls	r1, r1, #16
@   0x0800d464: 0c09        lsrs	r1, r1, #16
@   0x0800d466: 9102        str	r1, [sp, #8]
@   0x0800d468: 4c33        ldr	r4, [pc, #204]	@ (0xd538)
@   0x0800d46a: 1c20        adds	r0, r4, #0
@   0x0800d46c: 3072        adds	r0, #114	@ 0x72
@   0x0800d46e: 2100        movs	r1, #0
@   0x0800d470: 5e40        ldrsh	r0, [r0, r1]
@   0x0800d472: 2118        movs	r1, #24
@   0x0800d474: f026        fc4e 	bl	0x33d14
@   0x0800d478: 0400        lsls	r0, r0, #16
@   0x0800d47a: 0c00        lsrs	r0, r0, #16
@   0x0800d47c: 4652        mov	r2, sl
@   0x0800d47e: 4b2f        ldr	r3, [pc, #188]	@ (0xd53c)
@   0x0800d480: 401a        ands	r2, r3
@   0x0800d482: 4302        orrs	r2, r0
@   0x0800d484: 4692        mov	sl, r2
@   0x0800d486: 3474        adds	r4, #116	@ 0x74
@   0x0800d488: 2100        movs	r1, #0
@   0x0800d48a: 5e60        ldrsh	r0, [r4, r1]
@   0x0800d48c: 2118        movs	r1, #24
@   0x0800d48e: f026        fc41 	bl	0x33d14
@   0x0800d492: 0400        lsls	r0, r0, #16
@   0x0800d494: 492a        ldr	r1, [pc, #168]	@ (0xd540)
@   0x0800d496: 4652        mov	r2, sl
@   0x0800d498: 400a        ands	r2, r1
@   0x0800d49a: 4302        orrs	r2, r0
@   0x0800d49c: 4692        mov	sl, r2
@   0x0800d49e: 2300        movs	r3, #0
@   0x0800d4a0: 469c        mov	ip, r3
@   0x0800d4a2: 2400        movs	r4, #0
@   0x0800d4a4: 9403        str	r4, [sp, #12]
@   0x0800d4a6: 46a1        mov	r9, r4
@   0x0800d4a8: 0410        lsls	r0, r2, #16
@   0x0800d4aa: 1400        asrs	r0, r0, #16
@   0x0800d4ac: 9004        str	r0, [sp, #16]
@   0x0800d4ae: 4825        ldr	r0, [pc, #148]	@ (0xd544)
@   0x0800d4b0: 4448        add	r0, r9
@   0x0800d4b2: 7800        ldrb	r0, [r0, #0]
@   0x0800d4b4: 2801        cmp	r0, #1
@   0x0800d4b6: d04b        beq.n	0xd550
@   0x0800d4b8: 2801        cmp	r0, #1
@   0x0800d4ba: dc50        bgt.n	0xd55e
@   0x0800d4bc: 2800        cmp	r0, #0
@   0x0800d4be: d14e        bne.n	0xd55e
@   0x0800d4c0: 4648        mov	r0, r9
@   0x0800d4c2: 0602        lsls	r2, r0, #24
@   0x0800d4c4: 491e        ldr	r1, [pc, #120]	@ (0xd540)
@   0x0800d4c6: 400e        ands	r6, r1
@   0x0800d4c8: 20a0        movs	r0, #160	@ 0xa0
@   0x0800d4ca: 02c0        lsls	r0, r0, #11
@   0x0800d4cc: 4306        orrs	r6, r0
@   0x0800d4ce: 4b1b        ldr	r3, [pc, #108]	@ (0xd53c)
@   0x0800d4d0: 401e        ands	r6, r3
@   0x0800d4d2: 2003        movs	r0, #3
@   0x0800d4d4: 4306        orrs	r6, r0
@   0x0800d4d6: 1431        asrs	r1, r6, #16
@   0x0800d4d8: 0ed0        lsrs	r0, r2, #27
@   0x0800d4da: 1840        adds	r0, r0, r1
@   0x0800d4dc: 0400        lsls	r0, r0, #16
@   0x0800d4de: 4c18        ldr	r4, [pc, #96]	@ (0xd540)
@   0x0800d4e0: 4026        ands	r6, r4
@   0x0800d4e2: 4306        orrs	r6, r0
@   0x0800d4e4: 20e0        movs	r0, #224	@ 0xe0
@   0x0800d4e6: 04c0        lsls	r0, r0, #19
@   0x0800d4e8: 4010        ands	r0, r2
@   0x0800d4ea: 0e00        lsrs	r0, r0, #24
@   0x0800d4ec: 1980        adds	r0, r0, r6
@   0x0800d4ee: 0400        lsls	r0, r0, #16
@   0x0800d4f0: 0c00        lsrs	r0, r0, #16
@   0x0800d4f2: 401e        ands	r6, r3
@   0x0800d4f4: 4306        orrs	r6, r0
@   0x0800d4f6: 1c32        adds	r2, r6, #0
@   0x0800d4f8: 4c13        ldr	r4, [pc, #76]	@ (0xd548)
@   0x0800d4fa: 2008        movs	r0, #8
@   0x0800d4fc: 5e21        ldrsh	r1, [r4, r0]
@   0x0800d4fe: 0410        lsls	r0, r2, #16
@   0x0800d500: 1403        asrs	r3, r0, #16
@   0x0800d502: 4299        cmp	r1, r3
@   0x0800d504: d02b        beq.n	0xd55e
@   0x0800d506: 210a        movs	r1, #10
@   0x0800d508: 5e60        ldrsh	r0, [r4, r1]
@   0x0800d50a: 1411        asrs	r1, r2, #16
@   0x0800d50c: 4288        cmp	r0, r1
@   0x0800d50e: d026        beq.n	0xd55e
@   0x0800d510: 9a04        ldr	r2, [sp, #16]
@   0x0800d512: 429a        cmp	r2, r3
@   0x0800d514: d023        beq.n	0xd55e
@   0x0800d516: 4653        mov	r3, sl
@   0x0800d518: 1418        asrs	r0, r3, #16
@   0x0800d51a: 4288        cmp	r0, r1
@   0x0800d51c: d01f        beq.n	0xd55e
@   0x0800d51e: 490b        ldr	r1, [pc, #44]	@ (0xd54c)
@   0x0800d520: 9c03        ldr	r4, [sp, #12]
@   0x0800d522: 0420        lsls	r0, r4, #16
@   0x0800d524: 1400        asrs	r0, r0, #16
@   0x0800d526: 1841        adds	r1, r0, r1
@   0x0800d528: 464a        mov	r2, r9
@   0x0800d52a: 700a        strb	r2, [r1, #0]
@   0x0800d52c: 3001        adds	r0, #1
@   0x0800d52e: 0400        lsls	r0, r0, #16
@   0x0800d530: 0c00        lsrs	r0, r0, #16
@   0x0800d532: 9003        str	r0, [sp, #12]
@   0x0800d534: e013        b.n	0xd55e
@   0x0800d536: 0000        movs	r0, r0
@   0x0800d538: 3720        adds	r7, #32
@   0x0800d53a: 0300        lsls	r0, r0, #12
@   0x0800d53c: 0000        movs	r0, r0
@   0x0800d53e: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0800d542: 0000        movs	r0, r0
@   0x0800d544: 53a0        strh	r0, [r4, r6]
@   0x0800d546: 0300        lsls	r0, r0, #12
@   0x0800d548: 35e0        adds	r5, #224	@ 0xe0
@   0x0800d54a: 0300        lsls	r0, r0, #12
@   0x0800d54c: 3610        adds	r6, #16
@   0x0800d54e: 0300        lsls	r0, r0, #12
@   0x0800d550: 4663        mov	r3, ip
@   0x0800d552: 0418        lsls	r0, r3, #16
@   0x0800d554: 2480        movs	r4, #128	@ 0x80
@   0x0800d556: 0264        lsls	r4, r4, #9
@   0x0800d558: 1900        adds	r0, r0, r4
@   0x0800d55a: 0c00        lsrs	r0, r0, #16
@   0x0800d55c: 4684        mov	ip, r0
@   0x0800d55e: 2001        movs	r0, #1
@   0x0800d560: 4481        add	r9, r0
@   0x0800d562: 4649        mov	r1, r9
@   0x0800d564: 293f        cmp	r1, #63	@ 0x3f
@   0x0800d566: dda2        ble.n	0xd4ae
@   0x0800d568: 4662        mov	r2, ip
@   0x0800d56a: 0411        lsls	r1, r2, #16
@   0x0800d56c: 9b01        ldr	r3, [sp, #4]
@   0x0800d56e: 0418        lsls	r0, r3, #16
@   0x0800d570: 140c        asrs	r4, r1, #16
@   0x0800d572: 46a1        mov	r9, r4
@   0x0800d574: 9009        str	r0, [sp, #36]	@ 0x24
@   0x0800d576: 9802        ldr	r0, [sp, #8]
@   0x0800d578: 0400        lsls	r0, r0, #16
@   0x0800d57a: 900a        str	r0, [sp, #40]	@ 0x28
@   0x0800d57c: 9a09        ldr	r2, [sp, #36]	@ 0x24
@   0x0800d57e: 4291        cmp	r1, r2
@   0x0800d580: da5f        bge.n	0xd642
@   0x0800d582: 466b        mov	r3, sp
@   0x0800d584: 9305        str	r3, [sp, #20]
@   0x0800d586: 9c03        ldr	r4, [sp, #12]
@   0x0800d588: 0420        lsls	r0, r4, #16
@   0x0800d58a: 1400        asrs	r0, r0, #16
@   0x0800d58c: f7f3        f8ea 	bl	0x764
@   0x0800d590: 9905        ldr	r1, [sp, #20]
@   0x0800d592: 7008        strb	r0, [r1, #0]
@   0x0800d594: 7808        ldrb	r0, [r1, #0]
@   0x0800d596: 4a35        ldr	r2, [pc, #212]	@ (0xd66c)
@   0x0800d598: 1880        adds	r0, r0, r2
@   0x0800d59a: 7800        ldrb	r0, [r0, #0]
@   0x0800d59c: 4b34        ldr	r3, [pc, #208]	@ (0xd670)
@   0x0800d59e: 18c1        adds	r1, r0, r3
@   0x0800d5a0: 2001        movs	r0, #1
@   0x0800d5a2: 7008        strb	r0, [r1, #0]
@   0x0800d5a4: 2400        movs	r4, #0
@   0x0800d5a6: 9403        str	r4, [sp, #12]
@   0x0800d5a8: 2600        movs	r6, #0
@   0x0800d5aa: 4649        mov	r1, r9
@   0x0800d5ac: 0608        lsls	r0, r1, #24
@   0x0800d5ae: 0ec2        lsrs	r2, r0, #27
@   0x0800d5b0: 9206        str	r2, [sp, #24]
@   0x0800d5b2: 0e00        lsrs	r0, r0, #24
@   0x0800d5b4: 4684        mov	ip, r0
@   0x0800d5b6: 4663        mov	r3, ip
@   0x0800d5b8: 2407        movs	r4, #7
@   0x0800d5ba: 4023        ands	r3, r4
@   0x0800d5bc: 469c        mov	ip, r3
@   0x0800d5be: 492c        ldr	r1, [pc, #176]	@ (0xd670)
@   0x0800d5c0: 1870        adds	r0, r6, r1
@   0x0800d5c2: 7800        ldrb	r0, [r0, #0]
@   0x0800d5c4: 2800        cmp	r0, #0
@   0x0800d5c6: d133        bne.n	0xd630
@   0x0800d5c8: 4a2a        ldr	r2, [pc, #168]	@ (0xd674)
@   0x0800d5ca: 4017        ands	r7, r2
@   0x0800d5cc: 20a0        movs	r0, #160	@ 0xa0
@   0x0800d5ce: 02c0        lsls	r0, r0, #11
@   0x0800d5d0: 4307        orrs	r7, r0
@   0x0800d5d2: 4b29        ldr	r3, [pc, #164]	@ (0xd678)
@   0x0800d5d4: 401f        ands	r7, r3
@   0x0800d5d6: 2003        movs	r0, #3
@   0x0800d5d8: 4307        orrs	r7, r0
@   0x0800d5da: 1438        asrs	r0, r7, #16
@   0x0800d5dc: 9c06        ldr	r4, [sp, #24]
@   0x0800d5de: 1820        adds	r0, r4, r0
@   0x0800d5e0: 0400        lsls	r0, r0, #16
@   0x0800d5e2: 4017        ands	r7, r2
@   0x0800d5e4: 4307        orrs	r7, r0
@   0x0800d5e6: 4661        mov	r1, ip
@   0x0800d5e8: 19c8        adds	r0, r1, r7
@   0x0800d5ea: 0400        lsls	r0, r0, #16
@   0x0800d5ec: 0c00        lsrs	r0, r0, #16
@   0x0800d5ee: 401f        ands	r7, r3
@   0x0800d5f0: 4307        orrs	r7, r0
@   0x0800d5f2: 1c3a        adds	r2, r7, #0
@   0x0800d5f4: 4c21        ldr	r4, [pc, #132]	@ (0xd67c)
@   0x0800d5f6: 2308        movs	r3, #8
@   0x0800d5f8: 5ee1        ldrsh	r1, [r4, r3]
@   0x0800d5fa: 0410        lsls	r0, r2, #16
@   0x0800d5fc: 1403        asrs	r3, r0, #16
@   0x0800d5fe: 4299        cmp	r1, r3
@   0x0800d600: d016        beq.n	0xd630
@   0x0800d602: 210a        movs	r1, #10
@   0x0800d604: 5e60        ldrsh	r0, [r4, r1]
@   0x0800d606: 1411        asrs	r1, r2, #16
@   0x0800d608: 4288        cmp	r0, r1
@   0x0800d60a: d011        beq.n	0xd630
@   0x0800d60c: 4652        mov	r2, sl
@   0x0800d60e: 0410        lsls	r0, r2, #16
@   0x0800d610: 1400        asrs	r0, r0, #16
@   0x0800d612: 4298        cmp	r0, r3
@   0x0800d614: d00c        beq.n	0xd630
@   0x0800d616: 1410        asrs	r0, r2, #16
@   0x0800d618: 4288        cmp	r0, r1
@   0x0800d61a: d009        beq.n	0xd630
@   0x0800d61c: 9b03        ldr	r3, [sp, #12]
@   0x0800d61e: 0418        lsls	r0, r3, #16
@   0x0800d620: 1400        asrs	r0, r0, #16
@   0x0800d622: 4c12        ldr	r4, [pc, #72]	@ (0xd66c)
@   0x0800d624: 1901        adds	r1, r0, r4
@   0x0800d626: 700e        strb	r6, [r1, #0]
@   0x0800d628: 3001        adds	r0, #1
@   0x0800d62a: 0400        lsls	r0, r0, #16
@   0x0800d62c: 0c00        lsrs	r0, r0, #16
@   0x0800d62e: 9003        str	r0, [sp, #12]
@   0x0800d630: 3601        adds	r6, #1
@   0x0800d632: 2e3f        cmp	r6, #63	@ 0x3f
@   0x0800d634: ddc3        ble.n	0xd5be
@   0x0800d636: 2001        movs	r0, #1
@   0x0800d638: 4481        add	r9, r0
@   0x0800d63a: 9909        ldr	r1, [sp, #36]	@ 0x24
@   0x0800d63c: 1408        asrs	r0, r1, #16
@   0x0800d63e: 4581        cmp	r9, r0
@   0x0800d640: dba1        blt.n	0xd586
@   0x0800d642: 2600        movs	r6, #0
@   0x0800d644: 2200        movs	r2, #0
@   0x0800d646: 9203        str	r2, [sp, #12]
@   0x0800d648: 4691        mov	r9, r2
@   0x0800d64a: 4b0a        ldr	r3, [pc, #40]	@ (0xd674)
@   0x0800d64c: 469c        mov	ip, r3
@   0x0800d64e: 4f0a        ldr	r7, [pc, #40]	@ (0xd678)
@   0x0800d650: 4654        mov	r4, sl
@   0x0800d652: 0420        lsls	r0, r4, #16
@   0x0800d654: 1400        asrs	r0, r0, #16
@   0x0800d656: 9007        str	r0, [sp, #28]
@   0x0800d658: 4805        ldr	r0, [pc, #20]	@ (0xd670)
@   0x0800d65a: 4448        add	r0, r9
@   0x0800d65c: 7800        ldrb	r0, [r0, #0]
@   0x0800d65e: 2801        cmp	r0, #1
@   0x0800d660: d059        beq.n	0xd716
@   0x0800d662: 2801        cmp	r0, #1
@   0x0800d664: dc0c        bgt.n	0xd680
@   0x0800d666: 2800        cmp	r0, #0
@   0x0800d668: d00d        beq.n	0xd686
@   0x0800d66a: e054        b.n	0xd716
@   0x0800d66c: 3610        adds	r6, #16
@   0x0800d66e: 0300        lsls	r0, r0, #12
@   0x0800d670: 53a0        strh	r0, [r4, r6]
@   0x0800d672: 0300        lsls	r0, r0, #12
@   0x0800d674: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0800d678: 0000        movs	r0, r0
@   0x0800d67a: ffff        35e0 			@ <UNDEFINED> instruction: 0xffff35e0
@   0x0800d67e: 0300        lsls	r0, r0, #12
@   0x0800d680: 2802        cmp	r0, #2
@   0x0800d682: d043        beq.n	0xd70c
@   0x0800d684: e047        b.n	0xd716
@   0x0800d686: 4648        mov	r0, r9
@   0x0800d688: 0602        lsls	r2, r0, #24
@   0x0800d68a: 4641        mov	r1, r8
@   0x0800d68c: 4663        mov	r3, ip
@   0x0800d68e: 4019        ands	r1, r3
@   0x0800d690: 20a0        movs	r0, #160	@ 0xa0
@   0x0800d692: 02c0        lsls	r0, r0, #11
@   0x0800d694: 4301        orrs	r1, r0
@   0x0800d696: 4039        ands	r1, r7
@   0x0800d698: 2003        movs	r0, #3
@   0x0800d69a: 4301        orrs	r1, r0
@   0x0800d69c: 4688        mov	r8, r1
@   0x0800d69e: 1409        asrs	r1, r1, #16
@   0x0800d6a0: 0ed0        lsrs	r0, r2, #27
@   0x0800d6a2: 1840        adds	r0, r0, r1
@   0x0800d6a4: 0400        lsls	r0, r0, #16
@   0x0800d6a6: 4644        mov	r4, r8
@   0x0800d6a8: 401c        ands	r4, r3
@   0x0800d6aa: 4304        orrs	r4, r0
@   0x0800d6ac: 46a0        mov	r8, r4
@   0x0800d6ae: 20e0        movs	r0, #224	@ 0xe0
@   0x0800d6b0: 04c0        lsls	r0, r0, #19
@   0x0800d6b2: 4010        ands	r0, r2
@   0x0800d6b4: 0e00        lsrs	r0, r0, #24
@   0x0800d6b6: 4440        add	r0, r8
@   0x0800d6b8: 0400        lsls	r0, r0, #16
@   0x0800d6ba: 0c00        lsrs	r0, r0, #16
@   0x0800d6bc: 403c        ands	r4, r7
@   0x0800d6be: 4304        orrs	r4, r0
@   0x0800d6c0: 46a0        mov	r8, r4
@   0x0800d6c2: 4642        mov	r2, r8
@   0x0800d6c4: 4c0f        ldr	r4, [pc, #60]	@ (0xd704)
@   0x0800d6c6: 2008        movs	r0, #8
@   0x0800d6c8: 5e21        ldrsh	r1, [r4, r0]
@   0x0800d6ca: 0410        lsls	r0, r2, #16
@   0x0800d6cc: 1403        asrs	r3, r0, #16
@   0x0800d6ce: 4299        cmp	r1, r3
@   0x0800d6d0: d021        beq.n	0xd716
@   0x0800d6d2: 210a        movs	r1, #10
@   0x0800d6d4: 5e60        ldrsh	r0, [r4, r1]
@   0x0800d6d6: 1411        asrs	r1, r2, #16
@   0x0800d6d8: 4288        cmp	r0, r1
@   0x0800d6da: d01c        beq.n	0xd716
@   0x0800d6dc: 9a07        ldr	r2, [sp, #28]
@   0x0800d6de: 429a        cmp	r2, r3
@   0x0800d6e0: d019        beq.n	0xd716
@   0x0800d6e2: 4653        mov	r3, sl
@   0x0800d6e4: 1418        asrs	r0, r3, #16
@   0x0800d6e6: 4288        cmp	r0, r1
@   0x0800d6e8: d015        beq.n	0xd716
@   0x0800d6ea: 4907        ldr	r1, [pc, #28]	@ (0xd708)
@   0x0800d6ec: 9c03        ldr	r4, [sp, #12]
@   0x0800d6ee: 0420        lsls	r0, r4, #16
@   0x0800d6f0: 1400        asrs	r0, r0, #16
@   0x0800d6f2: 1841        adds	r1, r0, r1
@   0x0800d6f4: 464a        mov	r2, r9
@   0x0800d6f6: 700a        strb	r2, [r1, #0]
@   0x0800d6f8: 3001        adds	r0, #1
@   0x0800d6fa: 0400        lsls	r0, r0, #16
@   0x0800d6fc: 0c00        lsrs	r0, r0, #16
@   0x0800d6fe: 9003        str	r0, [sp, #12]
@   0x0800d700: e009        b.n	0xd716
@   0x0800d702: 0000        movs	r0, r0
@   0x0800d704: 35e0        adds	r5, #224	@ 0xe0
@   0x0800d706: 0300        lsls	r0, r0, #12
@   0x0800d708: 3610        adds	r6, #16
@   0x0800d70a: 0300        lsls	r0, r0, #12
@   0x0800d70c: 0430        lsls	r0, r6, #16
@   0x0800d70e: 2380        movs	r3, #128	@ 0x80
@   0x0800d710: 025b        lsls	r3, r3, #9
@   0x0800d712: 18c0        adds	r0, r0, r3
@   0x0800d714: 0c06        lsrs	r6, r0, #16
@   0x0800d716: 2401        movs	r4, #1
@   0x0800d718: 44a1        add	r9, r4
@   0x0800d71a: 4648        mov	r0, r9
@   0x0800d71c: 283f        cmp	r0, #63	@ 0x3f
@   0x0800d71e: dd9b        ble.n	0xd658
@   0x0800d720: 0430        lsls	r0, r6, #16
@   0x0800d722: 1401        asrs	r1, r0, #16
@   0x0800d724: 4689        mov	r9, r1
@   0x0800d726: 9a0a        ldr	r2, [sp, #40]	@ 0x28
@   0x0800d728: 4290        cmp	r0, r2
@   0x0800d72a: da5b        bge.n	0xd7e4
@   0x0800d72c: 466b        mov	r3, sp
@   0x0800d72e: 9308        str	r3, [sp, #32]
@   0x0800d730: 9c03        ldr	r4, [sp, #12]
@   0x0800d732: 0420        lsls	r0, r4, #16
@   0x0800d734: 1400        asrs	r0, r0, #16
@   0x0800d736: f7f3        f815 	bl	0x764
@   0x0800d73a: 9908        ldr	r1, [sp, #32]
@   0x0800d73c: 7008        strb	r0, [r1, #0]
@   0x0800d73e: 7808        ldrb	r0, [r1, #0]
@   0x0800d740: 4a2c        ldr	r2, [pc, #176]	@ (0xd7f4)
@   0x0800d742: 1880        adds	r0, r0, r2
@   0x0800d744: 7800        ldrb	r0, [r0, #0]
@   0x0800d746: 4b2c        ldr	r3, [pc, #176]	@ (0xd7f8)
@   0x0800d748: 18c1        adds	r1, r0, r3
@   0x0800d74a: 2002        movs	r0, #2
@   0x0800d74c: 7008        strb	r0, [r1, #0]
@   0x0800d74e: 2400        movs	r4, #0
@   0x0800d750: 9403        str	r4, [sp, #12]
@   0x0800d752: 2600        movs	r6, #0
@   0x0800d754: 2001        movs	r0, #1
@   0x0800d756: 4448        add	r0, r9
@   0x0800d758: 4680        mov	r8, r0
@   0x0800d75a: 4649        mov	r1, r9
@   0x0800d75c: 0608        lsls	r0, r1, #24
@   0x0800d75e: 0ec7        lsrs	r7, r0, #27
@   0x0800d760: 0e02        lsrs	r2, r0, #24
@   0x0800d762: 2307        movs	r3, #7
@   0x0800d764: 401a        ands	r2, r3
@   0x0800d766: 4c24        ldr	r4, [pc, #144]	@ (0xd7f8)
@   0x0800d768: 1930        adds	r0, r6, r4
@   0x0800d76a: 7800        ldrb	r0, [r0, #0]
@   0x0800d76c: 2800        cmp	r0, #0
@   0x0800d76e: d131        bne.n	0xd7d4
@   0x0800d770: 4822        ldr	r0, [pc, #136]	@ (0xd7fc)
@   0x0800d772: 4005        ands	r5, r0
@   0x0800d774: 20a0        movs	r0, #160	@ 0xa0
@   0x0800d776: 02c0        lsls	r0, r0, #11
@   0x0800d778: 4305        orrs	r5, r0
@   0x0800d77a: 4921        ldr	r1, [pc, #132]	@ (0xd800)
@   0x0800d77c: 400d        ands	r5, r1
@   0x0800d77e: 2003        movs	r0, #3
@   0x0800d780: 4305        orrs	r5, r0
@   0x0800d782: 1428        asrs	r0, r5, #16
@   0x0800d784: 1838        adds	r0, r7, r0
@   0x0800d786: 0400        lsls	r0, r0, #16
@   0x0800d788: 4b1c        ldr	r3, [pc, #112]	@ (0xd7fc)
@   0x0800d78a: 401d        ands	r5, r3
@   0x0800d78c: 4305        orrs	r5, r0
@   0x0800d78e: 1950        adds	r0, r2, r5
@   0x0800d790: 0400        lsls	r0, r0, #16
@   0x0800d792: 0c00        lsrs	r0, r0, #16
@   0x0800d794: 400d        ands	r5, r1
@   0x0800d796: 4305        orrs	r5, r0
@   0x0800d798: 4c1a        ldr	r4, [pc, #104]	@ (0xd804)
@   0x0800d79a: 2008        movs	r0, #8
@   0x0800d79c: 5e21        ldrsh	r1, [r4, r0]
@   0x0800d79e: 0428        lsls	r0, r5, #16
@   0x0800d7a0: 1403        asrs	r3, r0, #16
@   0x0800d7a2: 4299        cmp	r1, r3
@   0x0800d7a4: d016        beq.n	0xd7d4
@   0x0800d7a6: 210a        movs	r1, #10
@   0x0800d7a8: 5e60        ldrsh	r0, [r4, r1]
@   0x0800d7aa: 1429        asrs	r1, r5, #16
@   0x0800d7ac: 4288        cmp	r0, r1
@   0x0800d7ae: d011        beq.n	0xd7d4
@   0x0800d7b0: 4654        mov	r4, sl
@   0x0800d7b2: 0420        lsls	r0, r4, #16
@   0x0800d7b4: 1400        asrs	r0, r0, #16
@   0x0800d7b6: 4298        cmp	r0, r3
@   0x0800d7b8: d00c        beq.n	0xd7d4
@   0x0800d7ba: 1420        asrs	r0, r4, #16
@   0x0800d7bc: 4288        cmp	r0, r1
@   0x0800d7be: d009        beq.n	0xd7d4
@   0x0800d7c0: 9903        ldr	r1, [sp, #12]
@   0x0800d7c2: 0408        lsls	r0, r1, #16
@   0x0800d7c4: 1400        asrs	r0, r0, #16
@   0x0800d7c6: 4b0b        ldr	r3, [pc, #44]	@ (0xd7f4)
@   0x0800d7c8: 18c1        adds	r1, r0, r3
@   0x0800d7ca: 700e        strb	r6, [r1, #0]
@   0x0800d7cc: 3001        adds	r0, #1
@   0x0800d7ce: 0400        lsls	r0, r0, #16
@   0x0800d7d0: 0c00        lsrs	r0, r0, #16
@   0x0800d7d2: 9003        str	r0, [sp, #12]
@   0x0800d7d4: 3601        adds	r6, #1
@   0x0800d7d6: 2e3f        cmp	r6, #63	@ 0x3f
@   0x0800d7d8: ddc5        ble.n	0xd766
@   0x0800d7da: 46c1        mov	r9, r8
@   0x0800d7dc: 9c0a        ldr	r4, [sp, #40]	@ 0x28
@   0x0800d7de: 1420        asrs	r0, r4, #16
@   0x0800d7e0: 4581        cmp	r9, r0
@   0x0800d7e2: dba5        blt.n	0xd730
@   0x0800d7e4: b00b        add	sp, #44	@ 0x2c
@   0x0800d7e6: bc38        pop	{r3, r4, r5}
@   0x0800d7e8: 4698        mov	r8, r3
@   0x0800d7ea: 46a1        mov	r9, r4
@   0x0800d7ec: 46aa        mov	sl, r5
@   0x0800d7ee: bcf0        pop	{r4, r5, r6, r7}
@   0x0800d7f0: bc01        pop	{r0}
@   0x0800d7f2: 4700        bx	r0
@   0x0800d7f4: 3610        adds	r6, #16
@   0x0800d7f6: 0300        lsls	r0, r0, #12
@   0x0800d7f8: 53a0        strh	r0, [r4, r6]
@   0x0800d7fa: 0300        lsls	r0, r0, #12
@   0x0800d7fc: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0800d800: 0000        movs	r0, r0
@   0x0800d802: ffff        35e0 			@ <UNDEFINED> instruction: 0xffff35e0
@   0x0800d806: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800D450
sub_0800D450: @ 0x0800d450
        .incbin "frog_us_baserom.gba", 0xd450, 0x3b8
        thumb_func_end sub_0800D450
