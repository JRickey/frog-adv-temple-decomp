@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d9ec, 0x0802e3f8)  (0xa0c bytes)
@
@ Post-peel chunk after sub_0802D8F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d9ec
        .type   text_0802d9ec, %object
text_0802d9ec:
        .incbin "frog_us_baserom.gba", 0x0002d9ec, 0x00000a0c
        .size   text_0802d9ec, . - text_0802d9ec
