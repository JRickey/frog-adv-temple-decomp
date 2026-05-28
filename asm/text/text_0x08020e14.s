@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020e14, 0x08020e7c)  (0x68 bytes)
@
@ Post-peel chunk after sub_08020DC4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020e14
        .type   text_08020e14, %object
text_08020e14:
        .incbin "frog_us_baserom.gba", 0x00020e14, 0x00000068
        .size   text_08020e14, . - text_08020e14
