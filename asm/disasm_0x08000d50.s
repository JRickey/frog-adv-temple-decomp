@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08000d50, 0x08000d5c)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8000d50 --end 0x8000d5c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08000d50: b500        push	{lr}
@   0x08000d52: f00d        f895 	bl	0xde80
@   0x08000d56: bc01        pop	{r0}
@   0x08000d58: 4700        bx	r0

        thumb_func_start sub_08000D50
sub_08000D50: @ 0x08000d50
        .incbin "frog_us_baserom.gba", 0xd50, 0xc
        thumb_func_end sub_08000D50
