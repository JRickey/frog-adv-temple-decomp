    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080264b8
text_080264b8: @ 0x080264b8
    .incbin "baserom.gba", 0x264b8, 0x3e38
    thumb_func_end text_080264b8
