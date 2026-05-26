@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08016650, 0x08016a40)  (0x3f0 bytes)
@
@ Pre-peel chunk before sub_08016A40.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08016650
        .type   text_08016650, %object
text_08016650:
        .incbin "frog_us_baserom.gba", 0x00016650, 0x000003f0
        .size   text_08016650, . - text_08016650
