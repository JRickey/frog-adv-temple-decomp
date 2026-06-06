@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08009188, 0x080094f8)  (880 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8009188 --end 0x80094f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08009188: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800918a: 4647        mov	r7, r8
@   0x0800918c: b480        push	{r7}
@   0x0800918e: 2300        movs	r3, #0
@   0x08009190: 481c        ldr	r0, [pc, #112]	@ (0x9204)
@   0x08009192: 1c01        adds	r1, r0, #0
@   0x08009194: 3131        adds	r1, #49	@ 0x31
@   0x08009196: 4684        mov	ip, r0
@   0x08009198: 4d1b        ldr	r5, [pc, #108]	@ (0x9208)
@   0x0800919a: 481c        ldr	r0, [pc, #112]	@ (0x920c)
@   0x0800919c: 4680        mov	r8, r0
@   0x0800919e: 7809        ldrb	r1, [r1, #0]
@   0x080091a0: 428b        cmp	r3, r1
@   0x080091a2: db00        blt.n	0x91a6
@   0x080091a4: e081        b.n	0x92aa
@   0x080091a6: 4c1a        ldr	r4, [pc, #104]	@ (0x9210)
@   0x080091a8: 1c2a        adds	r2, r5, #0
@   0x080091aa: 7811        ldrb	r1, [r2, #0]
@   0x080091ac: 00c8        lsls	r0, r1, #3
@   0x080091ae: 1a40        subs	r0, r0, r1
@   0x080091b0: 00c0        lsls	r0, r0, #3
@   0x080091b2: 1901        adds	r1, r0, r4
@   0x080091b4: 2080        movs	r0, #128	@ 0x80
@   0x080091b6: 01c0        lsls	r0, r0, #7
@   0x080091b8: 8e8e        ldrh	r6, [r1, #52]	@ 0x34
@   0x080091ba: 4030        ands	r0, r6
@   0x080091bc: 2800        cmp	r0, #0
@   0x080091be: d16c        bne.n	0x929a
@   0x080091c0: 7dc8        ldrb	r0, [r1, #23]
@   0x080091c2: 2800        cmp	r0, #0
@   0x080091c4: d104        bne.n	0x91d0
@   0x080091c6: 8857        ldrh	r7, [r2, #2]
@   0x080091c8: 21f0        movs	r1, #240	@ 0xf0
@   0x080091ca: 0209        lsls	r1, r1, #8
@   0x080091cc: 1878        adds	r0, r7, r1
@   0x080091ce: 8050        strh	r0, [r2, #2]
@   0x080091d0: 7816        ldrb	r6, [r2, #0]
@   0x080091d2: 00f0        lsls	r0, r6, #3
@   0x080091d4: 1b80        subs	r0, r0, r6
@   0x080091d6: 00c0        lsls	r0, r0, #3
@   0x080091d8: 1901        adds	r1, r0, r4
@   0x080091da: 7dcf        ldrb	r7, [r1, #23]
@   0x080091dc: 2f01        cmp	r7, #1
@   0x080091de: d104        bne.n	0x91ea
@   0x080091e0: 8856        ldrh	r6, [r2, #2]
@   0x080091e2: 27e0        movs	r7, #224	@ 0xe0
@   0x080091e4: 023f        lsls	r7, r7, #8
@   0x080091e6: 19f0        adds	r0, r6, r7
@   0x080091e8: 8050        strh	r0, [r2, #2]
@   0x080091ea: 7dc8        ldrb	r0, [r1, #23]
@   0x080091ec: 2802        cmp	r0, #2
@   0x080091ee: d129        bne.n	0x9244
@   0x080091f0: 2030        movs	r0, #48	@ 0x30
@   0x080091f2: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x080091f4: 4008        ands	r0, r1
@   0x080091f6: 2810        cmp	r0, #16
@   0x080091f8: d015        beq.n	0x9226
@   0x080091fa: 2810        cmp	r0, #16
@   0x080091fc: dc0a        bgt.n	0x9214
@   0x080091fe: 2800        cmp	r0, #0
@   0x08009200: d016        beq.n	0x9230
@   0x08009202: e01f        b.n	0x9244
@   0x08009204: 6110        str	r0, [r2, #16]
@   0x08009206: 0300        lsls	r0, r0, #12
@   0x08009208: 6160        str	r0, [r4, #20]
@   0x0800920a: 0300        lsls	r0, r0, #12
@   0x0800920c: a3a5        add	r3, pc, #660	@ (adr r3, 0x94a4)
@   0x0800920e: 0800        lsrs	r0, r0, #32
@   0x08009210: 3720        adds	r7, #32
@   0x08009212: 0300        lsls	r0, r0, #12
@   0x08009214: 2820        cmp	r0, #32
@   0x08009216: d002        beq.n	0x921e
@   0x08009218: 2830        cmp	r0, #48	@ 0x30
@   0x0800921a: d00e        beq.n	0x923a
@   0x0800921c: e012        b.n	0x9244
@   0x0800921e: 8851        ldrh	r1, [r2, #2]
@   0x08009220: 26d0        movs	r6, #208	@ 0xd0
@   0x08009222: 0236        lsls	r6, r6, #8
@   0x08009224: e00c        b.n	0x9240
@   0x08009226: 8857        ldrh	r7, [r2, #2]
@   0x08009228: 21c0        movs	r1, #192	@ 0xc0
@   0x0800922a: 0209        lsls	r1, r1, #8
@   0x0800922c: 1878        adds	r0, r7, r1
@   0x0800922e: e008        b.n	0x9242
@   0x08009230: 8856        ldrh	r6, [r2, #2]
@   0x08009232: 27b0        movs	r7, #176	@ 0xb0
@   0x08009234: 023f        lsls	r7, r7, #8
@   0x08009236: 19f0        adds	r0, r6, r7
@   0x08009238: e003        b.n	0x9242
@   0x0800923a: 8851        ldrh	r1, [r2, #2]
@   0x0800923c: 26a0        movs	r6, #160	@ 0xa0
@   0x0800923e: 0236        lsls	r6, r6, #8
@   0x08009240: 1988        adds	r0, r1, r6
@   0x08009242: 8050        strh	r0, [r2, #2]
@   0x08009244: 7817        ldrb	r7, [r2, #0]
@   0x08009246: 00f8        lsls	r0, r7, #3
@   0x08009248: 1c39        adds	r1, r7, #0
@   0x0800924a: 1a40        subs	r0, r0, r1
@   0x0800924c: 00c0        lsls	r0, r0, #3
@   0x0800924e: 1900        adds	r0, r0, r4
@   0x08009250: 7dc6        ldrb	r6, [r0, #23]
@   0x08009252: 2e03        cmp	r6, #3
@   0x08009254: d121        bne.n	0x929a
@   0x08009256: 2130        movs	r1, #48	@ 0x30
@   0x08009258: 8e80        ldrh	r0, [r0, #52]	@ 0x34
@   0x0800925a: 4001        ands	r1, r0
@   0x0800925c: 2910        cmp	r1, #16
@   0x0800925e: d00d        beq.n	0x927c
@   0x08009260: 2910        cmp	r1, #16
@   0x08009262: dc02        bgt.n	0x926a
@   0x08009264: 2900        cmp	r1, #0
@   0x08009266: d00e        beq.n	0x9286
@   0x08009268: e017        b.n	0x929a
@   0x0800926a: 2920        cmp	r1, #32
@   0x0800926c: d002        beq.n	0x9274
@   0x0800926e: 2930        cmp	r1, #48	@ 0x30
@   0x08009270: d00e        beq.n	0x9290
@   0x08009272: e012        b.n	0x929a
@   0x08009274: 8857        ldrh	r7, [r2, #2]
@   0x08009276: 2190        movs	r1, #144	@ 0x90
@   0x08009278: 0209        lsls	r1, r1, #8
@   0x0800927a: e00c        b.n	0x9296
@   0x0800927c: 8856        ldrh	r6, [r2, #2]
@   0x0800927e: 2780        movs	r7, #128	@ 0x80
@   0x08009280: 023f        lsls	r7, r7, #8
@   0x08009282: 19f0        adds	r0, r6, r7
@   0x08009284: e008        b.n	0x9298
@   0x08009286: 8851        ldrh	r1, [r2, #2]
@   0x08009288: 26e0        movs	r6, #224	@ 0xe0
@   0x0800928a: 01f6        lsls	r6, r6, #7
@   0x0800928c: 1988        adds	r0, r1, r6
@   0x0800928e: e003        b.n	0x9298
@   0x08009290: 8857        ldrh	r7, [r2, #2]
@   0x08009292: 21c0        movs	r1, #192	@ 0xc0
@   0x08009294: 01c9        lsls	r1, r1, #7
@   0x08009296: 1878        adds	r0, r7, r1
@   0x08009298: 8050        strh	r0, [r2, #2]
@   0x0800929a: 3208        adds	r2, #8
@   0x0800929c: 3301        adds	r3, #1
@   0x0800929e: 4660        mov	r0, ip
@   0x080092a0: 3031        adds	r0, #49	@ 0x31
@   0x080092a2: 7800        ldrb	r0, [r0, #0]
@   0x080092a4: 4283        cmp	r3, r0
@   0x080092a6: da00        bge.n	0x92aa
@   0x080092a8: e77f        b.n	0x91aa
@   0x080092aa: 4660        mov	r0, ip
@   0x080092ac: 3031        adds	r0, #49	@ 0x31
@   0x080092ae: 7801        ldrb	r1, [r0, #0]
@   0x080092b0: 1c28        adds	r0, r5, #0
@   0x080092b2: 2208        movs	r2, #8
@   0x080092b4: 4643        mov	r3, r8
@   0x080092b6: f02c        fa99 	bl	0x357ec
@   0x080092ba: bc08        pop	{r3}
@   0x080092bc: 4698        mov	r8, r3
@   0x080092be: bcf0        pop	{r4, r5, r6, r7}
@   0x080092c0: bc01        pop	{r0}
@   0x080092c2: 4700        bx	r0
@   0x080092c4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080092c6: 0400        lsls	r0, r0, #16
@   0x080092c8: 0c07        lsrs	r7, r0, #16
@   0x080092ca: 4e19        ldr	r6, [pc, #100]	@ (0x9330)
@   0x080092cc: 2104        movs	r1, #4
@   0x080092ce: 1c08        adds	r0, r1, #0
@   0x080092d0: 8eb2        ldrh	r2, [r6, #52]	@ 0x34
@   0x080092d2: 4010        ands	r0, r2
@   0x080092d4: 2800        cmp	r0, #0
@   0x080092d6: d000        beq.n	0x92da
@   0x080092d8: e105        b.n	0x94e6
@   0x080092da: 0438        lsls	r0, r7, #16
@   0x080092dc: 1403        asrs	r3, r0, #16
@   0x080092de: 1c05        adds	r5, r0, #0
@   0x080092e0: 2b00        cmp	r3, #0
@   0x080092e2: d100        bne.n	0x92e6
@   0x080092e4: e0ff        b.n	0x94e6
@   0x080092e6: 00d8        lsls	r0, r3, #3
@   0x080092e8: 1ac0        subs	r0, r0, r3
@   0x080092ea: 00c0        lsls	r0, r0, #3
@   0x080092ec: 1984        adds	r4, r0, r6
@   0x080092ee: 1c08        adds	r0, r1, #0
@   0x080092f0: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x080092f2: 4018        ands	r0, r3
@   0x080092f4: 2800        cmp	r0, #0
@   0x080092f6: d000        beq.n	0x92fa
@   0x080092f8: e0f5        b.n	0x94e6
@   0x080092fa: 79b0        ldrb	r0, [r6, #6]
@   0x080092fc: 79a1        ldrb	r1, [r4, #6]
@   0x080092fe: 4288        cmp	r0, r1
@   0x08009300: d000        beq.n	0x9304
@   0x08009302: e0f0        b.n	0x94e6
@   0x08009304: 1c20        adds	r0, r4, #0
@   0x08009306: f017        f967 	bl	0x205d8
@   0x0800930a: 1c30        adds	r0, r6, #0
@   0x0800930c: 1c21        adds	r1, r4, #0
@   0x0800930e: f000        fa75 	bl	0x97fc
@   0x08009312: 0600        lsls	r0, r0, #24
@   0x08009314: 2800        cmp	r0, #0
@   0x08009316: d100        bne.n	0x931a
@   0x08009318: e0e5        b.n	0x94e6
@   0x0800931a: 7860        ldrb	r0, [r4, #1]
@   0x0800931c: 3801        subs	r0, #1
@   0x0800931e: 2808        cmp	r0, #8
@   0x08009320: d900        bls.n	0x9324
@   0x08009322: e0e0        b.n	0x94e6
@   0x08009324: 0080        lsls	r0, r0, #2
@   0x08009326: 4903        ldr	r1, [pc, #12]	@ (0x9334)
@   0x08009328: 1840        adds	r0, r0, r1
@   0x0800932a: 6800        ldr	r0, [r0, #0]
@   0x0800932c: 4687        mov	pc, r0
@   0x0800932e: 0000        movs	r0, r0
@   0x08009330: 3720        adds	r7, #32
@   0x08009332: 0300        lsls	r0, r0, #12
@   0x08009334: 9338        str	r3, [sp, #224]	@ 0xe0
@   0x08009336: 0800        lsrs	r0, r0, #32
@   0x08009338: 935c        str	r3, [sp, #368]	@ 0x170
@   0x0800933a: 0800        lsrs	r0, r0, #32
@   0x0800933c: 9390        str	r3, [sp, #576]	@ 0x240
@   0x0800933e: 0800        lsrs	r0, r0, #32
@   0x08009340: 94e6        str	r4, [sp, #920]	@ 0x398
@   0x08009342: 0800        lsrs	r0, r0, #32
@   0x08009344: 944c        str	r4, [sp, #304]	@ 0x130
@   0x08009346: 0800        lsrs	r0, r0, #32
@   0x08009348: 93e4        str	r3, [sp, #912]	@ 0x390
@   0x0800934a: 0800        lsrs	r0, r0, #32
@   0x0800934c: 9484        str	r4, [sp, #528]	@ 0x210
@   0x0800934e: 0800        lsrs	r0, r0, #32
@   0x08009350: 9420        str	r4, [sp, #128]	@ 0x80
@   0x08009352: 0800        lsrs	r0, r0, #32
@   0x08009354: 944c        str	r4, [sp, #304]	@ 0x130
@   0x08009356: 0800        lsrs	r0, r0, #32
@   0x08009358: 94bc        str	r4, [sp, #752]	@ 0x2f0
@   0x0800935a: 0800        lsrs	r0, r0, #32
@   0x0800935c: 4b0a        ldr	r3, [pc, #40]	@ (0x9388)
@   0x0800935e: 7e9a        ldrb	r2, [r3, #26]
@   0x08009360: 2a03        cmp	r2, #3
@   0x08009362: d900        bls.n	0x9366
@   0x08009364: e0bf        b.n	0x94e6
@   0x08009366: 4a09        ldr	r2, [pc, #36]	@ (0x938c)
@   0x08009368: 1429        asrs	r1, r5, #16
@   0x0800936a: 00c8        lsls	r0, r1, #3
@   0x0800936c: 1a40        subs	r0, r0, r1
@   0x0800936e: 00c0        lsls	r0, r0, #3
@   0x08009370: 18c0        adds	r0, r0, r3
@   0x08009372: 7b11        ldrb	r1, [r2, #12]
@   0x08009374: 7843        ldrb	r3, [r0, #1]
@   0x08009376: 4319        orrs	r1, r3
@   0x08009378: 7311        strb	r1, [r2, #12]
@   0x0800937a: 2180        movs	r1, #128	@ 0x80
@   0x0800937c: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x0800937e: 4311        orrs	r1, r2
@   0x08009380: 2204        movs	r2, #4
@   0x08009382: 4311        orrs	r1, r2
@   0x08009384: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08009386: e0ae        b.n	0x94e6
@   0x08009388: 3720        adds	r7, #32
@   0x0800938a: 0300        lsls	r0, r0, #12
@   0x0800938c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800938e: 0300        lsls	r0, r0, #12
@   0x08009390: 4e12        ldr	r6, [pc, #72]	@ (0x93dc)
@   0x08009392: 1428        asrs	r0, r5, #16
@   0x08009394: 00c1        lsls	r1, r0, #3
@   0x08009396: 1a09        subs	r1, r1, r0
@   0x08009398: 00c9        lsls	r1, r1, #3
@   0x0800939a: 198c        adds	r4, r1, r6
@   0x0800939c: 1c30        adds	r0, r6, #0
@   0x0800939e: 1c21        adds	r1, r4, #0
@   0x080093a0: f000        feda 	bl	0xa158
@   0x080093a4: 0600        lsls	r0, r0, #24
@   0x080093a6: 2800        cmp	r0, #0
@   0x080093a8: d100        bne.n	0x93ac
@   0x080093aa: e09c        b.n	0x94e6
@   0x080093ac: 490c        ldr	r1, [pc, #48]	@ (0x93e0)
@   0x080093ae: 7b08        ldrb	r0, [r1, #12]
@   0x080093b0: 7863        ldrb	r3, [r4, #1]
@   0x080093b2: 4318        orrs	r0, r3
@   0x080093b4: 7308        strb	r0, [r1, #12]
@   0x080093b6: 734f        strb	r7, [r1, #13]
@   0x080093b8: 7eb6        ldrb	r6, [r6, #26]
@   0x080093ba: 2e03        cmp	r6, #3
@   0x080093bc: d905        bls.n	0x93ca
@   0x080093be: 2010        movs	r0, #16
@   0x080093c0: 8a0a        ldrh	r2, [r1, #16]
@   0x080093c2: 4010        ands	r0, r2
@   0x080093c4: 2800        cmp	r0, #0
@   0x080093c6: d100        bne.n	0x93ca
@   0x080093c8: e08d        b.n	0x94e6
@   0x080093ca: 2080        movs	r0, #128	@ 0x80
@   0x080093cc: 8ea3        ldrh	r3, [r4, #52]	@ 0x34
@   0x080093ce: 4318        orrs	r0, r3
@   0x080093d0: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080093d2: 2002        movs	r0, #2
@   0x080093d4: 8a0a        ldrh	r2, [r1, #16]
@   0x080093d6: 4310        orrs	r0, r2
@   0x080093d8: 8208        strh	r0, [r1, #16]
@   0x080093da: e084        b.n	0x94e6
@   0x080093dc: 3720        adds	r7, #32
@   0x080093de: 0300        lsls	r0, r0, #12
@   0x080093e0: 35e0        adds	r5, #224	@ 0xe0
@   0x080093e2: 0300        lsls	r0, r0, #12
@   0x080093e4: 490b        ldr	r1, [pc, #44]	@ (0x9414)
@   0x080093e6: 2001        movs	r0, #1
@   0x080093e8: 7c09        ldrb	r1, [r1, #16]
@   0x080093ea: 4008        ands	r0, r1
@   0x080093ec: 2800        cmp	r0, #0
@   0x080093ee: d000        beq.n	0x93f2
@   0x080093f0: e079        b.n	0x94e6
@   0x080093f2: 4809        ldr	r0, [pc, #36]	@ (0x9418)
@   0x080093f4: 4b09        ldr	r3, [pc, #36]	@ (0x941c)
@   0x080093f6: 142a        asrs	r2, r5, #16
@   0x080093f8: 00d1        lsls	r1, r2, #3
@   0x080093fa: 1a89        subs	r1, r1, r2
@   0x080093fc: 00c9        lsls	r1, r1, #3
@   0x080093fe: 18c9        adds	r1, r1, r3
@   0x08009400: 784a        ldrb	r2, [r1, #1]
@   0x08009402: 7302        strb	r2, [r0, #12]
@   0x08009404: 7809        ldrb	r1, [r1, #0]
@   0x08009406: 7341        strb	r1, [r0, #13]
@   0x08009408: 2180        movs	r1, #128	@ 0x80
@   0x0800940a: 0089        lsls	r1, r1, #2
@   0x0800940c: f7fd        fbbc 	bl	0x6b88
@   0x08009410: e069        b.n	0x94e6
@   0x08009412: 0000        movs	r0, r0
@   0x08009414: 5330        strh	r0, [r6, r4]
@   0x08009416: 0300        lsls	r0, r0, #12
@   0x08009418: 35e0        adds	r5, #224	@ 0xe0
@   0x0800941a: 0300        lsls	r0, r0, #12
@   0x0800941c: 3720        adds	r7, #32
@   0x0800941e: 0300        lsls	r0, r0, #12
@   0x08009420: 4907        ldr	r1, [pc, #28]	@ (0x9440)
@   0x08009422: 2001        movs	r0, #1
@   0x08009424: 7c09        ldrb	r1, [r1, #16]
@   0x08009426: 4008        ands	r0, r1
@   0x08009428: 2800        cmp	r0, #0
@   0x0800942a: d15c        bne.n	0x94e6
@   0x0800942c: 4b05        ldr	r3, [pc, #20]	@ (0x9444)
@   0x0800942e: 7e98        ldrb	r0, [r3, #26]
@   0x08009430: 3808        subs	r0, #8
@   0x08009432: 0600        lsls	r0, r0, #24
@   0x08009434: 0e00        lsrs	r0, r0, #24
@   0x08009436: 2803        cmp	r0, #3
@   0x08009438: d955        bls.n	0x94e6
@   0x0800943a: 4803        ldr	r0, [pc, #12]	@ (0x9448)
@   0x0800943c: e00e        b.n	0x945c
@   0x0800943e: 0000        movs	r0, r0
@   0x08009440: 5330        strh	r0, [r6, r4]
@   0x08009442: 0300        lsls	r0, r0, #12
@   0x08009444: 3720        adds	r7, #32
@   0x08009446: 0300        lsls	r0, r0, #12
@   0x08009448: 35e0        adds	r5, #224	@ 0xe0
@   0x0800944a: 0300        lsls	r0, r0, #12
@   0x0800944c: 490a        ldr	r1, [pc, #40]	@ (0x9478)
@   0x0800944e: 2001        movs	r0, #1
@   0x08009450: 7c09        ldrb	r1, [r1, #16]
@   0x08009452: 4008        ands	r0, r1
@   0x08009454: 2800        cmp	r0, #0
@   0x08009456: d146        bne.n	0x94e6
@   0x08009458: 4808        ldr	r0, [pc, #32]	@ (0x947c)
@   0x0800945a: 4b09        ldr	r3, [pc, #36]	@ (0x9480)
@   0x0800945c: 142a        asrs	r2, r5, #16
@   0x0800945e: 00d1        lsls	r1, r2, #3
@   0x08009460: 1a89        subs	r1, r1, r2
@   0x08009462: 00c9        lsls	r1, r1, #3
@   0x08009464: 18c9        adds	r1, r1, r3
@   0x08009466: 784a        ldrb	r2, [r1, #1]
@   0x08009468: 7302        strb	r2, [r0, #12]
@   0x0800946a: 7809        ldrb	r1, [r1, #0]
@   0x0800946c: 7341        strb	r1, [r0, #13]
@   0x0800946e: 2180        movs	r1, #128	@ 0x80
@   0x08009470: 00c9        lsls	r1, r1, #3
@   0x08009472: f7fd        fb89 	bl	0x6b88
@   0x08009476: e036        b.n	0x94e6
@   0x08009478: 5330        strh	r0, [r6, r4]
@   0x0800947a: 0300        lsls	r0, r0, #12
@   0x0800947c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800947e: 0300        lsls	r0, r0, #12
@   0x08009480: 3720        adds	r7, #32
@   0x08009482: 0300        lsls	r0, r0, #12
@   0x08009484: 490a        ldr	r1, [pc, #40]	@ (0x94b0)
@   0x08009486: 2001        movs	r0, #1
@   0x08009488: 7c09        ldrb	r1, [r1, #16]
@   0x0800948a: 4008        ands	r0, r1
@   0x0800948c: 2800        cmp	r0, #0
@   0x0800948e: d12a        bne.n	0x94e6
@   0x08009490: 4808        ldr	r0, [pc, #32]	@ (0x94b4)
@   0x08009492: 4b09        ldr	r3, [pc, #36]	@ (0x94b8)
@   0x08009494: 142a        asrs	r2, r5, #16
@   0x08009496: 00d1        lsls	r1, r2, #3
@   0x08009498: 1a89        subs	r1, r1, r2
@   0x0800949a: 00c9        lsls	r1, r1, #3
@   0x0800949c: 18c9        adds	r1, r1, r3
@   0x0800949e: 784a        ldrb	r2, [r1, #1]
@   0x080094a0: 7302        strb	r2, [r0, #12]
@   0x080094a2: 7809        ldrb	r1, [r1, #0]
@   0x080094a4: 7341        strb	r1, [r0, #13]
@   0x080094a6: 2180        movs	r1, #128	@ 0x80
@   0x080094a8: 0109        lsls	r1, r1, #4
@   0x080094aa: f7fd        fb6d 	bl	0x6b88
@   0x080094ae: e01a        b.n	0x94e6
@   0x080094b0: 5330        strh	r0, [r6, r4]
@   0x080094b2: 0300        lsls	r0, r0, #12
@   0x080094b4: 35e0        adds	r5, #224	@ 0xe0
@   0x080094b6: 0300        lsls	r0, r0, #12
@   0x080094b8: 3720        adds	r7, #32
@   0x080094ba: 0300        lsls	r0, r0, #12
@   0x080094bc: 490b        ldr	r1, [pc, #44]	@ (0x94ec)
@   0x080094be: 2001        movs	r0, #1
@   0x080094c0: 7c09        ldrb	r1, [r1, #16]
@   0x080094c2: 4008        ands	r0, r1
@   0x080094c4: 2800        cmp	r0, #0
@   0x080094c6: d10e        bne.n	0x94e6
@   0x080094c8: 4809        ldr	r0, [pc, #36]	@ (0x94f0)
@   0x080094ca: 4b0a        ldr	r3, [pc, #40]	@ (0x94f4)
@   0x080094cc: 142a        asrs	r2, r5, #16
@   0x080094ce: 00d1        lsls	r1, r2, #3
@   0x080094d0: 1a89        subs	r1, r1, r2
@   0x080094d2: 00c9        lsls	r1, r1, #3
@   0x080094d4: 18c9        adds	r1, r1, r3
@   0x080094d6: 784a        ldrb	r2, [r1, #1]
@   0x080094d8: 7302        strb	r2, [r0, #12]
@   0x080094da: 7809        ldrb	r1, [r1, #0]
@   0x080094dc: 7341        strb	r1, [r0, #13]
@   0x080094de: 2180        movs	r1, #128	@ 0x80
@   0x080094e0: 01c9        lsls	r1, r1, #7
@   0x080094e2: f7fd        fb51 	bl	0x6b88
@   0x080094e6: bcf0        pop	{r4, r5, r6, r7}
@   0x080094e8: bc01        pop	{r0}
@   0x080094ea: 4700        bx	r0
@   0x080094ec: 5330        strh	r0, [r6, r4]
@   0x080094ee: 0300        lsls	r0, r0, #12
@   0x080094f0: 35e0        adds	r5, #224	@ 0xe0
@   0x080094f2: 0300        lsls	r0, r0, #12
@   0x080094f4: 3720        adds	r7, #32
@   0x080094f6: 0300        lsls	r0, r0, #12

        thumb_func_start Entity_Advance
Entity_Advance: @ 0x08009188
        .incbin "frog_us_baserom.gba", 0x9188, 0x370
        thumb_func_end Entity_Advance
