@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802277c, 0x0802ab64)  (0x83e8 bytes)
@
@ Post-peel chunk after sub_08022758.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802277c
        .type   text_0802277c, %object
text_0802277c:
        .incbin "frog_us_baserom.gba", 0x0002277c, 0x000083e8
        .size   text_0802277c, . - text_0802277c
