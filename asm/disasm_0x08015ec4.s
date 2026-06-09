@ Peeled from the text_0x08015ec4 raw bucket (pre-Mode4_BlitRect chunk), which
@ held FOUR functions. The first two (EC4/F9C) are the tilemap-blit helpers
@ called by src/engine/sub_08017bfc.c; peeling them gives real Thumb symbols so
@ that file no longer needs `.thumb_set` aliases. sub_08016074/sub_0801616C are
@ the remaining two functions in the bucket (boundaries verified by epilogue
@ scan — the earlier detect-fn-boundary over-shot and folded all three tail
@ functions into the F9C symbol).

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08015EC4
sub_08015EC4: @ 0x08015ec4
        .incbin "frog_us_baserom.gba", 0x15ec4, 0xd8
        thumb_func_end sub_08015EC4

        thumb_func_start sub_08015F9C
sub_08015F9C: @ 0x08015f9c
        .incbin "frog_us_baserom.gba", 0x15f9c, 0xd8
        thumb_func_end sub_08015F9C

        thumb_func_start sub_08016074
sub_08016074: @ 0x08016074
        .incbin "frog_us_baserom.gba", 0x16074, 0xf8
        thumb_func_end sub_08016074

        thumb_func_start sub_0801616C
sub_0801616C: @ 0x0801616c
        .incbin "frog_us_baserom.gba", 0x1616c, 0xb0
        thumb_func_end sub_0801616C
