@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08020b50, 0x08020b60)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8020b50 --end 0x8020b60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08020b50: b500        push	{lr}
@   0x08020b52: f00d        faf3 	bl	0x2e13c
@   0x08020b56: 2001        movs	r0, #1
@   0x08020b58: f011        fa40 	bl	0x31fdc
@   0x08020b5c: bc01        pop	{r0}
@   0x08020b5e: 4700        bx	r0

        thumb_func_start sub_08020B50
sub_08020B50: @ 0x08020b50
        .incbin "frog_us_baserom.gba", 0x20b50, 0x10
        thumb_func_end sub_08020B50
