@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003668, 0x08003864)  (508 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003668 --end 0x8003864 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003668: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800366a: 4657        mov	r7, sl
@   0x0800366c: 464e        mov	r6, r9
@   0x0800366e: 4645        mov	r5, r8
@   0x08003670: b4e0        push	{r5, r6, r7}
@   0x08003672: 1c07        adds	r7, r0, #0
@   0x08003674: 4688        mov	r8, r1
@   0x08003676: 4691        mov	r9, r2
@   0x08003678: 469a        mov	sl, r3
@   0x0800367a: 2206        movs	r2, #6
@   0x0800367c: f008        f94c 	bl	0xb918
@   0x08003680: 4648        mov	r0, r9
@   0x08003682: 4651        mov	r1, sl
@   0x08003684: 2207        movs	r2, #7
@   0x08003686: f008        f947 	bl	0xb918
@   0x0800368a: 9808        ldr	r0, [sp, #32]
@   0x0800368c: 9909        ldr	r1, [sp, #36]	@ 0x24
@   0x0800368e: 2216        movs	r2, #22
@   0x08003690: f008        fc48 	bl	0xbf24
@   0x08003694: 4e60        ldr	r6, [pc, #384]	@ (0x3818)
@   0x08003696: 2004        movs	r0, #4
@   0x08003698: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x0800369a: 4008        ands	r0, r1
@   0x0800369c: 2800        cmp	r0, #0
@   0x0800369e: d000        beq.n	0x36a2
@   0x080036a0: e0b2        b.n	0x3808
@   0x080036a2: 4d5e        ldr	r5, [pc, #376]	@ (0x381c)
@   0x080036a4: 7e28        ldrb	r0, [r5, #24]
@   0x080036a6: 7e69        ldrb	r1, [r5, #25]
@   0x080036a8: 2308        movs	r3, #8
@   0x080036aa: 5eea        ldrsh	r2, [r5, r3]
@   0x080036ac: 240a        movs	r4, #10
@   0x080036ae: 5f2b        ldrsh	r3, [r5, r4]
@   0x080036b0: f009        fb6a 	bl	0xcd88
@   0x080036b4: 0600        lsls	r0, r0, #24
@   0x080036b6: 0e04        lsrs	r4, r0, #24
@   0x080036b8: 2010        movs	r0, #16
@   0x080036ba: 8a29        ldrh	r1, [r5, #16]
@   0x080036bc: 4008        ands	r0, r1
@   0x080036be: 2800        cmp	r0, #0
@   0x080036c0: d014        beq.n	0x36ec
@   0x080036c2: 1c38        adds	r0, r7, #0
@   0x080036c4: 4641        mov	r1, r8
@   0x080036c6: 2206        movs	r2, #6
@   0x080036c8: 1c23        adds	r3, r4, #0
@   0x080036ca: f008        f8ed 	bl	0xb8a8
@   0x080036ce: 4648        mov	r0, r9
@   0x080036d0: 4651        mov	r1, sl
@   0x080036d2: 2207        movs	r2, #7
@   0x080036d4: 1c23        adds	r3, r4, #0
@   0x080036d6: f008        f8e7 	bl	0xb8a8
@   0x080036da: 9808        ldr	r0, [sp, #32]
@   0x080036dc: 9909        ldr	r1, [sp, #36]	@ 0x24
@   0x080036de: 2216        movs	r2, #22
@   0x080036e0: 1c23        adds	r3, r4, #0
@   0x080036e2: f008        fbeb 	bl	0xbebc
@   0x080036e6: 1c20        adds	r0, r4, #0
@   0x080036e8: f008        feac 	bl	0xc444
@   0x080036ec: 1c28        adds	r0, r5, #0
@   0x080036ee: 2140        movs	r1, #64	@ 0x40
@   0x080036f0: f003        fa58 	bl	0x6ba4
@   0x080036f4: 0600        lsls	r0, r0, #24
@   0x080036f6: 2800        cmp	r0, #0
@   0x080036f8: d025        beq.n	0x3746
@   0x080036fa: 68aa        ldr	r2, [r5, #8]
@   0x080036fc: 4848        ldr	r0, [pc, #288]	@ (0x3820)
@   0x080036fe: 1c11        adds	r1, r2, #0
@   0x08003700: 4281        cmp	r1, r0
@   0x08003702: d101        bne.n	0x3708
@   0x08003704: 2002        movs	r0, #2
@   0x08003706: 71b0        strb	r0, [r6, #6]
@   0x08003708: 20b2        movs	r0, #178	@ 0xb2
@   0x0800370a: 03c0        lsls	r0, r0, #15
@   0x0800370c: 4281        cmp	r1, r0
@   0x0800370e: d101        bne.n	0x3714
@   0x08003710: 2002        movs	r0, #2
@   0x08003712: 71b0        strb	r0, [r6, #6]
@   0x08003714: 4843        ldr	r0, [pc, #268]	@ (0x3824)
@   0x08003716: 4281        cmp	r1, r0
@   0x08003718: d101        bne.n	0x371e
@   0x0800371a: 2002        movs	r0, #2
@   0x0800371c: 71b0        strb	r0, [r6, #6]
@   0x0800371e: 4842        ldr	r0, [pc, #264]	@ (0x3828)
@   0x08003720: 4281        cmp	r1, r0
@   0x08003722: d101        bne.n	0x3728
@   0x08003724: 2003        movs	r0, #3
@   0x08003726: 71b0        strb	r0, [r6, #6]
@   0x08003728: 4840        ldr	r0, [pc, #256]	@ (0x382c)
@   0x0800372a: 4281        cmp	r1, r0
@   0x0800372c: d101        bne.n	0x3732
@   0x0800372e: 2003        movs	r0, #3
@   0x08003730: 71b0        strb	r0, [r6, #6]
@   0x08003732: 483f        ldr	r0, [pc, #252]	@ (0x3830)
@   0x08003734: 4281        cmp	r1, r0
@   0x08003736: d101        bne.n	0x373c
@   0x08003738: 2003        movs	r0, #3
@   0x0800373a: 71b0        strb	r0, [r6, #6]
@   0x0800373c: 483d        ldr	r0, [pc, #244]	@ (0x3834)
@   0x0800373e: 4282        cmp	r2, r0
@   0x08003740: d101        bne.n	0x3746
@   0x08003742: 2003        movs	r0, #3
@   0x08003744: 71b0        strb	r0, [r6, #6]
@   0x08003746: 493c        ldr	r1, [pc, #240]	@ (0x3838)
@   0x08003748: 2001        movs	r0, #1
@   0x0800374a: 7c09        ldrb	r1, [r1, #16]
@   0x0800374c: 4008        ands	r0, r1
@   0x0800374e: 2800        cmp	r0, #0
@   0x08003750: d15a        bne.n	0x3808
@   0x08003752: 4c32        ldr	r4, [pc, #200]	@ (0x381c)
@   0x08003754: 68a1        ldr	r1, [r4, #8]
@   0x08003756: 4839        ldr	r0, [pc, #228]	@ (0x383c)
@   0x08003758: 4281        cmp	r1, r0
@   0x0800375a: d104        bne.n	0x3766
@   0x0800375c: 2180        movs	r1, #128	@ 0x80
@   0x0800375e: 0089        lsls	r1, r1, #2
@   0x08003760: 1c20        adds	r0, r4, #0
@   0x08003762: f003        fa11 	bl	0x6b88
@   0x08003766: 68a1        ldr	r1, [r4, #8]
@   0x08003768: 4835        ldr	r0, [pc, #212]	@ (0x3840)
@   0x0800376a: 4281        cmp	r1, r0
@   0x0800376c: d104        bne.n	0x3778
@   0x0800376e: 2180        movs	r1, #128	@ 0x80
@   0x08003770: 0089        lsls	r1, r1, #2
@   0x08003772: 1c20        adds	r0, r4, #0
@   0x08003774: f003        fa08 	bl	0x6b88
@   0x08003778: 68a1        ldr	r1, [r4, #8]
@   0x0800377a: 4832        ldr	r0, [pc, #200]	@ (0x3844)
@   0x0800377c: 4281        cmp	r1, r0
@   0x0800377e: d104        bne.n	0x378a
@   0x08003780: 2180        movs	r1, #128	@ 0x80
@   0x08003782: 0089        lsls	r1, r1, #2
@   0x08003784: 1c20        adds	r0, r4, #0
@   0x08003786: f003        f9ff 	bl	0x6b88
@   0x0800378a: 68a1        ldr	r1, [r4, #8]
@   0x0800378c: 482e        ldr	r0, [pc, #184]	@ (0x3848)
@   0x0800378e: 4281        cmp	r1, r0
@   0x08003790: d104        bne.n	0x379c
@   0x08003792: 2180        movs	r1, #128	@ 0x80
@   0x08003794: 0089        lsls	r1, r1, #2
@   0x08003796: 1c20        adds	r0, r4, #0
@   0x08003798: f003        f9f6 	bl	0x6b88
@   0x0800379c: 68a1        ldr	r1, [r4, #8]
@   0x0800379e: 482b        ldr	r0, [pc, #172]	@ (0x384c)
@   0x080037a0: 4281        cmp	r1, r0
@   0x080037a2: d104        bne.n	0x37ae
@   0x080037a4: 2180        movs	r1, #128	@ 0x80
@   0x080037a6: 0089        lsls	r1, r1, #2
@   0x080037a8: 1c20        adds	r0, r4, #0
@   0x080037aa: f003        f9ed 	bl	0x6b88
@   0x080037ae: 68a1        ldr	r1, [r4, #8]
@   0x080037b0: 4827        ldr	r0, [pc, #156]	@ (0x3850)
@   0x080037b2: 4281        cmp	r1, r0
@   0x080037b4: d104        bne.n	0x37c0
@   0x080037b6: 2180        movs	r1, #128	@ 0x80
@   0x080037b8: 0089        lsls	r1, r1, #2
@   0x080037ba: 1c20        adds	r0, r4, #0
@   0x080037bc: f003        f9e4 	bl	0x6b88
@   0x080037c0: 68a1        ldr	r1, [r4, #8]
@   0x080037c2: 4824        ldr	r0, [pc, #144]	@ (0x3854)
@   0x080037c4: 4281        cmp	r1, r0
@   0x080037c6: d104        bne.n	0x37d2
@   0x080037c8: 2180        movs	r1, #128	@ 0x80
@   0x080037ca: 0089        lsls	r1, r1, #2
@   0x080037cc: 1c20        adds	r0, r4, #0
@   0x080037ce: f003        f9db 	bl	0x6b88
@   0x080037d2: 68a1        ldr	r1, [r4, #8]
@   0x080037d4: 4820        ldr	r0, [pc, #128]	@ (0x3858)
@   0x080037d6: 4281        cmp	r1, r0
@   0x080037d8: d104        bne.n	0x37e4
@   0x080037da: 2180        movs	r1, #128	@ 0x80
@   0x080037dc: 0089        lsls	r1, r1, #2
@   0x080037de: 1c20        adds	r0, r4, #0
@   0x080037e0: f003        f9d2 	bl	0x6b88
@   0x080037e4: 68a1        ldr	r1, [r4, #8]
@   0x080037e6: 481d        ldr	r0, [pc, #116]	@ (0x385c)
@   0x080037e8: 4281        cmp	r1, r0
@   0x080037ea: d104        bne.n	0x37f6
@   0x080037ec: 2180        movs	r1, #128	@ 0x80
@   0x080037ee: 0089        lsls	r1, r1, #2
@   0x080037f0: 1c20        adds	r0, r4, #0
@   0x080037f2: f003        f9c9 	bl	0x6b88
@   0x080037f6: 68a1        ldr	r1, [r4, #8]
@   0x080037f8: 4819        ldr	r0, [pc, #100]	@ (0x3860)
@   0x080037fa: 4281        cmp	r1, r0
@   0x080037fc: d104        bne.n	0x3808
@   0x080037fe: 2180        movs	r1, #128	@ 0x80
@   0x08003800: 0089        lsls	r1, r1, #2
@   0x08003802: 1c20        adds	r0, r4, #0
@   0x08003804: f003        f9c0 	bl	0x6b88
@   0x08003808: bc38        pop	{r3, r4, r5}
@   0x0800380a: 4698        mov	r8, r3
@   0x0800380c: 46a1        mov	r9, r4
@   0x0800380e: 46aa        mov	sl, r5
@   0x08003810: bcf0        pop	{r4, r5, r6, r7}
@   0x08003812: bc01        pop	{r0}
@   0x08003814: 4700        bx	r0
@   0x08003816: 0000        movs	r0, r0
@   0x08003818: 3720        adds	r7, #32
@   0x0800381a: 0300        lsls	r0, r0, #12
@   0x0800381c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800381e: 0300        lsls	r0, r0, #12
@   0x08003820: 0002        movs	r2, r0
@   0x08003822: 005e        lsls	r6, r3, #1
@   0x08003824: 0001        movs	r1, r0
@   0x08003826: 0059        lsls	r1, r3, #1
@   0x08003828: 0002        movs	r2, r0
@   0x0800382a: 005d        lsls	r5, r3, #1
@   0x0800382c: 0003        movs	r3, r0
@   0x0800382e: 005e        lsls	r6, r3, #1
@   0x08003830: 0002        movs	r2, r0
@   0x08003832: 005f        lsls	r7, r3, #1
@   0x08003834: 0002        movs	r2, r0
@   0x08003836: 0058        lsls	r0, r3, #1
@   0x08003838: 5330        strh	r0, [r6, r4]
@   0x0800383a: 0300        lsls	r0, r0, #12
@   0x0800383c: 0014        movs	r4, r2
@   0x0800383e: 001f        movs	r7, r3
@   0x08003840: 0016        movs	r6, r2
@   0x08003842: 001f        movs	r7, r3
@   0x08003844: 0014        movs	r4, r2
@   0x08003846: 001c        movs	r4, r3
@   0x08003848: 0015        movs	r5, r2
@   0x0800384a: 001c        movs	r4, r3
@   0x0800384c: 0015        movs	r5, r2
@   0x0800384e: 0019        movs	r1, r3
@   0x08003850: 0016        movs	r6, r2
@   0x08003852: 0019        movs	r1, r3
@   0x08003854: 0014        movs	r4, r2
@   0x08003856: 0022        movs	r2, r4
@   0x08003858: 0015        movs	r5, r2
@   0x0800385a: 0022        movs	r2, r4
@   0x0800385c: 0015        movs	r5, r2
@   0x0800385e: 0025        movs	r5, r4
@   0x08003860: 0016        movs	r6, r2
@   0x08003862: 0025        movs	r5, r4

        thumb_func_start sub_08003668
sub_08003668: @ 0x08003668
        .incbin "frog_us_baserom.gba", 0x3668, 0x1fc
        thumb_func_end sub_08003668
