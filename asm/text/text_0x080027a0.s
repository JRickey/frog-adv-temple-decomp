@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080027a0, 0x08002844)  (0xa4 bytes)
@
@ Post-peel chunk after sub_0800276C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080027a0
        .type   text_080027a0, %object
text_080027a0:
        .incbin "frog_us_baserom.gba", 0x000027a0, 0x000000a4
        .size   text_080027a0, . - text_080027a0
