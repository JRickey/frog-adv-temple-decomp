@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803079c, 0x080308b0)  (276 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803079c --end 0x80308b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803079c: b570        push	{r4, r5, r6, lr}
@   0x0803079e: 1c03        adds	r3, r0, #0
@   0x080307a0: 1c0c        adds	r4, r1, #0
@   0x080307a2: 6825        ldr	r5, [r4, #0]
@   0x080307a4: 2b02        cmp	r3, #2
@   0x080307a6: dc13        bgt.n	0x307d0
@   0x080307a8: 4808        ldr	r0, [pc, #32]	@ (0x307cc)
@   0x080307aa: 6802        ldr	r2, [r0, #0]
@   0x080307ac: 00d8        lsls	r0, r3, #3
@   0x080307ae: 18c0        adds	r0, r0, r3
@   0x080307b0: 0080        lsls	r0, r0, #2
@   0x080307b2: 1810        adds	r0, r2, r0
@   0x080307b4: 886d        ldrh	r5, [r5, #2]
@   0x080307b6: 8c06        ldrh	r6, [r0, #32]
@   0x080307b8: 1ba9        subs	r1, r5, r6
@   0x080307ba: 8441        strh	r1, [r0, #34]	@ 0x22
@   0x080307bc: 0098        lsls	r0, r3, #2
@   0x080307be: 3210        adds	r2, #16
@   0x080307c0: 1812        adds	r2, r2, r0
@   0x080307c2: 6810        ldr	r0, [r2, #0]
@   0x080307c4: 2140        movs	r1, #64	@ 0x40
@   0x080307c6: 4308        orrs	r0, r1
@   0x080307c8: 6010        str	r0, [r2, #0]
@   0x080307ca: e013        b.n	0x307f4
@   0x080307cc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080307ce: 0300        lsls	r0, r0, #12
@   0x080307d0: 2b03        cmp	r3, #3
@   0x080307d2: dd0f        ble.n	0x307f4
@   0x080307d4: 480b        ldr	r0, [pc, #44]	@ (0x30804)
@   0x080307d6: 6801        ldr	r1, [r0, #0]
@   0x080307d8: 31c8        adds	r1, #200	@ 0xc8
@   0x080307da: 0198        lsls	r0, r3, #6
@   0x080307dc: 4a0a        ldr	r2, [pc, #40]	@ (0x30808)
@   0x080307de: 1880        adds	r0, r0, r2
@   0x080307e0: 6809        ldr	r1, [r1, #0]
@   0x080307e2: 1809        adds	r1, r1, r0
@   0x080307e4: 886d        ldrh	r5, [r5, #2]
@   0x080307e6: 880e        ldrh	r6, [r1, #0]
@   0x080307e8: 1ba8        subs	r0, r5, r6
@   0x080307ea: 8048        strh	r0, [r1, #2]
@   0x080307ec: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x080307ee: 2240        movs	r2, #64	@ 0x40
@   0x080307f0: 4310        orrs	r0, r2
@   0x080307f2: 6388        str	r0, [r1, #56]	@ 0x38
@   0x080307f4: 6820        ldr	r0, [r4, #0]
@   0x080307f6: 3004        adds	r0, #4
@   0x080307f8: 6020        str	r0, [r4, #0]
@   0x080307fa: 2001        movs	r0, #1
@   0x080307fc: bc70        pop	{r4, r5, r6}
@   0x080307fe: bc02        pop	{r1}
@   0x08030800: 4708        bx	r1
@   0x08030802: 0000        movs	r0, r0
@   0x08030804: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030806: 0300        lsls	r0, r0, #12
@   0x08030808: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0803080c: b570        push	{r4, r5, r6, lr}
@   0x0803080e: 1c03        adds	r3, r0, #0
@   0x08030810: 1c0d        adds	r5, r1, #0
@   0x08030812: 682c        ldr	r4, [r5, #0]
@   0x08030814: 2b02        cmp	r3, #2
@   0x08030816: dc25        bgt.n	0x30864
@   0x08030818: 2001        movs	r0, #1
@   0x0803081a: 7861        ldrb	r1, [r4, #1]
@   0x0803081c: 4008        ands	r0, r1
@   0x0803081e: 2800        cmp	r0, #0
@   0x08030820: d00a        beq.n	0x30838
@   0x08030822: 4a04        ldr	r2, [pc, #16]	@ (0x30834)
@   0x08030824: 6811        ldr	r1, [r2, #0]
@   0x08030826: 00d8        lsls	r0, r3, #3
@   0x08030828: 18c0        adds	r0, r0, r3
@   0x0803082a: 0080        lsls	r0, r0, #2
@   0x0803082c: 1809        adds	r1, r1, r0
@   0x0803082e: 8860        ldrh	r0, [r4, #2]
@   0x08030830: e00b        b.n	0x3084a
@   0x08030832: 0000        movs	r0, r0
@   0x08030834: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030836: 0300        lsls	r0, r0, #12
@   0x08030838: 4a09        ldr	r2, [pc, #36]	@ (0x30860)
@   0x0803083a: 6811        ldr	r1, [r2, #0]
@   0x0803083c: 00d8        lsls	r0, r3, #3
@   0x0803083e: 18c0        adds	r0, r0, r3
@   0x08030840: 0080        lsls	r0, r0, #2
@   0x08030842: 1809        adds	r1, r1, r0
@   0x08030844: 8c4e        ldrh	r6, [r1, #34]	@ 0x22
@   0x08030846: 8864        ldrh	r4, [r4, #2]
@   0x08030848: 1930        adds	r0, r6, r4
@   0x0803084a: 8448        strh	r0, [r1, #34]	@ 0x22
@   0x0803084c: 6811        ldr	r1, [r2, #0]
@   0x0803084e: 0098        lsls	r0, r3, #2
@   0x08030850: 3110        adds	r1, #16
@   0x08030852: 1809        adds	r1, r1, r0
@   0x08030854: 6808        ldr	r0, [r1, #0]
@   0x08030856: 2240        movs	r2, #64	@ 0x40
@   0x08030858: 4310        orrs	r0, r2
@   0x0803085a: 6008        str	r0, [r1, #0]
@   0x0803085c: e020        b.n	0x308a0
@   0x0803085e: 0000        movs	r0, r0
@   0x08030860: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08030862: 0300        lsls	r0, r0, #12
@   0x08030864: 2b03        cmp	r3, #3
@   0x08030866: dd1b        ble.n	0x308a0
@   0x08030868: 4807        ldr	r0, [pc, #28]	@ (0x30888)
@   0x0803086a: 6801        ldr	r1, [r0, #0]
@   0x0803086c: 31c8        adds	r1, #200	@ 0xc8
@   0x0803086e: 0198        lsls	r0, r3, #6
@   0x08030870: 4a06        ldr	r2, [pc, #24]	@ (0x3088c)
@   0x08030872: 1880        adds	r0, r0, r2
@   0x08030874: 6809        ldr	r1, [r1, #0]
@   0x08030876: 180a        adds	r2, r1, r0
@   0x08030878: 2001        movs	r0, #1
@   0x0803087a: 7866        ldrb	r6, [r4, #1]
@   0x0803087c: 4030        ands	r0, r6
@   0x0803087e: 2800        cmp	r0, #0
@   0x08030880: d006        beq.n	0x30890
@   0x08030882: 8860        ldrh	r0, [r4, #2]
@   0x08030884: e007        b.n	0x30896
@   0x08030886: 0000        movs	r0, r0
@   0x08030888: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803088a: 0300        lsls	r0, r0, #12
@   0x0803088c: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08030890: 8851        ldrh	r1, [r2, #2]
@   0x08030892: 8864        ldrh	r4, [r4, #2]
@   0x08030894: 1908        adds	r0, r1, r4
@   0x08030896: 8050        strh	r0, [r2, #2]
@   0x08030898: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0803089a: 2140        movs	r1, #64	@ 0x40
@   0x0803089c: 4308        orrs	r0, r1
@   0x0803089e: 6390        str	r0, [r2, #56]	@ 0x38
@   0x080308a0: 6828        ldr	r0, [r5, #0]
@   0x080308a2: 3004        adds	r0, #4
@   0x080308a4: 6028        str	r0, [r5, #0]
@   0x080308a6: 2001        movs	r0, #1
@   0x080308a8: bc70        pop	{r4, r5, r6}
@   0x080308aa: bc02        pop	{r1}
@   0x080308ac: 4708        bx	r1

        thumb_func_start sub_0803079C
sub_0803079C: @ 0x0803079c
        .incbin "frog_us_baserom.gba", 0x3079c, 0x114
        thumb_func_end sub_0803079C
