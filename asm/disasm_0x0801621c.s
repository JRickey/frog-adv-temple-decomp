        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0801621C
sub_0801621C: @ 0x0801621c
        .incbin "frog_us_baserom.gba", 0x1621c, 0x80
        thumb_func_end sub_0801621C
