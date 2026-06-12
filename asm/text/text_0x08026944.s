    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026944
text_08026944: @ 0x08026944
    .incbin "baserom.gba", 0x26944, 0x39ac
    thumb_func_end text_08026944
