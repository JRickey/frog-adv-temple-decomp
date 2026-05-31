@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800d924, 0x0800d9fc)  (0xd8 bytes)
@
@ Post-peel chunk after sub_0800D8A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800d924
        .type   text_0800d924, %object
text_0800d924:
        .incbin "frog_us_baserom.gba", 0x0000d924, 0x000000d8
        .size   text_0800d924, . - text_0800d924
