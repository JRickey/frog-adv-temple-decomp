@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08032bc8, 0x08033910)  (0xd48 bytes)
@
@ Post-peel chunk after sub_08032B18.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08032bc8
        .type   text_08032bc8, %object
text_08032bc8:
        .incbin "frog_us_baserom.gba", 0x00032bc8, 0x00000d48
        .size   text_08032bc8, . - text_08032bc8
