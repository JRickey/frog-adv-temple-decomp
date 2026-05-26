@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800f2f8, 0x0800fcc8)  (0x9d0 bytes)
@
@ Pre-peel chunk before sub_0800FCC8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800f2f8
        .type   text_0800f2f8, %object
text_0800f2f8:
        .incbin "frog_us_baserom.gba", 0x0000f2f8, 0x000009d0
        .size   text_0800f2f8, . - text_0800f2f8
