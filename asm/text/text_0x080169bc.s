@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080169bc, 0x08016a40)  (0x84 bytes)
@
@ Post-peel chunk after sub_08016928.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080169bc
        .type   text_080169bc, %object
text_080169bc:
        .incbin "frog_us_baserom.gba", 0x000169bc, 0x00000084
        .size   text_080169bc, . - text_080169bc
