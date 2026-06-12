    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026a98
text_08026a98: @ 0x08026a98
    .incbin "baserom.gba", 0x26a98, 0x3858
    thumb_func_end text_08026a98
