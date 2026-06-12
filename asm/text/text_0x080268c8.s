    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080268c8
text_080268c8: @ 0x080268c8
    .incbin "baserom.gba", 0x268c8, 0x3a28
    thumb_func_end text_080268c8
