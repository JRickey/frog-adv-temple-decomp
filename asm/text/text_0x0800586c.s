@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800586c, 0x0800793c)  (0x20d0 bytes)
@
@ Pre-peel chunk before sub_0800793C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800586c
        .type   text_0800586c, %object
text_0800586c:
        .incbin "frog_us_baserom.gba", 0x0000586c, 0x000020d0
        .size   text_0800586c, . - text_0800586c
