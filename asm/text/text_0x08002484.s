@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002484, 0x08002524)  (0xa0 bytes)
@
@ Post-peel chunk after sub_08002450.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002484
        .type   text_08002484, %object
text_08002484:
        .incbin "frog_us_baserom.gba", 0x00002484, 0x000000a0
        .size   text_08002484, . - text_08002484
