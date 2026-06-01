@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08015ea8, 0x08016360)  (0x4b8 bytes)
@
@ Post-peel chunk after sub_08015CBC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08015ea8
        .type   text_08015ea8, %object
text_08015ea8:
        .incbin "frog_us_baserom.gba", 0x00015ea8, 0x000004b8
        .size   text_08015ea8, . - text_08015ea8
