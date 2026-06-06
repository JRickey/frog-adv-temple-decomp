        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08021AC8
sub_08021AC8: @ 0x08021ac8
        .incbin "frog_us_baserom.gba", 0x21ac8, 0x234
        thumb_func_end sub_08021AC8
