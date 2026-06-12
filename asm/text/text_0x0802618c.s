    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_0802618c
text_0802618c: @ 0x0802618c
    .incbin "baserom.gba", 0x2618c, 0x4164
    thumb_func_end text_0802618c
