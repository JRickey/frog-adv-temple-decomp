@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001e18, 0x08001e24)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001e18 --end 0x8001e24 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001e18: b500        push	{lr}
@   0x08001e1a: f00c        f831 	bl	0xde80
@   0x08001e1e: bc01        pop	{r0}
@   0x08001e20: 4700        bx	r0

        thumb_func_start sub_08001E18
sub_08001E18: @ 0x08001e18
        .incbin "frog_us_baserom.gba", 0x1e18, 0xc
        thumb_func_end sub_08001E18
