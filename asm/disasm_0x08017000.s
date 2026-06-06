@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08017000, 0x080172f4)  (756 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8017000 --end 0x80172f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08017000: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08017002: 4657        mov	r7, sl
@   0x08017004: 464e        mov	r6, r9
@   0x08017006: 4645        mov	r5, r8
@   0x08017008: b4e0        push	{r5, r6, r7}
@   0x0801700a: 2001        movs	r0, #1
@   0x0801700c: 4682        mov	sl, r0
@   0x0801700e: 493e        ldr	r1, [pc, #248]	@ (0x17108)
@   0x08017010: 7a89        ldrb	r1, [r1, #10]
@   0x08017012: 2903        cmp	r1, #3
@   0x08017014: d100        bne.n	0x17018
@   0x08017016: e115        b.n	0x17244
@   0x08017018: 4a3c        ldr	r2, [pc, #240]	@ (0x1710c)
@   0x0801701a: 4b3b        ldr	r3, [pc, #236]	@ (0x17108)
@   0x0801701c: 6819        ldr	r1, [r3, #0]
@   0x0801701e: 6850        ldr	r0, [r2, #4]
@   0x08017020: 1a09        subs	r1, r1, r0
@   0x08017022: 4694        mov	ip, r2
@   0x08017024: 483a        ldr	r0, [pc, #232]	@ (0x17110)
@   0x08017026: 4680        mov	r8, r0
@   0x08017028: 2907        cmp	r1, #7
@   0x0801702a: d95f        bls.n	0x170ec
@   0x0801702c: 7811        ldrb	r1, [r2, #0]
@   0x0801702e: 2906        cmp	r1, #6
@   0x08017030: d901        bls.n	0x17036
@   0x08017032: 2000        movs	r0, #0
@   0x08017034: 7010        strb	r0, [r2, #0]
@   0x08017036: 4d37        ldr	r5, [pc, #220]	@ (0x17114)
@   0x08017038: 4a37        ldr	r2, [pc, #220]	@ (0x17118)
@   0x0801703a: 4663        mov	r3, ip
@   0x0801703c: 7818        ldrb	r0, [r3, #0]
@   0x0801703e: 3001        adds	r0, #1
@   0x08017040: 0041        lsls	r1, r0, #1
@   0x08017042: 1809        adds	r1, r1, r0
@   0x08017044: 0089        lsls	r1, r1, #2
@   0x08017046: 1c10        adds	r0, r2, #0
@   0x08017048: 3008        adds	r0, #8
@   0x0801704a: 1808        adds	r0, r1, r0
@   0x0801704c: 6806        ldr	r6, [r0, #0]
@   0x0801704e: 2400        movs	r4, #0
@   0x08017050: 1889        adds	r1, r1, r2
@   0x08017052: 8848        ldrh	r0, [r1, #2]
@   0x08017054: 4284        cmp	r4, r0
@   0x08017056: d206        bcs.n	0x17066
@   0x08017058: 1c01        adds	r1, r0, #0
@   0x0801705a: 3540        adds	r5, #64	@ 0x40
@   0x0801705c: 1c60        adds	r0, r4, #1
@   0x0801705e: 0400        lsls	r0, r0, #16
@   0x08017060: 0c04        lsrs	r4, r0, #16
@   0x08017062: 428c        cmp	r4, r1
@   0x08017064: d3f9        bcc.n	0x1705a
@   0x08017066: 2400        movs	r4, #0
@   0x08017068: 4660        mov	r0, ip
@   0x0801706a: 7801        ldrb	r1, [r0, #0]
@   0x0801706c: 3101        adds	r1, #1
@   0x0801706e: 0048        lsls	r0, r1, #1
@   0x08017070: 1840        adds	r0, r0, r1
@   0x08017072: 0080        lsls	r0, r0, #2
@   0x08017074: 1880        adds	r0, r0, r2
@   0x08017076: 8880        ldrh	r0, [r0, #4]
@   0x08017078: 4284        cmp	r4, r0
@   0x0801707a: d230        bcs.n	0x170de
@   0x0801707c: 4667        mov	r7, ip
@   0x0801707e: 7838        ldrb	r0, [r7, #0]
@   0x08017080: 3001        adds	r0, #1
@   0x08017082: 0041        lsls	r1, r0, #1
@   0x08017084: 1809        adds	r1, r1, r0
@   0x08017086: 0089        lsls	r1, r1, #2
@   0x08017088: 1889        adds	r1, r1, r2
@   0x0801708a: 880b        ldrh	r3, [r1, #0]
@   0x0801708c: 0058        lsls	r0, r3, #1
@   0x0801708e: 182d        adds	r5, r5, r0
@   0x08017090: 2300        movs	r3, #0
@   0x08017092: 3401        adds	r4, #1
@   0x08017094: 88c9        ldrh	r1, [r1, #6]
@   0x08017096: 428b        cmp	r3, r1
@   0x08017098: d20f        bcs.n	0x170ba
@   0x0801709a: 8830        ldrh	r0, [r6, #0]
@   0x0801709c: 8028        strh	r0, [r5, #0]
@   0x0801709e: 3602        adds	r6, #2
@   0x080170a0: 3502        adds	r5, #2
@   0x080170a2: 1c58        adds	r0, r3, #1
@   0x080170a4: 0400        lsls	r0, r0, #16
@   0x080170a6: 0c03        lsrs	r3, r0, #16
@   0x080170a8: 7839        ldrb	r1, [r7, #0]
@   0x080170aa: 3101        adds	r1, #1
@   0x080170ac: 0048        lsls	r0, r1, #1
@   0x080170ae: 1840        adds	r0, r0, r1
@   0x080170b0: 0080        lsls	r0, r0, #2
@   0x080170b2: 1880        adds	r0, r0, r2
@   0x080170b4: 88c0        ldrh	r0, [r0, #6]
@   0x080170b6: 4283        cmp	r3, r0
@   0x080170b8: d3ef        bcc.n	0x1709a
@   0x080170ba: 7838        ldrb	r0, [r7, #0]
@   0x080170bc: 3001        adds	r0, #1
@   0x080170be: 0041        lsls	r1, r0, #1
@   0x080170c0: 1809        adds	r1, r1, r0
@   0x080170c2: 0089        lsls	r1, r1, #2
@   0x080170c4: 1889        adds	r1, r1, r2
@   0x080170c6: 2020        movs	r0, #32
@   0x080170c8: 880b        ldrh	r3, [r1, #0]
@   0x080170ca: 1ac0        subs	r0, r0, r3
@   0x080170cc: 88cb        ldrh	r3, [r1, #6]
@   0x080170ce: 1ac0        subs	r0, r0, r3
@   0x080170d0: 0040        lsls	r0, r0, #1
@   0x080170d2: 182d        adds	r5, r5, r0
@   0x080170d4: 0420        lsls	r0, r4, #16
@   0x080170d6: 0c04        lsrs	r4, r0, #16
@   0x080170d8: 8889        ldrh	r1, [r1, #4]
@   0x080170da: 428c        cmp	r4, r1
@   0x080170dc: d3cf        bcc.n	0x1707e
@   0x080170de: 4661        mov	r1, ip
@   0x080170e0: 7808        ldrb	r0, [r1, #0]
@   0x080170e2: 3001        adds	r0, #1
@   0x080170e4: 7008        strb	r0, [r1, #0]
@   0x080170e6: 4a08        ldr	r2, [pc, #32]	@ (0x17108)
@   0x080170e8: 6810        ldr	r0, [r2, #0]
@   0x080170ea: 6048        str	r0, [r1, #4]
@   0x080170ec: 4b0b        ldr	r3, [pc, #44]	@ (0x1711c)
@   0x080170ee: 2004        movs	r0, #4
@   0x080170f0: 5618        ldrsb	r0, [r3, r0]
@   0x080170f2: 4641        mov	r1, r8
@   0x080170f4: 7889        ldrb	r1, [r1, #2]
@   0x080170f6: 4288        cmp	r0, r1
@   0x080170f8: db12        blt.n	0x17120
@   0x080170fa: 4a03        ldr	r2, [pc, #12]	@ (0x17108)
@   0x080170fc: 7a92        ldrb	r2, [r2, #10]
@   0x080170fe: 2a0f        cmp	r2, #15
@   0x08017100: d00e        beq.n	0x17120
@   0x08017102: f7ff        fc11 	bl	0x16928
@   0x08017106: e09d        b.n	0x17244
@   0x08017108: 5330        strh	r0, [r6, r4]
@   0x0801710a: 0300        lsls	r0, r0, #12
@   0x0801710c: 6100        str	r0, [r0, #16]
@   0x0801710e: 0300        lsls	r0, r0, #12
@   0x08017110: 6110        str	r0, [r2, #16]
@   0x08017112: 0300        lsls	r0, r0, #12
@   0x08017114: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08017118: 3628        adds	r6, #40	@ 0x28
@   0x0801711a: 080e        lsrs	r6, r1, #32
@   0x0801711c: 35e0        adds	r5, #224	@ 0xe0
@   0x0801711e: 0300        lsls	r0, r0, #12
@   0x08017120: 484c        ldr	r0, [pc, #304]	@ (0x17254)
@   0x08017122: 4b4d        ldr	r3, [pc, #308]	@ (0x17258)
@   0x08017124: 6819        ldr	r1, [r3, #0]
@   0x08017126: 6842        ldr	r2, [r0, #4]
@   0x08017128: 1a89        subs	r1, r1, r2
@   0x0801712a: 4681        mov	r9, r0
@   0x0801712c: 290d        cmp	r1, #13
@   0x0801712e: d800        bhi.n	0x17132
@   0x08017130: e088        b.n	0x17244
@   0x08017132: 2300        movs	r3, #0
@   0x08017134: 4949        ldr	r1, [pc, #292]	@ (0x1725c)
@   0x08017136: 2004        movs	r0, #4
@   0x08017138: 5608        ldrsb	r0, [r1, r0]
@   0x0801713a: 4283        cmp	r3, r0
@   0x0801713c: da7b        bge.n	0x17236
@   0x0801713e: 4a48        ldr	r2, [pc, #288]	@ (0x17260)
@   0x08017140: 4694        mov	ip, r2
@   0x08017142: 4844        ldr	r0, [pc, #272]	@ (0x17254)
@   0x08017144: 7800        ldrb	r0, [r0, #0]
@   0x08017146: 2804        cmp	r0, #4
@   0x08017148: d902        bls.n	0x17150
@   0x0801714a: 2000        movs	r0, #0
@   0x0801714c: 4649        mov	r1, r9
@   0x0801714e: 7008        strb	r0, [r1, #0]
@   0x08017150: 4a40        ldr	r2, [pc, #256]	@ (0x17254)
@   0x08017152: 7810        ldrb	r0, [r2, #0]
@   0x08017154: 3009        adds	r0, #9
@   0x08017156: 0041        lsls	r1, r0, #1
@   0x08017158: 1809        adds	r1, r1, r0
@   0x0801715a: 0089        lsls	r1, r1, #2
@   0x0801715c: 4660        mov	r0, ip
@   0x0801715e: 180a        adds	r2, r1, r0
@   0x08017160: 7810        ldrb	r0, [r2, #0]
@   0x08017162: 4450        add	r0, sl
@   0x08017164: 0600        lsls	r0, r0, #24
@   0x08017166: 0e00        lsrs	r0, r0, #24
@   0x08017168: 4682        mov	sl, r0
@   0x0801716a: 483e        ldr	r0, [pc, #248]	@ (0x17264)
@   0x0801716c: 1809        adds	r1, r1, r0
@   0x0801716e: 680e        ldr	r6, [r1, #0]
@   0x08017170: 4d3d        ldr	r5, [pc, #244]	@ (0x17268)
@   0x08017172: 4651        mov	r1, sl
@   0x08017174: 0048        lsls	r0, r1, #1
@   0x08017176: 1945        adds	r5, r0, r5
@   0x08017178: 2400        movs	r4, #0
@   0x0801717a: 3301        adds	r3, #1
@   0x0801717c: 4698        mov	r8, r3
@   0x0801717e: 8852        ldrh	r2, [r2, #2]
@   0x08017180: 4294        cmp	r4, r2
@   0x08017182: d20d        bcs.n	0x171a0
@   0x08017184: 4a33        ldr	r2, [pc, #204]	@ (0x17254)
@   0x08017186: 7811        ldrb	r1, [r2, #0]
@   0x08017188: 3109        adds	r1, #9
@   0x0801718a: 0048        lsls	r0, r1, #1
@   0x0801718c: 1840        adds	r0, r0, r1
@   0x0801718e: 0080        lsls	r0, r0, #2
@   0x08017190: 4460        add	r0, ip
@   0x08017192: 8841        ldrh	r1, [r0, #2]
@   0x08017194: 3540        adds	r5, #64	@ 0x40
@   0x08017196: 1c60        adds	r0, r4, #1
@   0x08017198: 0400        lsls	r0, r0, #16
@   0x0801719a: 0c04        lsrs	r4, r0, #16
@   0x0801719c: 428c        cmp	r4, r1
@   0x0801719e: d3f9        bcc.n	0x17194
@   0x080171a0: 2400        movs	r4, #0
@   0x080171a2: 4b2c        ldr	r3, [pc, #176]	@ (0x17254)
@   0x080171a4: 7819        ldrb	r1, [r3, #0]
@   0x080171a6: 3109        adds	r1, #9
@   0x080171a8: 0048        lsls	r0, r1, #1
@   0x080171aa: 1840        adds	r0, r0, r1
@   0x080171ac: 0080        lsls	r0, r0, #2
@   0x080171ae: 4460        add	r0, ip
@   0x080171b0: 8880        ldrh	r0, [r0, #4]
@   0x080171b2: 4284        cmp	r4, r0
@   0x080171b4: d231        bcs.n	0x1721a
@   0x080171b6: 4f2a        ldr	r7, [pc, #168]	@ (0x17260)
@   0x080171b8: 1c1a        adds	r2, r3, #0
@   0x080171ba: 7810        ldrb	r0, [r2, #0]
@   0x080171bc: 3009        adds	r0, #9
@   0x080171be: 0041        lsls	r1, r0, #1
@   0x080171c0: 1809        adds	r1, r1, r0
@   0x080171c2: 0089        lsls	r1, r1, #2
@   0x080171c4: 19c9        adds	r1, r1, r7
@   0x080171c6: 880b        ldrh	r3, [r1, #0]
@   0x080171c8: 0058        lsls	r0, r3, #1
@   0x080171ca: 182d        adds	r5, r5, r0
@   0x080171cc: 2300        movs	r3, #0
@   0x080171ce: 3401        adds	r4, #1
@   0x080171d0: 88c9        ldrh	r1, [r1, #6]
@   0x080171d2: 428b        cmp	r3, r1
@   0x080171d4: d20f        bcs.n	0x171f6
@   0x080171d6: 8830        ldrh	r0, [r6, #0]
@   0x080171d8: 8028        strh	r0, [r5, #0]
@   0x080171da: 3602        adds	r6, #2
@   0x080171dc: 3502        adds	r5, #2
@   0x080171de: 1c58        adds	r0, r3, #1
@   0x080171e0: 0400        lsls	r0, r0, #16
@   0x080171e2: 0c03        lsrs	r3, r0, #16
@   0x080171e4: 7811        ldrb	r1, [r2, #0]
@   0x080171e6: 3109        adds	r1, #9
@   0x080171e8: 0048        lsls	r0, r1, #1
@   0x080171ea: 1840        adds	r0, r0, r1
@   0x080171ec: 0080        lsls	r0, r0, #2
@   0x080171ee: 19c0        adds	r0, r0, r7
@   0x080171f0: 88c0        ldrh	r0, [r0, #6]
@   0x080171f2: 4283        cmp	r3, r0
@   0x080171f4: d3ef        bcc.n	0x171d6
@   0x080171f6: 7810        ldrb	r0, [r2, #0]
@   0x080171f8: 3009        adds	r0, #9
@   0x080171fa: 0041        lsls	r1, r0, #1
@   0x080171fc: 1809        adds	r1, r1, r0
@   0x080171fe: 0089        lsls	r1, r1, #2
@   0x08017200: 19c9        adds	r1, r1, r7
@   0x08017202: 2020        movs	r0, #32
@   0x08017204: 880b        ldrh	r3, [r1, #0]
@   0x08017206: 1ac0        subs	r0, r0, r3
@   0x08017208: 88cb        ldrh	r3, [r1, #6]
@   0x0801720a: 1ac0        subs	r0, r0, r3
@   0x0801720c: 0040        lsls	r0, r0, #1
@   0x0801720e: 182d        adds	r5, r5, r0
@   0x08017210: 0420        lsls	r0, r4, #16
@   0x08017212: 0c04        lsrs	r4, r0, #16
@   0x08017214: 8889        ldrh	r1, [r1, #4]
@   0x08017216: 428c        cmp	r4, r1
@   0x08017218: d3cf        bcc.n	0x171ba
@   0x0801721a: 4914        ldr	r1, [pc, #80]	@ (0x1726c)
@   0x0801721c: 7808        ldrb	r0, [r1, #0]
@   0x0801721e: 4450        add	r0, sl
@   0x08017220: 0600        lsls	r0, r0, #24
@   0x08017222: 0e00        lsrs	r0, r0, #24
@   0x08017224: 4682        mov	sl, r0
@   0x08017226: 4642        mov	r2, r8
@   0x08017228: 0610        lsls	r0, r2, #24
@   0x0801722a: 0e03        lsrs	r3, r0, #24
@   0x0801722c: 490b        ldr	r1, [pc, #44]	@ (0x1725c)
@   0x0801722e: 2004        movs	r0, #4
@   0x08017230: 5608        ldrsb	r0, [r1, r0]
@   0x08017232: 4283        cmp	r3, r0
@   0x08017234: db85        blt.n	0x17142
@   0x08017236: 464a        mov	r2, r9
@   0x08017238: 7810        ldrb	r0, [r2, #0]
@   0x0801723a: 3001        adds	r0, #1
@   0x0801723c: 7010        strb	r0, [r2, #0]
@   0x0801723e: 4b06        ldr	r3, [pc, #24]	@ (0x17258)
@   0x08017240: 6818        ldr	r0, [r3, #0]
@   0x08017242: 6050        str	r0, [r2, #4]
@   0x08017244: bc38        pop	{r3, r4, r5}
@   0x08017246: 4698        mov	r8, r3
@   0x08017248: 46a1        mov	r9, r4
@   0x0801724a: 46aa        mov	sl, r5
@   0x0801724c: bcf0        pop	{r4, r5, r6, r7}
@   0x0801724e: bc01        pop	{r0}
@   0x08017250: 4700        bx	r0
@   0x08017252: 0000        movs	r0, r0
@   0x08017254: 5320        strh	r0, [r4, r4]
@   0x08017256: 0300        lsls	r0, r0, #12
@   0x08017258: 5330        strh	r0, [r6, r4]
@   0x0801725a: 0300        lsls	r0, r0, #12
@   0x0801725c: 35e0        adds	r5, #224	@ 0xe0
@   0x0801725e: 0300        lsls	r0, r0, #12
@   0x08017260: 3628        adds	r6, #40	@ 0x28
@   0x08017262: 080e        lsrs	r6, r1, #32
@   0x08017264: 3630        adds	r6, #48	@ 0x30
@   0x08017266: 080e        lsrs	r6, r1, #32
@   0x08017268: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801726c: 369a        adds	r6, #154	@ 0x9a
@   0x0801726e: 080e        lsrs	r6, r1, #32
@   0x08017270: 210f        movs	r1, #15
@   0x08017272: 4803        ldr	r0, [pc, #12]	@ (0x17280)
@   0x08017274: 7880        ldrb	r0, [r0, #2]
@   0x08017276: 2803        cmp	r0, #3
@   0x08017278: d004        beq.n	0x17284
@   0x0801727a: 2805        cmp	r0, #5
@   0x0801727c: d004        beq.n	0x17288
@   0x0801727e: e004        b.n	0x1728a
@   0x08017280: 6110        str	r0, [r2, #16]
@   0x08017282: 0300        lsls	r0, r0, #12
@   0x08017284: 2100        movs	r1, #0
@   0x08017286: e000        b.n	0x1728a
@   0x08017288: 2101        movs	r1, #1
@   0x0801728a: 1c08        adds	r0, r1, #0
@   0x0801728c: 4770        bx	lr
@   0x0801728e: 0000        movs	r0, r0
@   0x08017290: 4904        ldr	r1, [pc, #16]	@ (0x172a4)
@   0x08017292: 4805        ldr	r0, [pc, #20]	@ (0x172a8)
@   0x08017294: 6008        str	r0, [r1, #0]
@   0x08017296: 4805        ldr	r0, [pc, #20]	@ (0x172ac)
@   0x08017298: 6048        str	r0, [r1, #4]
@   0x0801729a: 4805        ldr	r0, [pc, #20]	@ (0x172b0)
@   0x0801729c: 6088        str	r0, [r1, #8]
@   0x0801729e: 6888        ldr	r0, [r1, #8]
@   0x080172a0: 4770        bx	lr
@   0x080172a2: 0000        movs	r0, r0
@   0x080172a4: 00d4        lsls	r4, r2, #3
@   0x080172a6: 0400        lsls	r0, r0, #16
@   0x080172a8: 3038        adds	r0, #56	@ 0x38
@   0x080172aa: 0817        lsrs	r7, r2, #32
@   0x080172ac: 0180        lsls	r0, r0, #6
@   0x080172ae: 0500        lsls	r0, r0, #20
@   0x080172b0: 0010        movs	r0, r2
@   0x080172b2: 8000        strh	r0, [r0, #0]
@   0x080172b4: 0600        lsls	r0, r0, #24
@   0x080172b6: 4a0c        ldr	r2, [pc, #48]	@ (0x172e8)
@   0x080172b8: 2100        movs	r1, #0
@   0x080172ba: 7011        strb	r1, [r2, #0]
@   0x080172bc: 4b0b        ldr	r3, [pc, #44]	@ (0x172ec)
@   0x080172be: 0d00        lsrs	r0, r0, #20
@   0x080172c0: 1d19        adds	r1, r3, #4
@   0x080172c2: 1841        adds	r1, r0, r1
@   0x080172c4: 6809        ldr	r1, [r1, #0]
@   0x080172c6: 4a0a        ldr	r2, [pc, #40]	@ (0x172f0)
@   0x080172c8: 6809        ldr	r1, [r1, #0]
@   0x080172ca: 6011        str	r1, [r2, #0]
@   0x080172cc: 1c19        adds	r1, r3, #0
@   0x080172ce: 3108        adds	r1, #8
@   0x080172d0: 1841        adds	r1, r0, r1
@   0x080172d2: 6809        ldr	r1, [r1, #0]
@   0x080172d4: 6051        str	r1, [r2, #4]
@   0x080172d6: 18c0        adds	r0, r0, r3
@   0x080172d8: 8980        ldrh	r0, [r0, #12]
@   0x080172da: 0840        lsrs	r0, r0, #1
@   0x080172dc: 2180        movs	r1, #128	@ 0x80
@   0x080172de: 0609        lsls	r1, r1, #24
@   0x080172e0: 4308        orrs	r0, r1
@   0x080172e2: 6090        str	r0, [r2, #8]
@   0x080172e4: 6890        ldr	r0, [r2, #8]
@   0x080172e6: 4770        bx	lr
@   0x080172e8: 5320        strh	r0, [r4, r4]
@   0x080172ea: 0300        lsls	r0, r0, #12
@   0x080172ec: 6888        ldr	r0, [r1, #8]
@   0x080172ee: 0830        lsrs	r0, r6, #32
@   0x080172f0: 00d4        lsls	r4, r2, #3
@   0x080172f2: 0400        lsls	r0, r0, #16

        thumb_func_start FrogStatusBar_Update
FrogStatusBar_Update: @ 0x08017000
        .incbin "frog_us_baserom.gba", 0x17000, 0x2f4
        thumb_func_end FrogStatusBar_Update
