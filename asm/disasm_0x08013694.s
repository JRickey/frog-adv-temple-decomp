@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013694, 0x0801377c)  (232 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013694 --end 0x801377c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013694: b530        push	{r4, r5, lr}
@   0x08013696: b082        sub	sp, #8
@   0x08013698: 2500        movs	r5, #0
@   0x0801369a: 4a03        ldr	r2, [pc, #12]	@ (0x136a8)
@   0x0801369c: 7810        ldrb	r0, [r2, #0]
@   0x0801369e: 2800        cmp	r0, #0
@   0x080136a0: d004        beq.n	0x136ac
@   0x080136a2: 2801        cmp	r0, #1
@   0x080136a4: d01e        beq.n	0x136e4
@   0x080136a6: e056        b.n	0x13756
@   0x080136a8: 3610        adds	r6, #16
@   0x080136aa: 0300        lsls	r0, r0, #12
@   0x080136ac: 4808        ldr	r0, [pc, #32]	@ (0x136d0)
@   0x080136ae: 7285        strb	r5, [r0, #10]
@   0x080136b0: 4808        ldr	r0, [pc, #32]	@ (0x136d4)
@   0x080136b2: 7285        strb	r5, [r0, #10]
@   0x080136b4: 4908        ldr	r1, [pc, #32]	@ (0x136d8)
@   0x080136b6: 4b09        ldr	r3, [pc, #36]	@ (0x136dc)
@   0x080136b8: 1c18        adds	r0, r3, #0
@   0x080136ba: 8008        strh	r0, [r1, #0]
@   0x080136bc: 3102        adds	r1, #2
@   0x080136be: 4b08        ldr	r3, [pc, #32]	@ (0x136e0)
@   0x080136c0: 1c18        adds	r0, r3, #0
@   0x080136c2: 8008        strh	r0, [r1, #0]
@   0x080136c4: 2001        movs	r0, #1
@   0x080136c6: 7010        strb	r0, [r2, #0]
@   0x080136c8: 2002        movs	r0, #2
@   0x080136ca: f7fb        fbb3 	bl	0xee34
@   0x080136ce: e042        b.n	0x13756
@   0x080136d0: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x080136d2: 0300        lsls	r0, r0, #12
@   0x080136d4: 6580        str	r0, [r0, #88]	@ 0x58
@   0x080136d6: 0300        lsls	r0, r0, #12
@   0x080136d8: 0050        lsls	r0, r2, #1
@   0x080136da: 0400        lsls	r0, r0, #16
@   0x080136dc: 1744        asrs	r4, r0, #29
@   0x080136de: 0000        movs	r0, r0
@   0x080136e0: 0c04        lsrs	r4, r0, #16
@   0x080136e2: 0000        movs	r0, r0
@   0x080136e4: f003        fc8c 	bl	0x17000
@   0x080136e8: 2000        movs	r0, #0
@   0x080136ea: 2100        movs	r1, #0
@   0x080136ec: 22a0        movs	r2, #160	@ 0xa0
@   0x080136ee: 2301        movs	r3, #1
@   0x080136f0: f7ff        ff62 	bl	0x135b8
@   0x080136f4: 4a1a        ldr	r2, [pc, #104]	@ (0x13760)
@   0x080136f6: 481b        ldr	r0, [pc, #108]	@ (0x13764)
@   0x080136f8: 6851        ldr	r1, [r2, #4]
@   0x080136fa: 6800        ldr	r0, [r0, #0]
@   0x080136fc: 4281        cmp	r1, r0
@   0x080136fe: d10a        bne.n	0x13716
@   0x08013700: 7ad0        ldrb	r0, [r2, #11]
@   0x08013702: 2802        cmp	r0, #2
@   0x08013704: d001        beq.n	0x1370a
@   0x08013706: 3801        subs	r0, #1
@   0x08013708: 72d0        strb	r0, [r2, #11]
@   0x0801370a: 4917        ldr	r1, [pc, #92]	@ (0x13768)
@   0x0801370c: 7ac8        ldrb	r0, [r1, #11]
@   0x0801370e: 2800        cmp	r0, #0
@   0x08013710: d001        beq.n	0x13716
@   0x08013712: 3801        subs	r0, #1
@   0x08013714: 72c8        strb	r0, [r1, #11]
@   0x08013716: 4915        ldr	r1, [pc, #84]	@ (0x1376c)
@   0x08013718: 2018        movs	r0, #24
@   0x0801371a: 60c8        str	r0, [r1, #12]
@   0x0801371c: 2028        movs	r0, #40	@ 0x28
@   0x0801371e: 6108        str	r0, [r1, #16]
@   0x08013720: 4813        ldr	r0, [pc, #76]	@ (0x13770)
@   0x08013722: 2234        movs	r2, #52	@ 0x34
@   0x08013724: 5e80        ldrsh	r0, [r0, r2]
@   0x08013726: 3018        adds	r0, #24
@   0x08013728: 62c8        str	r0, [r1, #44]	@ 0x2c
@   0x0801372a: 4c0d        ldr	r4, [pc, #52]	@ (0x13760)
@   0x0801372c: 2336        movs	r3, #54	@ 0x36
@   0x0801372e: 5ee0        ldrsh	r0, [r4, r3]
@   0x08013730: 3028        adds	r0, #40	@ 0x28
@   0x08013732: 6308        str	r0, [r1, #48]	@ 0x30
@   0x08013734: 4b0f        ldr	r3, [pc, #60]	@ (0x13774)
@   0x08013736: 480c        ldr	r0, [pc, #48]	@ (0x13768)
@   0x08013738: 7ac0        ldrb	r0, [r0, #11]
@   0x0801373a: 9000        str	r0, [sp, #0]
@   0x0801373c: 480e        ldr	r0, [pc, #56]	@ (0x13778)
@   0x0801373e: 9001        str	r0, [sp, #4]
@   0x08013740: 6818        ldr	r0, [r3, #0]
@   0x08013742: 6859        ldr	r1, [r3, #4]
@   0x08013744: 689a        ldr	r2, [r3, #8]
@   0x08013746: 68db        ldr	r3, [r3, #12]
@   0x08013748: f000        fa8a 	bl	0x13c60
@   0x0801374c: 2136        movs	r1, #54	@ 0x36
@   0x0801374e: 5e60        ldrsh	r0, [r4, r1]
@   0x08013750: 289f        cmp	r0, #159	@ 0x9f
@   0x08013752: dd00        ble.n	0x13756
@   0x08013754: 2501        movs	r5, #1
@   0x08013756: 1c28        adds	r0, r5, #0
@   0x08013758: b002        add	sp, #8
@   0x0801375a: bc30        pop	{r4, r5}
@   0x0801375c: bc02        pop	{r1}
@   0x0801375e: 4708        bx	r1
@   0x08013760: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08013762: 0300        lsls	r0, r0, #12
@   0x08013764: 5330        strh	r0, [r6, r4]
@   0x08013766: 0300        lsls	r0, r0, #12
@   0x08013768: 6500        str	r0, [r0, #80]	@ 0x50
@   0x0801376a: 0300        lsls	r0, r0, #12
@   0x0801376c: 60a0        str	r0, [r4, #8]
@   0x0801376e: 0300        lsls	r0, r0, #12
@   0x08013770: 6540        str	r0, [r0, #84]	@ 0x54
@   0x08013772: 0300        lsls	r0, r0, #12
@   0x08013774: 6f6c        ldr	r4, [r5, #116]	@ 0x74
@   0x08013776: 0830        lsrs	r0, r6, #32
@   0x08013778: 64c0        str	r0, [r0, #76]	@ 0x4c
@   0x0801377a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08013694
sub_08013694: @ 0x08013694
        .incbin "frog_us_baserom.gba", 0x13694, 0xe8
        thumb_func_end sub_08013694
