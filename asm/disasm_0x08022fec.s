@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022fec, 0x080231f4)  (520 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022fec --end 0x80231f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022fec: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08022fee: 464f        mov	r7, r9
@   0x08022ff0: 4646        mov	r6, r8
@   0x08022ff2: b4c0        push	{r6, r7}
@   0x08022ff4: b084        sub	sp, #16
@   0x08022ff6: 4a0e        ldr	r2, [pc, #56]	@ (0x23030)
@   0x08022ff8: 2004        movs	r0, #4
@   0x08022ffa: 5e11        ldrsh	r1, [r2, r0]
@   0x08022ffc: 20cc        movs	r0, #204	@ 0xcc
@   0x08022ffe: 0040        lsls	r0, r0, #1
@   0x08023000: 4281        cmp	r1, r0
@   0x08023002: dd04        ble.n	0x2300e
@   0x08023004: 2102        movs	r1, #2
@   0x08023006: 5e50        ldrsh	r0, [r2, r1]
@   0x08023008: 28f0        cmp	r0, #240	@ 0xf0
@   0x0802300a: dd00        ble.n	0x2300e
@   0x0802300c: e0eb        b.n	0x231e6
@   0x0802300e: 2500        movs	r5, #0
@   0x08023010: 1c17        adds	r7, r2, #0
@   0x08023012: 2202        movs	r2, #2
@   0x08023014: 4690        mov	r8, r2
@   0x08023016: 1c29        adds	r1, r5, #0
@   0x08023018: 315b        adds	r1, #91	@ 0x5b
@   0x0802301a: 00c8        lsls	r0, r1, #3
@   0x0802301c: 1a40        subs	r0, r0, r1
@   0x0802301e: 00c0        lsls	r0, r0, #3
@   0x08023020: 19c2        adds	r2, r0, r7
@   0x08023022: 7e90        ldrb	r0, [r2, #26]
@   0x08023024: 1c0e        adds	r6, r1, #0
@   0x08023026: 2800        cmp	r0, #0
@   0x08023028: d004        beq.n	0x23034
@   0x0802302a: 2801        cmp	r0, #1
@   0x0802302c: d018        beq.n	0x23060
@   0x0802302e: e051        b.n	0x230d4
@   0x08023030: 3720        adds	r7, #32
@   0x08023032: 0300        lsls	r0, r0, #12
@   0x08023034: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08023036: 2302        movs	r3, #2
@   0x08023038: 4640        mov	r0, r8
@   0x0802303a: 4008        ands	r0, r1
@   0x0802303c: 2800        cmp	r0, #0
@   0x0802303e: d149        bne.n	0x230d4
@   0x08023040: 2480        movs	r4, #128	@ 0x80
@   0x08023042: 0224        lsls	r4, r4, #8
@   0x08023044: 1c20        adds	r0, r4, #0
@   0x08023046: 4008        ands	r0, r1
@   0x08023048: 2800        cmp	r0, #0
@   0x0802304a: d043        beq.n	0x230d4
@   0x0802304c: 1c18        adds	r0, r3, #0
@   0x0802304e: 4308        orrs	r0, r1
@   0x08023050: 4b02        ldr	r3, [pc, #8]	@ (0x2305c)
@   0x08023052: 1c19        adds	r1, r3, #0
@   0x08023054: 4008        ands	r0, r1
@   0x08023056: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08023058: e03c        b.n	0x230d4
@   0x0802305a: 0000        movs	r0, r0
@   0x0802305c: 7fff        ldrb	r7, [r7, #31]
@   0x0802305e: 0000        movs	r0, r0
@   0x08023060: 4640        mov	r0, r8
@   0x08023062: 8e94        ldrh	r4, [r2, #52]	@ 0x34
@   0x08023064: 4020        ands	r0, r4
@   0x08023066: 2800        cmp	r0, #0
@   0x08023068: d134        bne.n	0x230d4
@   0x0802306a: 7ed1        ldrb	r1, [r2, #27]
@   0x0802306c: 7f10        ldrb	r0, [r2, #28]
@   0x0802306e: 3802        subs	r0, #2
@   0x08023070: 4281        cmp	r1, r0
@   0x08023072: d11f        bne.n	0x230b4
@   0x08023074: 2d01        cmp	r5, #1
@   0x08023076: d107        bne.n	0x23088
@   0x08023078: 21a1        movs	r1, #161	@ 0xa1
@   0x0802307a: 0149        lsls	r1, r1, #5
@   0x0802307c: 1878        adds	r0, r7, r1
@   0x0802307e: 2113        movs	r1, #19
@   0x08023080: 2203        movs	r2, #3
@   0x08023082: 2303        movs	r3, #3
@   0x08023084: f7fd        fe2a 	bl	0x20cdc
@   0x08023088: 1c2c        adds	r4, r5, #0
@   0x0802308a: 345d        adds	r4, #93	@ 0x5d
@   0x0802308c: 493c        ldr	r1, [pc, #240]	@ (0x23180)
@   0x0802308e: 00a8        lsls	r0, r5, #2
@   0x08023090: 1840        adds	r0, r0, r1
@   0x08023092: 6801        ldr	r1, [r0, #0]
@   0x08023094: 483b        ldr	r0, [pc, #236]	@ (0x23184)
@   0x08023096: 9000        str	r0, [sp, #0]
@   0x08023098: 200c        movs	r0, #12
@   0x0802309a: 9001        str	r0, [sp, #4]
@   0x0802309c: 2003        movs	r0, #3
@   0x0802309e: 9002        str	r0, [sp, #8]
@   0x080230a0: 9003        str	r0, [sp, #12]
@   0x080230a2: 1c20        adds	r0, r4, #0
@   0x080230a4: 2210        movs	r2, #16
@   0x080230a6: 2318        movs	r3, #24
@   0x080230a8: f7fd        fffa 	bl	0x210a0
@   0x080230ac: 4836        ldr	r0, [pc, #216]	@ (0x23188)
@   0x080230ae: 1c21        adds	r1, r4, #0
@   0x080230b0: f7e3        fc5c 	bl	0x696c
@   0x080230b4: 00f0        lsls	r0, r6, #3
@   0x080230b6: 1b80        subs	r0, r0, r6
@   0x080230b8: 00c0        lsls	r0, r0, #3
@   0x080230ba: 19c1        adds	r1, r0, r7
@   0x080230bc: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x080230be: 2380        movs	r3, #128	@ 0x80
@   0x080230c0: 021b        lsls	r3, r3, #8
@   0x080230c2: 1c18        adds	r0, r3, #0
@   0x080230c4: 4010        ands	r0, r2
@   0x080230c6: 2800        cmp	r0, #0
@   0x080230c8: d004        beq.n	0x230d4
@   0x080230ca: 2000        movs	r0, #0
@   0x080230cc: 7688        strb	r0, [r1, #26]
@   0x080230ce: 4640        mov	r0, r8
@   0x080230d0: 4310        orrs	r0, r2
@   0x080230d2: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x080230d4: 1c68        adds	r0, r5, #1
@   0x080230d6: 0600        lsls	r0, r0, #24
@   0x080230d8: 0e05        lsrs	r5, r0, #24
@   0x080230da: 2d01        cmp	r5, #1
@   0x080230dc: d99b        bls.n	0x23016
@   0x080230de: 205b        movs	r0, #91	@ 0x5b
@   0x080230e0: 215c        movs	r1, #92	@ 0x5c
@   0x080230e2: f7e2        fe15 	bl	0x5d10
@   0x080230e6: 2500        movs	r5, #0
@   0x080230e8: 4f28        ldr	r7, [pc, #160]	@ (0x2318c)
@   0x080230ea: 2408        movs	r4, #8
@   0x080230ec: 46a1        mov	r9, r4
@   0x080230ee: 2002        movs	r0, #2
@   0x080230f0: 4680        mov	r8, r0
@   0x080230f2: 1c28        adds	r0, r5, #0
@   0x080230f4: 305d        adds	r0, #93	@ 0x5d
@   0x080230f6: 00c1        lsls	r1, r0, #3
@   0x080230f8: 1a09        subs	r1, r1, r0
@   0x080230fa: 00c9        lsls	r1, r1, #3
@   0x080230fc: 19ca        adds	r2, r1, r7
@   0x080230fe: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x08023100: 2108        movs	r1, #8
@   0x08023102: 4019        ands	r1, r3
@   0x08023104: 1c06        adds	r6, r0, #0
@   0x08023106: 2900        cmp	r1, #0
@   0x08023108: d160        bne.n	0x231cc
@   0x0802310a: 7e90        ldrb	r0, [r2, #26]
@   0x0802310c: 2800        cmp	r0, #0
@   0x0802310e: d043        beq.n	0x23198
@   0x08023110: 2804        cmp	r0, #4
@   0x08023112: d15b        bne.n	0x231cc
@   0x08023114: 2102        movs	r1, #2
@   0x08023116: 468c        mov	ip, r1
@   0x08023118: 4640        mov	r0, r8
@   0x0802311a: 4018        ands	r0, r3
@   0x0802311c: 0400        lsls	r0, r0, #16
@   0x0802311e: 0c01        lsrs	r1, r0, #16
@   0x08023120: 2900        cmp	r1, #0
@   0x08023122: d153        bne.n	0x231cc
@   0x08023124: 2402        movs	r4, #2
@   0x08023126: 5f10        ldrsh	r0, [r2, r4]
@   0x08023128: 2886        cmp	r0, #134	@ 0x86
@   0x0802312a: dd18        ble.n	0x2315e
@   0x0802312c: 7691        strb	r1, [r2, #26]
@   0x0802312e: 4660        mov	r0, ip
@   0x08023130: 4318        orrs	r0, r3
@   0x08023132: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08023134: 00e8        lsls	r0, r5, #3
@   0x08023136: 1b40        subs	r0, r0, r5
@   0x08023138: 00c0        lsls	r0, r0, #3
@   0x0802313a: 4a15        ldr	r2, [pc, #84]	@ (0x23190)
@   0x0802313c: 18b9        adds	r1, r7, r2
@   0x0802313e: 1840        adds	r0, r0, r1
@   0x08023140: 2100        movs	r1, #0
@   0x08023142: 2200        movs	r2, #0
@   0x08023144: 2300        movs	r3, #0
@   0x08023146: f7e7        fa1b 	bl	0xa580
@   0x0802314a: 2d01        cmp	r5, #1
@   0x0802314c: d107        bne.n	0x2315e
@   0x0802314e: 23a1        movs	r3, #161	@ 0xa1
@   0x08023150: 015b        lsls	r3, r3, #5
@   0x08023152: 18f8        adds	r0, r7, r3
@   0x08023154: 215e        movs	r1, #94	@ 0x5e
@   0x08023156: 2203        movs	r2, #3
@   0x08023158: 2303        movs	r3, #3
@   0x0802315a: f7fd        fdbf 	bl	0x20cdc
@   0x0802315e: 00f0        lsls	r0, r6, #3
@   0x08023160: 1b80        subs	r0, r0, r6
@   0x08023162: 00c0        lsls	r0, r0, #3
@   0x08023164: 19c2        adds	r2, r0, r7
@   0x08023166: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08023168: 2480        movs	r4, #128	@ 0x80
@   0x0802316a: 0224        lsls	r4, r4, #8
@   0x0802316c: 1c20        adds	r0, r4, #0
@   0x0802316e: 4008        ands	r0, r1
@   0x08023170: 2800        cmp	r0, #0
@   0x08023172: d02b        beq.n	0x231cc
@   0x08023174: 4640        mov	r0, r8
@   0x08023176: 4308        orrs	r0, r1
@   0x08023178: 4b06        ldr	r3, [pc, #24]	@ (0x23194)
@   0x0802317a: 1c19        adds	r1, r3, #0
@   0x0802317c: 4008        ands	r0, r1
@   0x0802317e: e024        b.n	0x231ca
@   0x08023180: 1f28        subs	r0, r5, #4
@   0x08023182: 0831        lsrs	r1, r6, #32
@   0x08023184: 0211        lsls	r1, r2, #8
@   0x08023186: 0000        movs	r0, r0
@   0x08023188: 6110        str	r0, [r2, #16]
@   0x0802318a: 0300        lsls	r0, r0, #12
@   0x0802318c: 3720        adds	r7, #32
@   0x0802318e: 0300        lsls	r0, r0, #12
@   0x08023190: 1458        asrs	r0, r3, #17
@   0x08023192: 0000        movs	r0, r0
@   0x08023194: 7fff        ldrb	r7, [r7, #31]
@   0x08023196: 0000        movs	r0, r0
@   0x08023198: 2402        movs	r4, #2
@   0x0802319a: 4640        mov	r0, r8
@   0x0802319c: 4018        ands	r0, r3
@   0x0802319e: 2800        cmp	r0, #0
@   0x080231a0: d114        bne.n	0x231cc
@   0x080231a2: 2180        movs	r1, #128	@ 0x80
@   0x080231a4: 0209        lsls	r1, r1, #8
@   0x080231a6: 1c08        adds	r0, r1, #0
@   0x080231a8: 4018        ands	r0, r3
@   0x080231aa: 2800        cmp	r0, #0
@   0x080231ac: d00e        beq.n	0x231cc
@   0x080231ae: 1c29        adds	r1, r5, #0
@   0x080231b0: 315b        adds	r1, #91	@ 0x5b
@   0x080231b2: 00c8        lsls	r0, r1, #3
@   0x080231b4: 1a40        subs	r0, r0, r1
@   0x080231b6: 00c0        lsls	r0, r0, #3
@   0x080231b8: 19c0        adds	r0, r0, r7
@   0x080231ba: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x080231bc: 4321        orrs	r1, r4
@   0x080231be: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080231c0: 2101        movs	r1, #1
@   0x080231c2: 7681        strb	r1, [r0, #26]
@   0x080231c4: 4648        mov	r0, r9
@   0x080231c6: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x080231c8: 4318        orrs	r0, r3
@   0x080231ca: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x080231cc: 1c68        adds	r0, r5, #1
@   0x080231ce: 0600        lsls	r0, r0, #24
@   0x080231d0: 0e05        lsrs	r5, r0, #24
@   0x080231d2: 2d01        cmp	r5, #1
@   0x080231d4: d98d        bls.n	0x230f2
@   0x080231d6: 205d        movs	r0, #93	@ 0x5d
@   0x080231d8: 215e        movs	r1, #94	@ 0x5e
@   0x080231da: f7fd        ff03 	bl	0x20fe4
@   0x080231de: 205d        movs	r0, #93	@ 0x5d
@   0x080231e0: 215e        movs	r1, #94	@ 0x5e
@   0x080231e2: f7e2        fd95 	bl	0x5d10
@   0x080231e6: b004        add	sp, #16
@   0x080231e8: bc18        pop	{r3, r4}
@   0x080231ea: 4698        mov	r8, r3
@   0x080231ec: 46a1        mov	r9, r4
@   0x080231ee: bcf0        pop	{r4, r5, r6, r7}
@   0x080231f0: bc01        pop	{r0}
@   0x080231f2: 4700        bx	r0

        thumb_func_start UpdateLogPairEntities2
UpdateLogPairEntities2: @ 0x08022fec
        .incbin "frog_us_baserom.gba", 0x22fec, 0x208
        thumb_func_end UpdateLogPairEntities2
