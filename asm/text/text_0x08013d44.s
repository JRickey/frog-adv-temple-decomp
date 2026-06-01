@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013d44, 0x08013fa0)  (0x25c bytes)
@
@ Post-peel chunk after sub_08013D1C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013d44
        .type   text_08013d44, %object
text_08013d44:
        .incbin "frog_us_baserom.gba", 0x00013d44, 0x0000025c
        .size   text_08013d44, . - text_08013d44
