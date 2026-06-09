@ Peeled from the text_0x0801629c raw bucket (post-Mode4_BlitRect chunk).
@ Two tilemap-blit helpers called by src/engine/sub_08017bfc.c; peeling them
@ gives real Thumb symbols so that file no longer needs `.thumb_set` aliases.

        .include "asm/macros.inc"
        .syntax unified

        thumb_func_start sub_0801629C
sub_0801629C: @ 0x0801629c
        .incbin "frog_us_baserom.gba", 0x1629c, 0x60
        thumb_func_end sub_0801629C

        thumb_func_start sub_080162FC
sub_080162FC: @ 0x080162fc
        .incbin "frog_us_baserom.gba", 0x162fc, 0x64
        thumb_func_end sub_080162FC
