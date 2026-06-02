@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022c44, 0x0802a394)  (0x7750 bytes)
@
@ Post-peel chunk after sub_08022BCC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022c44
        .type   text_08022c44, %object
text_08022c44:
        .incbin "frog_us_baserom.gba", 0x00022c44, 0x00007750
        .size   text_08022c44, . - text_08022c44
