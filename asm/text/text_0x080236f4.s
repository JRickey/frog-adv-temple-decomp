@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080236f4, 0x0802a2f0)  (0x6bfc bytes)
@
@ Post-peel chunk after sub_0802367C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080236f4
        .type   text_080236f4, %object
text_080236f4:
        .incbin "frog_us_baserom.gba", 0x000236f4, 0x00006bfc
        .size   text_080236f4, . - text_080236f4
