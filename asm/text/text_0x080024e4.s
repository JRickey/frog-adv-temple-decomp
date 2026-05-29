@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080024e4, 0x08002524)  (0x40 bytes)
@
@ Post-peel chunk after sub_08002484.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080024e4
        .type   text_080024e4, %object
text_080024e4:
        .incbin "frog_us_baserom.gba", 0x000024e4, 0x00000040
        .size   text_080024e4, . - text_080024e4
