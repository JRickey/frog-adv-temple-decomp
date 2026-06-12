    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080262f4
text_080262f4: @ 0x080262f4
    .incbin "baserom.gba", 0x262f4, 0x3ffc
    thumb_func_end text_080262f4
