@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002adc, 0x08002ae8)  (0xc bytes)
@
@ Post-peel chunk after sub_08002AC4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002adc
        .type   text_08002adc, %object
text_08002adc:
        .incbin "frog_us_baserom.gba", 0x00002adc, 0x0000000c
        .size   text_08002adc, . - text_08002adc
