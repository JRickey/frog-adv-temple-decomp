@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802a2d8, 0x0802a2f0)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802a2d8 --end 0x802a2f0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a2d8: b500        push	{lr}
@   0x0802a2da: f7ff        fd19 	bl	0x29d10
@   0x0802a2de: f7ff        fd99 	bl	0x29e14
@   0x0802a2e2: f7ff        fe6b 	bl	0x29fbc
@   0x0802a2e6: f7ff        ff1f 	bl	0x2a128
@   0x0802a2ea: bc01        pop	{r0}
@   0x0802a2ec: 4700        bx	r0

        thumb_func_start sub_0802A2D8
sub_0802A2D8: @ 0x0802a2d8
        .incbin "baserom.gba", 0x2a2d8, 0x18
        thumb_func_end sub_0802A2D8
