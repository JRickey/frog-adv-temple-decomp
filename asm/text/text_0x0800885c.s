@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800885c, 0x08008a5c)  (0x200 bytes)
@
@ Pre-peel chunk before sub_08008A5C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800885c
        .type   text_0800885c, %object
text_0800885c:
        .incbin "frog_us_baserom.gba", 0x0000885c, 0x00000200
        .size   text_0800885c, . - text_0800885c
