@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08010dd8, 0x0801129c)  (0x4c4 bytes)
@
@ Post-peel chunk after sub_08010A44.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08010dd8
        .type   text_08010dd8, %object
text_08010dd8:
        .incbin "frog_us_baserom.gba", 0x00010dd8, 0x000004c4
        .size   text_08010dd8, . - text_08010dd8
