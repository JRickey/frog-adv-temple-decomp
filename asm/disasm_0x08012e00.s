@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08012e00, 0x08012e2c)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8012e00 --end 0x8012e2c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08012e00: b500        push	{lr}
@   0x08012e02: 2003        movs	r0, #3
@   0x08012e04: f7fb        fd2a 	bl	0xe85c
@   0x08012e08: 2002        movs	r0, #2
@   0x08012e0a: f7fc        f813 	bl	0xee34
@   0x08012e0e: f7fb        fe85 	bl	0xeb1c
@   0x08012e12: f7ff        ff95 	bl	0x12d40
@   0x08012e16: 2003        movs	r0, #3
@   0x08012e18: f7fc        fa18 	bl	0xf24c
@   0x08012e1c: 2003        movs	r0, #3
@   0x08012e1e: f7fb        fedd 	bl	0xebdc
@   0x08012e22: f003        fe0d 	bl	0x16a40
@   0x08012e26: bc01        pop	{r0}
@   0x08012e28: 4700        bx	r0

        thumb_func_start sub_08012E00
sub_08012E00: @ 0x08012e00
        .incbin "frog_us_baserom.gba", 0x12e00, 0x2c
        thumb_func_end sub_08012E00
