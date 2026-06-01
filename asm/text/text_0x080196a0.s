@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080196a0, 0x08019964)  (0x2c4 bytes)
@
@ Post-peel chunk after sub_08019678.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080196a0
        .type   text_080196a0, %object
text_080196a0:
        .incbin "frog_us_baserom.gba", 0x000196a0, 0x000002c4
        .size   text_080196a0, . - text_080196a0
