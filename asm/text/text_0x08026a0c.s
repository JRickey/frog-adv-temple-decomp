    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026a0c
text_08026a0c: @ 0x08026a0c
    .incbin "baserom.gba", 0x26a0c, 0x38e4
    thumb_func_end text_08026a0c
