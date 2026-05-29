@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800189c, 0x080018a8)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800189c --end 0x80018a8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800189c: b500        push	{lr}
@   0x0800189e: f00c        faef 	bl	0xde80
@   0x080018a2: bc01        pop	{r0}
@   0x080018a4: 4700        bx	r0

        thumb_func_start sub_0800189C
sub_0800189C: @ 0x0800189c
        .incbin "frog_us_baserom.gba", 0x189c, 0xc
        thumb_func_end sub_0800189C
