@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022958, 0x0802ab64)  (0x820c bytes)
@
@ Post-peel chunk after sub_08022920.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022958
        .type   text_08022958, %object
text_08022958:
        .incbin "frog_us_baserom.gba", 0x00022958, 0x0000820c
        .size   text_08022958, . - text_08022958
