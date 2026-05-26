@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08005d10, 0x08005fc8)  (0x2b8 bytes)
@
@ Post-peel chunk after sub_080059C4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08005d10
        .type   text_08005d10, %object
text_08005d10:
        .incbin "frog_us_baserom.gba", 0x00005d10, 0x000002b8
        .size   text_08005d10, . - text_08005d10
