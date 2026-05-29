@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017db8, 0x08019500)  (0x1748 bytes)
@
@ Post-peel chunk after sub_08017BFC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017db8
        .type   text_08017db8, %object
text_08017db8:
        .incbin "frog_us_baserom.gba", 0x00017db8, 0x00001748
        .size   text_08017db8, . - text_08017db8
