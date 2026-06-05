@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08034924, 0x0803578c)  (0xe68 bytes)
@
@ Post-peel chunk after sub_08034900.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08034924
        .type   text_08034924, %object
text_08034924:
        .incbin "frog_us_baserom.gba", 0x00034924, 0x00000e68
        .size   text_08034924, . - text_08034924
