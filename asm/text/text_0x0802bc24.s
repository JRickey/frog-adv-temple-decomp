@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802bc24, 0x0802bc94)  (0x70 bytes)
@
@ Pre-peel chunk before sub_0802BC94.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802bc24
        .type   text_0802bc24, %object
text_0802bc24:
        .incbin "frog_us_baserom.gba", 0x0002bc24, 0x00000070
        .size   text_0802bc24, . - text_0802bc24
