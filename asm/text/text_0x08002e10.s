@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002e10, 0x0800336c)  (0x55c bytes)
@
@ Pre-peel chunk before sub_0800336C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002e10
        .type   text_08002e10, %object
text_08002e10:
        .incbin "frog_us_baserom.gba", 0x00002e10, 0x0000055c
        .size   text_08002e10, . - text_08002e10
