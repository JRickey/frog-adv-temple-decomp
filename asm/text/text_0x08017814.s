@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017814, 0x0801793c)  (0x128 bytes)
@
@ Post-peel chunk after sub_080177D8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017814
        .type   text_08017814, %object
text_08017814:
        .incbin "frog_us_baserom.gba", 0x00017814, 0x00000128
        .size   text_08017814, . - text_08017814
