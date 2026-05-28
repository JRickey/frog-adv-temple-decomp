@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08003584, 0x08003668)  (0xe4 bytes)
@
@ Pre-peel chunk before sub_08003668.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08003584
        .type   text_08003584, %object
text_08003584:
        .incbin "frog_us_baserom.gba", 0x00003584, 0x000000e4
        .size   text_08003584, . - text_08003584
