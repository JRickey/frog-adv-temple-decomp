@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013880, 0x08013898)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013880 --end 0x8013898 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013880: b500        push	{lr}
@   0x08013882: f7ff        ff7b 	bl	0x1377c
@   0x08013886: 2002        movs	r0, #2
@   0x08013888: f7fb        f9a8 	bl	0xebdc
@   0x0801388c: 2002        movs	r0, #2
@   0x0801388e: f7fb        fad1 	bl	0xee34
@   0x08013892: bc01        pop	{r0}
@   0x08013894: 4700        bx	r0

        thumb_func_start sub_08013880
sub_08013880: @ 0x08013880
        .incbin "frog_us_baserom.gba", 0x13880, 0x18
        thumb_func_end sub_08013880
