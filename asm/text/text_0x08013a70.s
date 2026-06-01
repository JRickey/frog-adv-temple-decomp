@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013a70, 0x08013c60)  (0x1f0 bytes)
@
@ Post-peel chunk after sub_08013A34.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013a70
        .type   text_08013a70, %object
text_08013a70:
        .incbin "frog_us_baserom.gba", 0x00013a70, 0x000001f0
        .size   text_08013a70, . - text_08013a70
