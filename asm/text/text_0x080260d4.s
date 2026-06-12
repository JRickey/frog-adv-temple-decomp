    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080260d4
text_080260d4: @ 0x080260d4
    .incbin "baserom.gba", 0x260d4, 0x421c
    thumb_func_end text_080260d4
