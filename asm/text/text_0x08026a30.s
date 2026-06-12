    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026a30
text_08026a30: @ 0x08026a30
    .incbin "baserom.gba", 0x26a30, 0x38c0
    thumb_func_end text_08026a30
