@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020b78, 0x08020b88)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020b78 --end 0x8020b88 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020b78: b500        push	{lr}
@   0x08020b7a: 202d        movs	r0, #45	@ 0x2d
@   0x08020b7c: f000        f98c 	bl	0x20e98
@   0x08020b80: f011        ff4e 	bl	0x32a20
@   0x08020b84: bc01        pop	{r0}
@   0x08020b86: 4700        bx	r0

        thumb_func_start sub_08020B78
sub_08020B78: @ 0x08020b78
        .incbin "frog_us_baserom.gba", 0x20b78, 0x10
        thumb_func_end sub_08020B78
