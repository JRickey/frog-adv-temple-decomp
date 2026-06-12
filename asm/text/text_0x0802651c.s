    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_0802651c
text_0802651c: @ 0x0802651c
    .incbin "baserom.gba", 0x2651c, 0x3dd4
    thumb_func_end text_0802651c
