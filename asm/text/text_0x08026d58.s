    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026d58
text_08026d58: @ 0x08026d58
    .incbin "baserom.gba", 0x26d58, 0x3598
    thumb_func_end text_08026d58
