@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800d808, 0x0800d9fc)  (0x1f4 bytes)
@
@ Post-peel chunk after sub_0800D450.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800d808
        .type   text_0800d808, %object
text_0800d808:
        .incbin "frog_us_baserom.gba", 0x0000d808, 0x000001f4
        .size   text_0800d808, . - text_0800d808
