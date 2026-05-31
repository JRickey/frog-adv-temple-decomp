@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802a63c, 0x0802a8fc)  (0x2c0 bytes)
@
@ Post-peel chunk after sub_0802A538.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802a63c
        .type   text_0802a63c, %object
text_0802a63c:
        .incbin "frog_us_baserom.gba", 0x0002a63c, 0x000002c0
        .size   text_0802a63c, . - text_0802a63c
