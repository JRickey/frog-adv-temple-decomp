@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800696c, 0x08006adc)  (0x170 bytes)
@
@ Pre-peel chunk before sub_08006ADC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800696c
        .type   text_0800696c, %object
text_0800696c:
        .incbin "frog_us_baserom.gba", 0x0000696c, 0x00000170
        .size   text_0800696c, . - text_0800696c
