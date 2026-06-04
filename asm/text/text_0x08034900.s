@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08034900, 0x0803578c)  (0xe8c bytes)
@
@ Post-peel chunk after sub_08034898.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08034900
        .type   text_08034900, %object
text_08034900:
        .incbin "frog_us_baserom.gba", 0x00034900, 0x00000e8c
        .size   text_08034900, . - text_08034900
