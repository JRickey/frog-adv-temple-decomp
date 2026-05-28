@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020dc4, 0x08020e14)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020dc4 --end 0x8020e14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020dc4: b570        push	{r4, r5, r6, lr}
@   0x08020dc6: 0600        lsls	r0, r0, #24
@   0x08020dc8: 4d11        ldr	r5, [pc, #68]	@ (0x20e10)
@   0x08020dca: 0d44        lsrs	r4, r0, #21
@   0x08020dcc: 1c28        adds	r0, r5, #0
@   0x08020dce: 3008        adds	r0, #8
@   0x08020dd0: 1826        adds	r6, r4, r0
@   0x08020dd2: 6830        ldr	r0, [r6, #0]
@   0x08020dd4: f00d        f9d6 	bl	0x2e184
@   0x08020dd8: 2800        cmp	r0, #0
@   0x08020dda: d116        bne.n	0x20e0a
@   0x08020ddc: 1d28        adds	r0, r5, #4
@   0x08020dde: 1820        adds	r0, r4, r0
@   0x08020de0: 6801        ldr	r1, [r0, #0]
@   0x08020de2: 2401        movs	r4, #1
@   0x08020de4: 4264        negs	r4, r4
@   0x08020de6: 2010        movs	r0, #16
@   0x08020de8: 782a        ldrb	r2, [r5, #0]
@   0x08020dea: 4010        ands	r0, r2
@   0x08020dec: 2800        cmp	r0, #0
@   0x08020dee: d00b        beq.n	0x20e08
@   0x08020df0: 1c08        adds	r0, r1, #0
@   0x08020df2: 21ff        movs	r1, #255	@ 0xff
@   0x08020df4: 22ff        movs	r2, #255	@ 0xff
@   0x08020df6: 23ff        movs	r3, #255	@ 0xff
@   0x08020df8: f00c        fdf8 	bl	0x2d9ec
@   0x08020dfc: 1c04        adds	r4, r0, #0
@   0x08020dfe: 217f        movs	r1, #127	@ 0x7f
@   0x08020e00: 78ad        ldrb	r5, [r5, #2]
@   0x08020e02: 4029        ands	r1, r5
@   0x08020e04: f00c        ff0a 	bl	0x2dc1c
@   0x08020e08: 6034        str	r4, [r6, #0]
@   0x08020e0a: bc70        pop	{r4, r5, r6}
@   0x08020e0c: bc01        pop	{r0}
@   0x08020e0e: 4700        bx	r0
@   0x08020e10: 3570        adds	r5, #112	@ 0x70
@   0x08020e12: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020DC4
sub_08020DC4: @ 0x08020dc4
        .incbin "frog_us_baserom.gba", 0x20dc4, 0x50
        thumb_func_end sub_08020DC4
