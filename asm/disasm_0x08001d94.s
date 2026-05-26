@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001d94, 0x08001e18)  (132 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001d94 --end 0x8001e18 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001d94: b570        push	{r4, r5, r6, lr}
@   0x08001d96: 1c04        adds	r4, r0, #0
@   0x08001d98: 1c0d        adds	r5, r1, #0
@   0x08001d9a: 1c16        adds	r6, r2, #0
@   0x08001d9c: f007        ff3a 	bl	0x9c14
@   0x08001da0: 2800        cmp	r0, #0
@   0x08001da2: d101        bne.n	0x1da8
@   0x08001da4: 2007        movs	r0, #7
@   0x08001da6: 7020        strb	r0, [r4, #0]
@   0x08001da8: 1c28        adds	r0, r5, #0
@   0x08001daa: 1c31        adds	r1, r6, #0
@   0x08001dac: 2205        movs	r2, #5
@   0x08001dae: f009        fcff 	bl	0xb7b0
@   0x08001db2: 4d17        ldr	r5, [pc, #92]	@ (0x1e10)
@   0x08001db4: 2005        movs	r0, #5
@   0x08001db6: 5628        ldrsb	r0, [r5, r0]
@   0x08001db8: 2801        cmp	r0, #1
@   0x08001dba: dc0a        bgt.n	0x1dd2
@   0x08001dbc: 4c15        ldr	r4, [pc, #84]	@ (0x1e14)
@   0x08001dbe: 1c20        adds	r0, r4, #0
@   0x08001dc0: 2108        movs	r1, #8
@   0x08001dc2: 2200        movs	r2, #0
@   0x08001dc4: f004        fc7e 	bl	0x66c4
@   0x08001dc8: 1c20        adds	r0, r4, #0
@   0x08001dca: 2109        movs	r1, #9
@   0x08001dcc: 2200        movs	r2, #0
@   0x08001dce: f004        fc79 	bl	0x66c4
@   0x08001dd2: 7968        ldrb	r0, [r5, #5]
@   0x08001dd4: 2802        cmp	r0, #2
@   0x08001dd6: d10a        bne.n	0x1dee
@   0x08001dd8: 4c0e        ldr	r4, [pc, #56]	@ (0x1e14)
@   0x08001dda: 1c20        adds	r0, r4, #0
@   0x08001ddc: 2108        movs	r1, #8
@   0x08001dde: 2201        movs	r2, #1
@   0x08001de0: f004        fc70 	bl	0x66c4
@   0x08001de4: 1c20        adds	r0, r4, #0
@   0x08001de6: 2109        movs	r1, #9
@   0x08001de8: 2201        movs	r2, #1
@   0x08001dea: f004        fc6b 	bl	0x66c4
@   0x08001dee: 796d        ldrb	r5, [r5, #5]
@   0x08001df0: 2d03        cmp	r5, #3
@   0x08001df2: d10a        bne.n	0x1e0a
@   0x08001df4: 4c07        ldr	r4, [pc, #28]	@ (0x1e14)
@   0x08001df6: 1c20        adds	r0, r4, #0
@   0x08001df8: 2108        movs	r1, #8
@   0x08001dfa: 2201        movs	r2, #1
@   0x08001dfc: f004        fc62 	bl	0x66c4
@   0x08001e00: 1c20        adds	r0, r4, #0
@   0x08001e02: 2109        movs	r1, #9
@   0x08001e04: 2201        movs	r2, #1
@   0x08001e06: f004        fc5d 	bl	0x66c4
@   0x08001e0a: bc70        pop	{r4, r5, r6}
@   0x08001e0c: bc01        pop	{r0}
@   0x08001e0e: 4700        bx	r0
@   0x08001e10: 35e0        adds	r5, #224	@ 0xe0
@   0x08001e12: 0300        lsls	r0, r0, #12
@   0x08001e14: 6110        str	r0, [r2, #16]
@   0x08001e16: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001D94
sub_08001D94: @ 0x08001d94
        .incbin "frog_us_baserom.gba", 0x1d94, 0x84
        thumb_func_end sub_08001D94
