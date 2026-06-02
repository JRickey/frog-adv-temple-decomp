        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08013D44
sub_08013D44: @ 0x08013d44
        .incbin "frog_us_baserom.gba", 0x13d44, 0xb8
        thumb_func_end sub_08013D44
