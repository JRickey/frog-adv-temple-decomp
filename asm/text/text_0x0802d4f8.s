@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d4f8, 0x0802d548)  (0x50 bytes)
@
@ Post-peel chunk after sub_0802D4AC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d4f8
        .type   text_0802d4f8, %object
text_0802d4f8:
        .incbin "frog_us_baserom.gba", 0x0002d4f8, 0x00000050
        .size   text_0802d4f8, . - text_0802d4f8
