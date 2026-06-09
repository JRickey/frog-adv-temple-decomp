@ Tail of the old text_0x08015ec4 bucket — the two functions after the
@ EC4/F9C blit helpers (now decompiled NON_MATCHING/NAKED in
@ src/engine/sub_08015ec4.c). Boundaries from epilogue scan.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08016074
sub_08016074: @ 0x08016074
        .incbin "frog_us_baserom.gba", 0x16074, 0xf8
        thumb_func_end sub_08016074

        thumb_func_start sub_0801616C
sub_0801616C: @ 0x0801616c
        .incbin "frog_us_baserom.gba", 0x1616c, 0xb0
        thumb_func_end sub_0801616C
