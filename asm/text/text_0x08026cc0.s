    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026cc0
text_08026cc0: @ 0x08026cc0
    .incbin "baserom.gba", 0x26cc0, 0x3630
    thumb_func_end text_08026cc0
