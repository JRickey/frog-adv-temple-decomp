@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801be7c, 0x0801c464)  (0x5e8 bytes)
@
@ Pre-peel chunk before sub_0801C464.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801be7c
        .type   text_0801be7c, %object
text_0801be7c:
        .incbin "frog_us_baserom.gba", 0x0001be7c, 0x000005e8
        .size   text_0801be7c, . - text_0801be7c
