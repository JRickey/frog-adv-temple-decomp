@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012bb4, 0x08012bc4)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012bb4 --end 0x8012bc4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012bb4: b500        push	{lr}
@   0x08012bb6: f7ff        ff59 	bl	0x12a6c
@   0x08012bba: f004        fa21 	bl	0x17000
@   0x08012bbe: bc01        pop	{r0}
@   0x08012bc0: 4700        bx	r0

        thumb_func_start sub_08012BB4
sub_08012BB4: @ 0x08012bb4
        .incbin "frog_us_baserom.gba", 0x12bb4, 0x10
        thumb_func_end sub_08012BB4
