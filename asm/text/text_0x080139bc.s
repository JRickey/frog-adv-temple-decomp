@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080139bc, 0x08013c60)  (0x2a4 bytes)
@
@ Post-peel chunk after sub_08013980.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080139bc
        .type   text_080139bc, %object
text_080139bc:
        .incbin "frog_us_baserom.gba", 0x000139bc, 0x000002a4
        .size   text_080139bc, . - text_080139bc
