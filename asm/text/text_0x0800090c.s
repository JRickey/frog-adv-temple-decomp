@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800090c, 0x08000918)  (0xc bytes)
@
@ Pre-peel chunk before sub_08000918.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800090c
        .type   text_0800090c, %object
text_0800090c:
        .incbin "frog_us_baserom.gba", 0x0000090c, 0x0000000c
        .size   text_0800090c, . - text_0800090c
