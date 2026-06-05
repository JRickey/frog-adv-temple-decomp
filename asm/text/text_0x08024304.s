@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024304, 0x0802a2f0)  (0x5fec bytes)
@
@ Post-peel chunk after sub_080242D8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024304
        .type   text_08024304, %object
text_08024304:
        .incbin "frog_us_baserom.gba", 0x00024304, 0x00005fec
        .size   text_08024304, . - text_08024304
