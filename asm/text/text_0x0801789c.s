@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801789c, 0x0801793c)  (0xa0 bytes)
@
@ Post-peel chunk after sub_08017858.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801789c
        .type   text_0801789c, %object
text_0801789c:
        .incbin "frog_us_baserom.gba", 0x0001789c, 0x000000a0
        .size   text_0801789c, . - text_0801789c
