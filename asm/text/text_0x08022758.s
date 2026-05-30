@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022758, 0x0802ab64)  (0x840c bytes)
@
@ Post-peel chunk after sub_08022730.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022758
        .type   text_08022758, %object
text_08022758:
        .incbin "frog_us_baserom.gba", 0x00022758, 0x0000840c
        .size   text_08022758, . - text_08022758
