@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017bfc, 0x08019500)  (0x1904 bytes)
@
@ Post-peel chunk after sub_08017ABC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017bfc
        .type   text_08017bfc, %object
text_08017bfc:
        .incbin "frog_us_baserom.gba", 0x00017bfc, 0x00001904
        .size   text_08017bfc, . - text_08017bfc
