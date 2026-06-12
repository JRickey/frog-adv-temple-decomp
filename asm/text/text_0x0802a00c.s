    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_0802a00c
text_0802a00c: @ 0x0802a00c
    .incbin "baserom.gba", 0x2a00c, 0x38cc
    thumb_func_end text_0802a00c
