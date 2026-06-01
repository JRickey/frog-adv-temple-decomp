@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013f94, 0x08013fa0)  (0xc bytes)
@
@ Post-peel chunk after sub_08013F68.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013f94
        .type   text_08013f94, %object
text_08013f94:
        .incbin "frog_us_baserom.gba", 0x00013f94, 0x0000000c
        .size   text_08013f94, . - text_08013f94
