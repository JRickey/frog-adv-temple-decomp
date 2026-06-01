@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801255c, 0x08012588)  (44 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801255c --end 0x8012588 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801255c: b500        push	{lr}
@   0x0801255e: 2003        movs	r0, #3
@   0x08012560: f7fc        f97c 	bl	0xe85c
@   0x08012564: 2002        movs	r0, #2
@   0x08012566: f7fc        fc65 	bl	0xee34
@   0x0801256a: f7fc        fad7 	bl	0xeb1c
@   0x0801256e: f7ff        fdc7 	bl	0x12100
@   0x08012572: 2003        movs	r0, #3
@   0x08012574: f7fc        fe6a 	bl	0xf24c
@   0x08012578: 2003        movs	r0, #3
@   0x0801257a: f7fc        fb2f 	bl	0xebdc
@   0x0801257e: f004        fa5f 	bl	0x16a40
@   0x08012582: bc01        pop	{r0}
@   0x08012584: 4700        bx	r0

        thumb_func_start sub_0801255C
sub_0801255C: @ 0x0801255c
        .incbin "frog_us_baserom.gba", 0x1255c, 0x2c
        thumb_func_end sub_0801255C
