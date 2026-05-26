@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e7c4, 0x0802e934)  (368 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e7c4 --end 0x802e934 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e7c4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802e7c6: 1c0c        adds	r4, r1, #0
@   0x0802e7c8: 0600        lsls	r0, r0, #24
@   0x0802e7ca: 0e05        lsrs	r5, r0, #24
@   0x0802e7cc: 2c03        cmp	r4, #3
@   0x0802e7ce: dc37        bgt.n	0x2e840
@   0x0802e7d0: 2088        movs	r0, #136	@ 0x88
@   0x0802e7d2: 0540        lsls	r0, r0, #21
@   0x0802e7d4: 40a0        lsls	r0, r4
@   0x0802e7d6: 0e03        lsrs	r3, r0, #24
@   0x0802e7d8: 4a0b        ldr	r2, [pc, #44]	@ (0x2e808)
@   0x0802e7da: 6810        ldr	r0, [r2, #0]
@   0x0802e7dc: 30ba        adds	r0, #186	@ 0xba
@   0x0802e7de: 7801        ldrb	r1, [r0, #0]
@   0x0802e7e0: 4399        bics	r1, r3
@   0x0802e7e2: 7001        strb	r1, [r0, #0]
@   0x0802e7e4: 6810        ldr	r0, [r2, #0]
@   0x0802e7e6: 4e09        ldr	r6, [pc, #36]	@ (0x2e80c)
@   0x0802e7e8: 1981        adds	r1, r0, r6
@   0x0802e7ea: 2610        movs	r6, #16
@   0x0802e7ec: 1c30        adds	r0, r6, #0
@   0x0802e7ee: 7809        ldrb	r1, [r1, #0]
@   0x0802e7f0: 4008        ands	r0, r1
@   0x0802e7f2: 1c17        adds	r7, r2, #0
@   0x0802e7f4: 2800        cmp	r0, #0
@   0x0802e7f6: d111        bne.n	0x2e81c
@   0x0802e7f8: 2dff        cmp	r5, #255	@ 0xff
@   0x0802e7fa: d00f        beq.n	0x2e81c
@   0x0802e7fc: 2d29        cmp	r5, #41	@ 0x29
@   0x0802e7fe: d807        bhi.n	0x2e810
@   0x0802e800: 1c30        adds	r0, r6, #0
@   0x0802e802: 40a0        lsls	r0, r4
@   0x0802e804: 0600        lsls	r0, r0, #24
@   0x0802e806: e008        b.n	0x2e81a
@   0x0802e808: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e80a: 0300        lsls	r0, r0, #12
@   0x0802e80c: 010f        lsls	r7, r1, #4
@   0x0802e80e: 0000        movs	r0, r0
@   0x0802e810: 2d55        cmp	r5, #85	@ 0x55
@   0x0802e812: d903        bls.n	0x2e81c
@   0x0802e814: 2080        movs	r0, #128	@ 0x80
@   0x0802e816: 0440        lsls	r0, r0, #17
@   0x0802e818: 40a0        lsls	r0, r4
@   0x0802e81a: 0e03        lsrs	r3, r0, #24
@   0x0802e81c: 6838        ldr	r0, [r7, #0]
@   0x0802e81e: 30ba        adds	r0, #186	@ 0xba
@   0x0802e820: 7801        ldrb	r1, [r0, #0]
@   0x0802e822: 430b        orrs	r3, r1
@   0x0802e824: 7003        strb	r3, [r0, #0]
@   0x0802e826: 4a05        ldr	r2, [pc, #20]	@ (0x2e83c)
@   0x0802e828: 8810        ldrh	r0, [r2, #0]
@   0x0802e82a: 21ff        movs	r1, #255	@ 0xff
@   0x0802e82c: 4001        ands	r1, r0
@   0x0802e82e: 6838        ldr	r0, [r7, #0]
@   0x0802e830: 30ba        adds	r0, #186	@ 0xba
@   0x0802e832: 7800        ldrb	r0, [r0, #0]
@   0x0802e834: 0200        lsls	r0, r0, #8
@   0x0802e836: 4301        orrs	r1, r0
@   0x0802e838: 8011        strh	r1, [r2, #0]
@   0x0802e83a: e013        b.n	0x2e864
@   0x0802e83c: 0080        lsls	r0, r0, #2
@   0x0802e83e: 0400        lsls	r0, r0, #16
@   0x0802e840: 480a        ldr	r0, [pc, #40]	@ (0x2e86c)
@   0x0802e842: 6801        ldr	r1, [r0, #0]
@   0x0802e844: 31c8        adds	r1, #200	@ 0xc8
@   0x0802e846: 01a0        lsls	r0, r4, #6
@   0x0802e848: 4a09        ldr	r2, [pc, #36]	@ (0x2e870)
@   0x0802e84a: 1880        adds	r0, r0, r2
@   0x0802e84c: 6809        ldr	r1, [r1, #0]
@   0x0802e84e: 180a        adds	r2, r1, r0
@   0x0802e850: 1c10        adds	r0, r2, #0
@   0x0802e852: 303c        adds	r0, #60	@ 0x3c
@   0x0802e854: 7801        ldrb	r1, [r0, #0]
@   0x0802e856: 7005        strb	r5, [r0, #0]
@   0x0802e858: 428d        cmp	r5, r1
@   0x0802e85a: d003        beq.n	0x2e864
@   0x0802e85c: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802e85e: 2180        movs	r1, #128	@ 0x80
@   0x0802e860: 4308        orrs	r0, r1
@   0x0802e862: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802e864: bcf0        pop	{r4, r5, r6, r7}
@   0x0802e866: bc01        pop	{r0}
@   0x0802e868: 4700        bx	r0
@   0x0802e86a: 0000        movs	r0, r0
@   0x0802e86c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e86e: 0300        lsls	r0, r0, #12
@   0x0802e870: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0802e874: b530        push	{r4, r5, lr}
@   0x0802e876: 1c0b        adds	r3, r1, #0
@   0x0802e878: 0600        lsls	r0, r0, #24
@   0x0802e87a: 0e05        lsrs	r5, r0, #24
@   0x0802e87c: 1604        asrs	r4, r0, #24
@   0x0802e87e: 2c00        cmp	r4, #0
@   0x0802e880: d054        beq.n	0x2e92c
@   0x0802e882: 2b03        cmp	r3, #3
@   0x0802e884: dc31        bgt.n	0x2e8ea
@   0x0802e886: 2088        movs	r0, #136	@ 0x88
@   0x0802e888: 0540        lsls	r0, r0, #21
@   0x0802e88a: 4098        lsls	r0, r3
@   0x0802e88c: 0e04        lsrs	r4, r0, #24
@   0x0802e88e: 480f        ldr	r0, [pc, #60]	@ (0x2e8cc)
@   0x0802e890: 6801        ldr	r1, [r0, #0]
@   0x0802e892: 480f        ldr	r0, [pc, #60]	@ (0x2e8d0)
@   0x0802e894: 180a        adds	r2, r1, r0
@   0x0802e896: 2010        movs	r0, #16
@   0x0802e898: 7812        ldrb	r2, [r2, #0]
@   0x0802e89a: 4010        ands	r0, r2
@   0x0802e89c: 2800        cmp	r0, #0
@   0x0802e89e: d11d        bne.n	0x2e8dc
@   0x0802e8a0: 31ba        adds	r1, #186	@ 0xba
@   0x0802e8a2: 1c20        adds	r0, r4, #0
@   0x0802e8a4: 7809        ldrb	r1, [r1, #0]
@   0x0802e8a6: 4008        ands	r0, r1
@   0x0802e8a8: 4118        asrs	r0, r3
@   0x0802e8aa: 0600        lsls	r0, r0, #24
@   0x0802e8ac: 0e00        lsrs	r0, r0, #24
@   0x0802e8ae: 212a        movs	r1, #42	@ 0x2a
@   0x0802e8b0: 2810        cmp	r0, #16
@   0x0802e8b2: d003        beq.n	0x2e8bc
@   0x0802e8b4: 2140        movs	r1, #64	@ 0x40
@   0x0802e8b6: 2801        cmp	r0, #1
@   0x0802e8b8: d100        bne.n	0x2e8bc
@   0x0802e8ba: 2155        movs	r1, #85	@ 0x55
@   0x0802e8bc: 0628        lsls	r0, r5, #24
@   0x0802e8be: 1600        asrs	r0, r0, #24
@   0x0802e8c0: 1809        adds	r1, r1, r0
@   0x0802e8c2: 2900        cmp	r1, #0
@   0x0802e8c4: da06        bge.n	0x2e8d4
@   0x0802e8c6: 2100        movs	r1, #0
@   0x0802e8c8: e009        b.n	0x2e8de
@   0x0802e8ca: 0000        movs	r0, r0
@   0x0802e8cc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e8ce: 0300        lsls	r0, r0, #12
@   0x0802e8d0: 010f        lsls	r7, r1, #4
@   0x0802e8d2: 0000        movs	r0, r0
@   0x0802e8d4: 297f        cmp	r1, #127	@ 0x7f
@   0x0802e8d6: dd02        ble.n	0x2e8de
@   0x0802e8d8: 217f        movs	r1, #127	@ 0x7f
@   0x0802e8da: e000        b.n	0x2e8de
@   0x0802e8dc: 2140        movs	r1, #64	@ 0x40
@   0x0802e8de: 0608        lsls	r0, r1, #24
@   0x0802e8e0: 0e00        lsrs	r0, r0, #24
@   0x0802e8e2: 1c19        adds	r1, r3, #0
@   0x0802e8e4: f7ff        ff6e 	bl	0x2e7c4
@   0x0802e8e8: e020        b.n	0x2e92c
@   0x0802e8ea: 4809        ldr	r0, [pc, #36]	@ (0x2e910)
@   0x0802e8ec: 6801        ldr	r1, [r0, #0]
@   0x0802e8ee: 31c8        adds	r1, #200	@ 0xc8
@   0x0802e8f0: 0198        lsls	r0, r3, #6
@   0x0802e8f2: 4a08        ldr	r2, [pc, #32]	@ (0x2e914)
@   0x0802e8f4: 1880        adds	r0, r0, r2
@   0x0802e8f6: 6809        ldr	r1, [r1, #0]
@   0x0802e8f8: 180a        adds	r2, r1, r0
@   0x0802e8fa: 1c11        adds	r1, r2, #0
@   0x0802e8fc: 313c        adds	r1, #60	@ 0x3c
@   0x0802e8fe: 7808        ldrb	r0, [r1, #0]
@   0x0802e900: 28ff        cmp	r0, #255	@ 0xff
@   0x0802e902: d013        beq.n	0x2e92c
@   0x0802e904: 7809        ldrb	r1, [r1, #0]
@   0x0802e906: 1909        adds	r1, r1, r4
@   0x0802e908: 2900        cmp	r1, #0
@   0x0802e90a: da05        bge.n	0x2e918
@   0x0802e90c: 2100        movs	r1, #0
@   0x0802e90e: e006        b.n	0x2e91e
@   0x0802e910: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e912: 0300        lsls	r0, r0, #12
@   0x0802e914: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0802e918: 297f        cmp	r1, #127	@ 0x7f
@   0x0802e91a: dd00        ble.n	0x2e91e
@   0x0802e91c: 217f        movs	r1, #127	@ 0x7f
@   0x0802e91e: 1c10        adds	r0, r2, #0
@   0x0802e920: 303c        adds	r0, #60	@ 0x3c
@   0x0802e922: 7001        strb	r1, [r0, #0]
@   0x0802e924: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802e926: 2180        movs	r1, #128	@ 0x80
@   0x0802e928: 4308        orrs	r0, r1
@   0x0802e92a: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802e92c: bc30        pop	{r4, r5}
@   0x0802e92e: bc01        pop	{r0}
@   0x0802e930: 4700        bx	r0

        thumb_func_start sub_0802E7C4
sub_0802E7C4: @ 0x0802e7c4
        .incbin "frog_us_baserom.gba", 0x2e7c4, 0x170
        thumb_func_end sub_0802E7C4
