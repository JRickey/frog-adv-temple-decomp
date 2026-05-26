@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800e85c, 0x0800ef90)  (0x734 bytes)
@
@ Post-peel chunk after sub_0800E6A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800e85c
        .type   text_0800e85c, %object
text_0800e85c:
        .incbin "frog_us_baserom.gba", 0x0000e85c, 0x00000734
        .size   text_0800e85c, . - text_0800e85c
