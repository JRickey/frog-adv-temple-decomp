@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801e1ac, 0x0801e28c)  (0xe0 bytes)
@
@ Post-peel chunk after sub_0801E118.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801e1ac
        .type   text_0801e1ac, %object
text_0801e1ac:
        .incbin "frog_us_baserom.gba", 0x0001e1ac, 0x000000e0
        .size   text_0801e1ac, . - text_0801e1ac
