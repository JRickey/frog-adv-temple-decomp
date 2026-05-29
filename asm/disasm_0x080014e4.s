@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080014e4, 0x080014f0)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80014e4 --end 0x80014f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080014e4: b500        push	{lr}
@   0x080014e6: f00c        fccb 	bl	0xde80
@   0x080014ea: bc01        pop	{r0}
@   0x080014ec: 4700        bx	r0

        thumb_func_start sub_080014E4
sub_080014E4: @ 0x080014e4
        .incbin "frog_us_baserom.gba", 0x14e4, 0xc
        thumb_func_end sub_080014E4
