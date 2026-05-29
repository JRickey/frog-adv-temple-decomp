@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022160, 0x0802ab64)  (0x8a04 bytes)
@
@ Post-peel chunk after sub_080220C4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022160
        .type   text_08022160, %object
text_08022160:
        .incbin "frog_us_baserom.gba", 0x00022160, 0x00008a04
        .size   text_08022160, . - text_08022160
