@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08002518, 0x08002524)  (0xc bytes)
@
@ Post-peel chunk after sub_080024E4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08002518
        .type   text_08002518, %object
text_08002518:
        .incbin "frog_us_baserom.gba", 0x00002518, 0x0000000c
        .size   text_08002518, . - text_08002518
