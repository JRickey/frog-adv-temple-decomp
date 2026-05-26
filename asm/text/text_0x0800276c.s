@ Auto-emitted by manual_peel.sh — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800276c, 0x08002844)  (0xd8 bytes)
@
@ Pre-peel chunk before sub_08002844.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800276c
        .type   text_0800276c, %object
text_0800276c:
        .incbin "frog_us_baserom.gba", 0x276c, 0x000000d8
        .size   text_0800276c, . - text_0800276c
