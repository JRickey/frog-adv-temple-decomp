@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022ddc, 0x0802a394)  (0x75b8 bytes)
@
@ Post-peel chunk after sub_08022D4C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022ddc
        .type   text_08022ddc, %object
text_08022ddc:
        .incbin "frog_us_baserom.gba", 0x00022ddc, 0x000075b8
        .size   text_08022ddc, . - text_08022ddc
