        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0802EBF8
sub_0802EBF8: @ 0x0802ebf8
        .incbin "frog_us_baserom.gba", 0x2ebf8, 0x84
        thumb_func_end sub_0802EBF8
