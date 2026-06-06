@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017364, 0x080177a0)  (1084 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017364 --end 0x80177a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017364: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08017366: 4657        mov	r7, sl
@   0x08017368: 464e        mov	r6, r9
@   0x0801736a: 4645        mov	r5, r8
@   0x0801736c: b4e0        push	{r5, r6, r7}
@   0x0801736e: b08f        sub	sp, #60	@ 0x3c
@   0x08017370: ad0c        add	r5, sp, #48	@ 0x30
@   0x08017372: 4c16        ldr	r4, [pc, #88]	@ (0x173cc)
@   0x08017374: 8820        ldrh	r0, [r4, #0]
@   0x08017376: 8028        strh	r0, [r5, #0]
@   0x08017378: f016        fb10 	bl	0x2d99c
@   0x0801737c: 8821        ldrh	r1, [r4, #0]
@   0x0801737e: 4814        ldr	r0, [pc, #80]	@ (0x173d0)
@   0x08017380: 4008        ands	r0, r1
@   0x08017382: 8020        strh	r0, [r4, #0]
@   0x08017384: 8821        ldrh	r1, [r4, #0]
@   0x08017386: 4813        ldr	r0, [pc, #76]	@ (0x173d4)
@   0x08017388: 4008        ands	r0, r1
@   0x0801738a: 8020        strh	r0, [r4, #0]
@   0x0801738c: 8820        ldrh	r0, [r4, #0]
@   0x0801738e: 2140        movs	r1, #64	@ 0x40
@   0x08017390: 4308        orrs	r0, r1
@   0x08017392: 8020        strh	r0, [r4, #0]
@   0x08017394: 4e10        ldr	r6, [pc, #64]	@ (0x173d8)
@   0x08017396: 2200        movs	r2, #0
@   0x08017398: 63f2        str	r2, [r6, #60]	@ 0x3c
@   0x0801739a: 1c30        adds	r0, r6, #0
@   0x0801739c: 3038        adds	r0, #56	@ 0x38
@   0x0801739e: 7002        strb	r2, [r0, #0]
@   0x080173a0: 73b2        strb	r2, [r6, #14]
@   0x080173a2: 2005        movs	r0, #5
@   0x080173a4: 7370        strb	r0, [r6, #13]
@   0x080173a6: 7332        strb	r2, [r6, #12]
@   0x080173a8: 20ff        movs	r0, #255	@ 0xff
@   0x080173aa: 60b0        str	r0, [r6, #8]
@   0x080173ac: 7bf1        ldrb	r1, [r6, #15]
@   0x080173ae: 4301        orrs	r1, r0
@   0x080173b0: 73f1        strb	r1, [r6, #15]
@   0x080173b2: 7cf1        ldrb	r1, [r6, #19]
@   0x080173b4: 4308        orrs	r0, r1
@   0x080173b6: 74f0        strb	r0, [r6, #19]
@   0x080173b8: 7072        strb	r2, [r6, #1]
@   0x080173ba: 7032        strb	r2, [r6, #0]
@   0x080173bc: f7ff        ff9a 	bl	0x172f4
@   0x080173c0: 46a9        mov	r9, r5
@   0x080173c2: 2800        cmp	r0, #0
@   0x080173c4: d10a        bne.n	0x173dc
@   0x080173c6: 63f0        str	r0, [r6, #60]	@ 0x3c
@   0x080173c8: e0ae        b.n	0x17528
@   0x080173ca: 0000        movs	r0, r0
@   0x080173cc: 0200        lsls	r0, r0, #8
@   0x080173ce: 0400        lsls	r0, r0, #16
@   0x080173d0: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x080173d4: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x080173d8: 3500        adds	r5, #0
@   0x080173da: 0300        lsls	r0, r0, #12
@   0x080173dc: 2f00        cmp	r7, #0
@   0x080173de: d000        beq.n	0x173e2
@   0x080173e0: e0a2        b.n	0x17528
@   0x080173e2: ac0d        add	r4, sp, #52	@ 0x34
@   0x080173e4: 1c20        adds	r0, r4, #0
@   0x080173e6: f000        f9db 	bl	0x177a0
@   0x080173ea: 46a0        mov	r8, r4
@   0x080173ec: 2800        cmp	r0, #0
@   0x080173ee: d100        bne.n	0x173f2
@   0x080173f0: e09a        b.n	0x17528
@   0x080173f2: 2001        movs	r0, #1
@   0x080173f4: 63f0        str	r0, [r6, #60]	@ 0x3c
@   0x080173f6: 2701        movs	r7, #1
@   0x080173f8: 7822        ldrb	r2, [r4, #0]
@   0x080173fa: 2a0f        cmp	r2, #15
@   0x080173fc: d900        bls.n	0x17400
@   0x080173fe: 2700        movs	r7, #0
@   0x08017400: 4643        mov	r3, r8
@   0x08017402: 78d8        ldrb	r0, [r3, #3]
@   0x08017404: 2800        cmp	r0, #0
@   0x08017406: d000        beq.n	0x1740a
@   0x08017408: 2700        movs	r7, #0
@   0x0801740a: 4644        mov	r4, r8
@   0x0801740c: 7860        ldrb	r0, [r4, #1]
@   0x0801740e: 2804        cmp	r0, #4
@   0x08017410: d900        bls.n	0x17414
@   0x08017412: 2700        movs	r7, #0
@   0x08017414: 4641        mov	r1, r8
@   0x08017416: 7988        ldrb	r0, [r1, #6]
@   0x08017418: 3803        subs	r0, #3
@   0x0801741a: 0600        lsls	r0, r0, #24
@   0x0801741c: 0e00        lsrs	r0, r0, #24
@   0x0801741e: 2806        cmp	r0, #6
@   0x08017420: d900        bls.n	0x17424
@   0x08017422: 2700        movs	r7, #0
@   0x08017424: 4642        mov	r2, r8
@   0x08017426: 79d0        ldrb	r0, [r2, #7]
@   0x08017428: 3803        subs	r0, #3
@   0x0801742a: 0600        lsls	r0, r0, #24
@   0x0801742c: 0e00        lsrs	r0, r0, #24
@   0x0801742e: 2806        cmp	r0, #6
@   0x08017430: d900        bls.n	0x17434
@   0x08017432: 2700        movs	r7, #0
@   0x08017434: 2f00        cmp	r7, #0
@   0x08017436: d10c        bne.n	0x17452
@   0x08017438: 4643        mov	r3, r8
@   0x0801743a: 701f        strb	r7, [r3, #0]
@   0x0801743c: 709f        strb	r7, [r3, #2]
@   0x0801743e: 70df        strb	r7, [r3, #3]
@   0x08017440: 705f        strb	r7, [r3, #1]
@   0x08017442: 480f        ldr	r0, [pc, #60]	@ (0x17480)
@   0x08017444: 6800        ldr	r0, [r0, #0]
@   0x08017446: 6058        str	r0, [r3, #4]
@   0x08017448: 4640        mov	r0, r8
@   0x0801744a: f000        f9c5 	bl	0x177d8
@   0x0801744e: 2800        cmp	r0, #0
@   0x08017450: d06a        beq.n	0x17528
@   0x08017452: 980d        ldr	r0, [sp, #52]	@ 0x34
@   0x08017454: 990e        ldr	r1, [sp, #56]	@ 0x38
@   0x08017456: 6030        str	r0, [r6, #0]
@   0x08017458: 6071        str	r1, [r6, #4]
@   0x0801745a: 2500        movs	r5, #0
@   0x0801745c: 4c09        ldr	r4, [pc, #36]	@ (0x17484)
@   0x0801745e: 46a2        mov	sl, r4
@   0x08017460: 4646        mov	r6, r8
@   0x08017462: 7833        ldrb	r3, [r6, #0]
@   0x08017464: 412b        asrs	r3, r5
@   0x08017466: 2001        movs	r0, #1
@   0x08017468: 4003        ands	r3, r0
@   0x0801746a: 2b00        cmp	r3, #0
@   0x0801746c: d00c        beq.n	0x17488
@   0x0801746e: 006c        lsls	r4, r5, #1
@   0x08017470: 1960        adds	r0, r4, r5
@   0x08017472: 0080        lsls	r0, r0, #2
@   0x08017474: 4468        add	r0, sp
@   0x08017476: 1c29        adds	r1, r5, #0
@   0x08017478: f000        f9cc 	bl	0x17814
@   0x0801747c: 1c22        adds	r2, r4, #0
@   0x0801747e: e011        b.n	0x174a4
@   0x08017480: 34b4        adds	r4, #180	@ 0xb4
@   0x08017482: 0300        lsls	r0, r0, #12
@   0x08017484: 3500        adds	r5, #0
@   0x08017486: 0300        lsls	r0, r0, #12
@   0x08017488: 006a        lsls	r2, r5, #1
@   0x0801748a: 1950        adds	r0, r2, r5
@   0x0801748c: 0080        lsls	r0, r0, #2
@   0x0801748e: 4468        add	r0, sp
@   0x08017490: 7143        strb	r3, [r0, #5]
@   0x08017492: 7183        strb	r3, [r0, #6]
@   0x08017494: 2141        movs	r1, #65	@ 0x41
@   0x08017496: 7201        strb	r1, [r0, #8]
@   0x08017498: 7241        strb	r1, [r0, #9]
@   0x0801749a: 7281        strb	r1, [r0, #10]
@   0x0801749c: 7103        strb	r3, [r0, #4]
@   0x0801749e: 6003        str	r3, [r0, #0]
@   0x080174a0: 71c3        strb	r3, [r0, #7]
@   0x080174a2: 72c3        strb	r3, [r0, #11]
@   0x080174a4: 1950        adds	r0, r2, r5
@   0x080174a6: 0080        lsls	r0, r0, #2
@   0x080174a8: 4657        mov	r7, sl
@   0x080174aa: 19c3        adds	r3, r0, r7
@   0x080174ac: 4669        mov	r1, sp
@   0x080174ae: 180a        adds	r2, r1, r0
@   0x080174b0: 1c19        adds	r1, r3, #0
@   0x080174b2: 3108        adds	r1, #8
@   0x080174b4: 1c10        adds	r0, r2, #0
@   0x080174b6: c8d0        ldmia	r0!, {r4, r6, r7}
@   0x080174b8: c1d0        stmia	r1!, {r4, r6, r7}
@   0x080174ba: 7a10        ldrb	r0, [r2, #8]
@   0x080174bc: 7418        strb	r0, [r3, #16]
@   0x080174be: 7a50        ldrb	r0, [r2, #9]
@   0x080174c0: 7458        strb	r0, [r3, #17]
@   0x080174c2: 7a90        ldrb	r0, [r2, #10]
@   0x080174c4: 7498        strb	r0, [r3, #18]
@   0x080174c6: 1c68        adds	r0, r5, #1
@   0x080174c8: 0600        lsls	r0, r0, #24
@   0x080174ca: 0e05        lsrs	r5, r0, #24
@   0x080174cc: 2d03        cmp	r5, #3
@   0x080174ce: d9c7        bls.n	0x17460
@   0x080174d0: 4c0d        ldr	r4, [pc, #52]	@ (0x17508)
@   0x080174d2: 2200        movs	r2, #0
@   0x080174d4: 2005        movs	r0, #5
@   0x080174d6: 70e0        strb	r0, [r4, #3]
@   0x080174d8: 70a0        strb	r0, [r4, #2]
@   0x080174da: 2001        movs	r0, #1
@   0x080174dc: 7020        strb	r0, [r4, #0]
@   0x080174de: 7060        strb	r0, [r4, #1]
@   0x080174e0: 490a        ldr	r1, [pc, #40]	@ (0x1750c)
@   0x080174e2: 4643        mov	r3, r8
@   0x080174e4: 7858        ldrb	r0, [r3, #1]
@   0x080174e6: 6008        str	r0, [r1, #0]
@   0x080174e8: 4809        ldr	r0, [pc, #36]	@ (0x17510)
@   0x080174ea: 3038        adds	r0, #56	@ 0x38
@   0x080174ec: 7002        strb	r2, [r0, #0]
@   0x080174ee: f008        ff4b 	bl	0x20388
@   0x080174f2: 7820        ldrb	r0, [r4, #0]
@   0x080174f4: 2800        cmp	r0, #0
@   0x080174f6: d101        bne.n	0x174fc
@   0x080174f8: f009        fb7a 	bl	0x20bf0
@   0x080174fc: 7860        ldrb	r0, [r4, #1]
@   0x080174fe: 2800        cmp	r0, #0
@   0x08017500: d008        beq.n	0x17514
@   0x08017502: f009        fba9 	bl	0x20c58
@   0x08017506: e007        b.n	0x17518
@   0x08017508: 34b4        adds	r4, #180	@ 0xb4
@   0x0801750a: 0300        lsls	r0, r0, #12
@   0x0801750c: 34b0        adds	r4, #176	@ 0xb0
@   0x0801750e: 0300        lsls	r0, r0, #12
@   0x08017510: 3500        adds	r5, #0
@   0x08017512: 0300        lsls	r0, r0, #12
@   0x08017514: f009        fb92 	bl	0x20c3c
@   0x08017518: 4902        ldr	r1, [pc, #8]	@ (0x17524)
@   0x0801751a: 464c        mov	r4, r9
@   0x0801751c: 8820        ldrh	r0, [r4, #0]
@   0x0801751e: 8008        strh	r0, [r1, #0]
@   0x08017520: 2001        movs	r0, #1
@   0x08017522: e018        b.n	0x17556
@   0x08017524: 0200        lsls	r0, r0, #8
@   0x08017526: 0400        lsls	r0, r0, #16
@   0x08017528: f008        ff2e 	bl	0x20388
@   0x0801752c: 4c05        ldr	r4, [pc, #20]	@ (0x17544)
@   0x0801752e: 7820        ldrb	r0, [r4, #0]
@   0x08017530: 2800        cmp	r0, #0
@   0x08017532: d101        bne.n	0x17538
@   0x08017534: f009        fb5c 	bl	0x20bf0
@   0x08017538: 7860        ldrb	r0, [r4, #1]
@   0x0801753a: 2800        cmp	r0, #0
@   0x0801753c: d004        beq.n	0x17548
@   0x0801753e: f009        fb8b 	bl	0x20c58
@   0x08017542: e003        b.n	0x1754c
@   0x08017544: 34b4        adds	r4, #180	@ 0xb4
@   0x08017546: 0300        lsls	r0, r0, #12
@   0x08017548: f009        fb78 	bl	0x20c3c
@   0x0801754c: 4906        ldr	r1, [pc, #24]	@ (0x17568)
@   0x0801754e: 464e        mov	r6, r9
@   0x08017550: 8830        ldrh	r0, [r6, #0]
@   0x08017552: 8008        strh	r0, [r1, #0]
@   0x08017554: 2000        movs	r0, #0
@   0x08017556: b00f        add	sp, #60	@ 0x3c
@   0x08017558: bc38        pop	{r3, r4, r5}
@   0x0801755a: 4698        mov	r8, r3
@   0x0801755c: 46a1        mov	r9, r4
@   0x0801755e: 46aa        mov	sl, r5
@   0x08017560: bcf0        pop	{r4, r5, r6, r7}
@   0x08017562: bc02        pop	{r1}
@   0x08017564: 4708        bx	r1
@   0x08017566: 0000        movs	r0, r0
@   0x08017568: 0200        lsls	r0, r0, #8
@   0x0801756a: 0400        lsls	r0, r0, #16
@   0x0801756c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801756e: 4657        mov	r7, sl
@   0x08017570: 464e        mov	r6, r9
@   0x08017572: 4645        mov	r5, r8
@   0x08017574: b4e0        push	{r5, r6, r7}
@   0x08017576: b086        sub	sp, #24
@   0x08017578: 1c0e        adds	r6, r1, #0
@   0x0801757a: 0600        lsls	r0, r0, #24
@   0x0801757c: 0e07        lsrs	r7, r0, #24
@   0x0801757e: ad03        add	r5, sp, #12
@   0x08017580: 4c43        ldr	r4, [pc, #268]	@ (0x17690)
@   0x08017582: 8820        ldrh	r0, [r4, #0]
@   0x08017584: 8028        strh	r0, [r5, #0]
@   0x08017586: f016        fa09 	bl	0x2d99c
@   0x0801758a: 8821        ldrh	r1, [r4, #0]
@   0x0801758c: 4841        ldr	r0, [pc, #260]	@ (0x17694)
@   0x0801758e: 4008        ands	r0, r1
@   0x08017590: 8020        strh	r0, [r4, #0]
@   0x08017592: 8821        ldrh	r1, [r4, #0]
@   0x08017594: 4840        ldr	r0, [pc, #256]	@ (0x17698)
@   0x08017596: 4008        ands	r0, r1
@   0x08017598: 8020        strh	r0, [r4, #0]
@   0x0801759a: 8820        ldrh	r0, [r4, #0]
@   0x0801759c: 2140        movs	r1, #64	@ 0x40
@   0x0801759e: 4308        orrs	r0, r1
@   0x080175a0: 8020        strh	r0, [r4, #0]
@   0x080175a2: 483e        ldr	r0, [pc, #248]	@ (0x1769c)
@   0x080175a4: 4680        mov	r8, r0
@   0x080175a6: 6bc0        ldr	r0, [r0, #60]	@ 0x3c
@   0x080175a8: 46aa        mov	sl, r5
@   0x080175aa: 2800        cmp	r0, #0
@   0x080175ac: d100        bne.n	0x175b0
@   0x080175ae: e08d        b.n	0x176cc
@   0x080175b0: 2500        movs	r5, #0
@   0x080175b2: 2004        movs	r0, #4
@   0x080175b4: f01c        f978 	bl	0x338a8
@   0x080175b8: 4642        mov	r2, r8
@   0x080175ba: 6810        ldr	r0, [r2, #0]
@   0x080175bc: 6851        ldr	r1, [r2, #4]
@   0x080175be: 9004        str	r0, [sp, #16]
@   0x080175c0: 9105        str	r1, [sp, #20]
@   0x080175c2: 4837        ldr	r0, [pc, #220]	@ (0x176a0)
@   0x080175c4: 7800        ldrb	r0, [r0, #0]
@   0x080175c6: 0202        lsls	r2, r0, #8
@   0x080175c8: 4936        ldr	r1, [pc, #216]	@ (0x176a4)
@   0x080175ca: 9804        ldr	r0, [sp, #16]
@   0x080175cc: 4008        ands	r0, r1
@   0x080175ce: 4310        orrs	r0, r2
@   0x080175d0: 9004        str	r0, [sp, #16]
@   0x080175d2: 4b35        ldr	r3, [pc, #212]	@ (0x176a8)
@   0x080175d4: 4699        mov	r9, r3
@   0x080175d6: 6818        ldr	r0, [r3, #0]
@   0x080175d8: ac04        add	r4, sp, #16
@   0x080175da: 6060        str	r0, [r4, #4]
@   0x080175dc: 4669        mov	r1, sp
@   0x080175de: 4a33        ldr	r2, [pc, #204]	@ (0x176ac)
@   0x080175e0: 7a90        ldrb	r0, [r2, #10]
@   0x080175e2: 7108        strb	r0, [r1, #4]
@   0x080175e4: 0600        lsls	r0, r0, #24
@   0x080175e6: 0e00        lsrs	r0, r0, #24
@   0x080175e8: 2810        cmp	r0, #16
@   0x080175ea: d101        bne.n	0x175f0
@   0x080175ec: 200f        movs	r0, #15
@   0x080175ee: 7108        strb	r0, [r1, #4]
@   0x080175f0: 68d0        ldr	r0, [r2, #12]
@   0x080175f2: 9000        str	r0, [sp, #0]
@   0x080175f4: 4669        mov	r1, sp
@   0x080175f6: 4a2e        ldr	r2, [pc, #184]	@ (0x176b0)
@   0x080175f8: 7810        ldrb	r0, [r2, #0]
@   0x080175fa: 7148        strb	r0, [r1, #5]
@   0x080175fc: 8850        ldrh	r0, [r2, #2]
@   0x080175fe: 7188        strb	r0, [r1, #6]
@   0x08017600: 7830        ldrb	r0, [r6, #0]
@   0x08017602: 7208        strb	r0, [r1, #8]
@   0x08017604: 7870        ldrb	r0, [r6, #1]
@   0x08017606: 7248        strb	r0, [r1, #9]
@   0x08017608: 78b0        ldrb	r0, [r6, #2]
@   0x0801760a: 7288        strb	r0, [r1, #10]
@   0x0801760c: 4668        mov	r0, sp
@   0x0801760e: 71c5        strb	r5, [r0, #7]
@   0x08017610: 72c5        strb	r5, [r0, #11]
@   0x08017612: 1c39        adds	r1, r7, #0
@   0x08017614: f000        f920 	bl	0x17858
@   0x08017618: 2800        cmp	r0, #0
@   0x0801761a: d057        beq.n	0x176cc
@   0x0801761c: 2001        movs	r0, #1
@   0x0801761e: 40b8        lsls	r0, r7
@   0x08017620: 7825        ldrb	r5, [r4, #0]
@   0x08017622: 4328        orrs	r0, r5
@   0x08017624: 0600        lsls	r0, r0, #24
@   0x08017626: 0e05        lsrs	r5, r0, #24
@   0x08017628: 4922        ldr	r1, [pc, #136]	@ (0x176b4)
@   0x0801762a: 9804        ldr	r0, [sp, #16]
@   0x0801762c: 4008        ands	r0, r1
@   0x0801762e: 4328        orrs	r0, r5
@   0x08017630: 9004        str	r0, [sp, #16]
@   0x08017632: 1c20        adds	r0, r4, #0
@   0x08017634: f000        f8d0 	bl	0x177d8
@   0x08017638: 2800        cmp	r0, #0
@   0x0801763a: d047        beq.n	0x176cc
@   0x0801763c: 9804        ldr	r0, [sp, #16]
@   0x0801763e: 9905        ldr	r1, [sp, #20]
@   0x08017640: 4642        mov	r2, r8
@   0x08017642: 6010        str	r0, [r2, #0]
@   0x08017644: 6051        str	r1, [r2, #4]
@   0x08017646: 007a        lsls	r2, r7, #1
@   0x08017648: 19d2        adds	r2, r2, r7
@   0x0801764a: 0092        lsls	r2, r2, #2
@   0x0801764c: 4442        add	r2, r8
@   0x0801764e: 1c11        adds	r1, r2, #0
@   0x08017650: 3108        adds	r1, #8
@   0x08017652: 4668        mov	r0, sp
@   0x08017654: c838        ldmia	r0!, {r3, r4, r5}
@   0x08017656: c138        stmia	r1!, {r3, r4, r5}
@   0x08017658: 4668        mov	r0, sp
@   0x0801765a: 7a00        ldrb	r0, [r0, #8]
@   0x0801765c: 7410        strb	r0, [r2, #16]
@   0x0801765e: 4668        mov	r0, sp
@   0x08017660: 7a40        ldrb	r0, [r0, #9]
@   0x08017662: 7450        strb	r0, [r2, #17]
@   0x08017664: 4668        mov	r0, sp
@   0x08017666: 7a80        ldrb	r0, [r0, #10]
@   0x08017668: 7490        strb	r0, [r2, #18]
@   0x0801766a: 4640        mov	r0, r8
@   0x0801766c: 3038        adds	r0, #56	@ 0x38
@   0x0801766e: 7007        strb	r7, [r0, #0]
@   0x08017670: f008        fe8a 	bl	0x20388
@   0x08017674: 4649        mov	r1, r9
@   0x08017676: 7808        ldrb	r0, [r1, #0]
@   0x08017678: 2800        cmp	r0, #0
@   0x0801767a: d101        bne.n	0x17680
@   0x0801767c: f009        fab8 	bl	0x20bf0
@   0x08017680: 464a        mov	r2, r9
@   0x08017682: 7850        ldrb	r0, [r2, #1]
@   0x08017684: 2800        cmp	r0, #0
@   0x08017686: d017        beq.n	0x176b8
@   0x08017688: f009        fae6 	bl	0x20c58
@   0x0801768c: e016        b.n	0x176bc
@   0x0801768e: 0000        movs	r0, r0
@   0x08017690: 0200        lsls	r0, r0, #8
@   0x08017692: 0400        lsls	r0, r0, #16
@   0x08017694: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x08017698: fffd        0000 	vcgt.s<illegal width 64>	d16, d0, #0
@   0x0801769c: 3500        adds	r5, #0
@   0x0801769e: 0300        lsls	r0, r0, #12
@   0x080176a0: 34b0        adds	r4, #176	@ 0xb0
@   0x080176a2: 0300        lsls	r0, r0, #12
@   0x080176a4: 00ff        lsls	r7, r7, #3
@   0x080176a6: ffff        34b4 	vsri.64	d19, d20, #1
@   0x080176aa: 0300        lsls	r0, r0, #12
@   0x080176ac: 5330        strh	r0, [r6, r4]
@   0x080176ae: 0300        lsls	r0, r0, #12
@   0x080176b0: 35e0        adds	r5, #224	@ 0xe0
@   0x080176b2: 0300        lsls	r0, r0, #12
@   0x080176b4: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x080176b8: f009        fac0 	bl	0x20c3c
@   0x080176bc: 4902        ldr	r1, [pc, #8]	@ (0x176c8)
@   0x080176be: 4653        mov	r3, sl
@   0x080176c0: 8818        ldrh	r0, [r3, #0]
@   0x080176c2: 8008        strh	r0, [r1, #0]
@   0x080176c4: 2001        movs	r0, #1
@   0x080176c6: e018        b.n	0x176fa
@   0x080176c8: 0200        lsls	r0, r0, #8
@   0x080176ca: 0400        lsls	r0, r0, #16
@   0x080176cc: f008        fe5c 	bl	0x20388
@   0x080176d0: 4c05        ldr	r4, [pc, #20]	@ (0x176e8)
@   0x080176d2: 7820        ldrb	r0, [r4, #0]
@   0x080176d4: 2800        cmp	r0, #0
@   0x080176d6: d101        bne.n	0x176dc
@   0x080176d8: f009        fa8a 	bl	0x20bf0
@   0x080176dc: 7860        ldrb	r0, [r4, #1]
@   0x080176de: 2800        cmp	r0, #0
@   0x080176e0: d004        beq.n	0x176ec
@   0x080176e2: f009        fab9 	bl	0x20c58
@   0x080176e6: e003        b.n	0x176f0
@   0x080176e8: 34b4        adds	r4, #180	@ 0xb4
@   0x080176ea: 0300        lsls	r0, r0, #12
@   0x080176ec: f009        faa6 	bl	0x20c3c
@   0x080176f0: 4906        ldr	r1, [pc, #24]	@ (0x1770c)
@   0x080176f2: 4654        mov	r4, sl
@   0x080176f4: 8820        ldrh	r0, [r4, #0]
@   0x080176f6: 8008        strh	r0, [r1, #0]
@   0x080176f8: 2000        movs	r0, #0
@   0x080176fa: b006        add	sp, #24
@   0x080176fc: bc38        pop	{r3, r4, r5}
@   0x080176fe: 4698        mov	r8, r3
@   0x08017700: 46a1        mov	r9, r4
@   0x08017702: 46aa        mov	sl, r5
@   0x08017704: bcf0        pop	{r4, r5, r6, r7}
@   0x08017706: bc02        pop	{r1}
@   0x08017708: 4708        bx	r1
@   0x0801770a: 0000        movs	r0, r0
@   0x0801770c: 0200        lsls	r0, r0, #8
@   0x0801770e: 0400        lsls	r0, r0, #16
@   0x08017710: b570        push	{r4, r5, r6, lr}
@   0x08017712: b083        sub	sp, #12
@   0x08017714: 0600        lsls	r0, r0, #24
@   0x08017716: 0e02        lsrs	r2, r0, #24
@   0x08017718: 1c14        adds	r4, r2, #0
@   0x0801771a: 4b1b        ldr	r3, [pc, #108]	@ (0x17788)
@   0x0801771c: 7818        ldrb	r0, [r3, #0]
@   0x0801771e: 4110        asrs	r0, r2
@   0x08017720: 2101        movs	r1, #1
@   0x08017722: 4008        ands	r0, r1
@   0x08017724: 2800        cmp	r0, #0
@   0x08017726: d035        beq.n	0x17794
@   0x08017728: 0050        lsls	r0, r2, #1
@   0x0801772a: 1880        adds	r0, r0, r2
@   0x0801772c: 0080        lsls	r0, r0, #2
@   0x0801772e: 18c0        adds	r0, r0, r3
@   0x08017730: 4669        mov	r1, sp
@   0x08017732: 3008        adds	r0, #8
@   0x08017734: c864        ldmia	r0!, {r2, r5, r6}
@   0x08017736: c164        stmia	r1!, {r2, r5, r6}
@   0x08017738: 4914        ldr	r1, [pc, #80]	@ (0x1778c)
@   0x0801773a: 4668        mov	r0, sp
@   0x0801773c: 7900        ldrb	r0, [r0, #4]
@   0x0801773e: 7288        strb	r0, [r1, #10]
@   0x08017740: 0600        lsls	r0, r0, #24
@   0x08017742: 0e00        lsrs	r0, r0, #24
@   0x08017744: 2810        cmp	r0, #16
@   0x08017746: d101        bne.n	0x1774c
@   0x08017748: 200f        movs	r0, #15
@   0x0801774a: 7288        strb	r0, [r1, #10]
@   0x0801774c: 9800        ldr	r0, [sp, #0]
@   0x0801774e: 60c8        str	r0, [r1, #12]
@   0x08017750: 4a0f        ldr	r2, [pc, #60]	@ (0x17790)
@   0x08017752: 4668        mov	r0, sp
@   0x08017754: 7940        ldrb	r0, [r0, #5]
@   0x08017756: 7010        strb	r0, [r2, #0]
@   0x08017758: 4668        mov	r0, sp
@   0x0801775a: 7980        ldrb	r0, [r0, #6]
@   0x0801775c: 8050        strh	r0, [r2, #2]
@   0x0801775e: 4668        mov	r0, sp
@   0x08017760: 7a01        ldrb	r1, [r0, #8]
@   0x08017762: 1c10        adds	r0, r2, #0
@   0x08017764: 3020        adds	r0, #32
@   0x08017766: 7001        strb	r1, [r0, #0]
@   0x08017768: 4668        mov	r0, sp
@   0x0801776a: 7a40        ldrb	r0, [r0, #9]
@   0x0801776c: 1c11        adds	r1, r2, #0
@   0x0801776e: 3121        adds	r1, #33	@ 0x21
@   0x08017770: 7008        strb	r0, [r1, #0]
@   0x08017772: 4668        mov	r0, sp
@   0x08017774: 7a81        ldrb	r1, [r0, #10]
@   0x08017776: 1c10        adds	r0, r2, #0
@   0x08017778: 3022        adds	r0, #34	@ 0x22
@   0x0801777a: 7001        strb	r1, [r0, #0]
@   0x0801777c: 1c18        adds	r0, r3, #0
@   0x0801777e: 3038        adds	r0, #56	@ 0x38
@   0x08017780: 7004        strb	r4, [r0, #0]
@   0x08017782: 2001        movs	r0, #1
@   0x08017784: e007        b.n	0x17796
@   0x08017786: 0000        movs	r0, r0
@   0x08017788: 3500        adds	r5, #0
@   0x0801778a: 0300        lsls	r0, r0, #12
@   0x0801778c: 5330        strh	r0, [r6, r4]
@   0x0801778e: 0300        lsls	r0, r0, #12
@   0x08017790: 35e0        adds	r5, #224	@ 0xe0
@   0x08017792: 0300        lsls	r0, r0, #12
@   0x08017794: 2000        movs	r0, #0
@   0x08017796: b003        add	sp, #12
@   0x08017798: bc70        pop	{r4, r5, r6}
@   0x0801779a: bc02        pop	{r1}
@   0x0801779c: 4708        bx	r1

        thumb_func_start SaveLoad
SaveLoad: @ 0x08017364
        .incbin "frog_us_baserom.gba", 0x17364, 0x208
        thumb_func_end SaveLoad

        thumb_func_start SaveCommit
SaveCommit: @ 0x0801756c
        .incbin "frog_us_baserom.gba", 0x1756c, 0x234
        thumb_func_end SaveCommit
