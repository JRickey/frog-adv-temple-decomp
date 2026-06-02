        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08019EF0
sub_08019EF0: @ 0x08019ef0
        .incbin "frog_us_baserom.gba", 0x19ef0, 0xe8
        thumb_func_end sub_08019EF0
