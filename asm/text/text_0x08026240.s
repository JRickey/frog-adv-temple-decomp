    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026240
text_08026240: @ 0x08026240
    .incbin "baserom.gba", 0x26240, 0x40b0
    thumb_func_end text_08026240
