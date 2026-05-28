@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802abb0, 0x0802d554)  (0x29a4 bytes)
@
@ Post-peel chunk after sub_0802AB64.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802abb0
        .type   text_0802abb0, %object
text_0802abb0:
        .incbin "frog_us_baserom.gba", 0x0002abb0, 0x000029a4
        .size   text_0802abb0, . - text_0802abb0
