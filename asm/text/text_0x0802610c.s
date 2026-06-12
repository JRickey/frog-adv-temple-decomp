    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_0802610c
text_0802610c: @ 0x0802610c
    .incbin "baserom.gba", 0x2610c, 0x41e4
    thumb_func_end text_0802610c
