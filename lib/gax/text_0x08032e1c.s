        .include "asm/macros.inc"
        .syntax unified

        .global text_08032e1c
        .global SoundIrqEnable_ARM
        .type   SoundIrqEnable_ARM, %function
SoundIrqEnable_ARM:
text_08032e1c:
        .incbin "frog_us_baserom.gba", 0x32e1c, 0x1c
        .global SoundIrqDisable_ARM
        .type   SoundIrqDisable_ARM, %function
SoundIrqDisable_ARM:
        .incbin "frog_us_baserom.gba", 0x32e38, 0xa70
