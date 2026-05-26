@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800441c, 0x08004938)  (0x51c bytes)
@
@ Pre-peel chunk before sub_08004938.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800441c
        .type   text_0800441c, %object
text_0800441c:
        .incbin "frog_us_baserom.gba", 0x0000441c, 0x0000051c
        .size   text_0800441c, . - text_0800441c
