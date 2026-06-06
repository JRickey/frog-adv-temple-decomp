@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d4ac, 0x0802d548)  (0x9c bytes)
@
@ Post-peel chunk after sub_0802D448.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d4ac
        .type   text_0802d4ac, %object
text_0802d4ac:
        .incbin "frog_us_baserom.gba", 0x0002d4ac, 0x0000009c
        .size   text_0802d4ac, . - text_0802d4ac
