@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024b3c, 0x08024b68)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024b3c --end 0x8024b68 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024b3c: b500        push	{lr}
@   0x08024b3e: f7ff        fe49 	bl	0x247d4
@   0x08024b42: f7ff        fe6d 	bl	0x24820
@   0x08024b46: f7ff        fe91 	bl	0x2486c
@   0x08024b4a: f7ff        fecb 	bl	0x248e4
@   0x08024b4e: f7ff        ff0f 	bl	0x24970
@   0x08024b52: f7ff        ff49 	bl	0x249e8
@   0x08024b56: f7ff        ff77 	bl	0x24a48
@   0x08024b5a: f7ff        fceb 	bl	0x24534
@   0x08024b5e: f7ff        ffb1 	bl	0x24ac4
@   0x08024b62: bc01        pop	{r0}
@   0x08024b64: 4700        bx	r0

        thumb_func_start sub_08024B3C
sub_08024B3C: @ 0x08024b3c
        .incbin "baserom.gba", 0x24b3c, 0x2c
        thumb_func_end sub_08024B3C
