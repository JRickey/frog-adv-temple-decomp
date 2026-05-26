@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000d2c, 0x08000d50)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000d2c --end 0x8000d50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000d2c: b570        push	{r4, r5, r6, lr}
@   0x08000d2e: 1c04        adds	r4, r0, #0
@   0x08000d30: 1c0d        adds	r5, r1, #0
@   0x08000d32: 1c16        adds	r6, r2, #0
@   0x08000d34: f008        ff6e 	bl	0x9c14
@   0x08000d38: 2800        cmp	r0, #0
@   0x08000d3a: d101        bne.n	0xd40
@   0x08000d3c: 2008        movs	r0, #8
@   0x08000d3e: 7020        strb	r0, [r4, #0]
@   0x08000d40: 1c28        adds	r0, r5, #0
@   0x08000d42: 1c31        adds	r1, r6, #0
@   0x08000d44: 2212        movs	r2, #18
@   0x08000d46: f00a        fd33 	bl	0xb7b0
@   0x08000d4a: bc70        pop	{r4, r5, r6}
@   0x08000d4c: bc01        pop	{r0}
@   0x08000d4e: 4700        bx	r0

        thumb_func_start sub_08000D2C
sub_08000D2C: @ 0x08000d2c
        .incbin "frog_us_baserom.gba", 0xd2c, 0x24
        thumb_func_end sub_08000D2C
