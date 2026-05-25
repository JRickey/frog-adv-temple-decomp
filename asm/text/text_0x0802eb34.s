@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802eb34, 0x0802ec7c)  (0x148 bytes)
@
@ Pre-peel chunk before sub_0802EC7C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802eb34
        .type   text_0802eb34, %object
text_0802eb34:
        .incbin "frog_us_baserom.gba", 0x0002eb34, 0x00000148
        .size   text_0802eb34, . - text_0802eb34
