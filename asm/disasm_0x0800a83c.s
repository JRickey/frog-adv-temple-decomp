@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a83c, 0x0800a910)  (212 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a83c --end 0x800a910 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a83c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800a83e: 4657        mov	r7, sl
@   0x0800a840: 464e        mov	r6, r9
@   0x0800a842: 4645        mov	r5, r8
@   0x0800a844: b4e0        push	{r5, r6, r7}
@   0x0800a846: b083        sub	sp, #12
@   0x0800a848: 0600        lsls	r0, r0, #24
@   0x0800a84a: 0e00        lsrs	r0, r0, #24
@   0x0800a84c: 9002        str	r0, [sp, #8]
@   0x0800a84e: 0609        lsls	r1, r1, #24
@   0x0800a850: 0e09        lsrs	r1, r1, #24
@   0x0800a852: 4689        mov	r9, r1
@   0x0800a854: 0612        lsls	r2, r2, #24
@   0x0800a856: 0e12        lsrs	r2, r2, #24
@   0x0800a858: 4690        mov	r8, r2
@   0x0800a85a: 061b        lsls	r3, r3, #24
@   0x0800a85c: 0e1b        lsrs	r3, r3, #24
@   0x0800a85e: 9301        str	r3, [sp, #4]
@   0x0800a860: 2600        movs	r6, #0
@   0x0800a862: 0602        lsls	r2, r0, #24
@   0x0800a864: 1611        asrs	r1, r2, #24
@   0x0800a866: 0048        lsls	r0, r1, #1
@   0x0800a868: 1840        adds	r0, r0, r1
@   0x0800a86a: 0080        lsls	r0, r0, #2
@   0x0800a86c: 4b11        ldr	r3, [pc, #68]	@ (0xa8b4)
@   0x0800a86e: 18c0        adds	r0, r0, r3
@   0x0800a870: 7800        ldrb	r0, [r0, #0]
@   0x0800a872: 0600        lsls	r0, r0, #24
@   0x0800a874: 1600        asrs	r0, r0, #24
@   0x0800a876: 4286        cmp	r6, r0
@   0x0800a878: da40        bge.n	0xa8fc
@   0x0800a87a: 3304        adds	r3, #4
@   0x0800a87c: 469a        mov	sl, r3
@   0x0800a87e: 2400        movs	r4, #0
@   0x0800a880: 1c0d        adds	r5, r1, #0
@   0x0800a882: 9f01        ldr	r7, [sp, #4]
@   0x0800a884: 2f00        cmp	r7, #0
@   0x0800a886: d117        bne.n	0xa8b8
@   0x0800a888: 1610        asrs	r0, r2, #24
@   0x0800a88a: 0041        lsls	r1, r0, #1
@   0x0800a88c: 1809        adds	r1, r1, r0
@   0x0800a88e: 0089        lsls	r1, r1, #2
@   0x0800a890: 4652        mov	r2, sl
@   0x0800a892: 1888        adds	r0, r1, r2
@   0x0800a894: 6800        ldr	r0, [r0, #0]
@   0x0800a896: 1820        adds	r0, r4, r0
@   0x0800a898: 2300        movs	r3, #0
@   0x0800a89a: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800a89c: 2702        movs	r7, #2
@   0x0800a89e: 5fc3        ldrsh	r3, [r0, r7]
@   0x0800a8a0: 4804        ldr	r0, [pc, #16]	@ (0xa8b4)
@   0x0800a8a2: 1809        adds	r1, r1, r0
@   0x0800a8a4: 7a08        ldrb	r0, [r1, #8]
@   0x0800a8a6: 9000        str	r0, [sp, #0]
@   0x0800a8a8: 4648        mov	r0, r9
@   0x0800a8aa: 4641        mov	r1, r8
@   0x0800a8ac: f002        f968 	bl	0xcb80
@   0x0800a8b0: e015        b.n	0xa8de
@   0x0800a8b2: 0000        movs	r0, r0
@   0x0800a8b4: 0b00        lsrs	r0, r0, #12
@   0x0800a8b6: 080c        lsrs	r4, r1, #32
@   0x0800a8b8: 0069        lsls	r1, r5, #1
@   0x0800a8ba: 1949        adds	r1, r1, r5
@   0x0800a8bc: 0089        lsls	r1, r1, #2
@   0x0800a8be: 4652        mov	r2, sl
@   0x0800a8c0: 1888        adds	r0, r1, r2
@   0x0800a8c2: 6800        ldr	r0, [r0, #0]
@   0x0800a8c4: 1820        adds	r0, r4, r0
@   0x0800a8c6: 2300        movs	r3, #0
@   0x0800a8c8: 5ec2        ldrsh	r2, [r0, r3]
@   0x0800a8ca: 2702        movs	r7, #2
@   0x0800a8cc: 5fc3        ldrsh	r3, [r0, r7]
@   0x0800a8ce: 480f        ldr	r0, [pc, #60]	@ (0xa90c)
@   0x0800a8d0: 1809        adds	r1, r1, r0
@   0x0800a8d2: 7a48        ldrb	r0, [r1, #9]
@   0x0800a8d4: 9000        str	r0, [sp, #0]
@   0x0800a8d6: 4648        mov	r0, r9
@   0x0800a8d8: 4641        mov	r1, r8
@   0x0800a8da: f002        f951 	bl	0xcb80
@   0x0800a8de: 9902        ldr	r1, [sp, #8]
@   0x0800a8e0: 0608        lsls	r0, r1, #24
@   0x0800a8e2: 3404        adds	r4, #4
@   0x0800a8e4: 3601        adds	r6, #1
@   0x0800a8e6: 1c02        adds	r2, r0, #0
@   0x0800a8e8: 1610        asrs	r0, r2, #24
@   0x0800a8ea: 0041        lsls	r1, r0, #1
@   0x0800a8ec: 1809        adds	r1, r1, r0
@   0x0800a8ee: 0089        lsls	r1, r1, #2
@   0x0800a8f0: 4b06        ldr	r3, [pc, #24]	@ (0xa90c)
@   0x0800a8f2: 18c9        adds	r1, r1, r3
@   0x0800a8f4: 2000        movs	r0, #0
@   0x0800a8f6: 5608        ldrsb	r0, [r1, r0]
@   0x0800a8f8: 4286        cmp	r6, r0
@   0x0800a8fa: dbc2        blt.n	0xa882
@   0x0800a8fc: b003        add	sp, #12
@   0x0800a8fe: bc38        pop	{r3, r4, r5}
@   0x0800a900: 4698        mov	r8, r3
@   0x0800a902: 46a1        mov	r9, r4
@   0x0800a904: 46aa        mov	sl, r5
@   0x0800a906: bcf0        pop	{r4, r5, r6, r7}
@   0x0800a908: bc01        pop	{r0}
@   0x0800a90a: 4700        bx	r0
@   0x0800a90c: 0b00        lsrs	r0, r0, #12
@   0x0800a90e: 080c        lsrs	r4, r1, #32

        thumb_func_start sub_0800A83C
sub_0800A83C: @ 0x0800a83c
        .incbin "frog_us_baserom.gba", 0xa83c, 0xd4
        thumb_func_end sub_0800A83C
