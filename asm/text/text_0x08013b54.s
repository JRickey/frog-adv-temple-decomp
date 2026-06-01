@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013b54, 0x08013c60)  (0x10c bytes)
@
@ Post-peel chunk after sub_08013AE8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013b54
        .type   text_08013b54, %object
text_08013b54:
        .incbin "frog_us_baserom.gba", 0x00013b54, 0x0000010c
        .size   text_08013b54, . - text_08013b54
