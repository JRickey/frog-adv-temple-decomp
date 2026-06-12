    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026dcc
text_08026dcc: @ 0x08026dcc
    .incbin "baserom.gba", 0x26dcc, 0x3524
    thumb_func_end text_08026dcc
