    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080261f8
text_080261f8: @ 0x080261f8
    .incbin "baserom.gba", 0x261f8, 0x40f8
    thumb_func_end text_080261f8
