@ Auto-emitted by peeling sub_08025240 — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08025264, 0x0802a2f0)  (0x508c bytes)
@
@ Post-peel chunk after sub_08025240.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08025264
        .type   text_08025264, %object
text_08025264:
        .incbin "frog_us_baserom.gba", 0x00025264, 0x0000508c
        .size   text_08025264, . - text_08025264
