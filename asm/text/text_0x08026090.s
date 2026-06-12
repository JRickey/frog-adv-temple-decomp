    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026090
text_08026090: @ 0x08026090
    .incbin "baserom.gba", 0x26090, 0x4260
    thumb_func_end text_08026090
