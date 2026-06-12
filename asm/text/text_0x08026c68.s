    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026c68
text_08026c68: @ 0x08026c68
    .incbin "baserom.gba", 0x26c68, 0x3688
    thumb_func_end text_08026c68
