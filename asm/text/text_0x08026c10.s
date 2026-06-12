    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026c10
text_08026c10: @ 0x08026c10
    .incbin "baserom.gba", 0x26c10, 0x36e0
    thumb_func_end text_08026c10
