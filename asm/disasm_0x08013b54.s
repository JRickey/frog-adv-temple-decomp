        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08013B54
sub_08013B54: @ 0x08013b54
        .incbin "frog_us_baserom.gba", 0x13b54, 0x50
        thumb_func_end sub_08013B54
