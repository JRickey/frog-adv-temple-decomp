@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080113e8, 0x08012664)  (0x127c bytes)
@
@ Post-peel chunk after sub_080112C0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080113e8
        .type   text_080113e8, %object
text_080113e8:
        .incbin "frog_us_baserom.gba", 0x000113e8, 0x0000127c
        .size   text_080113e8, . - text_080113e8
