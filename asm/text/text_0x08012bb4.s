@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012bb4, 0x08012bc4)  (0x10 bytes)
@
@ Post-peel chunk after sub_08012B78.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012bb4
        .type   text_08012bb4, %object
text_08012bb4:
        .incbin "frog_us_baserom.gba", 0x00012bb4, 0x00000010
        .size   text_08012bb4, . - text_08012bb4
