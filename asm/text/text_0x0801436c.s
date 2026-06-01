@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801436c, 0x080159b0)  (0x1644 bytes)
@
@ Post-peel chunk after sub_080142D4.
@ (Shrunk to 0x080159b0 to expose sub_080159B0.)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801436c
        .type   text_0801436c, %object
text_0801436c:
        .incbin "frog_us_baserom.gba", 0x0001436c, 0x00001644
        .size   text_0801436c, . - text_0801436c
