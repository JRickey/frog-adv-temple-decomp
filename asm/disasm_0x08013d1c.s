@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08013d1c, 0x08013d44)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8013d1c --end 0x8013d44 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08013d1c: b500        push	{lr}
@   0x08013d1e: 2003        movs	r0, #3
@   0x08013d20: f7fa        fd9c 	bl	0xe85c
@   0x08013d24: f7fa        fefa 	bl	0xeb1c
@   0x08013d28: f7ff        ff14 	bl	0x13b54
@   0x08013d2c: 2003        movs	r0, #3
@   0x08013d2e: f7fb        fa8d 	bl	0xf24c
@   0x08013d32: 2003        movs	r0, #3
@   0x08013d34: f7fa        ff52 	bl	0xebdc
@   0x08013d38: f7fe        ffb8 	bl	0x12cac
@   0x08013d3c: f002        fe80 	bl	0x16a40
@   0x08013d40: bc01        pop	{r0}
@   0x08013d42: 4700        bx	r0

        thumb_func_start sub_08013D1C
sub_08013D1C: @ 0x08013d1c
        .incbin "frog_us_baserom.gba", 0x13d1c, 0x28
        thumb_func_end sub_08013D1C
