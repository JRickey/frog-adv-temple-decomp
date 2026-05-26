@ Auto-emitted by manual_peel.sh — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004c04, 0x08004fac)  (0x3a8 bytes)
@
@ Pre-peel chunk before sub_08004fac.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004c04
        .type   text_08004c04, %object
text_08004c04:
        .incbin "frog_us_baserom.gba", 0x4c04, 0x000003a8
        .size   text_08004c04, . - text_08004c04
