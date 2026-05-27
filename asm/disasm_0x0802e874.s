@ Auto-emitted (manually split from disasm_0x0802e7c4.s — sub_0802E7C4 is now
@ in C; sub_0802E874 remains in asm because the small-channel path's register
@ allocation diverges from agbcc 2.x's natural choice).
@ Range:  [0x0802e874, 0x0802e934)  (192 bytes, thumb mode)

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
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

        thumb_func_start sub_0802E874
sub_0802E874: @ 0x0802e874
        .incbin "frog_us_baserom.gba", 0x2e874, 0xc0
        thumb_func_end sub_0802E874
