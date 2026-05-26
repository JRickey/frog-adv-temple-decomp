@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800586c, 0x080094f8)  (0x3c8c bytes)
@
@ Pre-peel chunk before sub_080094F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800586c
        .type   text_0800586c, %object
text_0800586c:
        .incbin "frog_us_baserom.gba", 0x0000586c, 0x00003c8c
        .size   text_0800586c, . - text_0800586c
