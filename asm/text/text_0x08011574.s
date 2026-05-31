@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011574, 0x080115f8)  (0x84 bytes)
@
@ Pre-peel chunk before sub_080115F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011574
        .type   text_08011574, %object
text_08011574:
        .incbin "frog_us_baserom.gba", 0x00011574, 0x00000084
        .size   text_08011574, . - text_08011574
