@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080231f4, 0x0802a394)  (0x71a0 bytes)
@
@ Post-peel chunk after sub_08022FEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080231f4
        .type   text_080231f4, %object
text_080231f4:
        .incbin "frog_us_baserom.gba", 0x000231f4, 0x000071a0
        .size   text_080231f4, . - text_080231f4
