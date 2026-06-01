@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08019678, 0x08019964)  (0x2ec bytes)
@
@ Post-peel chunk after sub_080195C4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08019678
        .type   text_08019678, %object
text_08019678:
        .incbin "frog_us_baserom.gba", 0x00019678, 0x000002ec
        .size   text_08019678, . - text_08019678
