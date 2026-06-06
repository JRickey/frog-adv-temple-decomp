@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d4f8, 0x0802d504)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d4f8 --end 0x802d504 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d4f8: b500        push	{lr}
@   0x0802d4fa: f7ff        ff61 	bl	0x2d3c0
@   0x0802d4fe: bc01        pop	{r0}
@   0x0802d500: 4700        bx	r0

        thumb_func_start sub_0802D4F8
sub_0802D4F8: @ 0x0802d4f8
        .incbin "frog_us_baserom.gba", 0x2d4f8, 0xc
        thumb_func_end sub_0802D4F8
