@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801f1e0, 0x0801f418)  (568 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801f1e0 --end 0x801f418 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801f1e0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801f1e2: 4657        mov	r7, sl
@   0x0801f1e4: 464e        mov	r6, r9
@   0x0801f1e6: 4645        mov	r5, r8
@   0x0801f1e8: b4e0        push	{r5, r6, r7}
@   0x0801f1ea: b087        sub	sp, #28
@   0x0801f1ec: 493b        ldr	r1, [pc, #236]	@ (0x1f2dc)
@   0x0801f1ee: 9804        ldr	r0, [sp, #16]
@   0x0801f1f0: 4008        ands	r0, r1
@   0x0801f1f2: 2102        movs	r1, #2
@   0x0801f1f4: 4308        orrs	r0, r1
@   0x0801f1f6: 493a        ldr	r1, [pc, #232]	@ (0x1f2e0)
@   0x0801f1f8: 4008        ands	r0, r1
@   0x0801f1fa: 21c0        movs	r1, #192	@ 0xc0
@   0x0801f1fc: 0089        lsls	r1, r1, #2
@   0x0801f1fe: 4308        orrs	r0, r1
@   0x0801f200: 4938        ldr	r1, [pc, #224]	@ (0x1f2e4)
@   0x0801f202: 4008        ands	r0, r1
@   0x0801f204: 2180        movs	r1, #128	@ 0x80
@   0x0801f206: 04c9        lsls	r1, r1, #19
@   0x0801f208: 4308        orrs	r0, r1
@   0x0801f20a: 4937        ldr	r1, [pc, #220]	@ (0x1f2e8)
@   0x0801f20c: 4008        ands	r0, r1
@   0x0801f20e: 21d0        movs	r1, #208	@ 0xd0
@   0x0801f210: 0349        lsls	r1, r1, #13
@   0x0801f212: 4308        orrs	r0, r1
@   0x0801f214: 9004        str	r0, [sp, #16]
@   0x0801f216: 4a35        ldr	r2, [pc, #212]	@ (0x1f2ec)
@   0x0801f218: 7810        ldrb	r0, [r2, #0]
@   0x0801f21a: 9005        str	r0, [sp, #20]
@   0x0801f21c: a903        add	r1, sp, #12
@   0x0801f21e: 2000        movs	r0, #0
@   0x0801f220: 8008        strh	r0, [r1, #0]
@   0x0801f222: 4933        ldr	r1, [pc, #204]	@ (0x1f2f0)
@   0x0801f224: a803        add	r0, sp, #12
@   0x0801f226: 6008        str	r0, [r1, #0]
@   0x0801f228: 4832        ldr	r0, [pc, #200]	@ (0x1f2f4)
@   0x0801f22a: 6048        str	r0, [r1, #4]
@   0x0801f22c: 4832        ldr	r0, [pc, #200]	@ (0x1f2f8)
@   0x0801f22e: 6088        str	r0, [r1, #8]
@   0x0801f230: 6888        ldr	r0, [r1, #8]
@   0x0801f232: 2100        movs	r1, #0
@   0x0801f234: 468a        mov	sl, r1
@   0x0801f236: 4668        mov	r0, sp
@   0x0801f238: 3010        adds	r0, #16
@   0x0801f23a: 9006        str	r0, [sp, #24]
@   0x0801f23c: 9805        ldr	r0, [sp, #20]
@   0x0801f23e: 4651        mov	r1, sl
@   0x0801f240: 4108        asrs	r0, r1
@   0x0801f242: 2101        movs	r1, #1
@   0x0801f244: 4008        ands	r0, r1
@   0x0801f246: 2800        cmp	r0, #0
@   0x0801f248: d100        bne.n	0x1f24c
@   0x0801f24a: e0b3        b.n	0x1f3b4
@   0x0801f24c: 4823        ldr	r0, [pc, #140]	@ (0x1f2dc)
@   0x0801f24e: 9904        ldr	r1, [sp, #16]
@   0x0801f250: 4001        ands	r1, r0
@   0x0801f252: 2003        movs	r0, #3
@   0x0801f254: 4301        orrs	r1, r0
@   0x0801f256: 4650        mov	r0, sl
@   0x0801f258: 0083        lsls	r3, r0, #2
@   0x0801f25a: 1cda        adds	r2, r3, #3
@   0x0801f25c: 0612        lsls	r2, r2, #24
@   0x0801f25e: 0c12        lsrs	r2, r2, #16
@   0x0801f260: 481f        ldr	r0, [pc, #124]	@ (0x1f2e0)
@   0x0801f262: 4001        ands	r1, r0
@   0x0801f264: 4311        orrs	r1, r2
@   0x0801f266: 9104        str	r1, [sp, #16]
@   0x0801f268: 3304        adds	r3, #4
@   0x0801f26a: 061b        lsls	r3, r3, #24
@   0x0801f26c: 0e1e        lsrs	r6, r3, #24
@   0x0801f26e: 9806        ldr	r0, [sp, #24]
@   0x0801f270: 4922        ldr	r1, [pc, #136]	@ (0x1f2fc)
@   0x0801f272: 2202        movs	r2, #2
@   0x0801f274: f7fa        fa3a 	bl	0x196ec
@   0x0801f278: 4651        mov	r1, sl
@   0x0801f27a: 0049        lsls	r1, r1, #1
@   0x0801f27c: 4689        mov	r9, r1
@   0x0801f27e: 464c        mov	r4, r9
@   0x0801f280: 4454        add	r4, sl
@   0x0801f282: 00a4        lsls	r4, r4, #2
@   0x0801f284: 491e        ldr	r1, [pc, #120]	@ (0x1f300)
@   0x0801f286: 1860        adds	r0, r4, r1
@   0x0801f288: 21a0        movs	r1, #160	@ 0xa0
@   0x0801f28a: 0049        lsls	r1, r1, #1
@   0x0801f28c: 4688        mov	r8, r1
@   0x0801f28e: 9100        str	r1, [sp, #0]
@   0x0801f290: 2705        movs	r7, #5
@   0x0801f292: 9701        str	r7, [sp, #4]
@   0x0801f294: 2502        movs	r5, #2
@   0x0801f296: 9502        str	r5, [sp, #8]
@   0x0801f298: 2103        movs	r1, #3
@   0x0801f29a: 2203        movs	r2, #3
@   0x0801f29c: 1c33        adds	r3, r6, #0
@   0x0801f29e: f7fc        fded 	bl	0x1be7c
@   0x0801f2a2: 4640        mov	r0, r8
@   0x0801f2a4: 9000        str	r0, [sp, #0]
@   0x0801f2a6: 9701        str	r7, [sp, #4]
@   0x0801f2a8: 9502        str	r5, [sp, #8]
@   0x0801f2aa: 4816        ldr	r0, [pc, #88]	@ (0x1f304)
@   0x0801f2ac: 2103        movs	r1, #3
@   0x0801f2ae: 220c        movs	r2, #12
@   0x0801f2b0: 1c33        adds	r3, r6, #0
@   0x0801f2b2: f7fc        fde3 	bl	0x1be7c
@   0x0801f2b6: 490d        ldr	r1, [pc, #52]	@ (0x1f2ec)
@   0x0801f2b8: 1864        adds	r4, r4, r1
@   0x0801f2ba: 7b60        ldrb	r0, [r4, #13]
@   0x0801f2bc: 9700        str	r7, [sp, #0]
@   0x0801f2be: 9501        str	r5, [sp, #4]
@   0x0801f2c0: 210c        movs	r1, #12
@   0x0801f2c2: 1c32        adds	r2, r6, #0
@   0x0801f2c4: 4643        mov	r3, r8
@   0x0801f2c6: f7fd        fe27 	bl	0x1cf18
@   0x0801f2ca: 7ba0        ldrb	r0, [r4, #14]
@   0x0801f2cc: 2863        cmp	r0, #99	@ 0x63
@   0x0801f2ce: d91b        bls.n	0x1f308
@   0x0801f2d0: 9700        str	r7, [sp, #0]
@   0x0801f2d2: 9501        str	r5, [sp, #4]
@   0x0801f2d4: 2100        movs	r1, #0
@   0x0801f2d6: 9102        str	r1, [sp, #8]
@   0x0801f2d8: 2112        movs	r1, #18
@   0x0801f2da: e01d        b.n	0x1f318
@   0x0801f2dc: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801f2e0: 00ff        lsls	r7, r7, #3
@   0x0801f2e2: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801f2e6: 00ff        lsls	r7, r7, #3
@   0x0801f2e8: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801f2ec: 3500        adds	r5, #0
@   0x0801f2ee: 0300        lsls	r0, r0, #12
@   0x0801f2f0: 00d4        lsls	r4, r2, #3
@   0x0801f2f2: 0400        lsls	r0, r0, #16
@   0x0801f2f4: f000        0600 	and.w	r6, r0, #0
@   0x0801f2f8: 0400        lsls	r0, r0, #16
@   0x0801f2fa: 8100        strh	r0, [r0, #8]
@   0x0801f2fc: 8398        strh	r0, [r3, #28]
@   0x0801f2fe: 081d        lsrs	r5, r3, #32
@   0x0801f300: 3510        adds	r5, #16
@   0x0801f302: 0300        lsls	r0, r0, #12
@   0x0801f304: e800        081b 			@ <UNDEFINED> instruction: 0xe800081b
@   0x0801f308: 2809        cmp	r0, #9
@   0x0801f30a: d90a        bls.n	0x1f322
@   0x0801f30c: 7ba0        ldrb	r0, [r4, #14]
@   0x0801f30e: 9700        str	r7, [sp, #0]
@   0x0801f310: 9501        str	r5, [sp, #4]
@   0x0801f312: 2100        movs	r1, #0
@   0x0801f314: 9102        str	r1, [sp, #8]
@   0x0801f316: 2113        movs	r1, #19
@   0x0801f318: 1c32        adds	r2, r6, #0
@   0x0801f31a: 4643        mov	r3, r8
@   0x0801f31c: f7fc        ffca 	bl	0x1c2b4
@   0x0801f320: e009        b.n	0x1f336
@   0x0801f322: 7ba0        ldrb	r0, [r4, #14]
@   0x0801f324: 9700        str	r7, [sp, #0]
@   0x0801f326: 9501        str	r5, [sp, #4]
@   0x0801f328: 2100        movs	r1, #0
@   0x0801f32a: 9102        str	r1, [sp, #8]
@   0x0801f32c: 2114        movs	r1, #20
@   0x0801f32e: 1c32        adds	r2, r6, #0
@   0x0801f330: 4643        mov	r3, r8
@   0x0801f332: f7fc        ffbf 	bl	0x1c2b4
@   0x0801f336: 4648        mov	r0, r9
@   0x0801f338: 4450        add	r0, sl
@   0x0801f33a: 0080        lsls	r0, r0, #2
@   0x0801f33c: 490c        ldr	r1, [pc, #48]	@ (0x1f370)
@   0x0801f33e: 1840        adds	r0, r0, r1
@   0x0801f340: 6800        ldr	r0, [r0, #0]
@   0x0801f342: f7fb        ff21 	bl	0x1b188
@   0x0801f346: 0600        lsls	r0, r0, #24
@   0x0801f348: 0e01        lsrs	r1, r0, #24
@   0x0801f34a: 2064        movs	r0, #100	@ 0x64
@   0x0801f34c: 4348        muls	r0, r1
@   0x0801f34e: 1100        asrs	r0, r0, #4
@   0x0801f350: 0600        lsls	r0, r0, #24
@   0x0801f352: 0e01        lsrs	r1, r0, #24
@   0x0801f354: 2964        cmp	r1, #100	@ 0x64
@   0x0801f356: d00d        beq.n	0x1f374
@   0x0801f358: 2005        movs	r0, #5
@   0x0801f35a: 9000        str	r0, [sp, #0]
@   0x0801f35c: 2002        movs	r0, #2
@   0x0801f35e: 9001        str	r0, [sp, #4]
@   0x0801f360: 1c08        adds	r0, r1, #0
@   0x0801f362: 2117        movs	r1, #23
@   0x0801f364: 1c32        adds	r2, r6, #0
@   0x0801f366: 23a0        movs	r3, #160	@ 0xa0
@   0x0801f368: 005b        lsls	r3, r3, #1
@   0x0801f36a: f7fd        fdd5 	bl	0x1cf18
@   0x0801f36e: e00e        b.n	0x1f38e
@   0x0801f370: 3508        adds	r5, #8
@   0x0801f372: 0300        lsls	r0, r0, #12
@   0x0801f374: 2005        movs	r0, #5
@   0x0801f376: 9000        str	r0, [sp, #0]
@   0x0801f378: 2002        movs	r0, #2
@   0x0801f37a: 9001        str	r0, [sp, #4]
@   0x0801f37c: 2000        movs	r0, #0
@   0x0801f37e: 9002        str	r0, [sp, #8]
@   0x0801f380: 2064        movs	r0, #100	@ 0x64
@   0x0801f382: 2116        movs	r1, #22
@   0x0801f384: 1c32        adds	r2, r6, #0
@   0x0801f386: 23a0        movs	r3, #160	@ 0xa0
@   0x0801f388: 005b        lsls	r3, r3, #1
@   0x0801f38a: f7fc        ff93 	bl	0x1c2b4
@   0x0801f38e: 4808        ldr	r0, [pc, #32]	@ (0x1f3b0)
@   0x0801f390: 7d00        ldrb	r0, [r0, #20]
@   0x0801f392: 4550        cmp	r0, sl
@   0x0801f394: d12a        bne.n	0x1f3ec
@   0x0801f396: 9806        ldr	r0, [sp, #24]
@   0x0801f398: 2105        movs	r1, #5
@   0x0801f39a: 2204        movs	r2, #4
@   0x0801f39c: 2302        movs	r3, #2
@   0x0801f39e: f7f9        f89d 	bl	0x184dc
@   0x0801f3a2: 9806        ldr	r0, [sp, #24]
@   0x0801f3a4: 2107        movs	r1, #7
@   0x0801f3a6: 2206        movs	r2, #6
@   0x0801f3a8: 2302        movs	r3, #2
@   0x0801f3aa: f7f9        f897 	bl	0x184dc
@   0x0801f3ae: e01d        b.n	0x1f3ec
@   0x0801f3b0: 3480        adds	r4, #128	@ 0x80
@   0x0801f3b2: 0300        lsls	r0, r0, #12
@   0x0801f3b4: 2003        movs	r0, #3
@   0x0801f3b6: 9906        ldr	r1, [sp, #24]
@   0x0801f3b8: 7008        strb	r0, [r1, #0]
@   0x0801f3ba: 4651        mov	r1, sl
@   0x0801f3bc: 0088        lsls	r0, r1, #2
@   0x0801f3be: 3004        adds	r0, #4
@   0x0801f3c0: ac04        add	r4, sp, #16
@   0x0801f3c2: 7060        strb	r0, [r4, #1]
@   0x0801f3c4: 4911        ldr	r1, [pc, #68]	@ (0x1f40c)
@   0x0801f3c6: 4812        ldr	r0, [pc, #72]	@ (0x1f410)
@   0x0801f3c8: 6800        ldr	r0, [r0, #0]
@   0x0801f3ca: 0080        lsls	r0, r0, #2
@   0x0801f3cc: 1840        adds	r0, r0, r1
@   0x0801f3ce: 6801        ldr	r1, [r0, #0]
@   0x0801f3d0: 1c20        adds	r0, r4, #0
@   0x0801f3d2: 2202        movs	r2, #2
@   0x0801f3d4: f7fa        f98a 	bl	0x196ec
@   0x0801f3d8: 480e        ldr	r0, [pc, #56]	@ (0x1f414)
@   0x0801f3da: 7d00        ldrb	r0, [r0, #20]
@   0x0801f3dc: 4550        cmp	r0, sl
@   0x0801f3de: d105        bne.n	0x1f3ec
@   0x0801f3e0: 1c20        adds	r0, r4, #0
@   0x0801f3e2: 2105        movs	r1, #5
@   0x0801f3e4: 2204        movs	r2, #4
@   0x0801f3e6: 2302        movs	r3, #2
@   0x0801f3e8: f7f9        f878 	bl	0x184dc
@   0x0801f3ec: 4650        mov	r0, sl
@   0x0801f3ee: 3001        adds	r0, #1
@   0x0801f3f0: 0600        lsls	r0, r0, #24
@   0x0801f3f2: 0e00        lsrs	r0, r0, #24
@   0x0801f3f4: 4682        mov	sl, r0
@   0x0801f3f6: 2803        cmp	r0, #3
@   0x0801f3f8: d800        bhi.n	0x1f3fc
@   0x0801f3fa: e71f        b.n	0x1f23c
@   0x0801f3fc: b007        add	sp, #28
@   0x0801f3fe: bc38        pop	{r3, r4, r5}
@   0x0801f400: 4698        mov	r8, r3
@   0x0801f402: 46a1        mov	r9, r4
@   0x0801f404: 46aa        mov	sl, r5
@   0x0801f406: bcf0        pop	{r4, r5, r6, r7}
@   0x0801f408: bc01        pop	{r0}
@   0x0801f40a: 4700        bx	r0
@   0x0801f40c: 8ef4        ldrh	r4, [r6, #54]	@ 0x36
@   0x0801f40e: 0830        lsrs	r0, r6, #32
@   0x0801f410: 34b0        adds	r4, #176	@ 0xb0
@   0x0801f412: 0300        lsls	r0, r0, #12
@   0x0801f414: 3480        adds	r4, #128	@ 0x80
@   0x0801f416: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801F1E0
sub_0801F1E0: @ 0x0801f1e0
        .incbin "frog_us_baserom.gba", 0x1f1e0, 0x238
        thumb_func_end sub_0801F1E0
