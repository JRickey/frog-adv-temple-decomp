@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080229cc, 0x0802ab64)  (0x8198 bytes)
@
@ Post-peel chunk after sub_080229A4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080229cc
        .type   text_080229cc, %object
text_080229cc:
        .incbin "frog_us_baserom.gba", 0x000229cc, 0x00008198
        .size   text_080229cc, . - text_080229cc
