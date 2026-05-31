@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022a9c, 0x0802a394)  (0x78f8 bytes)
@
@ Post-peel chunk after sub_08022A28.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022a9c
        .type   text_08022a9c, %object
text_08022a9c:
        .incbin "frog_us_baserom.gba", 0x00022a9c, 0x000078f8
        .size   text_08022a9c, . - text_08022a9c
