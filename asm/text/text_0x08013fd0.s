@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013fd0, 0x08016404)  (0x2434 bytes)
@
@ Post-peel chunk after sub_08013FA0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013fd0
        .type   text_08013fd0, %object
text_08013fd0:
        .incbin "frog_us_baserom.gba", 0x00013fd0, 0x00002434
        .size   text_08013fd0, . - text_08013fd0
