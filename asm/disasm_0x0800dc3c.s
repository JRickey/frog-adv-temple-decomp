@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800dc3c, 0x0800dc50)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800dc3c --end 0x800dc50 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800dc3c: b500        push	{lr}
@   0x0800dc3e: 2005        movs	r0, #5
@   0x0800dc40: f7ff        fde2 	bl	0xd808
@   0x0800dc44: 2014        movs	r0, #20
@   0x0800dc46: 210a        movs	r1, #10
@   0x0800dc48: f7ff        fc02 	bl	0xd450
@   0x0800dc4c: bc01        pop	{r0}
@   0x0800dc4e: 4700        bx	r0

        thumb_func_start sub_0800DC3C
sub_0800DC3C: @ 0x0800dc3c
        .incbin "frog_us_baserom.gba", 0xdc3c, 0x14
        thumb_func_end sub_0800DC3C
