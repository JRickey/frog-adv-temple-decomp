@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800df9c, 0x0800e060)  (0xc4 bytes)
@
@ Post-peel chunk after sub_0800DF7C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800df9c
        .type   text_0800df9c, %object
text_0800df9c:
        .incbin "frog_us_baserom.gba", 0x0000df9c, 0x000000c4
        .size   text_0800df9c, . - text_0800df9c
