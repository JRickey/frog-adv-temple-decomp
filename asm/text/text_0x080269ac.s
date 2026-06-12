    .include "asm/macros.inc"
    .syntax unified

    .section .text

    .align 2

    thumb_func_start text_080269ac
text_080269ac: @ 0x080269ac
    .incbin "baserom.gba", 0x269ac, 0x3944
    thumb_func_end text_080269ac
