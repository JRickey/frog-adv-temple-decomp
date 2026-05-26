@ Auto-emitted by manual_peel.sh — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002450, 0x08002524)  (0xd4 bytes)
@
@ Pre-peel chunk before sub_08002524.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002450
        .type   text_08002450, %object
text_08002450:
        .incbin "frog_us_baserom.gba", 0x2450, 0x000000d4
        .size   text_08002450, . - text_08002450
