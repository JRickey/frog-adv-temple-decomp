@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080179b8, 0x08019500)  (0x1b48 bytes)
@
@ Post-peel chunk after sub_0801793C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080179b8
        .type   text_080179b8, %object
text_080179b8:
        .incbin "frog_us_baserom.gba", 0x000179b8, 0x00001b48
        .size   text_080179b8, . - text_080179b8
