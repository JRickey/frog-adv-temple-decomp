@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080232cc, 0x0802a394)  (0x70c8 bytes)
@
@ Post-peel chunk after sub_08023244.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080232cc
        .type   text_080232cc, %object
text_080232cc:
        .incbin "frog_us_baserom.gba", 0x000232cc, 0x000070c8
        .size   text_080232cc, . - text_080232cc
