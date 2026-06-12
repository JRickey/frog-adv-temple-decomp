    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080265d4
text_080265d4: @ 0x080265d4
    .incbin "baserom.gba", 0x265d4, 0x3d1c
    thumb_func_end text_080265d4
