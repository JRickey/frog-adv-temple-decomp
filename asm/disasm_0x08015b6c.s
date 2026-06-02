        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08015B6C
sub_08015B6C: @ 0x08015b6c
        .incbin "frog_us_baserom.gba", 0x15b6c, 0xb8
        thumb_func_end sub_08015B6C
