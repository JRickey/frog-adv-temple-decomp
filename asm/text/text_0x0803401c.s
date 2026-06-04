@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0803401c, 0x080342cc)  (0x2b0 bytes)
@
@ Pre-peel chunk before sub_080342CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0803401c
        .type   text_0803401c, %object
text_0803401c:
        .incbin "frog_us_baserom.gba", 0x0003401c, 0x000002b0
        .size   text_0803401c, . - text_0803401c
