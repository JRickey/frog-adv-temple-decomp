    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026d34
text_08026d34: @ 0x08026d34
    .incbin "baserom.gba", 0x26d34, 0x35bc
    thumb_func_end text_08026d34
