        .include "asm/macros.inc"
        .syntax unified

        .section .text

        .align 2
        .incbin "baserom.gba", 0x2afc0, 0x38
