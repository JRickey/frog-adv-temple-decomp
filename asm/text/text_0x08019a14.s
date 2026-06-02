@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019a14, 0x08019aec)  (0xd8 bytes)
@
@ Pre-peel chunk shrunk from text_0x08019984 to expose sub_08019984 + sub_080199E4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019a14
        .type   text_08019a14, %object
text_08019a14:
        .incbin "frog_us_baserom.gba", 0x00019a14, 0x000000d8
        .size   text_08019a14, . - text_08019a14
