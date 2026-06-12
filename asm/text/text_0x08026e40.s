    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026e40
text_08026e40: @ 0x08026e40
    .incbin "baserom.gba", 0x26e40, 0x34b0
    thumb_func_end text_08026e40
