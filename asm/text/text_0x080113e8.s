@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080113e8, 0x0801185c)  (0x474 bytes)
@
@ Pre-peel chunk before sub_0801185C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080113e8
        .type   text_080113e8, %object
text_080113e8:
        .incbin "frog_us_baserom.gba", 0x000113e8, 0x00000474
        .size   text_080113e8, . - text_080113e8
