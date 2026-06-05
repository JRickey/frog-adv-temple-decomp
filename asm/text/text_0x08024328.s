@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024328, 0x0802a2f0)  (0x5fc8 bytes)
@
@ Post-peel chunk after sub_08024304.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024328
        .type   text_08024328, %object
text_08024328:
        .incbin "frog_us_baserom.gba", 0x00024328, 0x00005fc8
        .size   text_08024328, . - text_08024328
