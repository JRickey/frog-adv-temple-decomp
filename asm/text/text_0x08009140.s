@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08009140, 0x08009188)  (0x48 bytes)
@
@ Post-peel chunk after sub_080090FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08009140
        .type   text_08009140, %object
text_08009140:
        .incbin "frog_us_baserom.gba", 0x00009140, 0x00000048
        .size   text_08009140, . - text_08009140
