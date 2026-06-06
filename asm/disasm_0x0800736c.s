@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800736c, 0x08007660)  (756 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800736c --end 0x8007660 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800736c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800736e: 4657        mov	r7, sl
@   0x08007370: 464e        mov	r6, r9
@   0x08007372: 4645        mov	r5, r8
@   0x08007374: b4e0        push	{r5, r6, r7}
@   0x08007376: b08e        sub	sp, #56	@ 0x38
@   0x08007378: 1c0c        adds	r4, r1, #0
@   0x0800737a: 9303        str	r3, [sp, #12]
@   0x0800737c: 9916        ldr	r1, [sp, #88]	@ 0x58
@   0x0800737e: 0600        lsls	r0, r0, #24
@   0x08007380: 0e03        lsrs	r3, r0, #24
@   0x08007382: 0609        lsls	r1, r1, #24
@   0x08007384: 0e09        lsrs	r1, r1, #24
@   0x08007386: 9104        str	r1, [sp, #16]
@   0x08007388: 4827        ldr	r0, [pc, #156]	@ (0x7428)
@   0x0800738a: 6807        ldr	r7, [r0, #0]
@   0x0800738c: 2000        movs	r0, #0
@   0x0800738e: 9006        str	r0, [sp, #24]
@   0x08007390: 9205        str	r2, [sp, #20]
@   0x08007392: 9903        ldr	r1, [sp, #12]
@   0x08007394: 428a        cmp	r2, r1
@   0x08007396: dd00        ble.n	0x739a
@   0x08007398: e158        b.n	0x764c
@   0x0800739a: 00d0        lsls	r0, r2, #3
@   0x0800739c: 1880        adds	r0, r0, r2
@   0x0800739e: 0080        lsls	r0, r0, #2
@   0x080073a0: 1906        adds	r6, r0, r4
@   0x080073a2: 061b        lsls	r3, r3, #24
@   0x080073a4: 9309        str	r3, [sp, #36]	@ 0x24
@   0x080073a6: 161b        asrs	r3, r3, #24
@   0x080073a8: 469a        mov	sl, r3
@   0x080073aa: 4a20        ldr	r2, [pc, #128]	@ (0x742c)
@   0x080073ac: 2a00        cmp	r2, #0
@   0x080073ae: d100        bne.n	0x73b2
@   0x080073b0: e144        b.n	0x763c
@   0x080073b2: 2e00        cmp	r6, #0
@   0x080073b4: d100        bne.n	0x73b8
@   0x080073b6: e141        b.n	0x763c
@   0x080073b8: 88f4        ldrh	r4, [r6, #6]
@   0x080073ba: 0423        lsls	r3, r4, #16
@   0x080073bc: 0c58        lsrs	r0, r3, #17
@   0x080073be: 8871        ldrh	r1, [r6, #2]
@   0x080073c0: 1a08        subs	r0, r1, r0
@   0x080073c2: 0400        lsls	r0, r0, #16
@   0x080073c4: 0c00        lsrs	r0, r0, #16
@   0x080073c6: 4a1a        ldr	r2, [pc, #104]	@ (0x7430)
@   0x080073c8: 4691        mov	r9, r2
@   0x080073ca: 4649        mov	r1, r9
@   0x080073cc: 9c07        ldr	r4, [sp, #28]
@   0x080073ce: 4021        ands	r1, r4
@   0x080073d0: 4301        orrs	r1, r0
@   0x080073d2: 9107        str	r1, [sp, #28]
@   0x080073d4: 88b2        ldrh	r2, [r6, #4]
@   0x080073d6: 0410        lsls	r0, r2, #16
@   0x080073d8: 0c02        lsrs	r2, r0, #16
@   0x080073da: 0c40        lsrs	r0, r0, #17
@   0x080073dc: 8834        ldrh	r4, [r6, #0]
@   0x080073de: 1a20        subs	r0, r4, r0
@   0x080073e0: 3801        subs	r0, #1
@   0x080073e2: 0400        lsls	r0, r0, #16
@   0x080073e4: 4c13        ldr	r4, [pc, #76]	@ (0x7434)
@   0x080073e6: 46a0        mov	r8, r4
@   0x080073e8: 4021        ands	r1, r4
@   0x080073ea: 4301        orrs	r1, r0
@   0x080073ec: 9107        str	r1, [sp, #28]
@   0x080073ee: 4648        mov	r0, r9
@   0x080073f0: 9908        ldr	r1, [sp, #32]
@   0x080073f2: 4008        ands	r0, r1
@   0x080073f4: 4310        orrs	r0, r2
@   0x080073f6: 9008        str	r0, [sp, #32]
@   0x080073f8: 4020        ands	r0, r4
@   0x080073fa: 4318        orrs	r0, r3
@   0x080073fc: 9008        str	r0, [sp, #32]
@   0x080073fe: 22b4        movs	r2, #180	@ 0xb4
@   0x08007400: 9200        str	r2, [sp, #0]
@   0x08007402: 480a        ldr	r0, [pc, #40]	@ (0x742c)
@   0x08007404: 9907        ldr	r1, [sp, #28]
@   0x08007406: 9a08        ldr	r2, [sp, #32]
@   0x08007408: 2382        movs	r3, #130	@ 0x82
@   0x0800740a: 005b        lsls	r3, r3, #1
@   0x0800740c: f005        fd60 	bl	0xced0
@   0x08007410: 2800        cmp	r0, #0
@   0x08007412: d100        bne.n	0x7416
@   0x08007414: e112        b.n	0x763c
@   0x08007416: 7ef0        ldrb	r0, [r6, #27]
@   0x08007418: 2801        cmp	r0, #1
@   0x0800741a: d05f        beq.n	0x74dc
@   0x0800741c: 2801        cmp	r0, #1
@   0x0800741e: dc0b        bgt.n	0x7438
@   0x08007420: 2800        cmp	r0, #0
@   0x08007422: d00f        beq.n	0x7444
@   0x08007424: e0df        b.n	0x75e6
@   0x08007426: 0000        movs	r0, r0
@   0x08007428: 5330        strh	r0, [r6, r4]
@   0x0800742a: 0300        lsls	r0, r0, #12
@   0x0800742c: 3720        adds	r7, #32
@   0x0800742e: 0300        lsls	r0, r0, #12
@   0x08007430: 0000        movs	r0, r0
@   0x08007432: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x08007436: 0000        movs	r0, r0
@   0x08007438: 2802        cmp	r0, #2
@   0x0800743a: d06b        beq.n	0x7514
@   0x0800743c: 2803        cmp	r0, #3
@   0x0800743e: d100        bne.n	0x7442
@   0x08007440: e0b2        b.n	0x75a8
@   0x08007442: e0d0        b.n	0x75e6
@   0x08007444: 6970        ldr	r0, [r6, #20]
@   0x08007446: 1a38        subs	r0, r7, r0
@   0x08007448: 9b09        ldr	r3, [sp, #36]	@ 0x24
@   0x0800744a: 161d        asrs	r5, r3, #24
@   0x0800744c: 0069        lsls	r1, r5, #1
@   0x0800744e: 1949        adds	r1, r1, r5
@   0x08007450: 0089        lsls	r1, r1, #2
@   0x08007452: 4c20        ldr	r4, [pc, #128]	@ (0x74d4)
@   0x08007454: 1909        adds	r1, r1, r4
@   0x08007456: 79c9        ldrb	r1, [r1, #7]
@   0x08007458: 0609        lsls	r1, r1, #24
@   0x0800745a: 1609        asrs	r1, r1, #24
@   0x0800745c: 4288        cmp	r0, r1
@   0x0800745e: d800        bhi.n	0x7462
@   0x08007460: e0c1        b.n	0x75e6
@   0x08007462: 2001        movs	r0, #1
@   0x08007464: 76f0        strb	r0, [r6, #27]
@   0x08007466: 6177        str	r7, [r6, #20]
@   0x08007468: 9006        str	r0, [sp, #24]
@   0x0800746a: 2148        movs	r1, #72	@ 0x48
@   0x0800746c: 468c        mov	ip, r1
@   0x0800746e: 88f2        ldrh	r2, [r6, #6]
@   0x08007470: 0413        lsls	r3, r2, #16
@   0x08007472: 0c58        lsrs	r0, r3, #17
@   0x08007474: 8874        ldrh	r4, [r6, #2]
@   0x08007476: 1a20        subs	r0, r4, r0
@   0x08007478: 0400        lsls	r0, r0, #16
@   0x0800747a: 0c00        lsrs	r0, r0, #16
@   0x0800747c: 4649        mov	r1, r9
@   0x0800747e: 9a0a        ldr	r2, [sp, #40]	@ 0x28
@   0x08007480: 4011        ands	r1, r2
@   0x08007482: 4301        orrs	r1, r0
@   0x08007484: 910a        str	r1, [sp, #40]	@ 0x28
@   0x08007486: 88b4        ldrh	r4, [r6, #4]
@   0x08007488: 0420        lsls	r0, r4, #16
@   0x0800748a: 0c02        lsrs	r2, r0, #16
@   0x0800748c: 0c40        lsrs	r0, r0, #17
@   0x0800748e: 8834        ldrh	r4, [r6, #0]
@   0x08007490: 1a20        subs	r0, r4, r0
@   0x08007492: 3801        subs	r0, #1
@   0x08007494: 0400        lsls	r0, r0, #16
@   0x08007496: 4644        mov	r4, r8
@   0x08007498: 4021        ands	r1, r4
@   0x0800749a: 4301        orrs	r1, r0
@   0x0800749c: 910a        str	r1, [sp, #40]	@ 0x28
@   0x0800749e: 4648        mov	r0, r9
@   0x080074a0: 990b        ldr	r1, [sp, #44]	@ 0x2c
@   0x080074a2: 4008        ands	r0, r1
@   0x080074a4: 4310        orrs	r0, r2
@   0x080074a6: 900b        str	r0, [sp, #44]	@ 0x2c
@   0x080074a8: 4020        ands	r0, r4
@   0x080074aa: 4318        orrs	r0, r3
@   0x080074ac: 900b        str	r0, [sp, #44]	@ 0x2c
@   0x080074ae: 4662        mov	r2, ip
@   0x080074b0: 9200        str	r2, [sp, #0]
@   0x080074b2: 4809        ldr	r0, [pc, #36]	@ (0x74d8)
@   0x080074b4: 990a        ldr	r1, [sp, #40]	@ 0x28
@   0x080074b6: 9a0b        ldr	r2, [sp, #44]	@ 0x2c
@   0x080074b8: 2348        movs	r3, #72	@ 0x48
@   0x080074ba: f005        fd09 	bl	0xced0
@   0x080074be: 2800        cmp	r0, #0
@   0x080074c0: d100        bne.n	0x74c4
@   0x080074c2: e090        b.n	0x75e6
@   0x080074c4: 2d00        cmp	r5, #0
@   0x080074c6: d000        beq.n	0x74ca
@   0x080074c8: e08d        b.n	0x75e6
@   0x080074ca: 2007        movs	r0, #7
@   0x080074cc: f019        fc7a 	bl	0x20dc4
@   0x080074d0: e089        b.n	0x75e6
@   0x080074d2: 0000        movs	r0, r0
@   0x080074d4: 0ae8        lsrs	r0, r5, #11
@   0x080074d6: 080c        lsrs	r4, r1, #32
@   0x080074d8: 3720        adds	r7, #32
@   0x080074da: 0300        lsls	r0, r0, #12
@   0x080074dc: 6970        ldr	r0, [r6, #20]
@   0x080074de: 1a38        subs	r0, r7, r0
@   0x080074e0: 4653        mov	r3, sl
@   0x080074e2: 0059        lsls	r1, r3, #1
@   0x080074e4: 4451        add	r1, sl
@   0x080074e6: 0089        lsls	r1, r1, #2
@   0x080074e8: 4c08        ldr	r4, [pc, #32]	@ (0x750c)
@   0x080074ea: 190a        adds	r2, r1, r4
@   0x080074ec: 2108        movs	r1, #8
@   0x080074ee: 5651        ldrsb	r1, [r2, r1]
@   0x080074f0: 4288        cmp	r0, r1
@   0x080074f2: d978        bls.n	0x75e6
@   0x080074f4: 7e71        ldrb	r1, [r6, #25]
@   0x080074f6: 2006        movs	r0, #6
@   0x080074f8: 5610        ldrsb	r0, [r2, r0]
@   0x080074fa: 3801        subs	r0, #1
@   0x080074fc: 4281        cmp	r1, r0
@   0x080074fe: db07        blt.n	0x7510
@   0x08007500: 2002        movs	r0, #2
@   0x08007502: 76f0        strb	r0, [r6, #27]
@   0x08007504: 7990        ldrb	r0, [r2, #6]
@   0x08007506: 3801        subs	r0, #1
@   0x08007508: 7670        strb	r0, [r6, #25]
@   0x0800750a: e060        b.n	0x75ce
@   0x0800750c: 0ae8        lsrs	r0, r5, #11
@   0x0800750e: 080c        lsrs	r4, r1, #32
@   0x08007510: 1c48        adds	r0, r1, #1
@   0x08007512: e064        b.n	0x75de
@   0x08007514: 6970        ldr	r0, [r6, #20]
@   0x08007516: 1a38        subs	r0, r7, r0
@   0x08007518: 9a09        ldr	r2, [sp, #36]	@ 0x24
@   0x0800751a: 1615        asrs	r5, r2, #24
@   0x0800751c: 0069        lsls	r1, r5, #1
@   0x0800751e: 1949        adds	r1, r1, r5
@   0x08007520: 0089        lsls	r1, r1, #2
@   0x08007522: 4b1f        ldr	r3, [pc, #124]	@ (0x75a0)
@   0x08007524: 18c9        adds	r1, r1, r3
@   0x08007526: 7a49        ldrb	r1, [r1, #9]
@   0x08007528: 0609        lsls	r1, r1, #24
@   0x0800752a: 1609        asrs	r1, r1, #24
@   0x0800752c: 4288        cmp	r0, r1
@   0x0800752e: d95a        bls.n	0x75e6
@   0x08007530: 2003        movs	r0, #3
@   0x08007532: 76f0        strb	r0, [r6, #27]
@   0x08007534: 6177        str	r7, [r6, #20]
@   0x08007536: 2401        movs	r4, #1
@   0x08007538: 9406        str	r4, [sp, #24]
@   0x0800753a: 2048        movs	r0, #72	@ 0x48
@   0x0800753c: 4684        mov	ip, r0
@   0x0800753e: 88f1        ldrh	r1, [r6, #6]
@   0x08007540: 040b        lsls	r3, r1, #16
@   0x08007542: 0c58        lsrs	r0, r3, #17
@   0x08007544: 8872        ldrh	r2, [r6, #2]
@   0x08007546: 1a10        subs	r0, r2, r0
@   0x08007548: 0400        lsls	r0, r0, #16
@   0x0800754a: 0c00        lsrs	r0, r0, #16
@   0x0800754c: 4649        mov	r1, r9
@   0x0800754e: 9c0c        ldr	r4, [sp, #48]	@ 0x30
@   0x08007550: 4021        ands	r1, r4
@   0x08007552: 4301        orrs	r1, r0
@   0x08007554: 910c        str	r1, [sp, #48]	@ 0x30
@   0x08007556: 88b2        ldrh	r2, [r6, #4]
@   0x08007558: 0410        lsls	r0, r2, #16
@   0x0800755a: 0c02        lsrs	r2, r0, #16
@   0x0800755c: 0c40        lsrs	r0, r0, #17
@   0x0800755e: 8834        ldrh	r4, [r6, #0]
@   0x08007560: 1a20        subs	r0, r4, r0
@   0x08007562: 3801        subs	r0, #1
@   0x08007564: 0400        lsls	r0, r0, #16
@   0x08007566: 4644        mov	r4, r8
@   0x08007568: 4021        ands	r1, r4
@   0x0800756a: 4301        orrs	r1, r0
@   0x0800756c: 910c        str	r1, [sp, #48]	@ 0x30
@   0x0800756e: 4648        mov	r0, r9
@   0x08007570: 990d        ldr	r1, [sp, #52]	@ 0x34
@   0x08007572: 4008        ands	r0, r1
@   0x08007574: 4310        orrs	r0, r2
@   0x08007576: 900d        str	r0, [sp, #52]	@ 0x34
@   0x08007578: 4020        ands	r0, r4
@   0x0800757a: 4318        orrs	r0, r3
@   0x0800757c: 900d        str	r0, [sp, #52]	@ 0x34
@   0x0800757e: 4662        mov	r2, ip
@   0x08007580: 9200        str	r2, [sp, #0]
@   0x08007582: 4808        ldr	r0, [pc, #32]	@ (0x75a4)
@   0x08007584: 990c        ldr	r1, [sp, #48]	@ 0x30
@   0x08007586: 9a0d        ldr	r2, [sp, #52]	@ 0x34
@   0x08007588: 2348        movs	r3, #72	@ 0x48
@   0x0800758a: f005        fca1 	bl	0xced0
@   0x0800758e: 2800        cmp	r0, #0
@   0x08007590: d029        beq.n	0x75e6
@   0x08007592: 2d01        cmp	r5, #1
@   0x08007594: d127        bne.n	0x75e6
@   0x08007596: 2056        movs	r0, #86	@ 0x56
@   0x08007598: f019        fb6e 	bl	0x20c78
@   0x0800759c: e023        b.n	0x75e6
@   0x0800759e: 0000        movs	r0, r0
@   0x080075a0: 0ae8        lsrs	r0, r5, #11
@   0x080075a2: 080c        lsrs	r4, r1, #32
@   0x080075a4: 3720        adds	r7, #32
@   0x080075a6: 0300        lsls	r0, r0, #12
@   0x080075a8: 6970        ldr	r0, [r6, #20]
@   0x080075aa: 1a38        subs	r0, r7, r0
@   0x080075ac: 4653        mov	r3, sl
@   0x080075ae: 0059        lsls	r1, r3, #1
@   0x080075b0: 4451        add	r1, sl
@   0x080075b2: 0089        lsls	r1, r1, #2
@   0x080075b4: 4c08        ldr	r4, [pc, #32]	@ (0x75d8)
@   0x080075b6: 1909        adds	r1, r1, r4
@   0x080075b8: 7a09        ldrb	r1, [r1, #8]
@   0x080075ba: 0609        lsls	r1, r1, #24
@   0x080075bc: 1609        asrs	r1, r1, #24
@   0x080075be: 4288        cmp	r0, r1
@   0x080075c0: d911        bls.n	0x75e6
@   0x080075c2: 7e70        ldrb	r0, [r6, #25]
@   0x080075c4: 1c01        adds	r1, r0, #0
@   0x080075c6: 2900        cmp	r1, #0
@   0x080075c8: d108        bne.n	0x75dc
@   0x080075ca: 76f1        strb	r1, [r6, #27]
@   0x080075cc: 7671        strb	r1, [r6, #25]
@   0x080075ce: 6177        str	r7, [r6, #20]
@   0x080075d0: 2001        movs	r0, #1
@   0x080075d2: 9006        str	r0, [sp, #24]
@   0x080075d4: e007        b.n	0x75e6
@   0x080075d6: 0000        movs	r0, r0
@   0x080075d8: 0ae8        lsrs	r0, r5, #11
@   0x080075da: 080c        lsrs	r4, r1, #32
@   0x080075dc: 3801        subs	r0, #1
@   0x080075de: 7670        strb	r0, [r6, #25]
@   0x080075e0: 6177        str	r7, [r6, #20]
@   0x080075e2: 2101        movs	r1, #1
@   0x080075e4: 9106        str	r1, [sp, #24]
@   0x080075e6: 7ef2        ldrb	r2, [r6, #27]
@   0x080075e8: 2a02        cmp	r2, #2
@   0x080075ea: d103        bne.n	0x75f4
@   0x080075ec: 2004        movs	r0, #4
@   0x080075ee: 7eb3        ldrb	r3, [r6, #26]
@   0x080075f0: 4318        orrs	r0, r3
@   0x080075f2: e002        b.n	0x75fa
@   0x080075f4: 20fb        movs	r0, #251	@ 0xfb
@   0x080075f6: 7eb4        ldrb	r4, [r6, #26]
@   0x080075f8: 4020        ands	r0, r4
@   0x080075fa: 76b0        strb	r0, [r6, #26]
@   0x080075fc: 9806        ldr	r0, [sp, #24]
@   0x080075fe: 2801        cmp	r0, #1
@   0x08007600: d11c        bne.n	0x763c
@   0x08007602: 4651        mov	r1, sl
@   0x08007604: 004a        lsls	r2, r1, #1
@   0x08007606: 4452        add	r2, sl
@   0x08007608: 0092        lsls	r2, r2, #2
@   0x0800760a: 4b14        ldr	r3, [pc, #80]	@ (0x765c)
@   0x0800760c: 18d2        adds	r2, r2, r3
@   0x0800760e: 7810        ldrb	r0, [r2, #0]
@   0x08007610: 7951        ldrb	r1, [r2, #5]
@   0x08007612: 7912        ldrb	r2, [r2, #4]
@   0x08007614: 6a35        ldr	r5, [r6, #32]
@   0x08007616: 2300        movs	r3, #0
@   0x08007618: 5eec        ldrsh	r4, [r5, r3]
@   0x0800761a: 0063        lsls	r3, r4, #1
@   0x0800761c: 191b        adds	r3, r3, r4
@   0x0800761e: 041b        lsls	r3, r3, #16
@   0x08007620: 0c1b        lsrs	r3, r3, #16
@   0x08007622: 2402        movs	r4, #2
@   0x08007624: 5f2d        ldrsh	r5, [r5, r4]
@   0x08007626: 006c        lsls	r4, r5, #1
@   0x08007628: 1964        adds	r4, r4, r5
@   0x0800762a: 0424        lsls	r4, r4, #16
@   0x0800762c: 0c24        lsrs	r4, r4, #16
@   0x0800762e: 9400        str	r4, [sp, #0]
@   0x08007630: 9c04        ldr	r4, [sp, #16]
@   0x08007632: 9401        str	r4, [sp, #4]
@   0x08007634: 7e74        ldrb	r4, [r6, #25]
@   0x08007636: 9402        str	r4, [sp, #8]
@   0x08007638: f009        fe42 	bl	0x112c0
@   0x0800763c: 3624        adds	r6, #36	@ 0x24
@   0x0800763e: 9805        ldr	r0, [sp, #20]
@   0x08007640: 3001        adds	r0, #1
@   0x08007642: 9005        str	r0, [sp, #20]
@   0x08007644: 9903        ldr	r1, [sp, #12]
@   0x08007646: 4288        cmp	r0, r1
@   0x08007648: dc00        bgt.n	0x764c
@   0x0800764a: e6ae        b.n	0x73aa
@   0x0800764c: b00e        add	sp, #56	@ 0x38
@   0x0800764e: bc38        pop	{r3, r4, r5}
@   0x08007650: 4698        mov	r8, r3
@   0x08007652: 46a1        mov	r9, r4
@   0x08007654: 46aa        mov	sl, r5
@   0x08007656: bcf0        pop	{r4, r5, r6, r7}
@   0x08007658: bc01        pop	{r0}
@   0x0800765a: 4700        bx	r0
@   0x0800765c: 0ae8        lsrs	r0, r5, #11
@   0x0800765e: 080c        lsrs	r4, r1, #32

        thumb_func_start CollisionTable_CheckAndTriggerScript
CollisionTable_CheckAndTriggerScript: @ 0x0800736c
        .incbin "frog_us_baserom.gba", 0x736c, 0x2f4
        thumb_func_end CollisionTable_CheckAndTriggerScript
