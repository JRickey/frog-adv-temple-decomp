@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080005d8, 0x08000678)  (0xa0 bytes)
@
@ Pre-peel chunk before sub_08000678.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080005d8
        .type   text_080005d8, %object
text_080005d8:
        .incbin "frog_us_baserom.gba", 0x000005d8, 0x000000a0
        .size   text_080005d8, . - text_080005d8
