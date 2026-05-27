@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020b60, 0x08020b78)  (24 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020b60 --end 0x8020b78 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020b60: b500        push	{lr}
@   0x08020b62: f00d        faeb 	bl	0x2e13c
@   0x08020b66: 2000        movs	r0, #0
@   0x08020b68: f000        f996 	bl	0x20e98
@   0x08020b6c: 2001        movs	r0, #1
@   0x08020b6e: f011        fa91 	bl	0x32094
@   0x08020b72: bc01        pop	{r0}
@   0x08020b74: 4700        bx	r0

        thumb_func_start sub_08020B60
sub_08020B60: @ 0x08020b60
        .incbin "frog_us_baserom.gba", 0x20b60, 0x18
        thumb_func_end sub_08020B60
