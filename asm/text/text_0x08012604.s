@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012604, 0x08012664)  (0x60 bytes)
@
@ Post-peel chunk after sub_08012588.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012604
        .type   text_08012604, %object
text_08012604:
        .incbin "frog_us_baserom.gba", 0x00012604, 0x00000060
        .size   text_08012604, . - text_08012604
