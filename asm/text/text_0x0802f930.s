@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802f930, 0x0802f9f0)  (0xc0 bytes)
@
@ Post-peel chunk after sub_0802F8F0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802f930
        .type   text_0802f930, %object
text_0802f930:
        .incbin "frog_us_baserom.gba", 0x0002f930, 0x000000c0
        .size   text_0802f930, . - text_0802f930
