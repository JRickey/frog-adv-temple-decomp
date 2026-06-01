@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080168a0, 0x08016a40)  (0x1a0 bytes)
@
@ Post-peel chunk after sub_08016824.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080168a0
        .type   text_080168a0, %object
text_080168a0:
        .incbin "frog_us_baserom.gba", 0x000168a0, 0x000001a0
        .size   text_080168a0, . - text_080168a0
