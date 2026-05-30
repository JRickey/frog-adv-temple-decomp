@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080035f8, 0x08003604)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80035f8 --end 0x8003604 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080035f8: b500        push	{lr}
@   0x080035fa: f00a        fc41 	bl	0xde80
@   0x080035fe: bc01        pop	{r0}
@   0x08003600: 4700        bx	r0

        thumb_func_start sub_080035F8
sub_080035F8: @ 0x080035f8
        .incbin "frog_us_baserom.gba", 0x35f8, 0xc
        thumb_func_end sub_080035F8
