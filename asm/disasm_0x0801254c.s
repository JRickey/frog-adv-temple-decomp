@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801254c, 0x0801255c)  (16 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801254c --end 0x801255c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801254c: b500        push	{lr}
@   0x0801254e: 2002        movs	r0, #2
@   0x08012550: f7ff        fec8 	bl	0x122e4
@   0x08012554: f004        fd54 	bl	0x17000
@   0x08012558: bc01        pop	{r0}
@   0x0801255a: 4700        bx	r0

        thumb_func_start sub_0801254C
sub_0801254C: @ 0x0801254c
        .incbin "frog_us_baserom.gba", 0x1254c, 0x10
        thumb_func_end sub_0801254C
