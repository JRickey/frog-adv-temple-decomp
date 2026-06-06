@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800090c, 0x08000918)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800090c --end 0x8000918 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800090c: b500        push	{lr}
@   0x0800090e: f035        fa39 	bl	0x35d84
@   0x08000912: bc01        pop	{r0}
@   0x08000914: 4700        bx	r0

        thumb_func_start sub_0800090C
sub_0800090C: @ 0x0800090c
        .incbin "frog_us_baserom.gba", 0x90c, 0xc
        thumb_func_end sub_0800090C
