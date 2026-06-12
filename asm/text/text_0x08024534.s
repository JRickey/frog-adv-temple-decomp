@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024534, 0x0802a2f0)  (0x5dbc bytes)
@
@ Post-peel chunk after sub_080244F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024534
        .type   text_08024534, %object
text_08024534:
        .incbin "frog_us_baserom.gba", 0x00024534, 0x00005dbc
        .size   text_08024534, . - text_08024534
