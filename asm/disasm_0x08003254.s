@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003254, 0x0800336c)  (280 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003254 --end 0x800336c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003254: b570        push	{r4, r5, r6, lr}
@   0x08003256: 1c05        adds	r5, r0, #0
@   0x08003258: 2006        movs	r0, #6
@   0x0800325a: f004        fa01 	bl	0x7660
@   0x0800325e: f004        fdb7 	bl	0x7dd0
@   0x08003262: 4804        ldr	r0, [pc, #16]	@ (0x3274)
@   0x08003264: 6900        ldr	r0, [r0, #16]
@   0x08003266: 2800        cmp	r0, #0
@   0x08003268: d106        bne.n	0x3278
@   0x0800326a: 2018        movs	r0, #24
@   0x0800326c: 2118        movs	r1, #24
@   0x0800326e: f004        fb65 	bl	0x793c
@   0x08003272: e006        b.n	0x3282
@   0x08003274: 6110        str	r0, [r2, #16]
@   0x08003276: 0300        lsls	r0, r0, #12
@   0x08003278: 2802        cmp	r0, #2
@   0x0800327a: d102        bne.n	0x3282
@   0x0800327c: 2002        movs	r0, #2
@   0x0800327e: f7ff        ffa9 	bl	0x31d4
@   0x08003282: f004        ff77 	bl	0x8174
@   0x08003286: f005        ff13 	bl	0x90b0
@   0x0800328a: f007        f921 	bl	0xa4d0
@   0x0800328e: 4909        ldr	r1, [pc, #36]	@ (0x32b4)
@   0x08003290: 4c09        ldr	r4, [pc, #36]	@ (0x32b8)
@   0x08003292: 7aa2        ldrb	r2, [r4, #10]
@   0x08003294: 0090        lsls	r0, r2, #2
@   0x08003296: 1840        adds	r0, r0, r1
@   0x08003298: 6800        ldr	r0, [r0, #0]
@   0x0800329a: f030        fd1d 	bl	0x33cd8
@   0x0800329e: 4807        ldr	r0, [pc, #28]	@ (0x32bc)
@   0x080032a0: 6900        ldr	r0, [r0, #16]
@   0x080032a2: 2800        cmp	r0, #0
@   0x080032a4: d10e        bne.n	0x32c4
@   0x080032a6: 4806        ldr	r0, [pc, #24]	@ (0x32c0)
@   0x080032a8: 7aa4        ldrb	r4, [r4, #10]
@   0x080032aa: 1820        adds	r0, r4, r0
@   0x080032ac: 7800        ldrb	r0, [r0, #0]
@   0x080032ae: f00b        ffcd 	bl	0xf24c
@   0x080032b2: e010        b.n	0x32d6
@   0x080032b4: 0cb8        lsrs	r0, r7, #18
@   0x080032b6: 080c        lsrs	r4, r1, #32
@   0x080032b8: 5330        strh	r0, [r6, r4]
@   0x080032ba: 0300        lsls	r0, r0, #12
@   0x080032bc: 6110        str	r0, [r2, #16]
@   0x080032be: 0300        lsls	r0, r0, #12
@   0x080032c0: 0d84        lsrs	r4, r0, #22
@   0x080032c2: 080c        lsrs	r4, r1, #32
@   0x080032c4: 4823        ldr	r0, [pc, #140]	@ (0x3354)
@   0x080032c6: 7aa4        ldrb	r4, [r4, #10]
@   0x080032c8: 1820        adds	r0, r4, r0
@   0x080032ca: 7800        ldrb	r0, [r0, #0]
@   0x080032cc: 0600        lsls	r0, r0, #24
@   0x080032ce: 1600        asrs	r0, r0, #24
@   0x080032d0: 1c29        adds	r1, r5, #0
@   0x080032d2: f7ff        fe09 	bl	0x2ee8
@   0x080032d6: 4920        ldr	r1, [pc, #128]	@ (0x3358)
@   0x080032d8: 4d20        ldr	r5, [pc, #128]	@ (0x335c)
@   0x080032da: 7aab        ldrb	r3, [r5, #10]
@   0x080032dc: 0098        lsls	r0, r3, #2
@   0x080032de: 1840        adds	r0, r0, r1
@   0x080032e0: 6800        ldr	r0, [r0, #0]
@   0x080032e2: f030        fcf9 	bl	0x33cd8
@   0x080032e6: f006        fbb7 	bl	0x9a58
@   0x080032ea: f005        ff4d 	bl	0x9188
@   0x080032ee: f7fd        faf5 	bl	0x8dc
@   0x080032f2: f007        f819 	bl	0xa328
@   0x080032f6: f006        f8ff 	bl	0x94f8
@   0x080032fa: f006        fb43 	bl	0x9984
@   0x080032fe: 4918        ldr	r1, [pc, #96]	@ (0x3360)
@   0x08003300: 2004        movs	r0, #4
@   0x08003302: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08003304: 4008        ands	r0, r1
@   0x08003306: 2800        cmp	r0, #0
@   0x08003308: d11d        bne.n	0x3346
@   0x0800330a: 4816        ldr	r0, [pc, #88]	@ (0x3364)
@   0x0800330c: 6900        ldr	r0, [r0, #16]
@   0x0800330e: 2802        cmp	r0, #2
@   0x08003310: d119        bne.n	0x3346
@   0x08003312: 4c15        ldr	r4, [pc, #84]	@ (0x3368)
@   0x08003314: 7e20        ldrb	r0, [r4, #24]
@   0x08003316: 7e61        ldrb	r1, [r4, #25]
@   0x08003318: 2608        movs	r6, #8
@   0x0800331a: 5fa2        ldrsh	r2, [r4, r6]
@   0x0800331c: 260a        movs	r6, #10
@   0x0800331e: 5fa3        ldrsh	r3, [r4, r6]
@   0x08003320: f009        fd32 	bl	0xcd88
@   0x08003324: 0600        lsls	r0, r0, #24
@   0x08003326: 0e01        lsrs	r1, r0, #24
@   0x08003328: 2001        movs	r0, #1
@   0x0800332a: 7c2d        ldrb	r5, [r5, #16]
@   0x0800332c: 4028        ands	r0, r5
@   0x0800332e: 2800        cmp	r0, #0
@   0x08003330: d109        bne.n	0x3346
@   0x08003332: 2902        cmp	r1, #2
@   0x08003334: d107        bne.n	0x3346
@   0x08003336: 1c20        adds	r0, r4, #0
@   0x08003338: 2180        movs	r1, #128	@ 0x80
@   0x0800333a: 00c9        lsls	r1, r1, #3
@   0x0800333c: f003        fc24 	bl	0x6b88
@   0x08003340: 205d        movs	r0, #93	@ 0x5d
@   0x08003342: f01d        fc99 	bl	0x20c78
@   0x08003346: 4905        ldr	r1, [pc, #20]	@ (0x335c)
@   0x08003348: 6948        ldr	r0, [r1, #20]
@   0x0800334a: 3001        adds	r0, #1
@   0x0800334c: 6148        str	r0, [r1, #20]
@   0x0800334e: bc70        pop	{r4, r5, r6}
@   0x08003350: bc01        pop	{r0}
@   0x08003352: 4700        bx	r0
@   0x08003354: 0d84        lsrs	r4, r0, #22
@   0x08003356: 080c        lsrs	r4, r1, #32
@   0x08003358: 0d40        lsrs	r0, r0, #21
@   0x0800335a: 080c        lsrs	r4, r1, #32
@   0x0800335c: 5330        strh	r0, [r6, r4]
@   0x0800335e: 0300        lsls	r0, r0, #12
@   0x08003360: 3720        adds	r7, #32
@   0x08003362: 0300        lsls	r0, r0, #12
@   0x08003364: 6110        str	r0, [r2, #16]
@   0x08003366: 0300        lsls	r0, r0, #12
@   0x08003368: 35e0        adds	r5, #224	@ 0xe0
@   0x0800336a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08003254
sub_08003254: @ 0x08003254
        .incbin "frog_us_baserom.gba", 0x3254, 0x118
        thumb_func_end sub_08003254
