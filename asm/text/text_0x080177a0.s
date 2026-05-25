@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080177a0, 0x08020000)  (0x8860 bytes)
@
@ Post-peel chunk after sub_08017364.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080177a0
        .type   text_080177a0, %object
text_080177a0:
        .incbin "frog_us_baserom.gba", 0x000177a0, 0x00008860
        .size   text_080177a0, . - text_080177a0
