@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013d1c, 0x08013fa0)  (0x284 bytes)
@
@ Post-peel chunk after sub_08013C60.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013d1c
        .type   text_08013d1c, %object
text_08013d1c:
        .incbin "frog_us_baserom.gba", 0x00013d1c, 0x00000284
        .size   text_08013d1c, . - text_08013d1c
