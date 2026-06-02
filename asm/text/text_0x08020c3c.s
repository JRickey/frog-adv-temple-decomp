@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08020c3c, 0x08020c78)  (0x3c bytes)
@
@ Post-peel chunk after sub_08020C14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08020c3c
        .type   text_08020c3c, %object
text_08020c3c:
        .incbin "frog_us_baserom.gba", 0x00020c3c, 0x0000003c
        .size   text_08020c3c, . - text_08020c3c
