@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801f418, 0x08020000)  (0xbe8 bytes)
@
@ Post-peel chunk after sub_0801F1E0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801f418
        .type   text_0801f418, %object
text_0801f418:
        .incbin "frog_us_baserom.gba", 0x0001f418, 0x00000be8
        .size   text_0801f418, . - text_0801f418
