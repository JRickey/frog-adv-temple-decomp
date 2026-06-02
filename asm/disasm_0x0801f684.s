@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801f684, 0x0801f8bc)  (568 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801f684 --end 0x801f8bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801f684: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801f686: 4657        mov	r7, sl
@   0x0801f688: 464e        mov	r6, r9
@   0x0801f68a: 4645        mov	r5, r8
@   0x0801f68c: b4e0        push	{r5, r6, r7}
@   0x0801f68e: b087        sub	sp, #28
@   0x0801f690: 493b        ldr	r1, [pc, #236]	@ (0x1f780)
@   0x0801f692: 9804        ldr	r0, [sp, #16]
@   0x0801f694: 4008        ands	r0, r1
@   0x0801f696: 2102        movs	r1, #2
@   0x0801f698: 4308        orrs	r0, r1
@   0x0801f69a: 493a        ldr	r1, [pc, #232]	@ (0x1f784)
@   0x0801f69c: 4008        ands	r0, r1
@   0x0801f69e: 21c0        movs	r1, #192	@ 0xc0
@   0x0801f6a0: 0089        lsls	r1, r1, #2
@   0x0801f6a2: 4308        orrs	r0, r1
@   0x0801f6a4: 4938        ldr	r1, [pc, #224]	@ (0x1f788)
@   0x0801f6a6: 4008        ands	r0, r1
@   0x0801f6a8: 2180        movs	r1, #128	@ 0x80
@   0x0801f6aa: 04c9        lsls	r1, r1, #19
@   0x0801f6ac: 4308        orrs	r0, r1
@   0x0801f6ae: 4937        ldr	r1, [pc, #220]	@ (0x1f78c)
@   0x0801f6b0: 4008        ands	r0, r1
@   0x0801f6b2: 21d0        movs	r1, #208	@ 0xd0
@   0x0801f6b4: 0349        lsls	r1, r1, #13
@   0x0801f6b6: 4308        orrs	r0, r1
@   0x0801f6b8: 9004        str	r0, [sp, #16]
@   0x0801f6ba: 4a35        ldr	r2, [pc, #212]	@ (0x1f790)
@   0x0801f6bc: 7810        ldrb	r0, [r2, #0]
@   0x0801f6be: 9005        str	r0, [sp, #20]
@   0x0801f6c0: a903        add	r1, sp, #12
@   0x0801f6c2: 2000        movs	r0, #0
@   0x0801f6c4: 8008        strh	r0, [r1, #0]
@   0x0801f6c6: 4933        ldr	r1, [pc, #204]	@ (0x1f794)
@   0x0801f6c8: a803        add	r0, sp, #12
@   0x0801f6ca: 6008        str	r0, [r1, #0]
@   0x0801f6cc: 4832        ldr	r0, [pc, #200]	@ (0x1f798)
@   0x0801f6ce: 6048        str	r0, [r1, #4]
@   0x0801f6d0: 4832        ldr	r0, [pc, #200]	@ (0x1f79c)
@   0x0801f6d2: 6088        str	r0, [r1, #8]
@   0x0801f6d4: 6888        ldr	r0, [r1, #8]
@   0x0801f6d6: 2100        movs	r1, #0
@   0x0801f6d8: 468a        mov	sl, r1
@   0x0801f6da: 4668        mov	r0, sp
@   0x0801f6dc: 3010        adds	r0, #16
@   0x0801f6de: 9006        str	r0, [sp, #24]
@   0x0801f6e0: 9805        ldr	r0, [sp, #20]
@   0x0801f6e2: 4651        mov	r1, sl
@   0x0801f6e4: 4108        asrs	r0, r1
@   0x0801f6e6: 2101        movs	r1, #1
@   0x0801f6e8: 4008        ands	r0, r1
@   0x0801f6ea: 2800        cmp	r0, #0
@   0x0801f6ec: d100        bne.n	0x1f6f0
@   0x0801f6ee: e0b3        b.n	0x1f858
@   0x0801f6f0: 4823        ldr	r0, [pc, #140]	@ (0x1f780)
@   0x0801f6f2: 9904        ldr	r1, [sp, #16]
@   0x0801f6f4: 4001        ands	r1, r0
@   0x0801f6f6: 2003        movs	r0, #3
@   0x0801f6f8: 4301        orrs	r1, r0
@   0x0801f6fa: 4650        mov	r0, sl
@   0x0801f6fc: 0083        lsls	r3, r0, #2
@   0x0801f6fe: 1cda        adds	r2, r3, #3
@   0x0801f700: 0612        lsls	r2, r2, #24
@   0x0801f702: 0c12        lsrs	r2, r2, #16
@   0x0801f704: 481f        ldr	r0, [pc, #124]	@ (0x1f784)
@   0x0801f706: 4001        ands	r1, r0
@   0x0801f708: 4311        orrs	r1, r2
@   0x0801f70a: 9104        str	r1, [sp, #16]
@   0x0801f70c: 3304        adds	r3, #4
@   0x0801f70e: 061b        lsls	r3, r3, #24
@   0x0801f710: 0e1e        lsrs	r6, r3, #24
@   0x0801f712: 9806        ldr	r0, [sp, #24]
@   0x0801f714: 4922        ldr	r1, [pc, #136]	@ (0x1f7a0)
@   0x0801f716: 2202        movs	r2, #2
@   0x0801f718: f7f9        ffe8 	bl	0x196ec
@   0x0801f71c: 4651        mov	r1, sl
@   0x0801f71e: 0049        lsls	r1, r1, #1
@   0x0801f720: 4689        mov	r9, r1
@   0x0801f722: 464c        mov	r4, r9
@   0x0801f724: 4454        add	r4, sl
@   0x0801f726: 00a4        lsls	r4, r4, #2
@   0x0801f728: 491e        ldr	r1, [pc, #120]	@ (0x1f7a4)
@   0x0801f72a: 1860        adds	r0, r4, r1
@   0x0801f72c: 21a0        movs	r1, #160	@ 0xa0
@   0x0801f72e: 0049        lsls	r1, r1, #1
@   0x0801f730: 4688        mov	r8, r1
@   0x0801f732: 9100        str	r1, [sp, #0]
@   0x0801f734: 2705        movs	r7, #5
@   0x0801f736: 9701        str	r7, [sp, #4]
@   0x0801f738: 2502        movs	r5, #2
@   0x0801f73a: 9502        str	r5, [sp, #8]
@   0x0801f73c: 2103        movs	r1, #3
@   0x0801f73e: 2203        movs	r2, #3
@   0x0801f740: 1c33        adds	r3, r6, #0
@   0x0801f742: f7fc        fb9b 	bl	0x1be7c
@   0x0801f746: 4640        mov	r0, r8
@   0x0801f748: 9000        str	r0, [sp, #0]
@   0x0801f74a: 9701        str	r7, [sp, #4]
@   0x0801f74c: 9502        str	r5, [sp, #8]
@   0x0801f74e: 4816        ldr	r0, [pc, #88]	@ (0x1f7a8)
@   0x0801f750: 2103        movs	r1, #3
@   0x0801f752: 220c        movs	r2, #12
@   0x0801f754: 1c33        adds	r3, r6, #0
@   0x0801f756: f7fc        fb91 	bl	0x1be7c
@   0x0801f75a: 490d        ldr	r1, [pc, #52]	@ (0x1f790)
@   0x0801f75c: 1864        adds	r4, r4, r1
@   0x0801f75e: 7b60        ldrb	r0, [r4, #13]
@   0x0801f760: 9700        str	r7, [sp, #0]
@   0x0801f762: 9501        str	r5, [sp, #4]
@   0x0801f764: 210c        movs	r1, #12
@   0x0801f766: 1c32        adds	r2, r6, #0
@   0x0801f768: 4643        mov	r3, r8
@   0x0801f76a: f7fd        fbd5 	bl	0x1cf18
@   0x0801f76e: 7ba0        ldrb	r0, [r4, #14]
@   0x0801f770: 2863        cmp	r0, #99	@ 0x63
@   0x0801f772: d91b        bls.n	0x1f7ac
@   0x0801f774: 9700        str	r7, [sp, #0]
@   0x0801f776: 9501        str	r5, [sp, #4]
@   0x0801f778: 2100        movs	r1, #0
@   0x0801f77a: 9102        str	r1, [sp, #8]
@   0x0801f77c: 2112        movs	r1, #18
@   0x0801f77e: e01d        b.n	0x1f7bc
@   0x0801f780: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801f784: 00ff        lsls	r7, r7, #3
@   0x0801f786: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801f78a: 00ff        lsls	r7, r7, #3
@   0x0801f78c: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801f790: 3500        adds	r5, #0
@   0x0801f792: 0300        lsls	r0, r0, #12
@   0x0801f794: 00d4        lsls	r4, r2, #3
@   0x0801f796: 0400        lsls	r0, r0, #16
@   0x0801f798: f000        0600 	and.w	r6, r0, #0
@   0x0801f79c: 0400        lsls	r0, r0, #16
@   0x0801f79e: 8100        strh	r0, [r0, #8]
@   0x0801f7a0: 8398        strh	r0, [r3, #28]
@   0x0801f7a2: 081d        lsrs	r5, r3, #32
@   0x0801f7a4: 3510        adds	r5, #16
@   0x0801f7a6: 0300        lsls	r0, r0, #12
@   0x0801f7a8: e800        081b 			@ <UNDEFINED> instruction: 0xe800081b
@   0x0801f7ac: 2809        cmp	r0, #9
@   0x0801f7ae: d90a        bls.n	0x1f7c6
@   0x0801f7b0: 7ba0        ldrb	r0, [r4, #14]
@   0x0801f7b2: 9700        str	r7, [sp, #0]
@   0x0801f7b4: 9501        str	r5, [sp, #4]
@   0x0801f7b6: 2100        movs	r1, #0
@   0x0801f7b8: 9102        str	r1, [sp, #8]
@   0x0801f7ba: 2113        movs	r1, #19
@   0x0801f7bc: 1c32        adds	r2, r6, #0
@   0x0801f7be: 4643        mov	r3, r8
@   0x0801f7c0: f7fc        fd78 	bl	0x1c2b4
@   0x0801f7c4: e009        b.n	0x1f7da
@   0x0801f7c6: 7ba0        ldrb	r0, [r4, #14]
@   0x0801f7c8: 9700        str	r7, [sp, #0]
@   0x0801f7ca: 9501        str	r5, [sp, #4]
@   0x0801f7cc: 2100        movs	r1, #0
@   0x0801f7ce: 9102        str	r1, [sp, #8]
@   0x0801f7d0: 2114        movs	r1, #20
@   0x0801f7d2: 1c32        adds	r2, r6, #0
@   0x0801f7d4: 4643        mov	r3, r8
@   0x0801f7d6: f7fc        fd6d 	bl	0x1c2b4
@   0x0801f7da: 4648        mov	r0, r9
@   0x0801f7dc: 4450        add	r0, sl
@   0x0801f7de: 0080        lsls	r0, r0, #2
@   0x0801f7e0: 490c        ldr	r1, [pc, #48]	@ (0x1f814)
@   0x0801f7e2: 1840        adds	r0, r0, r1
@   0x0801f7e4: 6800        ldr	r0, [r0, #0]
@   0x0801f7e6: f7fb        fccf 	bl	0x1b188
@   0x0801f7ea: 0600        lsls	r0, r0, #24
@   0x0801f7ec: 0e01        lsrs	r1, r0, #24
@   0x0801f7ee: 2064        movs	r0, #100	@ 0x64
@   0x0801f7f0: 4348        muls	r0, r1
@   0x0801f7f2: 1100        asrs	r0, r0, #4
@   0x0801f7f4: 0600        lsls	r0, r0, #24
@   0x0801f7f6: 0e01        lsrs	r1, r0, #24
@   0x0801f7f8: 2964        cmp	r1, #100	@ 0x64
@   0x0801f7fa: d00d        beq.n	0x1f818
@   0x0801f7fc: 2005        movs	r0, #5
@   0x0801f7fe: 9000        str	r0, [sp, #0]
@   0x0801f800: 2002        movs	r0, #2
@   0x0801f802: 9001        str	r0, [sp, #4]
@   0x0801f804: 1c08        adds	r0, r1, #0
@   0x0801f806: 2117        movs	r1, #23
@   0x0801f808: 1c32        adds	r2, r6, #0
@   0x0801f80a: 23a0        movs	r3, #160	@ 0xa0
@   0x0801f80c: 005b        lsls	r3, r3, #1
@   0x0801f80e: f7fd        fb83 	bl	0x1cf18
@   0x0801f812: e00e        b.n	0x1f832
@   0x0801f814: 3508        adds	r5, #8
@   0x0801f816: 0300        lsls	r0, r0, #12
@   0x0801f818: 2005        movs	r0, #5
@   0x0801f81a: 9000        str	r0, [sp, #0]
@   0x0801f81c: 2002        movs	r0, #2
@   0x0801f81e: 9001        str	r0, [sp, #4]
@   0x0801f820: 2000        movs	r0, #0
@   0x0801f822: 9002        str	r0, [sp, #8]
@   0x0801f824: 2064        movs	r0, #100	@ 0x64
@   0x0801f826: 2116        movs	r1, #22
@   0x0801f828: 1c32        adds	r2, r6, #0
@   0x0801f82a: 23a0        movs	r3, #160	@ 0xa0
@   0x0801f82c: 005b        lsls	r3, r3, #1
@   0x0801f82e: f7fc        fd41 	bl	0x1c2b4
@   0x0801f832: 4808        ldr	r0, [pc, #32]	@ (0x1f854)
@   0x0801f834: 7d00        ldrb	r0, [r0, #20]
@   0x0801f836: 4550        cmp	r0, sl
@   0x0801f838: d12a        bne.n	0x1f890
@   0x0801f83a: 9806        ldr	r0, [sp, #24]
@   0x0801f83c: 2105        movs	r1, #5
@   0x0801f83e: 2204        movs	r2, #4
@   0x0801f840: 2302        movs	r3, #2
@   0x0801f842: f7f8        fe4b 	bl	0x184dc
@   0x0801f846: 9806        ldr	r0, [sp, #24]
@   0x0801f848: 2107        movs	r1, #7
@   0x0801f84a: 2206        movs	r2, #6
@   0x0801f84c: 2302        movs	r3, #2
@   0x0801f84e: f7f8        fe45 	bl	0x184dc
@   0x0801f852: e01d        b.n	0x1f890
@   0x0801f854: 3480        adds	r4, #128	@ 0x80
@   0x0801f856: 0300        lsls	r0, r0, #12
@   0x0801f858: 2003        movs	r0, #3
@   0x0801f85a: 9906        ldr	r1, [sp, #24]
@   0x0801f85c: 7008        strb	r0, [r1, #0]
@   0x0801f85e: 4651        mov	r1, sl
@   0x0801f860: 0088        lsls	r0, r1, #2
@   0x0801f862: 3004        adds	r0, #4
@   0x0801f864: ac04        add	r4, sp, #16
@   0x0801f866: 7060        strb	r0, [r4, #1]
@   0x0801f868: 4911        ldr	r1, [pc, #68]	@ (0x1f8b0)
@   0x0801f86a: 4812        ldr	r0, [pc, #72]	@ (0x1f8b4)
@   0x0801f86c: 6800        ldr	r0, [r0, #0]
@   0x0801f86e: 0080        lsls	r0, r0, #2
@   0x0801f870: 1840        adds	r0, r0, r1
@   0x0801f872: 6801        ldr	r1, [r0, #0]
@   0x0801f874: 1c20        adds	r0, r4, #0
@   0x0801f876: 2202        movs	r2, #2
@   0x0801f878: f7f9        ff38 	bl	0x196ec
@   0x0801f87c: 480e        ldr	r0, [pc, #56]	@ (0x1f8b8)
@   0x0801f87e: 7d00        ldrb	r0, [r0, #20]
@   0x0801f880: 4550        cmp	r0, sl
@   0x0801f882: d105        bne.n	0x1f890
@   0x0801f884: 1c20        adds	r0, r4, #0
@   0x0801f886: 2105        movs	r1, #5
@   0x0801f888: 2204        movs	r2, #4
@   0x0801f88a: 2302        movs	r3, #2
@   0x0801f88c: f7f8        fe26 	bl	0x184dc
@   0x0801f890: 4650        mov	r0, sl
@   0x0801f892: 3001        adds	r0, #1
@   0x0801f894: 0600        lsls	r0, r0, #24
@   0x0801f896: 0e00        lsrs	r0, r0, #24
@   0x0801f898: 4682        mov	sl, r0
@   0x0801f89a: 2803        cmp	r0, #3
@   0x0801f89c: d800        bhi.n	0x1f8a0
@   0x0801f89e: e71f        b.n	0x1f6e0
@   0x0801f8a0: b007        add	sp, #28
@   0x0801f8a2: bc38        pop	{r3, r4, r5}
@   0x0801f8a4: 4698        mov	r8, r3
@   0x0801f8a6: 46a1        mov	r9, r4
@   0x0801f8a8: 46aa        mov	sl, r5
@   0x0801f8aa: bcf0        pop	{r4, r5, r6, r7}
@   0x0801f8ac: bc01        pop	{r0}
@   0x0801f8ae: 4700        bx	r0
@   0x0801f8b0: 8ef4        ldrh	r4, [r6, #54]	@ 0x36
@   0x0801f8b2: 0830        lsrs	r0, r6, #32
@   0x0801f8b4: 34b0        adds	r4, #176	@ 0xb0
@   0x0801f8b6: 0300        lsls	r0, r0, #12
@   0x0801f8b8: 3480        adds	r4, #128	@ 0x80
@   0x0801f8ba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801F684
sub_0801F684: @ 0x0801f684
        .incbin "frog_us_baserom.gba", 0x1f684, 0x238
        thumb_func_end sub_0801F684
