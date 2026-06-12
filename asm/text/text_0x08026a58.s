    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026a58
text_08026a58: @ 0x08026a58
    .incbin "baserom.gba", 0x26a58, 0x3898
    thumb_func_end text_08026a58
