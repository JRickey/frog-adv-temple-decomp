    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_0802690c
text_0802690c: @ 0x0802690c
    .incbin "baserom.gba", 0x2690c, 0x39e4
    thumb_func_end text_0802690c
