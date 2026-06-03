@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080234e8, 0x0802a394)  (0x6eac bytes)
@
@ Post-peel chunk after sub_0802349C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080234e8
        .type   text_080234e8, %object
text_080234e8:
        .incbin "frog_us_baserom.gba", 0x000234e8, 0x00006eac
        .size   text_080234e8, . - text_080234e8
