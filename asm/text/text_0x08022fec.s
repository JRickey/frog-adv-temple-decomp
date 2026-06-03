@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022fec, 0x0802a394)  (0x73a8 bytes)
@
@ Post-peel chunk after sub_08022F4C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022fec
        .type   text_08022fec, %object
text_08022fec:
        .incbin "frog_us_baserom.gba", 0x00022fec, 0x000073a8
        .size   text_08022fec, . - text_08022fec
