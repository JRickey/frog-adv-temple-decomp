@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002518, 0x08002524)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002518 --end 0x8002524 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002518: b500        push	{lr}
@   0x0800251a: f00b        fcb1 	bl	0xde80
@   0x0800251e: bc01        pop	{r0}
@   0x08002520: 4700        bx	r0

        thumb_func_start sub_08002518
sub_08002518: @ 0x08002518
        .incbin "frog_us_baserom.gba", 0x2518, 0xc
        thumb_func_end sub_08002518
