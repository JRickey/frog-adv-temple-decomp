@ Peeled from the text_0x08015ec4 raw bucket (pre-Mode4_BlitRect chunk).
@ Two tilemap-blit helpers called by src/engine/sub_08017bfc.c; peeling them
@ gives real Thumb symbols so that file no longer needs `.thumb_set` aliases.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_08015EC4
sub_08015EC4: @ 0x08015ec4
        .incbin "frog_us_baserom.gba", 0x15ec4, 0xd8
        thumb_func_end sub_08015EC4

        thumb_func_start sub_08015F9C
sub_08015F9C: @ 0x08015f9c
        .incbin "frog_us_baserom.gba", 0x15f9c, 0x280
        thumb_func_end sub_08015F9C
