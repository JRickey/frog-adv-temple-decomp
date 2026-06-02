        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08022DDC
sub_08022DDC: @ 0x08022ddc
        .incbin "frog_us_baserom.gba", 0x22ddc, 0xcc
        thumb_func_end sub_08022DDC
