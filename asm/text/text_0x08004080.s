@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004080, 0x0800411c)  (0x9c bytes)
@
@ Pre-peel chunk before sub_0800411C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004080
        .type   text_08004080, %object
text_08004080:
        .incbin "frog_us_baserom.gba", 0x00004080, 0x0000009c
        .size   text_08004080, . - text_08004080
