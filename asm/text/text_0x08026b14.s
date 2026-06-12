    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026b14
text_08026b14: @ 0x08026b14
    .incbin "baserom.gba", 0x26b14, 0x37dc
    thumb_func_end text_08026b14
