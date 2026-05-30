@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019fd8, 0x0801a268)  (0x290 bytes)
@
@ Post-peel chunk after sub_08019EF0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019fd8
        .type   text_08019fd8, %object
text_08019fd8:
        .incbin "frog_us_baserom.gba", 0x00019fd8, 0x00000290
        .size   text_08019fd8, . - text_08019fd8
