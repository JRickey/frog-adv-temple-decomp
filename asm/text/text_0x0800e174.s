@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800e174, 0x0800e600)  (0x48c bytes)
@
@ Pre-peel chunk before sub_0800E600.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800e174
        .type   text_0800e174, %object
text_0800e174:
        .incbin "frog_us_baserom.gba", 0x0000e174, 0x0000048c
        .size   text_0800e174, . - text_0800e174
