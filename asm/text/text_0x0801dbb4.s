@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801dbb4, 0x0801e118)  (0x564 bytes)
@
@ Pre-peel chunk before sub_0801E118.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801dbb4
        .type   text_0801dbb4, %object
text_0801dbb4:
        .incbin "frog_us_baserom.gba", 0x0001dbb4, 0x00000564
        .size   text_0801dbb4, . - text_0801dbb4
