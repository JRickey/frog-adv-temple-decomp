@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e43c, 0x0802e4e8)  (172 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e43c --end 0x802e4e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e43c: b510        push	{r4, lr}
@   0x0802e43e: 2800        cmp	r0, #0
@   0x0802e440: d010        beq.n	0x2e464
@   0x0802e442: 0c03        lsrs	r3, r0, #16
@   0x0802e444: 20ff        movs	r0, #255	@ 0xff
@   0x0802e446: 4003        ands	r3, r0
@   0x0802e448: 4808        ldr	r0, [pc, #32]	@ (0x2e46c)
@   0x0802e44a: 6802        ldr	r2, [r0, #0]
@   0x0802e44c: 1c10        adds	r0, r2, #0
@   0x0802e44e: 30c4        adds	r0, #196	@ 0xc4
@   0x0802e450: 6800        ldr	r0, [r0, #0]
@   0x0802e452: 009c        lsls	r4, r3, #2
@   0x0802e454: 1824        adds	r4, r4, r0
@   0x0802e456: 32c0        adds	r2, #192	@ 0xc0
@   0x0802e458: 00d9        lsls	r1, r3, #3
@   0x0802e45a: 1ac9        subs	r1, r1, r3
@   0x0802e45c: 0089        lsls	r1, r1, #2
@   0x0802e45e: 6810        ldr	r0, [r2, #0]
@   0x0802e460: 1840        adds	r0, r0, r1
@   0x0802e462: 6020        str	r0, [r4, #0]
@   0x0802e464: bc10        pop	{r4}
@   0x0802e466: bc01        pop	{r0}
@   0x0802e468: 4700        bx	r0
@   0x0802e46a: 0000        movs	r0, r0
@   0x0802e46c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e46e: 0300        lsls	r0, r0, #12
@   0x0802e470: 2800        cmp	r0, #0
@   0x0802e472: d019        beq.n	0x2e4a8
@   0x0802e474: 4b0d        ldr	r3, [pc, #52]	@ (0x2e4ac)
@   0x0802e476: 4003        ands	r3, r0
@   0x0802e478: 0c01        lsrs	r1, r0, #16
@   0x0802e47a: 20ff        movs	r0, #255	@ 0xff
@   0x0802e47c: 4001        ands	r1, r0
@   0x0802e47e: 480c        ldr	r0, [pc, #48]	@ (0x2e4b0)
@   0x0802e480: 6800        ldr	r0, [r0, #0]
@   0x0802e482: 4684        mov	ip, r0
@   0x0802e484: 30c4        adds	r0, #196	@ 0xc4
@   0x0802e486: 6802        ldr	r2, [r0, #0]
@   0x0802e488: 0088        lsls	r0, r1, #2
@   0x0802e48a: 1880        adds	r0, r0, r2
@   0x0802e48c: 2200        movs	r2, #0
@   0x0802e48e: 6002        str	r2, [r0, #0]
@   0x0802e490: 009b        lsls	r3, r3, #2
@   0x0802e492: 2092        movs	r0, #146	@ 0x92
@   0x0802e494: 0040        lsls	r0, r0, #1
@   0x0802e496: 4460        add	r0, ip
@   0x0802e498: 18c0        adds	r0, r0, r3
@   0x0802e49a: 6002        str	r2, [r0, #0]
@   0x0802e49c: 4660        mov	r0, ip
@   0x0802e49e: 30c8        adds	r0, #200	@ 0xc8
@   0x0802e4a0: 6800        ldr	r0, [r0, #0]
@   0x0802e4a2: 0189        lsls	r1, r1, #6
@   0x0802e4a4: 1809        adds	r1, r1, r0
@   0x0802e4a6: 638a        str	r2, [r1, #56]	@ 0x38
@   0x0802e4a8: 4770        bx	lr
@   0x0802e4aa: 0000        movs	r0, r0
@   0x0802e4ac: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x0802e4b0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e4b2: 0300        lsls	r0, r0, #12
@   0x0802e4b4: 1c0b        adds	r3, r1, #0
@   0x0802e4b6: 2800        cmp	r0, #0
@   0x0802e4b8: d012        beq.n	0x2e4e0
@   0x0802e4ba: 0c02        lsrs	r2, r0, #16
@   0x0802e4bc: 20ff        movs	r0, #255	@ 0xff
@   0x0802e4be: 4002        ands	r2, r0
@   0x0802e4c0: 4908        ldr	r1, [pc, #32]	@ (0x2e4e4)
@   0x0802e4c2: 6808        ldr	r0, [r1, #0]
@   0x0802e4c4: 30c8        adds	r0, #200	@ 0xc8
@   0x0802e4c6: 6800        ldr	r0, [r0, #0]
@   0x0802e4c8: 0192        lsls	r2, r2, #6
@   0x0802e4ca: 1810        adds	r0, r2, r0
@   0x0802e4cc: 303c        adds	r0, #60	@ 0x3c
@   0x0802e4ce: 7003        strb	r3, [r0, #0]
@   0x0802e4d0: 6808        ldr	r0, [r1, #0]
@   0x0802e4d2: 30c8        adds	r0, #200	@ 0xc8
@   0x0802e4d4: 6800        ldr	r0, [r0, #0]
@   0x0802e4d6: 1812        adds	r2, r2, r0
@   0x0802e4d8: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802e4da: 2180        movs	r1, #128	@ 0x80
@   0x0802e4dc: 4308        orrs	r0, r1
@   0x0802e4de: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802e4e0: 4770        bx	lr
@   0x0802e4e2: 0000        movs	r0, r0
@   0x0802e4e4: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e4e6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802E43C
sub_0802E43C: @ 0x0802e43c
        .incbin "frog_us_baserom.gba", 0x2e43c, 0xac
        thumb_func_end sub_0802E43C
