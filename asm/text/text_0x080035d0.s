@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080035d0, 0x08003668)  (0x98 bytes)
@
@ Post-peel chunk after sub_0800359C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080035d0
        .type   text_080035d0, %object
text_080035d0:
        .incbin "frog_us_baserom.gba", 0x000035d0, 0x00000098
        .size   text_080035d0, . - text_080035d0
