@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d808, 0x0800d8a0)  (152 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d808 --end 0x800d8a0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d808: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800d80a: 4647        mov	r7, r8
@   0x0800d80c: b480        push	{r7}
@   0x0800d80e: b081        sub	sp, #4
@   0x0800d810: 0600        lsls	r0, r0, #24
@   0x0800d812: 0e03        lsrs	r3, r0, #24
@   0x0800d814: 2100        movs	r1, #0
@   0x0800d816: 2400        movs	r4, #0
@   0x0800d818: 4d1f        ldr	r5, [pc, #124]	@ (0xd898)
@   0x0800d81a: 4a20        ldr	r2, [pc, #128]	@ (0xd89c)
@   0x0800d81c: 1960        adds	r0, r4, r5
@   0x0800d81e: 7800        ldrb	r0, [r0, #0]
@   0x0800d820: 2800        cmp	r0, #0
@   0x0800d822: d006        beq.n	0xd832
@   0x0800d824: 0408        lsls	r0, r1, #16
@   0x0800d826: 1400        asrs	r0, r0, #16
@   0x0800d828: 1881        adds	r1, r0, r2
@   0x0800d82a: 700c        strb	r4, [r1, #0]
@   0x0800d82c: 3001        adds	r0, #1
@   0x0800d82e: 0400        lsls	r0, r0, #16
@   0x0800d830: 0c01        lsrs	r1, r0, #16
@   0x0800d832: 3401        adds	r4, #1
@   0x0800d834: 2c3f        cmp	r4, #63	@ 0x3f
@   0x0800d836: ddf1        ble.n	0xd81c
@   0x0800d838: 0618        lsls	r0, r3, #24
@   0x0800d83a: 2400        movs	r4, #0
@   0x0800d83c: 1c06        adds	r6, r0, #0
@   0x0800d83e: 2e00        cmp	r6, #0
@   0x0800d840: dd24        ble.n	0xd88c
@   0x0800d842: 466d        mov	r5, sp
@   0x0800d844: 4814        ldr	r0, [pc, #80]	@ (0xd898)
@   0x0800d846: 4680        mov	r8, r0
@   0x0800d848: 4f14        ldr	r7, [pc, #80]	@ (0xd89c)
@   0x0800d84a: 0408        lsls	r0, r1, #16
@   0x0800d84c: 1400        asrs	r0, r0, #16
@   0x0800d84e: f7f2        ff89 	bl	0x764
@   0x0800d852: 7028        strb	r0, [r5, #0]
@   0x0800d854: 7828        ldrb	r0, [r5, #0]
@   0x0800d856: 19c0        adds	r0, r0, r7
@   0x0800d858: 7801        ldrb	r1, [r0, #0]
@   0x0800d85a: 4441        add	r1, r8
@   0x0800d85c: 2000        movs	r0, #0
@   0x0800d85e: 7008        strb	r0, [r1, #0]
@   0x0800d860: 2100        movs	r1, #0
@   0x0800d862: 2200        movs	r2, #0
@   0x0800d864: 1c63        adds	r3, r4, #1
@   0x0800d866: 4644        mov	r4, r8
@   0x0800d868: 1910        adds	r0, r2, r4
@   0x0800d86a: 7800        ldrb	r0, [r0, #0]
@   0x0800d86c: 2800        cmp	r0, #0
@   0x0800d86e: d006        beq.n	0xd87e
@   0x0800d870: 0408        lsls	r0, r1, #16
@   0x0800d872: 1400        asrs	r0, r0, #16
@   0x0800d874: 19c1        adds	r1, r0, r7
@   0x0800d876: 700a        strb	r2, [r1, #0]
@   0x0800d878: 3001        adds	r0, #1
@   0x0800d87a: 0400        lsls	r0, r0, #16
@   0x0800d87c: 0c01        lsrs	r1, r0, #16
@   0x0800d87e: 3201        adds	r2, #1
@   0x0800d880: 2a3f        cmp	r2, #63	@ 0x3f
@   0x0800d882: ddf0        ble.n	0xd866
@   0x0800d884: 1c1c        adds	r4, r3, #0
@   0x0800d886: 1630        asrs	r0, r6, #24
@   0x0800d888: 4284        cmp	r4, r0
@   0x0800d88a: dbde        blt.n	0xd84a
@   0x0800d88c: b001        add	sp, #4
@   0x0800d88e: bc08        pop	{r3}
@   0x0800d890: 4698        mov	r8, r3
@   0x0800d892: bcf0        pop	{r4, r5, r6, r7}
@   0x0800d894: bc01        pop	{r0}
@   0x0800d896: 4700        bx	r0
@   0x0800d898: 53a0        strh	r0, [r4, r6]
@   0x0800d89a: 0300        lsls	r0, r0, #12
@   0x0800d89c: 3610        adds	r6, #16
@   0x0800d89e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800D808
sub_0800D808: @ 0x0800d808
        .incbin "frog_us_baserom.gba", 0xd808, 0x98
        thumb_func_end sub_0800D808
