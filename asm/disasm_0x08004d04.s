@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08004d04, 0x08004d10)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8004d04 --end 0x8004d10 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08004d04: b500        push	{lr}
@   0x08004d06: f009        f8bb 	bl	0xde80
@   0x08004d0a: bc01        pop	{r0}
@   0x08004d0c: 4700        bx	r0

        thumb_func_start sub_08004D04
sub_08004D04: @ 0x08004d04
        .incbin "frog_us_baserom.gba", 0x4d04, 0xc
        thumb_func_end sub_08004D04
