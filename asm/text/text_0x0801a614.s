@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801a614, 0x0801bb54)  (0x1540 bytes)
@
@ Pre-peel chunk before sub_0801BB54.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801a614
        .type   text_0801a614, %object
text_0801a614:
        .incbin "frog_us_baserom.gba", 0x0001a614, 0x00001540
        .size   text_0801a614, . - text_0801a614
