@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022bb0, 0x0802a394)  (0x77e4 bytes)
@
@ Post-peel chunk after sub_08022B90.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022bb0
        .type   text_08022bb0, %object
text_08022bb0:
        .incbin "frog_us_baserom.gba", 0x00022bb0, 0x000077e4
        .size   text_08022bb0, . - text_08022bb0
