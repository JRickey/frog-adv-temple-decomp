@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080204a0, 0x080204a4)  (0x4 bytes)
@
@ Post-peel chunk after sub_08020414.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080204a0
        .type   text_080204a0, %object
text_080204a0:
        .incbin "frog_us_baserom.gba", 0x000204a0, 0x00000004
        .size   text_080204a0, . - text_080204a0
