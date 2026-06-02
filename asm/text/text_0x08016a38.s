@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08016a38, 0x08016a40)  (0x8 bytes)
@
@ Post-peel chunk after sub_080169BC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08016a38
        .type   text_08016a38, %object
text_08016a38:
        .incbin "frog_us_baserom.gba", 0x00016a38, 0x00000008
        .size   text_08016a38, . - text_08016a38
