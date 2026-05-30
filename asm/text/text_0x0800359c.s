@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800359c, 0x08003668)  (0xcc bytes)
@
@ Post-peel chunk after sub_08003584.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800359c
        .type   text_0800359c, %object
text_0800359c:
        .incbin "frog_us_baserom.gba", 0x0000359c, 0x000000cc
        .size   text_0800359c, . - text_0800359c
