@ Split from asm/disasm_0x080076a4.s so sub_080076A4 can be decompiled.
@ Range:  [0x08007714, 0x080077ac)  (152 bytes, thumb mode)

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08007714
sub_08007714: @ 0x08007714
        .incbin "frog_us_baserom.gba", 0x7714, 0x98
        thumb_func_end sub_08007714
