@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08035730, 0x0803578c)  (0x5c bytes)
@
@ Post-peel chunk after sub_08035708.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08035730
        .type   text_08035730, %object
text_08035730:
        .incbin "frog_us_baserom.gba", 0x00035730, 0x0000005c
        .size   text_08035730, . - text_08035730
