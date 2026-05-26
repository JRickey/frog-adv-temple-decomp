@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800df7c, 0x0800e060)  (0xe4 bytes)
@
@ Pre-peel chunk before sub_0800E060.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800df7c
        .type   text_0800df7c, %object
text_0800df7c:
        .incbin "frog_us_baserom.gba", 0x0000df7c, 0x000000e4
        .size   text_0800df7c, . - text_0800df7c
