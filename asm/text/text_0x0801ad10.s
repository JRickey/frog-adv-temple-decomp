@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801ad10, 0x0801b374)  (0x664 bytes)
@
@ Post-peel chunk after sub_0801AC84.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801ad10
        .type   text_0801ad10, %object
text_0801ad10:
        .incbin "frog_us_baserom.gba", 0x0001ad10, 0x00000664
        .size   text_0801ad10, . - text_0801ad10
