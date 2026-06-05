@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08030644, 0x0803079c)  (344 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8030644 --end 0x803079c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08030644: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08030646: 1c02        adds	r2, r0, #0
@   0x08030648: 1c0c        adds	r4, r1, #0
@   0x0803064a: 6825        ldr	r5, [r4, #0]
@   0x0803064c: 8920        ldrh	r0, [r4, #8]
@   0x0803064e: 2800        cmp	r0, #0
@   0x08030650: d153        bne.n	0x306fa
@   0x08030652: 8868        ldrh	r0, [r5, #2]
@   0x08030654: 1c07        adds	r7, r0, #0
@   0x08030656: 2f00        cmp	r7, #0
@   0x08030658: d03c        beq.n	0x306d4
@   0x0803065a: 7869        ldrb	r1, [r5, #1]
@   0x0803065c: 2001        movs	r0, #1
@   0x0803065e: 4008        ands	r0, r1
@   0x08030660: 1c0e        adds	r6, r1, #0
@   0x08030662: 2800        cmp	r0, #0
@   0x08030664: d018        beq.n	0x30698
@   0x08030666: 2a03        cmp	r2, #3
@   0x08030668: dc08        bgt.n	0x3067c
@   0x0803066a: 4803        ldr	r0, [pc, #12]	@ (0x30678)
@   0x0803066c: 6800        ldr	r0, [r0, #0]
@   0x0803066e: 0091        lsls	r1, r2, #2
@   0x08030670: 3010        adds	r0, #16
@   0x08030672: 1840        adds	r0, r0, r1
@   0x08030674: 6800        ldr	r0, [r0, #0]
@   0x08030676: e00a        b.n	0x3068e
@   0x08030678: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803067a: 0300        lsls	r0, r0, #12
@   0x0803067c: 4817        ldr	r0, [pc, #92]	@ (0x306dc)
@   0x0803067e: 6800        ldr	r0, [r0, #0]
@   0x08030680: 30c8        adds	r0, #200	@ 0xc8
@   0x08030682: 6801        ldr	r1, [r0, #0]
@   0x08030684: 0190        lsls	r0, r2, #6
@   0x08030686: 1840        adds	r0, r0, r1
@   0x08030688: 4915        ldr	r1, [pc, #84]	@ (0x306e0)
@   0x0803068a: 1840        adds	r0, r0, r1
@   0x0803068c: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x0803068e: 2180        movs	r1, #128	@ 0x80
@   0x08030690: 0049        lsls	r1, r1, #1
@   0x08030692: 4008        ands	r0, r1
@   0x08030694: 2800        cmp	r0, #0
@   0x08030696: d11d        bne.n	0x306d4
@   0x08030698: 2004        movs	r0, #4
@   0x0803069a: 4030        ands	r0, r6
@   0x0803069c: 2800        cmp	r0, #0
@   0x0803069e: d021        beq.n	0x306e4
@   0x080306a0: 2a03        cmp	r2, #3
@   0x080306a2: dd1f        ble.n	0x306e4
@   0x080306a4: 480d        ldr	r0, [pc, #52]	@ (0x306dc)
@   0x080306a6: 6803        ldr	r3, [r0, #0]
@   0x080306a8: 1c18        adds	r0, r3, #0
@   0x080306aa: 30c8        adds	r0, #200	@ 0xc8
@   0x080306ac: 6801        ldr	r1, [r0, #0]
@   0x080306ae: 0190        lsls	r0, r2, #6
@   0x080306b0: 1840        adds	r0, r0, r1
@   0x080306b2: 490b        ldr	r1, [pc, #44]	@ (0x306e0)
@   0x080306b4: 1840        adds	r0, r0, r1
@   0x080306b6: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x080306b8: 2180        movs	r1, #128	@ 0x80
@   0x080306ba: 0089        lsls	r1, r1, #2
@   0x080306bc: 4008        ands	r0, r1
@   0x080306be: 2800        cmp	r0, #0
@   0x080306c0: d110        bne.n	0x306e4
@   0x080306c2: 1c18        adds	r0, r3, #0
@   0x080306c4: 30c4        adds	r0, #196	@ 0xc4
@   0x080306c6: 6801        ldr	r1, [r0, #0]
@   0x080306c8: 0090        lsls	r0, r2, #2
@   0x080306ca: 1840        adds	r0, r0, r1
@   0x080306cc: 3810        subs	r0, #16
@   0x080306ce: 6800        ldr	r0, [r0, #0]
@   0x080306d0: 2800        cmp	r0, #0
@   0x080306d2: d107        bne.n	0x306e4
@   0x080306d4: 6820        ldr	r0, [r4, #0]
@   0x080306d6: 3006        adds	r0, #6
@   0x080306d8: e05a        b.n	0x30790
@   0x080306da: 0000        movs	r0, r0
@   0x080306dc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080306de: 0300        lsls	r0, r0, #12
@   0x080306e0: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x080306e4: 2002        movs	r0, #2
@   0x080306e6: 4030        ands	r0, r6
@   0x080306e8: 2800        cmp	r0, #0
@   0x080306ea: d004        beq.n	0x306f6
@   0x080306ec: 8868        ldrh	r0, [r5, #2]
@   0x080306ee: f7fd        fe6b 	bl	0x2e3c8
@   0x080306f2: 8120        strh	r0, [r4, #8]
@   0x080306f4: e048        b.n	0x30788
@   0x080306f6: 8127        strh	r7, [r4, #8]
@   0x080306f8: e046        b.n	0x30788
@   0x080306fa: 4905        ldr	r1, [pc, #20]	@ (0x30710)
@   0x080306fc: 886b        ldrh	r3, [r5, #2]
@   0x080306fe: 428b        cmp	r3, r1
@   0x08030700: d008        beq.n	0x30714
@   0x08030702: 3801        subs	r0, #1
@   0x08030704: 8120        strh	r0, [r4, #8]
@   0x08030706: 4008        ands	r0, r1
@   0x08030708: 2800        cmp	r0, #0
@   0x0803070a: d103        bne.n	0x30714
@   0x0803070c: 1da8        adds	r0, r5, #6
@   0x0803070e: e03f        b.n	0x30790
@   0x08030710: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x08030714: 7869        ldrb	r1, [r5, #1]
@   0x08030716: 2001        movs	r0, #1
@   0x08030718: 4008        ands	r0, r1
@   0x0803071a: 1c0e        adds	r6, r1, #0
@   0x0803071c: 2800        cmp	r0, #0
@   0x0803071e: d019        beq.n	0x30754
@   0x08030720: 2a03        cmp	r2, #3
@   0x08030722: dc09        bgt.n	0x30738
@   0x08030724: 4803        ldr	r0, [pc, #12]	@ (0x30734)
@   0x08030726: 6800        ldr	r0, [r0, #0]
@   0x08030728: 0091        lsls	r1, r2, #2
@   0x0803072a: 3010        adds	r0, #16
@   0x0803072c: 1840        adds	r0, r0, r1
@   0x0803072e: 6800        ldr	r0, [r0, #0]
@   0x08030730: e00b        b.n	0x3074a
@   0x08030732: 0000        movs	r0, r0
@   0x08030734: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030736: 0300        lsls	r0, r0, #12
@   0x08030738: 4811        ldr	r0, [pc, #68]	@ (0x30780)
@   0x0803073a: 6800        ldr	r0, [r0, #0]
@   0x0803073c: 30c8        adds	r0, #200	@ 0xc8
@   0x0803073e: 6801        ldr	r1, [r0, #0]
@   0x08030740: 0190        lsls	r0, r2, #6
@   0x08030742: 1840        adds	r0, r0, r1
@   0x08030744: 490f        ldr	r1, [pc, #60]	@ (0x30784)
@   0x08030746: 1840        adds	r0, r0, r1
@   0x08030748: 6b80        ldr	r0, [r0, #56]	@ 0x38
@   0x0803074a: 2180        movs	r1, #128	@ 0x80
@   0x0803074c: 0049        lsls	r1, r1, #1
@   0x0803074e: 4008        ands	r0, r1
@   0x08030750: 2800        cmp	r0, #0
@   0x08030752: d10f        bne.n	0x30774
@   0x08030754: 2004        movs	r0, #4
@   0x08030756: 4030        ands	r0, r6
@   0x08030758: 2800        cmp	r0, #0
@   0x0803075a: d015        beq.n	0x30788
@   0x0803075c: 2a03        cmp	r2, #3
@   0x0803075e: dd13        ble.n	0x30788
@   0x08030760: 4807        ldr	r0, [pc, #28]	@ (0x30780)
@   0x08030762: 6800        ldr	r0, [r0, #0]
@   0x08030764: 30c4        adds	r0, #196	@ 0xc4
@   0x08030766: 6801        ldr	r1, [r0, #0]
@   0x08030768: 0090        lsls	r0, r2, #2
@   0x0803076a: 1840        adds	r0, r0, r1
@   0x0803076c: 3810        subs	r0, #16
@   0x0803076e: 6800        ldr	r0, [r0, #0]
@   0x08030770: 2800        cmp	r0, #0
@   0x08030772: d109        bne.n	0x30788
@   0x08030774: 2000        movs	r0, #0
@   0x08030776: 8120        strh	r0, [r4, #8]
@   0x08030778: 6820        ldr	r0, [r4, #0]
@   0x0803077a: 3006        adds	r0, #6
@   0x0803077c: e008        b.n	0x30790
@   0x0803077e: 0000        movs	r0, r0
@   0x08030780: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030782: 0300        lsls	r0, r0, #12
@   0x08030784: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08030788: 2304        movs	r3, #4
@   0x0803078a: 5ee9        ldrsh	r1, [r5, r3]
@   0x0803078c: 6820        ldr	r0, [r4, #0]
@   0x0803078e: 1840        adds	r0, r0, r1
@   0x08030790: 6020        str	r0, [r4, #0]
@   0x08030792: 2001        movs	r0, #1
@   0x08030794: bcf0        pop	{r4, r5, r6, r7}
@   0x08030796: bc02        pop	{r1}
@   0x08030798: 4708        bx	r1

        thumb_func_start sub_08030644
sub_08030644: @ 0x08030644
        .incbin "frog_us_baserom.gba", 0x30644, 0x158
        thumb_func_end sub_08030644
