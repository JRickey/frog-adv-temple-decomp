    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026330
text_08026330: @ 0x08026330
    .incbin "baserom.gba", 0x26330, 0x124
    thumb_func_end text_08026330
