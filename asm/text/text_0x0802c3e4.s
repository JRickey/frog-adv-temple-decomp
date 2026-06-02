@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802c3e4, 0x0802c75c)  (0x378 bytes)
@
@ Pre-peel chunk before sub_0802C75C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802c3e4
        .type   text_0802c3e4, %object
text_0802c3e4:
        .incbin "frog_us_baserom.gba", 0x0002c3e4, 0x00000378
        .size   text_0802c3e4, . - text_0802c3e4
