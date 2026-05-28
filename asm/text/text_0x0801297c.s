@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801297c, 0x08012b38)  (0x1bc bytes)
@
@ Post-peel chunk after sub_0801288C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801297c
        .type   text_0801297c, %object
text_0801297c:
        .incbin "frog_us_baserom.gba", 0x0001297c, 0x000001bc
        .size   text_0801297c, . - text_0801297c
