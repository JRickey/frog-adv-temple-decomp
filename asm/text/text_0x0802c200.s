@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802c200, 0x0802c7ec)  (0x5ec bytes)
@
@ Post-peel chunk after sub_0802C000.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802c200
        .type   text_0802c200, %object
text_0802c200:
        .incbin "frog_us_baserom.gba", 0x0002c200, 0x000005ec
        .size   text_0802c200, . - text_0802c200
