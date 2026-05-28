@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012b78, 0x08012bc4)  (0x4c bytes)
@
@ Pre-peel chunk before sub_08012BC4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012b78
        .type   text_08012b78, %object
text_08012b78:
        .incbin "frog_us_baserom.gba", 0x00012b78, 0x0000004c
        .size   text_08012b78, . - text_08012b78
