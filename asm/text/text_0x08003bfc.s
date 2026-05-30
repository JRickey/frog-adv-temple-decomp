@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08003bfc, 0x08003ca8)  (0xac bytes)
@
@ Post-peel chunk after sub_08003B8C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08003bfc
        .type   text_08003bfc, %object
text_08003bfc:
        .incbin "frog_us_baserom.gba", 0x00003bfc, 0x000000ac
        .size   text_08003bfc, . - text_08003bfc
