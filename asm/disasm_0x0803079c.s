@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803080c, 0x080308b0)  (164 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803080c --end 0x80308b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
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

        thumb_func_start sub_0803080C
sub_0803080C: @ 0x0803080c
        .incbin "frog_us_baserom.gba", 0x3080c, 0xa4
        thumb_func_end sub_0803080C
