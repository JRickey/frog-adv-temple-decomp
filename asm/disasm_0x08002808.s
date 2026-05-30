@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002808, 0x08002814)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002808 --end 0x8002814 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002808: b500        push	{lr}
@   0x0800280a: f00b        fb39 	bl	0xde80
@   0x0800280e: bc01        pop	{r0}
@   0x08002810: 4700        bx	r0

        thumb_func_start sub_08002808
sub_08002808: @ 0x08002808
        .incbin "frog_us_baserom.gba", 0x2808, 0xc
        thumb_func_end sub_08002808
