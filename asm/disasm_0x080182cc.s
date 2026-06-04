@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080182cc, 0x080184dc)  (528 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80182cc --end 0x80184dc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080182cc: b510        push	{r4, lr}
@   0x080182ce: 480e        ldr	r0, [pc, #56]	@ (0x18308)
@   0x080182d0: 8801        ldrh	r1, [r0, #0]
@   0x080182d2: 43c9        mvns	r1, r1
@   0x080182d4: 0409        lsls	r1, r1, #16
@   0x080182d6: 0c09        lsrs	r1, r1, #16
@   0x080182d8: 4c0c        ldr	r4, [pc, #48]	@ (0x1830c)
@   0x080182da: 4a0d        ldr	r2, [pc, #52]	@ (0x18310)
@   0x080182dc: 1c08        adds	r0, r1, #0
@   0x080182de: 8813        ldrh	r3, [r2, #0]
@   0x080182e0: 4398        bics	r0, r3
@   0x080182e2: 8020        strh	r0, [r4, #0]
@   0x080182e4: 8011        strh	r1, [r2, #0]
@   0x080182e6: f7f8        fa13 	bl	0x10710
@   0x080182ea: 2800        cmp	r0, #0
@   0x080182ec: d125        bne.n	0x1833a
@   0x080182ee: 2001        movs	r0, #1
@   0x080182f0: 8824        ldrh	r4, [r4, #0]
@   0x080182f2: 4020        ands	r0, r4
@   0x080182f4: 2800        cmp	r0, #0
@   0x080182f6: d00f        beq.n	0x18318
@   0x080182f8: 4906        ldr	r1, [pc, #24]	@ (0x18314)
@   0x080182fa: 78c8        ldrb	r0, [r1, #3]
@   0x080182fc: 3001        adds	r0, #1
@   0x080182fe: 70c8        strb	r0, [r1, #3]
@   0x08018300: 20bf        movs	r0, #191	@ 0xbf
@   0x08018302: f7f8        f9c7 	bl	0x10694
@   0x08018306: e018        b.n	0x1833a
@   0x08018308: 0130        lsls	r0, r6, #4
@   0x0801830a: 0400        lsls	r0, r0, #16
@   0x0801830c: 5358        strh	r0, [r3, r5]
@   0x0801830e: 0300        lsls	r0, r0, #12
@   0x08018310: 3710        adds	r7, #16
@   0x08018312: 0300        lsls	r0, r0, #12
@   0x08018314: 3480        adds	r4, #128	@ 0x80
@   0x08018316: 0300        lsls	r0, r0, #12
@   0x08018318: f7e8        faf2 	bl	0x900
@   0x0801831c: 4c08        ldr	r4, [pc, #32]	@ (0x18340)
@   0x0801831e: 68e1        ldr	r1, [r4, #12]
@   0x08018320: 1a40        subs	r0, r0, r1
@   0x08018322: 4908        ldr	r1, [pc, #32]	@ (0x18344)
@   0x08018324: 4288        cmp	r0, r1
@   0x08018326: d908        bls.n	0x1833a
@   0x08018328: f7e8        faea 	bl	0x900
@   0x0801832c: 60e0        str	r0, [r4, #12]
@   0x0801832e: 78e0        ldrb	r0, [r4, #3]
@   0x08018330: 3001        adds	r0, #1
@   0x08018332: 70e0        strb	r0, [r4, #3]
@   0x08018334: 20bf        movs	r0, #191	@ 0xbf
@   0x08018336: f7f8        f9ad 	bl	0x10694
@   0x0801833a: bc10        pop	{r4}
@   0x0801833c: bc01        pop	{r0}
@   0x0801833e: 4700        bx	r0
@   0x08018340: 3480        adds	r4, #128	@ 0x80
@   0x08018342: 0300        lsls	r0, r0, #12
@   0x08018344: 0383        lsls	r3, r0, #14
@   0x08018346: 0000        movs	r0, r0
@   0x08018348: b530        push	{r4, r5, lr}
@   0x0801834a: f7e8        fad9 	bl	0x900
@   0x0801834e: 4d19        ldr	r5, [pc, #100]	@ (0x183b4)
@   0x08018350: 60e8        str	r0, [r5, #12]
@   0x08018352: 20bf        movs	r0, #191	@ 0xbf
@   0x08018354: f7f8        f9ca 	bl	0x106ec
@   0x08018358: 4b17        ldr	r3, [pc, #92]	@ (0x183b8)
@   0x0801835a: 2100        movs	r1, #0
@   0x0801835c: 7019        strb	r1, [r3, #0]
@   0x0801835e: 7059        strb	r1, [r3, #1]
@   0x08018360: 20a0        movs	r0, #160	@ 0xa0
@   0x08018362: 70d8        strb	r0, [r3, #3]
@   0x08018364: 20f0        movs	r0, #240	@ 0xf0
@   0x08018366: 7098        strb	r0, [r3, #2]
@   0x08018368: 4814        ldr	r0, [pc, #80]	@ (0x183bc)
@   0x0801836a: 8001        strh	r1, [r0, #0]
@   0x0801836c: 2480        movs	r4, #128	@ 0x80
@   0x0801836e: 04e4        lsls	r4, r4, #19
@   0x08018370: 4913        ldr	r1, [pc, #76]	@ (0x183c0)
@   0x08018372: 1c08        adds	r0, r1, #0
@   0x08018374: 8020        strh	r0, [r4, #0]
@   0x08018376: 4913        ldr	r1, [pc, #76]	@ (0x183c4)
@   0x08018378: 4a13        ldr	r2, [pc, #76]	@ (0x183c8)
@   0x0801837a: 1c10        adds	r0, r2, #0
@   0x0801837c: 30d0        adds	r0, #208	@ 0xd0
@   0x0801837e: 6800        ldr	r0, [r0, #0]
@   0x08018380: 6008        str	r0, [r1, #0]
@   0x08018382: 20a0        movs	r0, #160	@ 0xa0
@   0x08018384: 04c0        lsls	r0, r0, #19
@   0x08018386: 6048        str	r0, [r1, #4]
@   0x08018388: 4810        ldr	r0, [pc, #64]	@ (0x183cc)
@   0x0801838a: 6088        str	r0, [r1, #8]
@   0x0801838c: 6888        ldr	r0, [r1, #8]
@   0x0801838e: 32cc        adds	r2, #204	@ 0xcc
@   0x08018390: 6812        ldr	r2, [r2, #0]
@   0x08018392: 2000        movs	r0, #0
@   0x08018394: 2100        movs	r1, #0
@   0x08018396: f7fd        ff41 	bl	0x1621c
@   0x0801839a: 8820        ldrh	r0, [r4, #0]
@   0x0801839c: 2110        movs	r1, #16
@   0x0801839e: 4048        eors	r0, r1
@   0x080183a0: 8020        strh	r0, [r4, #0]
@   0x080183a2: f015        faa9 	bl	0x2d8f8
@   0x080183a6: 7928        ldrb	r0, [r5, #4]
@   0x080183a8: 3001        adds	r0, #1
@   0x080183aa: 7128        strb	r0, [r5, #4]
@   0x080183ac: bc30        pop	{r4, r5}
@   0x080183ae: bc01        pop	{r0}
@   0x080183b0: 4700        bx	r0
@   0x080183b2: 0000        movs	r0, r0
@   0x080183b4: 3480        adds	r4, #128	@ 0x80
@   0x080183b6: 0300        lsls	r0, r0, #12
@   0x080183b8: 3470        adds	r4, #112	@ 0x70
@   0x080183ba: 0300        lsls	r0, r0, #12
@   0x080183bc: 000c        movs	r4, r1
@   0x080183be: 0400        lsls	r0, r0, #16
@   0x080183c0: 0404        lsls	r4, r0, #16
@   0x080183c2: 0000        movs	r0, r0
@   0x080183c4: 00d4        lsls	r4, r2, #3
@   0x080183c6: 0400        lsls	r0, r0, #16
@   0x080183c8: 3550        adds	r5, #80	@ 0x50
@   0x080183ca: 080e        lsrs	r6, r1, #32
@   0x080183cc: 0100        lsls	r0, r0, #4
@   0x080183ce: 8000        strh	r0, [r0, #0]
@   0x080183d0: b510        push	{r4, lr}
@   0x080183d2: 480e        ldr	r0, [pc, #56]	@ (0x1840c)
@   0x080183d4: 8801        ldrh	r1, [r0, #0]
@   0x080183d6: 43c9        mvns	r1, r1
@   0x080183d8: 0409        lsls	r1, r1, #16
@   0x080183da: 0c09        lsrs	r1, r1, #16
@   0x080183dc: 4c0c        ldr	r4, [pc, #48]	@ (0x18410)
@   0x080183de: 4a0d        ldr	r2, [pc, #52]	@ (0x18414)
@   0x080183e0: 1c08        adds	r0, r1, #0
@   0x080183e2: 8813        ldrh	r3, [r2, #0]
@   0x080183e4: 4398        bics	r0, r3
@   0x080183e6: 8020        strh	r0, [r4, #0]
@   0x080183e8: 8011        strh	r1, [r2, #0]
@   0x080183ea: f7f8        f991 	bl	0x10710
@   0x080183ee: 2800        cmp	r0, #0
@   0x080183f0: d125        bne.n	0x1843e
@   0x080183f2: 2001        movs	r0, #1
@   0x080183f4: 8824        ldrh	r4, [r4, #0]
@   0x080183f6: 4020        ands	r0, r4
@   0x080183f8: 2800        cmp	r0, #0
@   0x080183fa: d00f        beq.n	0x1841c
@   0x080183fc: 4906        ldr	r1, [pc, #24]	@ (0x18418)
@   0x080183fe: 7908        ldrb	r0, [r1, #4]
@   0x08018400: 3001        adds	r0, #1
@   0x08018402: 7108        strb	r0, [r1, #4]
@   0x08018404: 20bf        movs	r0, #191	@ 0xbf
@   0x08018406: f7f8        f945 	bl	0x10694
@   0x0801840a: e018        b.n	0x1843e
@   0x0801840c: 0130        lsls	r0, r6, #4
@   0x0801840e: 0400        lsls	r0, r0, #16
@   0x08018410: 5358        strh	r0, [r3, r5]
@   0x08018412: 0300        lsls	r0, r0, #12
@   0x08018414: 3710        adds	r7, #16
@   0x08018416: 0300        lsls	r0, r0, #12
@   0x08018418: 3480        adds	r4, #128	@ 0x80
@   0x0801841a: 0300        lsls	r0, r0, #12
@   0x0801841c: f7e8        fa70 	bl	0x900
@   0x08018420: 4c08        ldr	r4, [pc, #32]	@ (0x18444)
@   0x08018422: 68e1        ldr	r1, [r4, #12]
@   0x08018424: 1a40        subs	r0, r0, r1
@   0x08018426: 4908        ldr	r1, [pc, #32]	@ (0x18448)
@   0x08018428: 4288        cmp	r0, r1
@   0x0801842a: d908        bls.n	0x1843e
@   0x0801842c: f7e8        fa68 	bl	0x900
@   0x08018430: 60e0        str	r0, [r4, #12]
@   0x08018432: 7920        ldrb	r0, [r4, #4]
@   0x08018434: 3001        adds	r0, #1
@   0x08018436: 7120        strb	r0, [r4, #4]
@   0x08018438: 20bf        movs	r0, #191	@ 0xbf
@   0x0801843a: f7f8        f92b 	bl	0x10694
@   0x0801843e: bc10        pop	{r4}
@   0x08018440: bc01        pop	{r0}
@   0x08018442: 4700        bx	r0
@   0x08018444: 3480        adds	r4, #128	@ 0x80
@   0x08018446: 0300        lsls	r0, r0, #12
@   0x08018448: 0257        lsls	r7, r2, #9
@   0x0801844a: 0000        movs	r0, r0
@   0x0801844c: b081        sub	sp, #4
@   0x0801844e: 4669        mov	r1, sp
@   0x08018450: 2000        movs	r0, #0
@   0x08018452: 8008        strh	r0, [r1, #0]
@   0x08018454: 491b        ldr	r1, [pc, #108]	@ (0x184c4)
@   0x08018456: 4668        mov	r0, sp
@   0x08018458: 6008        str	r0, [r1, #0]
@   0x0801845a: 481b        ldr	r0, [pc, #108]	@ (0x184c8)
@   0x0801845c: 6048        str	r0, [r1, #4]
@   0x0801845e: 481b        ldr	r0, [pc, #108]	@ (0x184cc)
@   0x08018460: 6088        str	r0, [r1, #8]
@   0x08018462: 6888        ldr	r0, [r1, #8]
@   0x08018464: 39d4        subs	r1, #212	@ 0xd4
@   0x08018466: 22a0        movs	r2, #160	@ 0xa0
@   0x08018468: 00d2        lsls	r2, r2, #3
@   0x0801846a: 1c10        adds	r0, r2, #0
@   0x0801846c: 8008        strh	r0, [r1, #0]
@   0x0801846e: 3108        adds	r1, #8
@   0x08018470: 4a17        ldr	r2, [pc, #92]	@ (0x184d0)
@   0x08018472: 1c10        adds	r0, r2, #0
@   0x08018474: 8008        strh	r0, [r1, #0]
@   0x08018476: 3102        adds	r1, #2
@   0x08018478: 32ff        adds	r2, #255	@ 0xff
@   0x0801847a: 1c10        adds	r0, r2, #0
@   0x0801847c: 8008        strh	r0, [r1, #0]
@   0x0801847e: 3102        adds	r1, #2
@   0x08018480: 32ff        adds	r2, #255	@ 0xff
@   0x08018482: 1c10        adds	r0, r2, #0
@   0x08018484: 8008        strh	r0, [r1, #0]
@   0x08018486: 3102        adds	r1, #2
@   0x08018488: 32ff        adds	r2, #255	@ 0xff
@   0x0801848a: 1c10        adds	r0, r2, #0
@   0x0801848c: 8008        strh	r0, [r1, #0]
@   0x0801848e: 4911        ldr	r1, [pc, #68]	@ (0x184d4)
@   0x08018490: 2000        movs	r0, #0
@   0x08018492: 8008        strh	r0, [r1, #0]
@   0x08018494: 8048        strh	r0, [r1, #2]
@   0x08018496: 8088        strh	r0, [r1, #4]
@   0x08018498: 80c8        strh	r0, [r1, #6]
@   0x0801849a: 8108        strh	r0, [r1, #8]
@   0x0801849c: 8148        strh	r0, [r1, #10]
@   0x0801849e: 490e        ldr	r1, [pc, #56]	@ (0x184d8)
@   0x080184a0: 8008        strh	r0, [r1, #0]
@   0x080184a2: 3102        adds	r1, #2
@   0x080184a4: 8008        strh	r0, [r1, #0]
@   0x080184a6: 3102        adds	r1, #2
@   0x080184a8: 8008        strh	r0, [r1, #0]
@   0x080184aa: 3102        adds	r1, #2
@   0x080184ac: 8008        strh	r0, [r1, #0]
@   0x080184ae: 3102        adds	r1, #2
@   0x080184b0: 8008        strh	r0, [r1, #0]
@   0x080184b2: 3102        adds	r1, #2
@   0x080184b4: 8008        strh	r0, [r1, #0]
@   0x080184b6: 3102        adds	r1, #2
@   0x080184b8: 8008        strh	r0, [r1, #0]
@   0x080184ba: 3102        adds	r1, #2
@   0x080184bc: 8008        strh	r0, [r1, #0]
@   0x080184be: b001        add	sp, #4
@   0x080184c0: 4770        bx	lr
@   0x080184c2: 0000        movs	r0, r0
@   0x080184c4: 00d4        lsls	r4, r2, #3
@   0x080184c6: 0400        lsls	r0, r0, #16
@   0x080184c8: e000        b.n	0x184cc
@   0x080184ca: 0600        lsls	r0, r0, #24
@   0x080184cc: 1000        asrs	r0, r0, #32
@   0x080184ce: 8100        strh	r0, [r0, #8]
@   0x080184d0: 1c03        adds	r3, r0, #0
@   0x080184d2: 0000        movs	r0, r0
@   0x080184d4: 3550        adds	r5, #80	@ 0x50
@   0x080184d6: 0300        lsls	r0, r0, #12
@   0x080184d8: 0010        movs	r0, r2
@   0x080184da: 0400        lsls	r0, r0, #16

        thumb_func_start sub_080182CC
sub_080182CC: @ 0x080182cc
        .incbin "frog_us_baserom.gba", 0x182cc, 0x180
        thumb_func_end sub_080182CC

        thumb_func_start sub_0801844C
sub_0801844C: @ 0x0801844c
        .incbin "frog_us_baserom.gba", 0x1844c, 0x90
        thumb_func_end sub_0801844C
