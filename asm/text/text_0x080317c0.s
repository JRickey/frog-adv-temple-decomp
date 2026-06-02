        .include "asm/macros.inc"
        .syntax unified

        .global text_080317c0
text_080317c0:
        .incbin "frog_us_baserom.gba", 0x317c0, 0xdc
