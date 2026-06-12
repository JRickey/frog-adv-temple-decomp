    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_0802626c
text_0802626c: @ 0x0802626c
    .incbin "baserom.gba", 0x2626c, 0x4084
    thumb_func_end text_0802626c
