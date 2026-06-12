@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802aff8, 0x0802b008)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802aff8 --end 0x802b008 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802aff8: b500        push	{lr}
@   0x0802affa: f7ff        fe5b 	bl	0x2acb4
@   0x0802affe: f7ff        ffa5 	bl	0x2af4c
@   0x0802b002: bc01        pop	{r0}
@   0x0802b004: 4700        bx	r0

        thumb_func_start sub_0802AFF8
sub_0802AFF8: @ 0x0802aff8
        .incbin "baserom.gba", 0x2aff8, 0x10
        thumb_func_end sub_0802AFF8
