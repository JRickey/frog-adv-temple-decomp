@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802ca64, 0x0802ca70)  (12 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802ca64 --end 0x802ca70 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802ca64: b500        push	{lr}
@   0x0802ca66: 2058        movs	r0, #88	@ 0x58
@   0x0802ca68: f7ff        fbca 	bl	0x2c200
@   0x0802ca6c: bc01        pop	{r0}
@   0x0802ca6e: 4700        bx	r0

        thumb_func_start sub_0802CA64
sub_0802CA64: @ 0x0802ca64
        .incbin "frog_us_baserom.gba", 0x2ca64, 0xc
        thumb_func_end sub_0802CA64
