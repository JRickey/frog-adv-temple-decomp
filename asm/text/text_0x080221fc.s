@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080221fc, 0x0802ab64)  (0x8968 bytes)
@
@ Post-peel chunk after sub_08022160.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080221fc
        .type   text_080221fc, %object
text_080221fc:
        .incbin "frog_us_baserom.gba", 0x000221fc, 0x00008968
        .size   text_080221fc, . - text_080221fc
