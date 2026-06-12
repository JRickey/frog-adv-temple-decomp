    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026290
text_08026290: @ 0x08026290
    .incbin "baserom.gba", 0x26290, 0x4060
    thumb_func_end text_08026290
