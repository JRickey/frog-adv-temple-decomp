@ Auto-emitted by manual_peel.sh — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08003b40, 0x08003ca8)  (0x168 bytes)
@
@ Pre-peel chunk before sub_08003ca8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08003b40
        .type   text_08003b40, %object
text_08003b40:
        .incbin "frog_us_baserom.gba", 0x3b40, 0x00000168
        .size   text_08003b40, . - text_08003b40
