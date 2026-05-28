@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012a6c, 0x08012b38)  (0xcc bytes)
@
@ Post-peel chunk after sub_0801297C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012a6c
        .type   text_08012a6c, %object
text_08012a6c:
        .incbin "frog_us_baserom.gba", 0x00012a6c, 0x000000cc
        .size   text_08012a6c, . - text_08012a6c
