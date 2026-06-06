@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ca54, 0x0802ca64)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ca54 --end 0x802ca64 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ca54: b500        push	{lr}
@   0x0802ca56: f7e0        ff23 	bl	0xd8a0
@   0x0802ca5a: f7ff        ff59 	bl	0x2c910
@   0x0802ca5e: bc01        pop	{r0}
@   0x0802ca60: 4700        bx	r0

        thumb_func_start sub_0802CA54
sub_0802CA54: @ 0x0802ca54
        .incbin "frog_us_baserom.gba", 0x2ca54, 0x10
        thumb_func_end sub_0802CA54
