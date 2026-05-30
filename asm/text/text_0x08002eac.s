@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002eac, 0x08002ee8)  (0x3c bytes)
@
@ Post-peel chunk after sub_08002E94.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002eac
        .type   text_08002eac, %object
text_08002eac:
        .incbin "frog_us_baserom.gba", 0x00002eac, 0x0000003c
        .size   text_08002eac, . - text_08002eac
