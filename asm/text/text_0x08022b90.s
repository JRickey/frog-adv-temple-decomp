@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022b90, 0x0802a394)  (0x7804 bytes)
@
@ Post-peel chunk after sub_08022B4C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022b90
        .type   text_08022b90, %object
text_08022b90:
        .incbin "frog_us_baserom.gba", 0x00022b90, 0x00007804
        .size   text_08022b90, . - text_08022b90
