@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801cd0c, 0x0801cec0)  (0x1b4 bytes)
@
@ Post-peel chunk after sub_0801C6FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801cd0c
        .type   text_0801cd0c, %object
text_0801cd0c:
        .incbin "frog_us_baserom.gba", 0x0001cd0c, 0x000001b4
        .size   text_0801cd0c, . - text_0801cd0c
