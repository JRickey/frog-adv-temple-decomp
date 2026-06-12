    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026ad0
text_08026ad0: @ 0x08026ad0
    .incbin "baserom.gba", 0x26ad0, 0x3820
    thumb_func_end text_08026ad0
