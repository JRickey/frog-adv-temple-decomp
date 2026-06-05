@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08034150, 0x080342cc)  (380 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8034150 --end 0x80342cc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08034150: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08034152: 4647        mov	r7, r8
@   0x08034154: b480        push	{r7}
@   0x08034156: 1c06        adds	r6, r0, #0
@   0x08034158: 1c0f        adds	r7, r1, #0
@   0x0803415a: 1c15        adds	r5, r2, #0
@   0x0803415c: 2000        movs	r0, #0
@   0x0803415e: 6832        ldr	r2, [r6, #0]
@   0x08034160: 2a01        cmp	r2, #1
@   0x08034162: d800        bhi.n	0x34166
@   0x08034164: 2001        movs	r0, #1
@   0x08034166: 2800        cmp	r0, #0
@   0x08034168: d001        beq.n	0x3416e
@   0x0803416a: 1c30        adds	r0, r6, #0
@   0x0803416c: e0aa        b.n	0x342c4
@   0x0803416e: 2100        movs	r1, #0
@   0x08034170: 6838        ldr	r0, [r7, #0]
@   0x08034172: 2801        cmp	r0, #1
@   0x08034174: d800        bhi.n	0x34178
@   0x08034176: 2101        movs	r1, #1
@   0x08034178: 2900        cmp	r1, #0
@   0x0803417a: d137        bne.n	0x341ec
@   0x0803417c: 2100        movs	r1, #0
@   0x0803417e: 2a04        cmp	r2, #4
@   0x08034180: d100        bne.n	0x34184
@   0x08034182: 2101        movs	r1, #1
@   0x08034184: 2900        cmp	r1, #0
@   0x08034186: d00d        beq.n	0x341a4
@   0x08034188: 2100        movs	r1, #0
@   0x0803418a: 2804        cmp	r0, #4
@   0x0803418c: d100        bne.n	0x34190
@   0x0803418e: 2101        movs	r1, #1
@   0x08034190: 2900        cmp	r1, #0
@   0x08034192: d0ea        beq.n	0x3416a
@   0x08034194: 6871        ldr	r1, [r6, #4]
@   0x08034196: 6878        ldr	r0, [r7, #4]
@   0x08034198: 4281        cmp	r1, r0
@   0x0803419a: d0e6        beq.n	0x3416a
@   0x0803419c: 4800        ldr	r0, [pc, #0]	@ (0x341a0)
@   0x0803419e: e091        b.n	0x342c4
@   0x080341a0: 3440        adds	r4, #64	@ 0x40
@   0x080341a2: 0300        lsls	r0, r0, #12
@   0x080341a4: 2100        movs	r1, #0
@   0x080341a6: 2804        cmp	r0, #4
@   0x080341a8: d100        bne.n	0x341ac
@   0x080341aa: 2101        movs	r1, #1
@   0x080341ac: 2900        cmp	r1, #0
@   0x080341ae: d11d        bne.n	0x341ec
@   0x080341b0: 2100        movs	r1, #0
@   0x080341b2: 2802        cmp	r0, #2
@   0x080341b4: d100        bne.n	0x341b8
@   0x080341b6: 2101        movs	r1, #1
@   0x080341b8: 2900        cmp	r1, #0
@   0x080341ba: d010        beq.n	0x341de
@   0x080341bc: 2000        movs	r0, #0
@   0x080341be: 2a02        cmp	r2, #2
@   0x080341c0: d100        bne.n	0x341c4
@   0x080341c2: 2001        movs	r0, #1
@   0x080341c4: 2800        cmp	r0, #0
@   0x080341c6: d0d0        beq.n	0x3416a
@   0x080341c8: 1c29        adds	r1, r5, #0
@   0x080341ca: 1c30        adds	r0, r6, #0
@   0x080341cc: c81c        ldmia	r0!, {r2, r3, r4}
@   0x080341ce: c11c        stmia	r1!, {r2, r3, r4}
@   0x080341d0: 6800        ldr	r0, [r0, #0]
@   0x080341d2: 6008        str	r0, [r1, #0]
@   0x080341d4: 6870        ldr	r0, [r6, #4]
@   0x080341d6: 6879        ldr	r1, [r7, #4]
@   0x080341d8: 4008        ands	r0, r1
@   0x080341da: 6068        str	r0, [r5, #4]
@   0x080341dc: e071        b.n	0x342c2
@   0x080341de: 2100        movs	r1, #0
@   0x080341e0: 6830        ldr	r0, [r6, #0]
@   0x080341e2: 2802        cmp	r0, #2
@   0x080341e4: d100        bne.n	0x341e8
@   0x080341e6: 2101        movs	r1, #1
@   0x080341e8: 2900        cmp	r1, #0
@   0x080341ea: d001        beq.n	0x341f0
@   0x080341ec: 1c38        adds	r0, r7, #0
@   0x080341ee: e069        b.n	0x342c4
@   0x080341f0: 68b1        ldr	r1, [r6, #8]
@   0x080341f2: 68bb        ldr	r3, [r7, #8]
@   0x080341f4: 68f2        ldr	r2, [r6, #12]
@   0x080341f6: 68fc        ldr	r4, [r7, #12]
@   0x080341f8: 1ac8        subs	r0, r1, r3
@   0x080341fa: 2800        cmp	r0, #0
@   0x080341fc: da00        bge.n	0x34200
@   0x080341fe: 4240        negs	r0, r0
@   0x08034200: 281f        cmp	r0, #31
@   0x08034202: dc1f        bgt.n	0x34244
@   0x08034204: 6876        ldr	r6, [r6, #4]
@   0x08034206: 687f        ldr	r7, [r7, #4]
@   0x08034208: 46b8        mov	r8, r7
@   0x0803420a: 4299        cmp	r1, r3
@   0x0803420c: dd0b        ble.n	0x34226
@   0x0803420e: 2701        movs	r7, #1
@   0x08034210: 46bc        mov	ip, r7
@   0x08034212: 1acb        subs	r3, r1, r3
@   0x08034214: 3b01        subs	r3, #1
@   0x08034216: 1c20        adds	r0, r4, #0
@   0x08034218: 4667        mov	r7, ip
@   0x0803421a: 4038        ands	r0, r7
@   0x0803421c: 0864        lsrs	r4, r4, #1
@   0x0803421e: 4304        orrs	r4, r0
@   0x08034220: 2b00        cmp	r3, #0
@   0x08034222: d1f7        bne.n	0x34214
@   0x08034224: 1c0b        adds	r3, r1, #0
@   0x08034226: 428b        cmp	r3, r1
@   0x08034228: dd15        ble.n	0x34256
@   0x0803422a: 2001        movs	r0, #1
@   0x0803422c: 4684        mov	ip, r0
@   0x0803422e: 1a59        subs	r1, r3, r1
@   0x08034230: 3901        subs	r1, #1
@   0x08034232: 1c10        adds	r0, r2, #0
@   0x08034234: 4667        mov	r7, ip
@   0x08034236: 4038        ands	r0, r7
@   0x08034238: 0852        lsrs	r2, r2, #1
@   0x0803423a: 4302        orrs	r2, r0
@   0x0803423c: 2900        cmp	r1, #0
@   0x0803423e: d1f7        bne.n	0x34230
@   0x08034240: 1c19        adds	r1, r3, #0
@   0x08034242: e008        b.n	0x34256
@   0x08034244: 4299        cmp	r1, r3
@   0x08034246: dd01        ble.n	0x3424c
@   0x08034248: 2400        movs	r4, #0
@   0x0803424a: e001        b.n	0x34250
@   0x0803424c: 1c19        adds	r1, r3, #0
@   0x0803424e: 2200        movs	r2, #0
@   0x08034250: 6876        ldr	r6, [r6, #4]
@   0x08034252: 687f        ldr	r7, [r7, #4]
@   0x08034254: 46b8        mov	r8, r7
@   0x08034256: 4546        cmp	r6, r8
@   0x08034258: d022        beq.n	0x342a0
@   0x0803425a: 2e00        cmp	r6, #0
@   0x0803425c: d001        beq.n	0x34262
@   0x0803425e: 1aa3        subs	r3, r4, r2
@   0x08034260: e000        b.n	0x34264
@   0x08034262: 1b13        subs	r3, r2, r4
@   0x08034264: 2b00        cmp	r3, #0
@   0x08034266: db04        blt.n	0x34272
@   0x08034268: 2000        movs	r0, #0
@   0x0803426a: 6068        str	r0, [r5, #4]
@   0x0803426c: 60a9        str	r1, [r5, #8]
@   0x0803426e: 60eb        str	r3, [r5, #12]
@   0x08034270: e004        b.n	0x3427c
@   0x08034272: 2001        movs	r0, #1
@   0x08034274: 6068        str	r0, [r5, #4]
@   0x08034276: 60a9        str	r1, [r5, #8]
@   0x08034278: 4258        negs	r0, r3
@   0x0803427a: 60e8        str	r0, [r5, #12]
@   0x0803427c: 68e9        ldr	r1, [r5, #12]
@   0x0803427e: 1e48        subs	r0, r1, #1
@   0x08034280: 4a06        ldr	r2, [pc, #24]	@ (0x3429c)
@   0x08034282: 4290        cmp	r0, r2
@   0x08034284: d810        bhi.n	0x342a8
@   0x08034286: 0048        lsls	r0, r1, #1
@   0x08034288: 60e8        str	r0, [r5, #12]
@   0x0803428a: 68a9        ldr	r1, [r5, #8]
@   0x0803428c: 3901        subs	r1, #1
@   0x0803428e: 60a9        str	r1, [r5, #8]
@   0x08034290: 1c01        adds	r1, r0, #0
@   0x08034292: 1e48        subs	r0, r1, #1
@   0x08034294: 4290        cmp	r0, r2
@   0x08034296: d9f6        bls.n	0x34286
@   0x08034298: e006        b.n	0x342a8
@   0x0803429a: 0000        movs	r0, r0
@   0x0803429c: fffe        3fff 			@ <UNDEFINED> instruction: 0xfffe3fff
@   0x080342a0: 606e        str	r6, [r5, #4]
@   0x080342a2: 60a9        str	r1, [r5, #8]
@   0x080342a4: 1910        adds	r0, r2, r4
@   0x080342a6: 60e8        str	r0, [r5, #12]
@   0x080342a8: 2003        movs	r0, #3
@   0x080342aa: 6028        str	r0, [r5, #0]
@   0x080342ac: 68e9        ldr	r1, [r5, #12]
@   0x080342ae: 2900        cmp	r1, #0
@   0x080342b0: da07        bge.n	0x342c2
@   0x080342b2: 2001        movs	r0, #1
@   0x080342b4: 4008        ands	r0, r1
@   0x080342b6: 0849        lsrs	r1, r1, #1
@   0x080342b8: 4308        orrs	r0, r1
@   0x080342ba: 60e8        str	r0, [r5, #12]
@   0x080342bc: 68a8        ldr	r0, [r5, #8]
@   0x080342be: 3001        adds	r0, #1
@   0x080342c0: 60a8        str	r0, [r5, #8]
@   0x080342c2: 1c28        adds	r0, r5, #0
@   0x080342c4: bc08        pop	{r3}
@   0x080342c6: 4698        mov	r8, r3
@   0x080342c8: bdf0        pop	{r4, r5, r6, r7, pc}

        thumb_func_start sub_08034150
sub_08034150: @ 0x08034150
        .incbin "frog_us_baserom.gba", 0x34150, 0x17c
        thumb_func_end sub_08034150
