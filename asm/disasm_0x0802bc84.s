@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802bc84, 0x0802bc94)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802bc84 --end 0x802bc94 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802bc84: b500        push	{lr}
@   0x0802bc86: f7ff        fc17 	bl	0x2b4b8
@   0x0802bc8a: f7e1        fab5 	bl	0xd1f8
@   0x0802bc8e: bc01        pop	{r0}
@   0x0802bc90: 4700        bx	r0

        thumb_func_start sub_0802BC84
sub_0802BC84: @ 0x0802bc84
        .incbin "frog_us_baserom.gba", 0x2bc84, 0x10
        thumb_func_end sub_0802BC84
