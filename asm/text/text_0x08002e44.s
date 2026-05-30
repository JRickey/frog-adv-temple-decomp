@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002e44, 0x08002ee8)  (0xa4 bytes)
@
@ Post-peel chunk after sub_08002E10.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002e44
        .type   text_08002e44, %object
text_08002e44:
        .incbin "frog_us_baserom.gba", 0x00002e44, 0x000000a4
        .size   text_08002e44, . - text_08002e44
