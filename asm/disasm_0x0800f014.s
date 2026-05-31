@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800f014, 0x0800f24c)  (568 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800f014 --end 0x800f24c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800f014: b510        push	{r4, lr}
@   0x0800f016: 4829        ldr	r0, [pc, #164]	@ (0xf0bc)
@   0x0800f018: 4929        ldr	r1, [pc, #164]	@ (0xf0c0)
@   0x0800f01a: 6001        str	r1, [r0, #0]
@   0x0800f01c: 21a0        movs	r1, #160	@ 0xa0
@   0x0800f01e: 04c9        lsls	r1, r1, #19
@   0x0800f020: 6041        str	r1, [r0, #4]
@   0x0800f022: 4928        ldr	r1, [pc, #160]	@ (0xf0c4)
@   0x0800f024: 6081        str	r1, [r0, #8]
@   0x0800f026: 6881        ldr	r1, [r0, #8]
@   0x0800f028: 4927        ldr	r1, [pc, #156]	@ (0xf0c8)
@   0x0800f02a: 6001        str	r1, [r0, #0]
@   0x0800f02c: 21c0        movs	r1, #192	@ 0xc0
@   0x0800f02e: 04c9        lsls	r1, r1, #19
@   0x0800f030: 6041        str	r1, [r0, #4]
@   0x0800f032: 4926        ldr	r1, [pc, #152]	@ (0xf0cc)
@   0x0800f034: 6081        str	r1, [r0, #8]
@   0x0800f036: 6881        ldr	r1, [r0, #8]
@   0x0800f038: 4925        ldr	r1, [pc, #148]	@ (0xf0d0)
@   0x0800f03a: 6001        str	r1, [r0, #0]
@   0x0800f03c: 4925        ldr	r1, [pc, #148]	@ (0xf0d4)
@   0x0800f03e: 6041        str	r1, [r0, #4]
@   0x0800f040: 4b25        ldr	r3, [pc, #148]	@ (0xf0d8)
@   0x0800f042: 6083        str	r3, [r0, #8]
@   0x0800f044: 6881        ldr	r1, [r0, #8]
@   0x0800f046: 4a25        ldr	r2, [pc, #148]	@ (0xf0dc)
@   0x0800f048: 4c25        ldr	r4, [pc, #148]	@ (0xf0e0)
@   0x0800f04a: 1c21        adds	r1, r4, #0
@   0x0800f04c: 8011        strh	r1, [r2, #0]
@   0x0800f04e: 4925        ldr	r1, [pc, #148]	@ (0xf0e4)
@   0x0800f050: 6001        str	r1, [r0, #0]
@   0x0800f052: 4925        ldr	r1, [pc, #148]	@ (0xf0e8)
@   0x0800f054: 6041        str	r1, [r0, #4]
@   0x0800f056: 4925        ldr	r1, [pc, #148]	@ (0xf0ec)
@   0x0800f058: 6081        str	r1, [r0, #8]
@   0x0800f05a: 6881        ldr	r1, [r0, #8]
@   0x0800f05c: 4924        ldr	r1, [pc, #144]	@ (0xf0f0)
@   0x0800f05e: 6001        str	r1, [r0, #0]
@   0x0800f060: 4924        ldr	r1, [pc, #144]	@ (0xf0f4)
@   0x0800f062: 6041        str	r1, [r0, #4]
@   0x0800f064: 6083        str	r3, [r0, #8]
@   0x0800f066: 6880        ldr	r0, [r0, #8]
@   0x0800f068: 4923        ldr	r1, [pc, #140]	@ (0xf0f8)
@   0x0800f06a: 4a24        ldr	r2, [pc, #144]	@ (0xf0fc)
@   0x0800f06c: 1c10        adds	r0, r2, #0
@   0x0800f06e: 8008        strh	r0, [r1, #0]
@   0x0800f070: 3102        adds	r1, #2
@   0x0800f072: 4c23        ldr	r4, [pc, #140]	@ (0xf100)
@   0x0800f074: 1c20        adds	r0, r4, #0
@   0x0800f076: 8008        strh	r0, [r1, #0]
@   0x0800f078: 390c        subs	r1, #12
@   0x0800f07a: 22d0        movs	r2, #208	@ 0xd0
@   0x0800f07c: 0092        lsls	r2, r2, #2
@   0x0800f07e: 1c10        adds	r0, r2, #0
@   0x0800f080: 8008        strh	r0, [r1, #0]
@   0x0800f082: 4920        ldr	r1, [pc, #128]	@ (0xf104)
@   0x0800f084: 2000        movs	r0, #0
@   0x0800f086: 8008        strh	r0, [r1, #0]
@   0x0800f088: 8048        strh	r0, [r1, #2]
@   0x0800f08a: 8088        strh	r0, [r1, #4]
@   0x0800f08c: 80c8        strh	r0, [r1, #6]
@   0x0800f08e: 8108        strh	r0, [r1, #8]
@   0x0800f090: 8148        strh	r0, [r1, #10]
@   0x0800f092: 491d        ldr	r1, [pc, #116]	@ (0xf108)
@   0x0800f094: 8008        strh	r0, [r1, #0]
@   0x0800f096: 3104        adds	r1, #4
@   0x0800f098: 8008        strh	r0, [r1, #0]
@   0x0800f09a: 3104        adds	r1, #4
@   0x0800f09c: 8008        strh	r0, [r1, #0]
@   0x0800f09e: 3906        subs	r1, #6
@   0x0800f0a0: 8008        strh	r0, [r1, #0]
@   0x0800f0a2: 3104        adds	r1, #4
@   0x0800f0a4: 8008        strh	r0, [r1, #0]
@   0x0800f0a6: 3104        adds	r1, #4
@   0x0800f0a8: 8008        strh	r0, [r1, #0]
@   0x0800f0aa: 4918        ldr	r1, [pc, #96]	@ (0xf10c)
@   0x0800f0ac: 2001        movs	r0, #1
@   0x0800f0ae: 8008        strh	r0, [r1, #0]
@   0x0800f0b0: 4917        ldr	r1, [pc, #92]	@ (0xf110)
@   0x0800f0b2: 2008        movs	r0, #8
@   0x0800f0b4: 8008        strh	r0, [r1, #0]
@   0x0800f0b6: bc10        pop	{r4}
@   0x0800f0b8: bc01        pop	{r0}
@   0x0800f0ba: 4700        bx	r0
@   0x0800f0bc: 00d4        lsls	r4, r2, #3
@   0x0800f0be: 0400        lsls	r0, r0, #16
@   0x0800f0c0: 72c4        strb	r4, [r0, #11]
@   0x0800f0c2: 080f        lsrs	r7, r1, #32
@   0x0800f0c4: 0100        lsls	r0, r0, #4
@   0x0800f0c6: 8000        strh	r0, [r0, #0]
@   0x0800f0c8: 7cc4        ldrb	r4, [r0, #19]
@   0x0800f0ca: 080f        lsrs	r7, r1, #32
@   0x0800f0cc: 4000        ands	r0, r0
@   0x0800f0ce: 8000        strh	r0, [r0, #0]
@   0x0800f0d0: 74c4        strb	r4, [r0, #19]
@   0x0800f0d2: 080f        lsrs	r7, r1, #32
@   0x0800f0d4: e000        b.n	0xf0d8
@   0x0800f0d6: 0600        lsls	r0, r0, #24
@   0x0800f0d8: 0400        lsls	r0, r0, #16
@   0x0800f0da: 8000        strh	r0, [r0, #0]
@   0x0800f0dc: 0008        movs	r0, r1
@   0x0800f0de: 0400        lsls	r0, r0, #16
@   0x0800f0e0: 1c83        adds	r3, r0, #2
@   0x0800f0e2: 0000        movs	r0, r0
@   0x0800f0e4: 0cc4        lsrs	r4, r0, #19
@   0x0800f0e6: 0810        lsrs	r0, r2, #32
@   0x0800f0e8: 8000        strh	r0, [r0, #0]
@   0x0800f0ea: 0600        lsls	r0, r0, #24
@   0x0800f0ec: 2000        movs	r0, #0
@   0x0800f0ee: 8000        strh	r0, [r0, #0]
@   0x0800f0f0: fcc4        080f 			@ <UNDEFINED> instruction: 0xfcc4080f
@   0x0800f0f4: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0800f0f8: 000a        movs	r2, r1
@   0x0800f0fa: 0400        lsls	r0, r0, #16
@   0x0800f0fc: 1d8a        adds	r2, r1, #6
@   0x0800f0fe: 0000        movs	r0, r0
@   0x0800f100: 1e89        subs	r1, r1, #2
@   0x0800f102: 0000        movs	r0, r0
@   0x0800f104: 3550        adds	r5, #80	@ 0x50
@   0x0800f106: 0300        lsls	r0, r0, #12
@   0x0800f108: 0010        movs	r0, r2
@   0x0800f10a: 0400        lsls	r0, r0, #16
@   0x0800f10c: 0200        lsls	r0, r0, #8
@   0x0800f10e: 0400        lsls	r0, r0, #16
@   0x0800f110: 0004        movs	r4, r0
@   0x0800f112: 0400        lsls	r0, r0, #16
@   0x0800f114: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800f116: 464f        mov	r7, r9
@   0x0800f118: 4646        mov	r6, r8
@   0x0800f11a: b4c0        push	{r6, r7}
@   0x0800f11c: 492f        ldr	r1, [pc, #188]	@ (0xf1dc)
@   0x0800f11e: 4d30        ldr	r5, [pc, #192]	@ (0xf1e0)
@   0x0800f120: 6868        ldr	r0, [r5, #4]
@   0x0800f122: 6008        str	r0, [r1, #0]
@   0x0800f124: 20a0        movs	r0, #160	@ 0xa0
@   0x0800f126: 04c0        lsls	r0, r0, #19
@   0x0800f128: 6048        str	r0, [r1, #4]
@   0x0800f12a: 482e        ldr	r0, [pc, #184]	@ (0xf1e4)
@   0x0800f12c: 6088        str	r0, [r1, #8]
@   0x0800f12e: 6888        ldr	r0, [r1, #8]
@   0x0800f130: 4e2d        ldr	r6, [pc, #180]	@ (0xf1e8)
@   0x0800f132: 7ab0        ldrb	r0, [r6, #10]
@   0x0800f134: 3801        subs	r0, #1
@   0x0800f136: 0140        lsls	r0, r0, #5
@   0x0800f138: 1940        adds	r0, r0, r5
@   0x0800f13a: 6800        ldr	r0, [r0, #0]
@   0x0800f13c: 6008        str	r0, [r1, #0]
@   0x0800f13e: 20c0        movs	r0, #192	@ 0xc0
@   0x0800f140: 04c0        lsls	r0, r0, #19
@   0x0800f142: 6048        str	r0, [r1, #4]
@   0x0800f144: 4829        ldr	r0, [pc, #164]	@ (0xf1ec)
@   0x0800f146: 4680        mov	r8, r0
@   0x0800f148: 6088        str	r0, [r1, #8]
@   0x0800f14a: 6888        ldr	r0, [r1, #8]
@   0x0800f14c: 4c28        ldr	r4, [pc, #160]	@ (0xf1f0)
@   0x0800f14e: 4b29        ldr	r3, [pc, #164]	@ (0xf1f4)
@   0x0800f150: 8ad8        ldrh	r0, [r3, #22]
@   0x0800f152: 2200        movs	r2, #0
@   0x0800f154: 4691        mov	r9, r2
@   0x0800f156: 8060        strh	r0, [r4, #2]
@   0x0800f158: 8a98        ldrh	r0, [r3, #20]
@   0x0800f15a: 8020        strh	r0, [r4, #0]
@   0x0800f15c: 4a26        ldr	r2, [pc, #152]	@ (0xf1f8)
@   0x0800f15e: 4f27        ldr	r7, [pc, #156]	@ (0xf1fc)
@   0x0800f160: 1c38        adds	r0, r7, #0
@   0x0800f162: 8010        strh	r0, [r2, #0]
@   0x0800f164: 7ab0        ldrb	r0, [r6, #10]
@   0x0800f166: 3801        subs	r0, #1
@   0x0800f168: 0040        lsls	r0, r0, #1
@   0x0800f16a: 3001        adds	r0, #1
@   0x0800f16c: 0100        lsls	r0, r0, #4
@   0x0800f16e: 1940        adds	r0, r0, r5
@   0x0800f170: 6800        ldr	r0, [r0, #0]
@   0x0800f172: 6008        str	r0, [r1, #0]
@   0x0800f174: 4822        ldr	r0, [pc, #136]	@ (0xf200)
@   0x0800f176: 6048        str	r0, [r1, #4]
@   0x0800f178: 4640        mov	r0, r8
@   0x0800f17a: 6088        str	r0, [r1, #8]
@   0x0800f17c: 6888        ldr	r0, [r1, #8]
@   0x0800f17e: 8ed8        ldrh	r0, [r3, #54]	@ 0x36
@   0x0800f180: 80e0        strh	r0, [r4, #6]
@   0x0800f182: 8e98        ldrh	r0, [r3, #52]	@ 0x34
@   0x0800f184: 80a0        strh	r0, [r4, #4]
@   0x0800f186: 3202        adds	r2, #2
@   0x0800f188: 4b1e        ldr	r3, [pc, #120]	@ (0xf204)
@   0x0800f18a: 1c18        adds	r0, r3, #0
@   0x0800f18c: 8010        strh	r0, [r2, #0]
@   0x0800f18e: 481e        ldr	r0, [pc, #120]	@ (0xf208)
@   0x0800f190: 6008        str	r0, [r1, #0]
@   0x0800f192: 481e        ldr	r0, [pc, #120]	@ (0xf20c)
@   0x0800f194: 6048        str	r0, [r1, #4]
@   0x0800f196: 481e        ldr	r0, [pc, #120]	@ (0xf210)
@   0x0800f198: 6088        str	r0, [r1, #8]
@   0x0800f19a: 6888        ldr	r0, [r1, #8]
@   0x0800f19c: 481d        ldr	r0, [pc, #116]	@ (0xf214)
@   0x0800f19e: 6008        str	r0, [r1, #0]
@   0x0800f1a0: 481d        ldr	r0, [pc, #116]	@ (0xf218)
@   0x0800f1a2: 6048        str	r0, [r1, #4]
@   0x0800f1a4: 481d        ldr	r0, [pc, #116]	@ (0xf21c)
@   0x0800f1a6: 6088        str	r0, [r1, #8]
@   0x0800f1a8: 6888        ldr	r0, [r1, #8]
@   0x0800f1aa: 491d        ldr	r1, [pc, #116]	@ (0xf220)
@   0x0800f1ac: 2003        movs	r0, #3
@   0x0800f1ae: 8008        strh	r0, [r1, #0]
@   0x0800f1b0: 491c        ldr	r1, [pc, #112]	@ (0xf224)
@   0x0800f1b2: 2018        movs	r0, #24
@   0x0800f1b4: 8008        strh	r0, [r1, #0]
@   0x0800f1b6: 310a        adds	r1, #10
@   0x0800f1b8: 4f1b        ldr	r7, [pc, #108]	@ (0xf228)
@   0x0800f1ba: 1c38        adds	r0, r7, #0
@   0x0800f1bc: 8008        strh	r0, [r1, #0]
@   0x0800f1be: 390e        subs	r1, #14
@   0x0800f1c0: 4648        mov	r0, r9
@   0x0800f1c2: 8008        strh	r0, [r1, #0]
@   0x0800f1c4: 22b4        movs	r2, #180	@ 0xb4
@   0x0800f1c6: 0112        lsls	r2, r2, #4
@   0x0800f1c8: 1c10        adds	r0, r2, #0
@   0x0800f1ca: 8008        strh	r0, [r1, #0]
@   0x0800f1cc: f7ff        fec4 	bl	0xef58
@   0x0800f1d0: bc18        pop	{r3, r4}
@   0x0800f1d2: 4698        mov	r8, r3
@   0x0800f1d4: 46a1        mov	r9, r4
@   0x0800f1d6: bcf0        pop	{r4, r5, r6, r7}
@   0x0800f1d8: bc01        pop	{r0}
@   0x0800f1da: 4700        bx	r0
@   0x0800f1dc: 00d4        lsls	r4, r2, #3
@   0x0800f1de: 0400        lsls	r0, r0, #16
@   0x0800f1e0: 3190        adds	r1, #144	@ 0x90
@   0x0800f1e2: 080e        lsrs	r6, r1, #32
@   0x0800f1e4: 0100        lsls	r0, r0, #4
@   0x0800f1e6: 8000        strh	r0, [r0, #0]
@   0x0800f1e8: 5330        strh	r0, [r6, r4]
@   0x0800f1ea: 0300        lsls	r0, r0, #12
@   0x0800f1ec: 4000        ands	r0, r0
@   0x0800f1ee: 8000        strh	r0, [r0, #0]
@   0x0800f1f0: 3550        adds	r5, #80	@ 0x50
@   0x0800f1f2: 0300        lsls	r0, r0, #12
@   0x0800f1f4: 60a0        str	r0, [r4, #8]
@   0x0800f1f6: 0300        lsls	r0, r0, #12
@   0x0800f1f8: 0008        movs	r0, r1
@   0x0800f1fa: 0400        lsls	r0, r0, #16
@   0x0800f1fc: 1c03        adds	r3, r0, #0
@   0x0800f1fe: 0000        movs	r0, r0
@   0x0800f200: 8000        strh	r0, [r0, #0]
@   0x0800f202: 0600        lsls	r0, r0, #24
@   0x0800f204: 1d0a        adds	r2, r1, #4
@   0x0800f206: 0000        movs	r0, r0
@   0x0800f208: 3754        adds	r7, #84	@ 0x54
@   0x0800f20a: 080e        lsrs	r6, r1, #32
@   0x0800f20c: 01a0        lsls	r0, r4, #6
@   0x0800f20e: 0500        lsls	r0, r0, #20
@   0x0800f210: 0030        movs	r0, r6
@   0x0800f212: 8000        strh	r0, [r0, #0]
@   0x0800f214: 3ab6        subs	r2, #182	@ 0xb6
@   0x0800f216: 080e        lsrs	r6, r1, #32
@   0x0800f218: c000        stmia	r0!, {}
@   0x0800f21a: 0600        lsls	r0, r0, #24
@   0x0800f21c: 1000        asrs	r0, r0, #32
@   0x0800f21e: 8000        strh	r0, [r0, #0]
@   0x0800f220: 0200        lsls	r0, r0, #8
@   0x0800f222: 0400        lsls	r0, r0, #16
@   0x0800f224: 0004        movs	r4, r0
@   0x0800f226: 0400        lsls	r0, r0, #16
@   0x0800f228: 1f0c        subs	r4, r1, #4
@   0x0800f22a: 0000        movs	r0, r0
@   0x0800f22c: b500        push	{lr}
@   0x0800f22e: 2000        movs	r0, #0
@   0x0800f230: f001        face 	bl	0x107d0
@   0x0800f234: 2001        movs	r0, #1
@   0x0800f236: f001        facb 	bl	0x107d0
@   0x0800f23a: 2002        movs	r0, #2
@   0x0800f23c: f001        fac8 	bl	0x107d0
@   0x0800f240: 2003        movs	r0, #3
@   0x0800f242: f001        fac5 	bl	0x107d0
@   0x0800f246: bc01        pop	{r0}
@   0x0800f248: 4700        bx	r0

        thumb_func_start sub_0800F014
sub_0800F014: @ 0x0800f014
        .incbin "frog_us_baserom.gba", 0xf014, 0x238
        thumb_func_end sub_0800F014
