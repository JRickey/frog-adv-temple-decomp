@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08001850, 0x080018f8)  (0xa8 bytes)
@
@ Post-peel chunk after sub_080017DC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08001850
        .type   text_08001850, %object
text_08001850:
        .incbin "frog_us_baserom.gba", 0x00001850, 0x000000a8
        .size   text_08001850, . - text_08001850
