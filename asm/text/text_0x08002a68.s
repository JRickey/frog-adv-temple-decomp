@ Auto-emitted by manual_peel.sh — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002a68, 0x08002b58)  (0xf0 bytes)
@
@ Pre-peel chunk before sub_08002b58.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002a68
        .type   text_08002a68, %object
text_08002a68:
        .incbin "frog_us_baserom.gba", 0x2a68, 0x000000f0
        .size   text_08002a68, . - text_08002a68
