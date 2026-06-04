@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080342f8, 0x08034760)  (0x468 bytes)
@
@ Post-peel chunk after sub_080342CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080342f8
        .type   text_080342f8, %object
text_080342f8:
        .incbin "frog_us_baserom.gba", 0x000342f8, 0x00000468
        .size   text_080342f8, . - text_080342f8
