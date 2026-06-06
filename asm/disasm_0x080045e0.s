@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080045e0, 0x080045ec)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80045e0 --end 0x80045ec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080045e0: b500        push	{lr}
@   0x080045e2: f009        fc4d 	bl	0xde80
@   0x080045e6: bc01        pop	{r0}
@   0x080045e8: 4700        bx	r0

        thumb_func_start sub_080045E0
sub_080045E0: @ 0x080045e0
        .incbin "frog_us_baserom.gba", 0x45e0, 0xc
        thumb_func_end sub_080045E0
