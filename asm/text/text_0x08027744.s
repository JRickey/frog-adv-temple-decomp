@ Auto-created during peel of sub_080276FC (now shrunken for sub_08027744 peel).
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08027744, 0x08027770)  (0x002c bytes)
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08027744
        .type   text_08027744, %object
text_08027744:
        .incbin "frog_us_baserom.gba", 0x00027744, 0x0000002c
        .size   text_08027744, . - text_08027744
