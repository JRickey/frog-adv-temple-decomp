        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0801AD10
sub_0801AD10: @ 0x0801ad10
        .incbin "frog_us_baserom.gba", 0x1ad10, 0x98
        thumb_func_end sub_0801AD10
