@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080229a4, 0x0802ab64)  (0x81c0 bytes)
@
@ Post-peel chunk after sub_08022980.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080229a4
        .type   text_080229a4, %object
text_080229a4:
        .incbin "frog_us_baserom.gba", 0x000229a4, 0x000081c0
        .size   text_080229a4, . - text_080229a4
