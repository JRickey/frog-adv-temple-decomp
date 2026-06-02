        .include "asm/macros.inc"
        .syntax unified

        .global text_080316fc
text_080316fc:
        .incbin "frog_us_baserom.gba", 0x316fc, 0x24
