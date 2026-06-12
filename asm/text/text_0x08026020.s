    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026020
text_08026020: @ 0x08026020
    .incbin "baserom.gba", 0x26020, 0x42d0
    thumb_func_end text_08026020
