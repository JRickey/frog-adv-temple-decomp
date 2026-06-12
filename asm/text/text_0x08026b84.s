    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026b84
text_08026b84: @ 0x08026b84
    .incbin "baserom.gba", 0x26b84, 0x376c
    thumb_func_end text_08026b84
