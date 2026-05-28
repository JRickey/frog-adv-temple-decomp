@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a26c, 0x0800a2d8)  (0x6c bytes)
@
@ Post-peel chunk after sub_0800A258.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a26c
        .type   text_0800a26c, %object
text_0800a26c:
        .incbin "frog_us_baserom.gba", 0x0000a26c, 0x0000006c
        .size   text_0800a26c, . - text_0800a26c
