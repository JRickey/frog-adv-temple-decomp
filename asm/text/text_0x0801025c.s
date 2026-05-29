@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801025c, 0x08010694)  (0x438 bytes)
@
@ Post-peel chunk after sub_080100E4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801025c
        .type   text_0801025c, %object
text_0801025c:
        .incbin "frog_us_baserom.gba", 0x0001025c, 0x00000438
        .size   text_0801025c, . - text_0801025c
