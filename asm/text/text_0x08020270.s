@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020270, 0x080202a8)  (0x38 bytes)
@
@ Pre-peel chunk before sub_080202A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020270
        .type   text_08020270, %object
text_08020270:
        .incbin "frog_us_baserom.gba", 0x00020270, 0x00000038
        .size   text_08020270, . - text_08020270
