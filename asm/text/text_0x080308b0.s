@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080308b0, 0x080315d8)  (0xd28 bytes)
@
@ Post-peel chunk after sub_0803079C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080308b0
        .type   text_080308b0, %object
text_080308b0:
        .incbin "frog_us_baserom.gba", 0x000308b0, 0x00000d28
        .size   text_080308b0, . - text_080308b0
