@ Remaining slice after peeling sub_080122E4 into src/engine/sub_0801223c.c
@ Range:  [0x080124d0, 0x0801254c)

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_080124D0
sub_080124D0: @ 0x080124d0
        .incbin "frog_us_baserom.gba", 0x124d0, 0x34
        thumb_func_end sub_080124D0

        thumb_func_start sub_08012504
sub_08012504: @ 0x08012504
        .incbin "frog_us_baserom.gba", 0x12504, 0x48
        thumb_func_end sub_08012504
