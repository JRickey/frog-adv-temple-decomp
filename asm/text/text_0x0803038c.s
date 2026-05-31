@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0803038c, 0x080315d8)  (0x124c bytes)
@
@ Post-peel chunk after sub_08030290.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0803038c
        .type   text_0803038c, %object
text_0803038c:
        .incbin "frog_us_baserom.gba", 0x0003038c, 0x0000124c
        .size   text_0803038c, . - text_0803038c
