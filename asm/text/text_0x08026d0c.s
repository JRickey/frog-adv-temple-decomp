    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026d0c
text_08026d0c: @ 0x08026d0c
    .incbin "baserom.gba", 0x26d0c, 0x35e4
    thumb_func_end text_08026d0c
