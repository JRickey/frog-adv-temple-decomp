@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a214, 0x0800a2d8)  (0xc4 bytes)
@
@ Post-peel chunk after sub_0800A1C8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a214
        .type   text_0800a214, %object
text_0800a214:
        .incbin "frog_us_baserom.gba", 0x0000a214, 0x000000c4
        .size   text_0800a214, . - text_0800a214
