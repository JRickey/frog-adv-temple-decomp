@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022b4c, 0x0802a394)  (0x7848 bytes)
@
@ Post-peel chunk after sub_08022AEC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022b4c
        .type   text_08022b4c, %object
text_08022b4c:
        .incbin "frog_us_baserom.gba", 0x00022b4c, 0x00007848
        .size   text_08022b4c, . - text_08022b4c
