@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022a28, 0x0802a394)  (0x796c bytes)
@
@ Post-peel chunk after sub_080229F0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022a28
        .type   text_08022a28, %object
text_08022a28:
        .incbin "frog_us_baserom.gba", 0x00022a28, 0x0000796c
        .size   text_08022a28, . - text_08022a28
