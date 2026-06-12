    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080269e4
text_080269e4: @ 0x080269e4
    .incbin "baserom.gba", 0x269e4, 0x390c
    thumb_func_end text_080269e4
