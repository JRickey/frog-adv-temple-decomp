@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080181d0, 0x0801932c)  (0x115c bytes)
@
@ Post-peel chunk after sub_08017F00.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080181d0
        .type   text_080181d0, %object
text_080181d0:
        .incbin "frog_us_baserom.gba", 0x000181d0, 0x0000115c
        .size   text_080181d0, . - text_080181d0
