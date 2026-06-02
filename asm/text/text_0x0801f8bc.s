@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801f8bc, 0x08020000)  (0x744 bytes)
@
@ Post-peel chunk after sub_0801F684.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801f8bc
        .type   text_0801f8bc, %object
text_0801f8bc:
        .incbin "frog_us_baserom.gba", 0x0001f8bc, 0x00000744
        .size   text_0801f8bc, . - text_0801f8bc
