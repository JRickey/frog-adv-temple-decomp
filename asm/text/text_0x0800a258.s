@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a258, 0x0800a2d8)  (0x80 bytes)
@
@ Post-peel chunk after sub_0800A214.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a258
        .type   text_0800a258, %object
text_0800a258:
        .incbin "frog_us_baserom.gba", 0x0000a258, 0x00000080
        .size   text_0800a258, . - text_0800a258
