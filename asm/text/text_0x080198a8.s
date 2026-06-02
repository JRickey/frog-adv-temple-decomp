@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080198a8, 0x08019964)  (0xbc bytes)
@
@ Post-peel chunk after sub_08019834.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080198a8
        .type   text_080198a8, %object
text_080198a8:
        .incbin "frog_us_baserom.gba", 0x000198a8, 0x000000bc
        .size   text_080198a8, . - text_080198a8
