@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022cd4, 0x0802a394)  (0x76c0 bytes)
@
@ Post-peel chunk after sub_08022C44.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022cd4
        .type   text_08022cd4, %object
text_08022cd4:
        .incbin "frog_us_baserom.gba", 0x00022cd4, 0x000076c0
        .size   text_08022cd4, . - text_08022cd4
