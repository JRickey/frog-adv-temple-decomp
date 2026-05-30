@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002808, 0x08002844)  (0x3c bytes)
@
@ Post-peel chunk after sub_080027F0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002808
        .type   text_08002808, %object
text_08002808:
        .incbin "frog_us_baserom.gba", 0x00002808, 0x0000003c
        .size   text_08002808, . - text_08002808
