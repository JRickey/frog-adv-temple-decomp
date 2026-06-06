@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d800, 0x0802d890)  (144 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d800 --end 0x802d890 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d800: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d802: 0600        lsls	r0, r0, #24
@   0x0802d804: 0e03        lsrs	r3, r0, #24
@   0x0802d806: 4921        ldr	r1, [pc, #132]	@ (0x2d88c)
@   0x0802d808: 6808        ldr	r0, [r1, #0]
@   0x0802d80a: 1c02        adds	r2, r0, #0
@   0x0802d80c: 32be        adds	r2, #190	@ 0xbe
@   0x0802d80e: 8815        ldrh	r5, [r2, #0]
@   0x0802d810: 8013        strh	r3, [r2, #0]
@   0x0802d812: 1c0c        adds	r4, r1, #0
@   0x0802d814: 2b00        cmp	r3, #0
@   0x0802d816: d001        beq.n	0x2d81c
@   0x0802d818: 1c58        adds	r0, r3, #1
@   0x0802d81a: 8010        strh	r0, [r2, #0]
@   0x0802d81c: 6820        ldr	r0, [r4, #0]
@   0x0802d81e: 30be        adds	r0, #190	@ 0xbe
@   0x0802d820: 8800        ldrh	r0, [r0, #0]
@   0x0802d822: 42a8        cmp	r0, r5
@   0x0802d824: d02f        beq.n	0x2d886
@   0x0802d826: 2300        movs	r3, #0
@   0x0802d828: 1c27        adds	r7, r4, #0
@   0x0802d82a: 2680        movs	r6, #128	@ 0x80
@   0x0802d82c: 0276        lsls	r6, r6, #9
@   0x0802d82e: 2580        movs	r5, #128	@ 0x80
@   0x0802d830: 6838        ldr	r0, [r7, #0]
@   0x0802d832: 0099        lsls	r1, r3, #2
@   0x0802d834: 3010        adds	r0, #16
@   0x0802d836: 1842        adds	r2, r0, r1
@   0x0802d838: 6811        ldr	r1, [r2, #0]
@   0x0802d83a: 1c08        adds	r0, r1, #0
@   0x0802d83c: 4030        ands	r0, r6
@   0x0802d83e: 2800        cmp	r0, #0
@   0x0802d840: d001        beq.n	0x2d846
@   0x0802d842: 4329        orrs	r1, r5
@   0x0802d844: 6011        str	r1, [r2, #0]
@   0x0802d846: 3301        adds	r3, #1
@   0x0802d848: 2b03        cmp	r3, #3
@   0x0802d84a: ddf1        ble.n	0x2d830
@   0x0802d84c: 2300        movs	r3, #0
@   0x0802d84e: 6820        ldr	r0, [r4, #0]
@   0x0802d850: 7800        ldrb	r0, [r0, #0]
@   0x0802d852: 4283        cmp	r3, r0
@   0x0802d854: da17        bge.n	0x2d886
@   0x0802d856: 1c27        adds	r7, r4, #0
@   0x0802d858: 2680        movs	r6, #128	@ 0x80
@   0x0802d85a: 0276        lsls	r6, r6, #9
@   0x0802d85c: 2580        movs	r5, #128	@ 0x80
@   0x0802d85e: 6838        ldr	r0, [r7, #0]
@   0x0802d860: 30cc        adds	r0, #204	@ 0xcc
@   0x0802d862: 6801        ldr	r1, [r0, #0]
@   0x0802d864: 0098        lsls	r0, r3, #2
@   0x0802d866: 1840        adds	r0, r0, r1
@   0x0802d868: 6802        ldr	r2, [r0, #0]
@   0x0802d86a: 2a00        cmp	r2, #0
@   0x0802d86c: d006        beq.n	0x2d87c
@   0x0802d86e: 6b91        ldr	r1, [r2, #56]	@ 0x38
@   0x0802d870: 1c08        adds	r0, r1, #0
@   0x0802d872: 4030        ands	r0, r6
@   0x0802d874: 2800        cmp	r0, #0
@   0x0802d876: d001        beq.n	0x2d87c
@   0x0802d878: 4329        orrs	r1, r5
@   0x0802d87a: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802d87c: 3301        adds	r3, #1
@   0x0802d87e: 6820        ldr	r0, [r4, #0]
@   0x0802d880: 7800        ldrb	r0, [r0, #0]
@   0x0802d882: 4283        cmp	r3, r0
@   0x0802d884: dbeb        blt.n	0x2d85e
@   0x0802d886: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d888: bc01        pop	{r0}
@   0x0802d88a: 4700        bx	r0
@   0x0802d88c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802d88e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802D800
sub_0802D800: @ 0x0802d800
        .incbin "frog_us_baserom.gba", 0x2d800, 0x90
        thumb_func_end sub_0802D800
