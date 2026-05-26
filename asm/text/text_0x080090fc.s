@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080090fc, 0x08009188)  (0x8c bytes)
@
@ Post-peel chunk after sub_080090B0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080090fc
        .type   text_080090fc, %object
text_080090fc:
        .incbin "frog_us_baserom.gba", 0x000090fc, 0x0000008c
        .size   text_080090fc, . - text_080090fc
