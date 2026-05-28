@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800bebc, 0x0800c358)  (0x49c bytes)
@
@ Post-peel chunk after sub_0800BE18.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800bebc
        .type   text_0800bebc, %object
text_0800bebc:
        .incbin "frog_us_baserom.gba", 0x0000bebc, 0x0000049c
        .size   text_0800bebc, . - text_0800bebc
