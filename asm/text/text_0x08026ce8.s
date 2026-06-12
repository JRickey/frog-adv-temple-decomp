    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_08026ce8
text_08026ce8: @ 0x08026ce8
    .incbin "baserom.gba", 0x26ce8, 0x24
    thumb_func_end text_08026ce8
