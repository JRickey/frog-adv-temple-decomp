@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08031688, 0x080316dc)  (0x54 bytes)
@
@ Post-peel chunk after sub_08031638.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08031688
        .type   text_08031688, %object
text_08031688:
        .incbin "frog_us_baserom.gba", 0x00031688, 0x00000054
        .size   text_08031688, . - text_08031688
