@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003c9c, 0x08003ca8)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003c9c --end 0x8003ca8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003c9c: b500        push	{lr}
@   0x08003c9e: f00a        f8ef 	bl	0xde80
@   0x08003ca2: bc01        pop	{r0}
@   0x08003ca4: 4700        bx	r0

        thumb_func_start sub_08003C9C
sub_08003C9C: @ 0x08003c9c
        .incbin "frog_us_baserom.gba", 0x3c9c, 0xc
        thumb_func_end sub_08003C9C
