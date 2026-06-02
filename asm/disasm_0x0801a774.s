@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a774, 0x0801a894)  (288 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a774 --end 0x801a894 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a774: b510        push	{r4, lr}
@   0x0801a776: 0600        lsls	r0, r0, #24
@   0x0801a778: 0e04        lsrs	r4, r0, #24
@   0x0801a77a: 4813        ldr	r0, [pc, #76]	@ (0x1a7c8)
@   0x0801a77c: 22f0        movs	r2, #240	@ 0xf0
@   0x0801a77e: 8002        strh	r2, [r0, #0]
@   0x0801a780: 4912        ldr	r1, [pc, #72]	@ (0x1a7cc)
@   0x0801a782: 4b13        ldr	r3, [pc, #76]	@ (0x1a7d0)
@   0x0801a784: 1c18        adds	r0, r3, #0
@   0x0801a786: 8008        strh	r0, [r1, #0]
@   0x0801a788: 4812        ldr	r0, [pc, #72]	@ (0x1a7d4)
@   0x0801a78a: 8002        strh	r2, [r0, #0]
@   0x0801a78c: 3102        adds	r1, #2
@   0x0801a78e: 2030        movs	r0, #48	@ 0x30
@   0x0801a790: 8008        strh	r0, [r1, #0]
@   0x0801a792: 3102        adds	r1, #2
@   0x0801a794: 4a10        ldr	r2, [pc, #64]	@ (0x1a7d8)
@   0x0801a796: 1c10        adds	r0, r2, #0
@   0x0801a798: 8008        strh	r0, [r1, #0]
@   0x0801a79a: 4a10        ldr	r2, [pc, #64]	@ (0x1a7dc)
@   0x0801a79c: 4b10        ldr	r3, [pc, #64]	@ (0x1a7e0)
@   0x0801a79e: 1c18        adds	r0, r3, #0
@   0x0801a7a0: 8010        strh	r0, [r2, #0]
@   0x0801a7a2: 8810        ldrh	r0, [r2, #0]
@   0x0801a7a4: 2108        movs	r1, #8
@   0x0801a7a6: 4048        eors	r0, r1
@   0x0801a7a8: 8010        strh	r0, [r2, #0]
@   0x0801a7aa: 1c20        adds	r0, r4, #0
@   0x0801a7ac: f000        fd02 	bl	0x1b1b4
@   0x0801a7b0: 490c        ldr	r1, [pc, #48]	@ (0x1a7e4)
@   0x0801a7b2: 2000        movs	r0, #0
@   0x0801a7b4: 7048        strb	r0, [r1, #1]
@   0x0801a7b6: 2001        movs	r0, #1
@   0x0801a7b8: 6088        str	r0, [r1, #8]
@   0x0801a7ba: 2c05        cmp	r4, #5
@   0x0801a7bc: d866        bhi.n	0x1a88c
@   0x0801a7be: 00a0        lsls	r0, r4, #2
@   0x0801a7c0: 4909        ldr	r1, [pc, #36]	@ (0x1a7e8)
@   0x0801a7c2: 1840        adds	r0, r0, r1
@   0x0801a7c4: 6800        ldr	r0, [r0, #0]
@   0x0801a7c6: 4687        mov	pc, r0
@   0x0801a7c8: 0040        lsls	r0, r0, #1
@   0x0801a7ca: 0400        lsls	r0, r0, #16
@   0x0801a7cc: 0044        lsls	r4, r0, #1
@   0x0801a7ce: 0400        lsls	r0, r0, #16
@   0x0801a7d0: 70a0        strb	r0, [r4, #2]
@   0x0801a7d2: 0000        movs	r0, r0
@   0x0801a7d4: 0042        lsls	r2, r0, #1
@   0x0801a7d6: 0400        lsls	r0, r0, #16
@   0x0801a7d8: 0808        lsrs	r0, r1, #32
@   0x0801a7da: 0000        movs	r0, r0
@   0x0801a7dc: 004a        lsls	r2, r1, #1
@   0x0801a7de: 0400        lsls	r0, r0, #16
@   0x0801a7e0: 3f3f        subs	r7, #63	@ 0x3f
@   0x0801a7e2: 0000        movs	r0, r0
@   0x0801a7e4: 3540        adds	r5, #64	@ 0x40
@   0x0801a7e6: 0300        lsls	r0, r0, #12
@   0x0801a7e8: a7ec        add	r7, pc, #944	@ (adr r7, 0x1ab9c)
@   0x0801a7ea: 0801        lsrs	r1, r0, #32
@   0x0801a7ec: a804        add	r0, sp, #16
@   0x0801a7ee: 0801        lsrs	r1, r0, #32
@   0x0801a7f0: a814        add	r0, sp, #80	@ 0x50
@   0x0801a7f2: 0801        lsrs	r1, r0, #32
@   0x0801a7f4: a824        add	r0, sp, #144	@ 0x90
@   0x0801a7f6: 0801        lsrs	r1, r0, #32
@   0x0801a7f8: a834        add	r0, sp, #208	@ 0xd0
@   0x0801a7fa: 0801        lsrs	r1, r0, #32
@   0x0801a7fc: a844        add	r0, sp, #272	@ 0x110
@   0x0801a7fe: 0801        lsrs	r1, r0, #32
@   0x0801a800: a864        add	r0, sp, #400	@ 0x190
@   0x0801a802: 0801        lsrs	r1, r0, #32
@   0x0801a804: 4902        ldr	r1, [pc, #8]	@ (0x1a810)
@   0x0801a806: 2000        movs	r0, #0
@   0x0801a808: 6048        str	r0, [r1, #4]
@   0x0801a80a: 7308        strb	r0, [r1, #12]
@   0x0801a80c: e03e        b.n	0x1a88c
@   0x0801a80e: 0000        movs	r0, r0
@   0x0801a810: 3540        adds	r5, #64	@ 0x40
@   0x0801a812: 0300        lsls	r0, r0, #12
@   0x0801a814: 4802        ldr	r0, [pc, #8]	@ (0x1a820)
@   0x0801a816: 2100        movs	r1, #0
@   0x0801a818: 6041        str	r1, [r0, #4]
@   0x0801a81a: 2107        movs	r1, #7
@   0x0801a81c: 7301        strb	r1, [r0, #12]
@   0x0801a81e: e035        b.n	0x1a88c
@   0x0801a820: 3540        adds	r5, #64	@ 0x40
@   0x0801a822: 0300        lsls	r0, r0, #12
@   0x0801a824: 4802        ldr	r0, [pc, #8]	@ (0x1a830)
@   0x0801a826: 2100        movs	r1, #0
@   0x0801a828: 6041        str	r1, [r0, #4]
@   0x0801a82a: 210b        movs	r1, #11
@   0x0801a82c: 7301        strb	r1, [r0, #12]
@   0x0801a82e: e02d        b.n	0x1a88c
@   0x0801a830: 3540        adds	r5, #64	@ 0x40
@   0x0801a832: 0300        lsls	r0, r0, #12
@   0x0801a834: 4802        ldr	r0, [pc, #8]	@ (0x1a840)
@   0x0801a836: 2100        movs	r1, #0
@   0x0801a838: 6041        str	r1, [r0, #4]
@   0x0801a83a: 210d        movs	r1, #13
@   0x0801a83c: 7301        strb	r1, [r0, #12]
@   0x0801a83e: e025        b.n	0x1a88c
@   0x0801a840: 3540        adds	r5, #64	@ 0x40
@   0x0801a842: 0300        lsls	r0, r0, #12
@   0x0801a844: 4904        ldr	r1, [pc, #16]	@ (0x1a858)
@   0x0801a846: 2200        movs	r2, #0
@   0x0801a848: 604a        str	r2, [r1, #4]
@   0x0801a84a: 4804        ldr	r0, [pc, #16]	@ (0x1a85c)
@   0x0801a84c: 2302        movs	r3, #2
@   0x0801a84e: 5ec0        ldrsh	r0, [r0, r3]
@   0x0801a850: 2831        cmp	r0, #49	@ 0x31
@   0x0801a852: dc05        bgt.n	0x1a860
@   0x0801a854: 2011        movs	r0, #17
@   0x0801a856: e00e        b.n	0x1a876
@   0x0801a858: 3540        adds	r5, #64	@ 0x40
@   0x0801a85a: 0300        lsls	r0, r0, #12
@   0x0801a85c: 35e0        adds	r5, #224	@ 0xe0
@   0x0801a85e: 0300        lsls	r0, r0, #12
@   0x0801a860: 2012        movs	r0, #18
@   0x0801a862: e010        b.n	0x1a886
@   0x0801a864: 4905        ldr	r1, [pc, #20]	@ (0x1a87c)
@   0x0801a866: 2200        movs	r2, #0
@   0x0801a868: 604a        str	r2, [r1, #4]
@   0x0801a86a: 4805        ldr	r0, [pc, #20]	@ (0x1a880)
@   0x0801a86c: 2302        movs	r3, #2
@   0x0801a86e: 5ec0        ldrsh	r0, [r0, r3]
@   0x0801a870: 284a        cmp	r0, #74	@ 0x4a
@   0x0801a872: dc07        bgt.n	0x1a884
@   0x0801a874: 2014        movs	r0, #20
@   0x0801a876: 7308        strb	r0, [r1, #12]
@   0x0801a878: 608a        str	r2, [r1, #8]
@   0x0801a87a: e007        b.n	0x1a88c
@   0x0801a87c: 3540        adds	r5, #64	@ 0x40
@   0x0801a87e: 0300        lsls	r0, r0, #12
@   0x0801a880: 35e0        adds	r5, #224	@ 0xe0
@   0x0801a882: 0300        lsls	r0, r0, #12
@   0x0801a884: 2017        movs	r0, #23
@   0x0801a886: 7308        strb	r0, [r1, #12]
@   0x0801a888: 2001        movs	r0, #1
@   0x0801a88a: 6088        str	r0, [r1, #8]
@   0x0801a88c: bc10        pop	{r4}
@   0x0801a88e: bc01        pop	{r0}
@   0x0801a890: 4700        bx	r0

        thumb_func_start sub_0801A774
sub_0801A774: @ 0x0801a774
        .incbin "frog_us_baserom.gba", 0x1a774, 0x120
        thumb_func_end sub_0801A774
