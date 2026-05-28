@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800b07c, 0x0800b7b0)  (0x734 bytes)
@
@ Post-peel chunk after sub_0800AF50.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800b07c
        .type   text_0800b07c, %object
text_0800b07c:
        .incbin "frog_us_baserom.gba", 0x0000b07c, 0x00000734
        .size   text_0800b07c, . - text_0800b07c
