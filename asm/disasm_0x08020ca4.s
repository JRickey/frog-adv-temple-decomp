@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020ca4, 0x08020cdc)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020ca4 --end 0x8020cdc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020ca4: b530        push	{r4, r5, lr}
@   0x08020ca6: 1c01        adds	r1, r0, #0
@   0x08020ca8: 2401        movs	r4, #1
@   0x08020caa: 4264        negs	r4, r4
@   0x08020cac: 4d0a        ldr	r5, [pc, #40]	@ (0x20cd8)
@   0x08020cae: 2010        movs	r0, #16
@   0x08020cb0: 782a        ldrb	r2, [r5, #0]
@   0x08020cb2: 4010        ands	r0, r2
@   0x08020cb4: 2800        cmp	r0, #0
@   0x08020cb6: d00b        beq.n	0x20cd0
@   0x08020cb8: 1c08        adds	r0, r1, #0
@   0x08020cba: 21ff        movs	r1, #255	@ 0xff
@   0x08020cbc: 22ff        movs	r2, #255	@ 0xff
@   0x08020cbe: 23ff        movs	r3, #255	@ 0xff
@   0x08020cc0: f00c        fe94 	bl	0x2d9ec
@   0x08020cc4: 1c04        adds	r4, r0, #0
@   0x08020cc6: 217f        movs	r1, #127	@ 0x7f
@   0x08020cc8: 78ad        ldrb	r5, [r5, #2]
@   0x08020cca: 4029        ands	r1, r5
@   0x08020ccc: f00c        ffa6 	bl	0x2dc1c
@   0x08020cd0: 1c20        adds	r0, r4, #0
@   0x08020cd2: bc30        pop	{r4, r5}
@   0x08020cd4: bc02        pop	{r1}
@   0x08020cd6: 4708        bx	r1
@   0x08020cd8: 3570        adds	r5, #112	@ 0x70
@   0x08020cda: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08020CA4
sub_08020CA4: @ 0x08020ca4
        .incbin "frog_us_baserom.gba", 0x20ca4, 0x38
        thumb_func_end sub_08020CA4
