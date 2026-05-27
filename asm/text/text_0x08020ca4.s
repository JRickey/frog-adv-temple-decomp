@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020ca4, 0x08020e98)  (0x1f4 bytes)
@
@ Pre-peel chunk before sub_08020E98.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020ca4
        .type   text_08020ca4, %object
text_08020ca4:
        .incbin "frog_us_baserom.gba", 0x00020ca4, 0x000001f4
        .size   text_08020ca4, . - text_08020ca4
