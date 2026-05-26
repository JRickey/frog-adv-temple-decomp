@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800586c, 0x08009188)  (0x391c bytes)
@
@ Pre-peel chunk before sub_08009188.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800586c
        .type   text_0800586c, %object
text_0800586c:
        .incbin "frog_us_baserom.gba", 0x0000586c, 0x0000391c
        .size   text_0800586c, . - text_0800586c
