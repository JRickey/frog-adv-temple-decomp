    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026454
text_08026454: @ 0x08026454
    .incbin "baserom.gba", 0x26454, 0x3e9c
    thumb_func_end text_08026454
