        .include "asm/macros.inc"
        .syntax unified

        .global sub_0802BAF8
        .thumb_func
sub_0802BAF8: @ 0x0802baf8
        .incbin "frog_us_baserom.gba", 0x2baf8, 0x64
