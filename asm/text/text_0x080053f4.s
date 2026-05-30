@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080053f4, 0x080054a8)  (0xb4 bytes)
@
@ Post-peel chunk after sub_080053A4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080053f4
        .type   text_080053f4, %object
text_080053f4:
        .incbin "frog_us_baserom.gba", 0x000053f4, 0x000000b4
        .size   text_080053f4, . - text_080053f4
