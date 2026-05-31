@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801f1e0, 0x08020000)  (0xe20 bytes)
@
@ Post-peel chunk after sub_0801EA08.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801f1e0
        .type   text_0801f1e0, %object
text_0801f1e0:
        .incbin "frog_us_baserom.gba", 0x0001f1e0, 0x00000e20
        .size   text_0801f1e0, . - text_0801f1e0
