@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800da10, 0x0800dc50)  (0x240 bytes)
@
@ Post-peel chunk after sub_0800D9FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800da10
        .type   text_0800da10, %object
text_0800da10:
        .incbin "frog_us_baserom.gba", 0x0000da10, 0x00000240
        .size   text_0800da10, . - text_0800da10
