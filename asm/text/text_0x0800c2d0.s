@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800c2d0, 0x0800c358)  (0x88 bytes)
@
@ Post-peel chunk after sub_0800C2A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800c2d0
        .type   text_0800c2d0, %object
text_0800c2d0:
        .incbin "frog_us_baserom.gba", 0x0000c2d0, 0x00000088
        .size   text_0800c2d0, . - text_0800c2d0
