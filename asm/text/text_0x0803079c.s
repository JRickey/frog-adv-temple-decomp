@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0803079c, 0x080315d8)  (0xe3c bytes)
@
@ Post-peel chunk after sub_08030644.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0803079c
        .type   text_0803079c, %object
text_0803079c:
        .incbin "frog_us_baserom.gba", 0x0003079c, 0x00000e3c
        .size   text_0803079c, . - text_0803079c
