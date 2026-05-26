@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a83c, 0x0800ab84)  (0x348 bytes)
@
@ Post-peel chunk after sub_0800A7A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a83c
        .type   text_0800a83c, %object
text_0800a83c:
        .incbin "frog_us_baserom.gba", 0x0000a83c, 0x00000348
        .size   text_0800a83c, . - text_0800a83c
