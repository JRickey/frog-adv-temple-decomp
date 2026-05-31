@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802c910, 0x0802ca64)  (0x154 bytes)
@
@ Pre-peel chunk before sub_0802CA64.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802c910
        .type   text_0802c910, %object
text_0802c910:
        .incbin "frog_us_baserom.gba", 0x0002c910, 0x00000154
        .size   text_0802c910, . - text_0802c910
