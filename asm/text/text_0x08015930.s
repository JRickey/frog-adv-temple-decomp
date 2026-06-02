@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08015930, 0x080159b0)  (0x80 bytes)
@
@ Post-peel chunk after sub_0801585C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801436c_b
        .type   text_0801436c_b, %object
text_0801436c_b:
        .incbin "frog_us_baserom.gba", 0x00015930, 0x00000080
        .size   text_0801436c_b, . - text_0801436c_b
