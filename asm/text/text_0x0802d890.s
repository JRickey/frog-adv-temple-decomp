@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d890, 0x0802d8f8)  (0x68 bytes)
@
@ Pre-peel chunk before sub_0802E3F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d890
        .type   text_0802d890, %object
text_0802d890:
        .incbin "frog_us_baserom.gba", 0x0002d890, 0x00000068
        .size   text_0802d890, . - text_0802d890
