@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08008570, 0x080087b4)  (580 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8008570 --end 0x80087b4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08008570: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08008572: 4647        mov	r7, r8
@   0x08008574: b480        push	{r7}
@   0x08008576: b086        sub	sp, #24
@   0x08008578: 4908        ldr	r1, [pc, #32]	@ (0x859c)
@   0x0800857a: 2004        movs	r0, #4
@   0x0800857c: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x0800857e: 4010        ands	r0, r2
@   0x08008580: 2800        cmp	r0, #0
@   0x08008582: d000        beq.n	0x8586
@   0x08008584: e10e        b.n	0x87a4
@   0x08008586: 7e88        ldrb	r0, [r1, #26]
@   0x08008588: 3804        subs	r0, #4
@   0x0800858a: 2807        cmp	r0, #7
@   0x0800858c: d900        bls.n	0x8590
@   0x0800858e: e07f        b.n	0x8690
@   0x08008590: 0080        lsls	r0, r0, #2
@   0x08008592: 4903        ldr	r1, [pc, #12]	@ (0x85a0)
@   0x08008594: 1840        adds	r0, r0, r1
@   0x08008596: 6800        ldr	r0, [r0, #0]
@   0x08008598: 4687        mov	pc, r0
@   0x0800859a: 0000        movs	r0, r0
@   0x0800859c: 3720        adds	r7, #32
@   0x0800859e: 0300        lsls	r0, r0, #12
@   0x080085a0: 85a4        strh	r4, [r4, #44]	@ 0x2c
@   0x080085a2: 0800        lsrs	r0, r0, #32
@   0x080085a4: 85c4        strh	r4, [r0, #46]	@ 0x2e
@   0x080085a6: 0800        lsrs	r0, r0, #32
@   0x080085a8: 85da        strh	r2, [r3, #46]	@ 0x2e
@   0x080085aa: 0800        lsrs	r0, r0, #32
@   0x080085ac: 85ee        strh	r6, [r5, #46]	@ 0x2e
@   0x080085ae: 0800        lsrs	r0, r0, #32
@   0x080085b0: 8604        strh	r4, [r0, #48]	@ 0x30
@   0x080085b2: 0800        lsrs	r0, r0, #32
@   0x080085b4: 8624        strh	r4, [r4, #48]	@ 0x30
@   0x080085b6: 0800        lsrs	r0, r0, #32
@   0x080085b8: 863a        strh	r2, [r7, #48]	@ 0x30
@   0x080085ba: 0800        lsrs	r0, r0, #32
@   0x080085bc: 864e        strh	r6, [r1, #50]	@ 0x32
@   0x080085be: 0800        lsrs	r0, r0, #32
@   0x080085c0: 8672        strh	r2, [r6, #50]	@ 0x32
@   0x080085c2: 0800        lsrs	r0, r0, #32
@   0x080085c4: af04        add	r7, sp, #16
@   0x080085c6: 9700        str	r7, [sp, #0]
@   0x080085c8: 4668        mov	r0, sp
@   0x080085ca: 3012        adds	r0, #18
@   0x080085cc: 9001        str	r0, [sp, #4]
@   0x080085ce: a805        add	r0, sp, #20
@   0x080085d0: 9002        str	r0, [sp, #8]
@   0x080085d2: 3002        adds	r0, #2
@   0x080085d4: 9003        str	r0, [sp, #12]
@   0x080085d6: 2000        movs	r0, #0
@   0x080085d8: e01e        b.n	0x8618
@   0x080085da: a804        add	r0, sp, #16
@   0x080085dc: 9000        str	r0, [sp, #0]
@   0x080085de: 3002        adds	r0, #2
@   0x080085e0: 9001        str	r0, [sp, #4]
@   0x080085e2: a805        add	r0, sp, #20
@   0x080085e4: 9002        str	r0, [sp, #8]
@   0x080085e6: 3002        adds	r0, #2
@   0x080085e8: 9003        str	r0, [sp, #12]
@   0x080085ea: 2001        movs	r0, #1
@   0x080085ec: e014        b.n	0x8618
@   0x080085ee: a904        add	r1, sp, #16
@   0x080085f0: 9100        str	r1, [sp, #0]
@   0x080085f2: 4668        mov	r0, sp
@   0x080085f4: 3012        adds	r0, #18
@   0x080085f6: 9001        str	r0, [sp, #4]
@   0x080085f8: a805        add	r0, sp, #20
@   0x080085fa: 9002        str	r0, [sp, #8]
@   0x080085fc: 3002        adds	r0, #2
@   0x080085fe: 9003        str	r0, [sp, #12]
@   0x08008600: 2002        movs	r0, #2
@   0x08008602: e009        b.n	0x8618
@   0x08008604: aa04        add	r2, sp, #16
@   0x08008606: 9200        str	r2, [sp, #0]
@   0x08008608: 4668        mov	r0, sp
@   0x0800860a: 3012        adds	r0, #18
@   0x0800860c: 9001        str	r0, [sp, #4]
@   0x0800860e: a805        add	r0, sp, #20
@   0x08008610: 9002        str	r0, [sp, #8]
@   0x08008612: 3002        adds	r0, #2
@   0x08008614: 9003        str	r0, [sp, #12]
@   0x08008616: 2003        movs	r0, #3
@   0x08008618: 2118        movs	r1, #24
@   0x0800861a: 2218        movs	r2, #24
@   0x0800861c: 2318        movs	r3, #24
@   0x0800861e: f000        f9c1 	bl	0x89a4
@   0x08008622: e035        b.n	0x8690
@   0x08008624: af04        add	r7, sp, #16
@   0x08008626: 9700        str	r7, [sp, #0]
@   0x08008628: 4668        mov	r0, sp
@   0x0800862a: 3012        adds	r0, #18
@   0x0800862c: 9001        str	r0, [sp, #4]
@   0x0800862e: a805        add	r0, sp, #20
@   0x08008630: 9002        str	r0, [sp, #8]
@   0x08008632: 3002        adds	r0, #2
@   0x08008634: 9003        str	r0, [sp, #12]
@   0x08008636: 2000        movs	r0, #0
@   0x08008638: e013        b.n	0x8662
@   0x0800863a: a804        add	r0, sp, #16
@   0x0800863c: 9000        str	r0, [sp, #0]
@   0x0800863e: 3002        adds	r0, #2
@   0x08008640: 9001        str	r0, [sp, #4]
@   0x08008642: a805        add	r0, sp, #20
@   0x08008644: 9002        str	r0, [sp, #8]
@   0x08008646: 3002        adds	r0, #2
@   0x08008648: 9003        str	r0, [sp, #12]
@   0x0800864a: 2001        movs	r0, #1
@   0x0800864c: e009        b.n	0x8662
@   0x0800864e: a904        add	r1, sp, #16
@   0x08008650: 9100        str	r1, [sp, #0]
@   0x08008652: 4668        mov	r0, sp
@   0x08008654: 3012        adds	r0, #18
@   0x08008656: 9001        str	r0, [sp, #4]
@   0x08008658: a805        add	r0, sp, #20
@   0x0800865a: 9002        str	r0, [sp, #8]
@   0x0800865c: 3002        adds	r0, #2
@   0x0800865e: 9003        str	r0, [sp, #12]
@   0x08008660: 2002        movs	r0, #2
@   0x08008662: 2130        movs	r1, #48	@ 0x30
@   0x08008664: 2214        movs	r2, #20
@   0x08008666: 2314        movs	r3, #20
@   0x08008668: f000        f99c 	bl	0x89a4
@   0x0800866c: e010        b.n	0x8690
@   0x0800866e: 76a3        strb	r3, [r4, #26]
@   0x08008670: e052        b.n	0x8718
@   0x08008672: aa04        add	r2, sp, #16
@   0x08008674: 9200        str	r2, [sp, #0]
@   0x08008676: 4668        mov	r0, sp
@   0x08008678: 3012        adds	r0, #18
@   0x0800867a: 9001        str	r0, [sp, #4]
@   0x0800867c: a805        add	r0, sp, #20
@   0x0800867e: 9002        str	r0, [sp, #8]
@   0x08008680: 3002        adds	r0, #2
@   0x08008682: 9003        str	r0, [sp, #12]
@   0x08008684: 2003        movs	r0, #3
@   0x08008686: 2130        movs	r1, #48	@ 0x30
@   0x08008688: 2214        movs	r2, #20
@   0x0800868a: 2314        movs	r3, #20
@   0x0800868c: f000        f98a 	bl	0x89a4
@   0x08008690: 4826        ldr	r0, [pc, #152]	@ (0x872c)
@   0x08008692: 1c06        adds	r6, r0, #0
@   0x08008694: 4c26        ldr	r4, [pc, #152]	@ (0x8730)
@   0x08008696: 7eb7        ldrb	r7, [r6, #26]
@   0x08008698: 2f07        cmp	r7, #7
@   0x0800869a: d83b        bhi.n	0x8714
@   0x0800869c: 2500        movs	r5, #0
@   0x0800869e: 4825        ldr	r0, [pc, #148]	@ (0x8734)
@   0x080086a0: 3031        adds	r0, #49	@ 0x31
@   0x080086a2: 7800        ldrb	r0, [r0, #0]
@   0x080086a4: 4285        cmp	r5, r0
@   0x080086a6: da35        bge.n	0x8714
@   0x080086a8: 46b4        mov	ip, r6
@   0x080086aa: 4680        mov	r8, r0
@   0x080086ac: 4922        ldr	r1, [pc, #136]	@ (0x8738)
@   0x080086ae: 00e8        lsls	r0, r5, #3
@   0x080086b0: 1840        adds	r0, r0, r1
@   0x080086b2: 7803        ldrb	r3, [r0, #0]
@   0x080086b4: 2b00        cmp	r3, #0
@   0x080086b6: d02a        beq.n	0x870e
@   0x080086b8: 00d8        lsls	r0, r3, #3
@   0x080086ba: 1ac0        subs	r0, r0, r3
@   0x080086bc: 00c0        lsls	r0, r0, #3
@   0x080086be: 4661        mov	r1, ip
@   0x080086c0: 1842        adds	r2, r0, r1
@   0x080086c2: 2004        movs	r0, #4
@   0x080086c4: 8e97        ldrh	r7, [r2, #52]	@ 0x34
@   0x080086c6: 4038        ands	r0, r7
@   0x080086c8: 2800        cmp	r0, #0
@   0x080086ca: d120        bne.n	0x870e
@   0x080086cc: 79b0        ldrb	r0, [r6, #6]
@   0x080086ce: 7991        ldrb	r1, [r2, #6]
@   0x080086d0: 4288        cmp	r0, r1
@   0x080086d2: d11c        bne.n	0x870e
@   0x080086d4: a805        add	r0, sp, #20
@   0x080086d6: 2702        movs	r7, #2
@   0x080086d8: 5fd1        ldrsh	r1, [r2, r7]
@   0x080086da: 2700        movs	r7, #0
@   0x080086dc: 5fc0        ldrsh	r0, [r0, r7]
@   0x080086de: 4281        cmp	r1, r0
@   0x080086e0: dd15        ble.n	0x870e
@   0x080086e2: 4668        mov	r0, sp
@   0x080086e4: 3016        adds	r0, #22
@   0x080086e6: 2700        movs	r7, #0
@   0x080086e8: 5fc0        ldrsh	r0, [r0, r7]
@   0x080086ea: 4281        cmp	r1, r0
@   0x080086ec: da0f        bge.n	0x870e
@   0x080086ee: a804        add	r0, sp, #16
@   0x080086f0: 2704        movs	r7, #4
@   0x080086f2: 5fd1        ldrsh	r1, [r2, r7]
@   0x080086f4: 2700        movs	r7, #0
@   0x080086f6: 5fc0        ldrsh	r0, [r0, r7]
@   0x080086f8: 4281        cmp	r1, r0
@   0x080086fa: dd08        ble.n	0x870e
@   0x080086fc: 4668        mov	r0, sp
@   0x080086fe: 3012        adds	r0, #18
@   0x08008700: 2700        movs	r7, #0
@   0x08008702: 5fc0        ldrsh	r0, [r0, r7]
@   0x08008704: 4281        cmp	r1, r0
@   0x08008706: da02        bge.n	0x870e
@   0x08008708: 7852        ldrb	r2, [r2, #1]
@   0x0800870a: 2a02        cmp	r2, #2
@   0x0800870c: d0af        beq.n	0x866e
@   0x0800870e: 3501        adds	r5, #1
@   0x08008710: 4545        cmp	r5, r8
@   0x08008712: dbcb        blt.n	0x86ac
@   0x08008714: 2000        movs	r0, #0
@   0x08008716: 76a0        strb	r0, [r4, #26]
@   0x08008718: 7eb0        ldrb	r0, [r6, #26]
@   0x0800871a: 3804        subs	r0, #4
@   0x0800871c: 2807        cmp	r0, #7
@   0x0800871e: d841        bhi.n	0x87a4
@   0x08008720: 0080        lsls	r0, r0, #2
@   0x08008722: 4906        ldr	r1, [pc, #24]	@ (0x873c)
@   0x08008724: 1840        adds	r0, r0, r1
@   0x08008726: 6800        ldr	r0, [r0, #0]
@   0x08008728: 4687        mov	pc, r0
@   0x0800872a: 0000        movs	r0, r0
@   0x0800872c: 3720        adds	r7, #32
@   0x0800872e: 0300        lsls	r0, r0, #12
@   0x08008730: 35e0        adds	r5, #224	@ 0xe0
@   0x08008732: 0300        lsls	r0, r0, #12
@   0x08008734: 6110        str	r0, [r2, #16]
@   0x08008736: 0300        lsls	r0, r0, #12
@   0x08008738: 6160        str	r0, [r4, #20]
@   0x0800873a: 0300        lsls	r0, r0, #12
@   0x0800873c: 8740        strh	r0, [r0, #58]	@ 0x3a
@   0x0800873e: 0800        lsrs	r0, r0, #32
@   0x08008740: 8760        strh	r0, [r4, #58]	@ 0x3a
@   0x08008742: 0800        lsrs	r0, r0, #32
@   0x08008744: 876a        strh	r2, [r5, #58]	@ 0x3a
@   0x08008746: 0800        lsrs	r0, r0, #32
@   0x08008748: 8774        strh	r4, [r6, #58]	@ 0x3a
@   0x0800874a: 0800        lsrs	r0, r0, #32
@   0x0800874c: 877a        strh	r2, [r7, #58]	@ 0x3a
@   0x0800874e: 0800        lsrs	r0, r0, #32
@   0x08008750: 8780        strh	r0, [r0, #60]	@ 0x3c
@   0x08008752: 0800        lsrs	r0, r0, #32
@   0x08008754: 878a        strh	r2, [r1, #60]	@ 0x3c
@   0x08008756: 0800        lsrs	r0, r0, #32
@   0x08008758: 8794        strh	r4, [r2, #60]	@ 0x3c
@   0x0800875a: 0800        lsrs	r0, r0, #32
@   0x0800875c: 879a        strh	r2, [r3, #60]	@ 0x3c
@   0x0800875e: 0800        lsrs	r0, r0, #32
@   0x08008760: 8920        ldrh	r0, [r4, #8]
@   0x08008762: 83a0        strh	r0, [r4, #28]
@   0x08008764: 8960        ldrh	r0, [r4, #10]
@   0x08008766: 3801        subs	r0, #1
@   0x08008768: e01b        b.n	0x87a2
@   0x0800876a: 8920        ldrh	r0, [r4, #8]
@   0x0800876c: 83a0        strh	r0, [r4, #28]
@   0x0800876e: 8960        ldrh	r0, [r4, #10]
@   0x08008770: 3001        adds	r0, #1
@   0x08008772: e016        b.n	0x87a2
@   0x08008774: 8920        ldrh	r0, [r4, #8]
@   0x08008776: 3801        subs	r0, #1
@   0x08008778: e011        b.n	0x879e
@   0x0800877a: 8920        ldrh	r0, [r4, #8]
@   0x0800877c: 3001        adds	r0, #1
@   0x0800877e: e00e        b.n	0x879e
@   0x08008780: 8920        ldrh	r0, [r4, #8]
@   0x08008782: 83a0        strh	r0, [r4, #28]
@   0x08008784: 8960        ldrh	r0, [r4, #10]
@   0x08008786: 3802        subs	r0, #2
@   0x08008788: e00b        b.n	0x87a2
@   0x0800878a: 8920        ldrh	r0, [r4, #8]
@   0x0800878c: 83a0        strh	r0, [r4, #28]
@   0x0800878e: 8960        ldrh	r0, [r4, #10]
@   0x08008790: 3002        adds	r0, #2
@   0x08008792: e006        b.n	0x87a2
@   0x08008794: 8920        ldrh	r0, [r4, #8]
@   0x08008796: 3802        subs	r0, #2
@   0x08008798: e001        b.n	0x879e
@   0x0800879a: 8920        ldrh	r0, [r4, #8]
@   0x0800879c: 3002        adds	r0, #2
@   0x0800879e: 83a0        strh	r0, [r4, #28]
@   0x080087a0: 8960        ldrh	r0, [r4, #10]
@   0x080087a2: 83e0        strh	r0, [r4, #30]
@   0x080087a4: 2000        movs	r0, #0
@   0x080087a6: b006        add	sp, #24
@   0x080087a8: bc08        pop	{r3}
@   0x080087aa: 4698        mov	r8, r3
@   0x080087ac: bcf0        pop	{r4, r5, r6, r7}
@   0x080087ae: bc02        pop	{r1}
@   0x080087b0: 4708        bx	r1

        thumb_func_start sub_08008570
sub_08008570: @ 0x08008570
        .incbin "frog_us_baserom.gba", 0x8570, 0x244
        thumb_func_end sub_08008570
