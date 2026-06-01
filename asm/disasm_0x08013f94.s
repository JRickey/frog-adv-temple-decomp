@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013f94, 0x08013fa0)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013f94 --end 0x8013fa0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013f94: b500        push	{lr}
@   0x08013f96: f003        f833 	bl	0x17000
@   0x08013f9a: bc01        pop	{r0}
@   0x08013f9c: 4700        bx	r0

        thumb_func_start sub_08013F94
sub_08013F94: @ 0x08013f94
        .incbin "frog_us_baserom.gba", 0x13f94, 0xc
        thumb_func_end sub_08013F94
