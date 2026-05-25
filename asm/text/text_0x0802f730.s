@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802f730, 0x08030000)  (0x8d0 bytes)
@
@ Post-peel chunk after sub_0802F4B0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802f730
        .type   text_0802f730, %object
text_0802f730:
        .incbin "frog_us_baserom.gba", 0x0002f730, 0x000008d0
        .size   text_0802f730, . - text_0802f730
