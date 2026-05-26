@ Auto-emitted by manual_peel.sh — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08001128, 0x08001214)  (0xec bytes)
@
@ Pre-peel chunk before sub_08001214.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08001128
        .type   text_08001128, %object
text_08001128:
        .incbin "frog_us_baserom.gba", 0x1128, 0x000000ec
        .size   text_08001128, . - text_08001128
