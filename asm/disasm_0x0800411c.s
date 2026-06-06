@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800411c, 0x0800441c)  (768 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800411c --end 0x800441c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800411c: b570        push	{r4, r5, r6, lr}
@   0x0800411e: 4c03        ldr	r4, [pc, #12]	@ (0x412c)
@   0x08004120: 44a5        add	sp, r4
@   0x08004122: 4803        ldr	r0, [pc, #12]	@ (0x4130)
@   0x08004124: 4468        add	r0, sp
@   0x08004126: 2100        movs	r1, #0
@   0x08004128: 7001        strb	r1, [r0, #0]
@   0x0800412a: e167        b.n	0x43fc
@   0x0800412c: fc34        ffff 			@ <UNDEFINED> instruction: 0xfc34ffff
@   0x08004130: 03b9        lsls	r1, r7, #14
@   0x08004132: 0000        movs	r0, r0
@   0x08004134: f01c        fd44 	bl	0x20bc0
@   0x08004138: 4805        ldr	r0, [pc, #20]	@ (0x4150)
@   0x0800413a: 4468        add	r0, sp
@   0x0800413c: 7800        ldrb	r0, [r0, #0]
@   0x0800413e: 2808        cmp	r0, #8
@   0x08004140: d900        bls.n	0x4144
@   0x08004142: e15b        b.n	0x43fc
@   0x08004144: 0080        lsls	r0, r0, #2
@   0x08004146: 4903        ldr	r1, [pc, #12]	@ (0x4154)
@   0x08004148: 1840        adds	r0, r0, r1
@   0x0800414a: 6800        ldr	r0, [r0, #0]
@   0x0800414c: 4687        mov	pc, r0
@   0x0800414e: 0000        movs	r0, r0
@   0x08004150: 03b9        lsls	r1, r7, #14
@   0x08004152: 0000        movs	r0, r0
@   0x08004154: 4158        adcs	r0, r3
@   0x08004156: 0800        lsrs	r0, r0, #32
@   0x08004158: 417c        adcs	r4, r7
@   0x0800415a: 0800        lsrs	r0, r0, #32
@   0x0800415c: 41d0        rors	r0, r2
@   0x0800415e: 0800        lsrs	r0, r0, #32
@   0x08004160: 4200        tst	r0, r0
@   0x08004162: 0800        lsrs	r0, r0, #32
@   0x08004164: 4224        tst	r4, r4
@   0x08004166: 0800        lsrs	r0, r0, #32
@   0x08004168: 42dc        cmn	r4, r3
@   0x0800416a: 0800        lsrs	r0, r0, #32
@   0x0800416c: 4340        muls	r0, r0
@   0x0800416e: 0800        lsrs	r0, r0, #32
@   0x08004170: 4380        bics	r0, r0
@   0x08004172: 0800        lsrs	r0, r0, #32
@   0x08004174: 43c0        mvns	r0, r0
@   0x08004176: 0800        lsrs	r0, r0, #32
@   0x08004178: 43f8        mvns	r0, r7
@   0x0800417a: 0800        lsrs	r0, r0, #32
@   0x0800417c: acef        add	r4, sp, #956	@ 0x3bc
@   0x0800417e: adf1        add	r5, sp, #964	@ 0x3c4
@   0x08004180: 4911        ldr	r1, [pc, #68]	@ (0x41c8)
@   0x08004182: 2600        movs	r6, #0
@   0x08004184: 200d        movs	r0, #13
@   0x08004186: 7288        strb	r0, [r1, #10]
@   0x08004188: 2002        movs	r0, #2
@   0x0800418a: 4669        mov	r1, sp
@   0x0800418c: f002        fd12 	bl	0x6bb4
@   0x08004190: 2003        movs	r0, #3
@   0x08004192: a999        add	r1, sp, #612	@ 0x264
@   0x08004194: 2202        movs	r2, #2
@   0x08004196: f003        f847 	bl	0x7228
@   0x0800419a: 2004        movs	r0, #4
@   0x0800419c: a9ab        add	r1, sp, #684	@ 0x2ac
@   0x0800419e: 2202        movs	r2, #2
@   0x080041a0: f003        f842 	bl	0x7228
@   0x080041a4: a8c6        add	r0, sp, #792	@ 0x318
@   0x080041a6: 1c21        adds	r1, r4, #0
@   0x080041a8: 220b        movs	r2, #11
@   0x080041aa: f007        fb01 	bl	0xb7b0
@   0x080041ae: a8ce        add	r0, sp, #824	@ 0x338
@   0x080041b0: 1c29        adds	r1, r5, #0
@   0x080041b2: 2210        movs	r2, #16
@   0x080041b4: f007        fafc 	bl	0xb7b0
@   0x080041b8: 4904        ldr	r1, [pc, #16]	@ (0x41cc)
@   0x080041ba: 4469        add	r1, sp
@   0x080041bc: 2001        movs	r0, #1
@   0x080041be: 7008        strb	r0, [r1, #0]
@   0x080041c0: a8ee        add	r0, sp, #952	@ 0x3b8
@   0x080041c2: 7006        strb	r6, [r0, #0]
@   0x080041c4: e11a        b.n	0x43fc
@   0x080041c6: 0000        movs	r0, r0
@   0x080041c8: 5330        strh	r0, [r6, r4]
@   0x080041ca: 0300        lsls	r0, r0, #12
@   0x080041cc: 03b9        lsls	r1, r7, #14
@   0x080041ce: 0000        movs	r0, r0
@   0x080041d0: acee        add	r4, sp, #952	@ 0x3b8
@   0x080041d2: 4908        ldr	r1, [pc, #32]	@ (0x41f4)
@   0x080041d4: 1c20        adds	r0, r4, #0
@   0x080041d6: f005        ff95 	bl	0xa104
@   0x080041da: 0600        lsls	r0, r0, #24
@   0x080041dc: 2800        cmp	r0, #0
@   0x080041de: d100        bne.n	0x41e2
@   0x080041e0: e100        b.n	0x43e4
@   0x080041e2: 4905        ldr	r1, [pc, #20]	@ (0x41f8)
@   0x080041e4: 4469        add	r1, sp
@   0x080041e6: 2002        movs	r0, #2
@   0x080041e8: 7008        strb	r0, [r1, #0]
@   0x080041ea: 4904        ldr	r1, [pc, #16]	@ (0x41fc)
@   0x080041ec: 2000        movs	r0, #0
@   0x080041ee: 6148        str	r0, [r1, #20]
@   0x080041f0: 7020        strb	r0, [r4, #0]
@   0x080041f2: e0f7        b.n	0x43e4
@   0x080041f4: 4471        add	r1, lr
@   0x080041f6: 0800        lsrs	r0, r0, #32
@   0x080041f8: 03b9        lsls	r1, r7, #14
@   0x080041fa: 0000        movs	r0, r0
@   0x080041fc: 5330        strh	r0, [r6, r4]
@   0x080041fe: 0300        lsls	r0, r0, #12
@   0x08004200: a8ee        add	r0, sp, #952	@ 0x3b8
@   0x08004202: f005        fdcb 	bl	0x9d9c
@   0x08004206: 2800        cmp	r0, #0
@   0x08004208: d100        bne.n	0x420c
@   0x0800420a: e0f7        b.n	0x43fc
@   0x0800420c: 4903        ldr	r1, [pc, #12]	@ (0x421c)
@   0x0800420e: 4469        add	r1, sp
@   0x08004210: 2003        movs	r0, #3
@   0x08004212: 7008        strb	r0, [r1, #0]
@   0x08004214: 4902        ldr	r1, [pc, #8]	@ (0x4220)
@   0x08004216: 2000        movs	r0, #0
@   0x08004218: 6148        str	r0, [r1, #20]
@   0x0800421a: e0ef        b.n	0x43fc
@   0x0800421c: 03b9        lsls	r1, r7, #14
@   0x0800421e: 0000        movs	r0, r0
@   0x08004220: 5330        strh	r0, [r6, r4]
@   0x08004222: 0300        lsls	r0, r0, #12
@   0x08004224: f7fc        f94e 	bl	0x4c4
@   0x08004228: 4906        ldr	r1, [pc, #24]	@ (0x4244)
@   0x0800422a: 8008        strh	r0, [r1, #0]
@   0x0800422c: 0400        lsls	r0, r0, #16
@   0x0800422e: 0c00        lsrs	r0, r0, #16
@   0x08004230: 2840        cmp	r0, #64	@ 0x40
@   0x08004232: d10b        bne.n	0x424c
@   0x08004234: 4904        ldr	r1, [pc, #16]	@ (0x4248)
@   0x08004236: 4469        add	r1, sp
@   0x08004238: 2005        movs	r0, #5
@   0x0800423a: 7008        strb	r0, [r1, #0]
@   0x0800423c: f009        ff10 	bl	0xe060
@   0x08004240: e0dc        b.n	0x43fc
@   0x08004242: 0000        movs	r0, r0
@   0x08004244: 5398        strh	r0, [r3, r6]
@   0x08004246: 0300        lsls	r0, r0, #12
@   0x08004248: 03b9        lsls	r1, r7, #14
@   0x0800424a: 0000        movs	r0, r0
@   0x0800424c: 4906        ldr	r1, [pc, #24]	@ (0x4268)
@   0x0800424e: 2308        movs	r3, #8
@   0x08004250: 2208        movs	r2, #8
@   0x08004252: 1c10        adds	r0, r2, #0
@   0x08004254: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08004256: 4008        ands	r0, r1
@   0x08004258: 2800        cmp	r0, #0
@   0x0800425a: d009        beq.n	0x4270
@   0x0800425c: 4903        ldr	r1, [pc, #12]	@ (0x426c)
@   0x0800425e: 4469        add	r1, sp
@   0x08004260: 2004        movs	r0, #4
@   0x08004262: 7008        strb	r0, [r1, #0]
@   0x08004264: e0ca        b.n	0x43fc
@   0x08004266: 0000        movs	r0, r0
@   0x08004268: 3720        adds	r7, #32
@   0x0800426a: 0300        lsls	r0, r0, #12
@   0x0800426c: 03b9        lsls	r1, r7, #14
@   0x0800426e: 0000        movs	r0, r0
@   0x08004270: 4904        ldr	r1, [pc, #16]	@ (0x4284)
@   0x08004272: 1c10        adds	r0, r2, #0
@   0x08004274: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08004276: 4008        ands	r0, r1
@   0x08004278: 2800        cmp	r0, #0
@   0x0800427a: d007        beq.n	0x428c
@   0x0800427c: 4802        ldr	r0, [pc, #8]	@ (0x4288)
@   0x0800427e: 4468        add	r0, sp
@   0x08004280: 7003        strb	r3, [r0, #0]
@   0x08004282: e0bb        b.n	0x43fc
@   0x08004284: 6110        str	r0, [r2, #16]
@   0x08004286: 0300        lsls	r0, r0, #12
@   0x08004288: 03b9        lsls	r1, r7, #14
@   0x0800428a: 0000        movs	r0, r0
@   0x0800428c: acef        add	r4, sp, #956	@ 0x3bc
@   0x0800428e: adf1        add	r5, sp, #964	@ 0x3c4
@   0x08004290: 2002        movs	r0, #2
@   0x08004292: 4669        mov	r1, sp
@   0x08004294: f003        f9e4 	bl	0x7660
@   0x08004298: 2000        movs	r0, #0
@   0x0800429a: 2103        movs	r1, #3
@   0x0800429c: aa99        add	r2, sp, #612	@ 0x264
@   0x0800429e: f003        f81f 	bl	0x72e0
@   0x080042a2: 2001        movs	r0, #1
@   0x080042a4: 2104        movs	r1, #4
@   0x080042a6: aaab        add	r2, sp, #684	@ 0x2ac
@   0x080042a8: f003        f81a 	bl	0x72e0
@   0x080042ac: f006        f814 	bl	0xa2d8
@   0x080042b0: f7fc        fb14 	bl	0x8dc
@   0x080042b4: f006        f838 	bl	0xa328
@   0x080042b8: f005        f91e 	bl	0x94f8
@   0x080042bc: f005        fb62 	bl	0x9984
@   0x080042c0: a8c6        add	r0, sp, #792	@ 0x318
@   0x080042c2: 1c21        adds	r1, r4, #0
@   0x080042c4: aace        add	r2, sp, #824	@ 0x338
@   0x080042c6: 1c2b        adds	r3, r5, #0
@   0x080042c8: f000        f91e 	bl	0x4508
@   0x080042cc: 4902        ldr	r1, [pc, #8]	@ (0x42d8)
@   0x080042ce: 6948        ldr	r0, [r1, #20]
@   0x080042d0: 3001        adds	r0, #1
@   0x080042d2: 6148        str	r0, [r1, #20]
@   0x080042d4: e092        b.n	0x43fc
@   0x080042d6: 0000        movs	r0, r0
@   0x080042d8: 5330        strh	r0, [r6, r4]
@   0x080042da: 0300        lsls	r0, r0, #12
@   0x080042dc: 4c06        ldr	r4, [pc, #24]	@ (0x42f8)
@   0x080042de: 446c        add	r4, sp
@   0x080042e0: adef        add	r5, sp, #956	@ 0x3bc
@   0x080042e2: aef1        add	r6, sp, #964	@ 0x3c4
@   0x080042e4: 4805        ldr	r0, [pc, #20]	@ (0x42fc)
@   0x080042e6: 7940        ldrb	r0, [r0, #5]
@   0x080042e8: 0600        lsls	r0, r0, #24
@   0x080042ea: 1600        asrs	r0, r0, #24
@   0x080042ec: 2801        cmp	r0, #1
@   0x080042ee: dc09        bgt.n	0x4304
@   0x080042f0: 4903        ldr	r1, [pc, #12]	@ (0x4300)
@   0x080042f2: 2000        movs	r0, #0
@   0x080042f4: e008        b.n	0x4308
@   0x080042f6: 0000        movs	r0, r0
@   0x080042f8: 03b9        lsls	r1, r7, #14
@   0x080042fa: 0000        movs	r0, r0
@   0x080042fc: 35e0        adds	r5, #224	@ 0xe0
@   0x080042fe: 0300        lsls	r0, r0, #12
@   0x08004300: 6110        str	r0, [r2, #16]
@   0x08004302: 0300        lsls	r0, r0, #12
@   0x08004304: 490c        ldr	r1, [pc, #48]	@ (0x4338)
@   0x08004306: 2001        movs	r0, #1
@   0x08004308: 6108        str	r0, [r1, #16]
@   0x0800430a: 480c        ldr	r0, [pc, #48]	@ (0x433c)
@   0x0800430c: 4468        add	r0, sp
@   0x0800430e: f005        fc81 	bl	0x9c14
@   0x08004312: 2800        cmp	r0, #0
@   0x08004314: d101        bne.n	0x431a
@   0x08004316: 2007        movs	r0, #7
@   0x08004318: 7020        strb	r0, [r4, #0]
@   0x0800431a: a8c6        add	r0, sp, #792	@ 0x318
@   0x0800431c: 1c29        adds	r1, r5, #0
@   0x0800431e: 220b        movs	r2, #11
@   0x08004320: f007        fa46 	bl	0xb7b0
@   0x08004324: a8ce        add	r0, sp, #824	@ 0x338
@   0x08004326: 1c31        adds	r1, r6, #0
@   0x08004328: 2210        movs	r2, #16
@   0x0800432a: f007        fa41 	bl	0xb7b0
@   0x0800432e: a9ee        add	r1, sp, #952	@ 0x3b8
@   0x08004330: 2000        movs	r0, #0
@   0x08004332: 7008        strb	r0, [r1, #0]
@   0x08004334: e062        b.n	0x43fc
@   0x08004336: 0000        movs	r0, r0
@   0x08004338: 6110        str	r0, [r2, #16]
@   0x0800433a: 0300        lsls	r0, r0, #12
@   0x0800433c: 03b9        lsls	r1, r7, #14
@   0x0800433e: 0000        movs	r0, r0
@   0x08004340: f7fc        f8c0 	bl	0x4c4
@   0x08004344: 490b        ldr	r1, [pc, #44]	@ (0x4374)
@   0x08004346: 8008        strh	r0, [r1, #0]
@   0x08004348: f00a        f9ae 	bl	0xe6a8
@   0x0800434c: 0600        lsls	r0, r0, #24
@   0x0800434e: 0e02        lsrs	r2, r0, #24
@   0x08004350: 2a00        cmp	r2, #0
@   0x08004352: d105        bne.n	0x4360
@   0x08004354: 4808        ldr	r0, [pc, #32]	@ (0x4378)
@   0x08004356: 4468        add	r0, sp
@   0x08004358: 2106        movs	r1, #6
@   0x0800435a: 7001        strb	r1, [r0, #0]
@   0x0800435c: a8ee        add	r0, sp, #952	@ 0x3b8
@   0x0800435e: 7002        strb	r2, [r0, #0]
@   0x08004360: 4806        ldr	r0, [pc, #24]	@ (0x437c)
@   0x08004362: 7800        ldrb	r0, [r0, #0]
@   0x08004364: 2800        cmp	r0, #0
@   0x08004366: d149        bne.n	0x43fc
@   0x08004368: 4903        ldr	r1, [pc, #12]	@ (0x4378)
@   0x0800436a: 4469        add	r1, sp
@   0x0800436c: 2003        movs	r0, #3
@   0x0800436e: 7008        strb	r0, [r1, #0]
@   0x08004370: e044        b.n	0x43fc
@   0x08004372: 0000        movs	r0, r0
@   0x08004374: 5398        strh	r0, [r3, r6]
@   0x08004376: 0300        lsls	r0, r0, #12
@   0x08004378: 03b9        lsls	r1, r7, #14
@   0x0800437a: 0000        movs	r0, r0
@   0x0800437c: 5328        strh	r0, [r5, r4]
@   0x0800437e: 0300        lsls	r0, r0, #12
@   0x08004380: acee        add	r4, sp, #952	@ 0x3b8
@   0x08004382: 2000        movs	r0, #0
@   0x08004384: 5620        ldrsb	r0, [r4, r0]
@   0x08004386: 2800        cmp	r0, #0
@   0x08004388: d105        bne.n	0x4396
@   0x0800438a: 20bf        movs	r0, #191	@ 0xbf
@   0x0800438c: f00c        f982 	bl	0x10694
@   0x08004390: 7820        ldrb	r0, [r4, #0]
@   0x08004392: 3001        adds	r0, #1
@   0x08004394: 7020        strb	r0, [r4, #0]
@   0x08004396: 7824        ldrb	r4, [r4, #0]
@   0x08004398: 0624        lsls	r4, r4, #24
@   0x0800439a: 1624        asrs	r4, r4, #24
@   0x0800439c: 2c01        cmp	r4, #1
@   0x0800439e: d12d        bne.n	0x43fc
@   0x080043a0: f00c        f98a 	bl	0x106b8
@   0x080043a4: 0600        lsls	r0, r0, #24
@   0x080043a6: 2800        cmp	r0, #0
@   0x080043a8: d128        bne.n	0x43fc
@   0x080043aa: 4803        ldr	r0, [pc, #12]	@ (0x43b8)
@   0x080043ac: 2104        movs	r1, #4
@   0x080043ae: 7001        strb	r1, [r0, #0]
@   0x080043b0: 7184        strb	r4, [r0, #6]
@   0x080043b2: 4802        ldr	r0, [pc, #8]	@ (0x43bc)
@   0x080043b4: 7241        strb	r1, [r0, #9]
@   0x080043b6: e021        b.n	0x43fc
@   0x080043b8: 3480        adds	r4, #128	@ 0x80
@   0x080043ba: 0300        lsls	r0, r0, #12
@   0x080043bc: 5330        strh	r0, [r6, r4]
@   0x080043be: 0300        lsls	r0, r0, #12
@   0x080043c0: acee        add	r4, sp, #952	@ 0x3b8
@   0x080043c2: 490a        ldr	r1, [pc, #40]	@ (0x43ec)
@   0x080043c4: 1c20        adds	r0, r4, #0
@   0x080043c6: f005        fe9d 	bl	0xa104
@   0x080043ca: 0600        lsls	r0, r0, #24
@   0x080043cc: 2800        cmp	r0, #0
@   0x080043ce: d009        beq.n	0x43e4
@   0x080043d0: 4907        ldr	r1, [pc, #28]	@ (0x43f0)
@   0x080043d2: 4469        add	r1, sp
@   0x080043d4: 2002        movs	r0, #2
@   0x080043d6: 7008        strb	r0, [r1, #0]
@   0x080043d8: 4906        ldr	r1, [pc, #24]	@ (0x43f4)
@   0x080043da: 2000        movs	r0, #0
@   0x080043dc: 6148        str	r0, [r1, #20]
@   0x080043de: 7020        strb	r0, [r4, #0]
@   0x080043e0: f005        fef2 	bl	0xa1c8
@   0x080043e4: f7fc        fa7a 	bl	0x8dc
@   0x080043e8: e008        b.n	0x43fc
@   0x080043ea: 0000        movs	r0, r0
@   0x080043ec: a26d        add	r2, pc, #436	@ (adr r2, 0x45a4)
@   0x080043ee: 0800        lsrs	r0, r0, #32
@   0x080043f0: 03b9        lsls	r1, r7, #14
@   0x080043f2: 0000        movs	r0, r0
@   0x080043f4: 5330        strh	r0, [r6, r4]
@   0x080043f6: 0300        lsls	r0, r0, #12
@   0x080043f8: f009        fd42 	bl	0xde80
@   0x080043fc: 4806        ldr	r0, [pc, #24]	@ (0x4418)
@   0x080043fe: 7a40        ldrb	r0, [r0, #9]
@   0x08004400: 2814        cmp	r0, #20
@   0x08004402: d100        bne.n	0x4406
@   0x08004404: e696        b.n	0x4134
@   0x08004406: 2818        cmp	r0, #24
@   0x08004408: d100        bne.n	0x440c
@   0x0800440a: e693        b.n	0x4134
@   0x0800440c: 23f3        movs	r3, #243	@ 0xf3
@   0x0800440e: 009b        lsls	r3, r3, #2
@   0x08004410: 449d        add	sp, r3
@   0x08004412: bc70        pop	{r4, r5, r6}
@   0x08004414: bc01        pop	{r0}
@   0x08004416: 4700        bx	r0
@   0x08004418: 5330        strh	r0, [r6, r4]
@   0x0800441a: 0300        lsls	r0, r0, #12

        thumb_func_start SceneLoop_20
SceneLoop_20: @ 0x0800411c
        .incbin "frog_us_baserom.gba", 0x411c, 0x300
        thumb_func_end SceneLoop_20
