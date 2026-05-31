@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802ca80, 0x0802d554)  (0xad4 bytes)
@
@ Post-peel chunk after sub_0802CA70.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802ca80
        .type   text_0802ca80, %object
text_0802ca80:
        .incbin "frog_us_baserom.gba", 0x0002ca80, 0x00000ad4
        .size   text_0802ca80, . - text_0802ca80
