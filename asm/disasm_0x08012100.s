        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08012100
sub_08012100: @ 0x08012100
        .incbin "frog_us_baserom.gba", 0x12100, 0x80
        thumb_func_end sub_08012100
