        .include "asm/macros.inc"
        .syntax unified

        .global PadGrid_SpawnTypeA
        .thumb_func
PadGrid_SpawnTypeA: @ 0x0802baf8
        .incbin "frog_us_baserom.gba", 0x2baf8, 0x64
