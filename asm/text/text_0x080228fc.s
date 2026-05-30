@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080228fc, 0x0802ab64)  (0x8268 bytes)
@
@ Post-peel chunk after sub_080228D0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080228fc
        .type   text_080228fc, %object
text_080228fc:
        .incbin "frog_us_baserom.gba", 0x000228fc, 0x00008268
        .size   text_080228fc, . - text_080228fc
