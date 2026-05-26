@ Auto-emitted by manual_peel.sh — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08001d18, 0x08002184)  (0x46c bytes)
@
@ Pre-peel chunk before sub_08002184.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08001d18
        .type   text_08001d18, %object
text_08001d18:
        .incbin "frog_us_baserom.gba", 0x1d18, 0x0000046c
        .size   text_08001d18, . - text_08001d18
