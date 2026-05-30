@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080228d0, 0x0802ab64)  (0x8294 bytes)
@
@ Post-peel chunk after sub_080228AC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080228d0
        .type   text_080228d0, %object
text_080228d0:
        .incbin "frog_us_baserom.gba", 0x000228d0, 0x00008294
        .size   text_080228d0, . - text_080228d0
