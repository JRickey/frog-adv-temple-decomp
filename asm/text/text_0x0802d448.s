@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d448, 0x0802d548)  (0x100 bytes)
@
@ Post-peel chunk after sub_0802D3C0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d448
        .type   text_0802d448, %object
text_0802d448:
        .incbin "frog_us_baserom.gba", 0x0002d448, 0x00000100
        .size   text_0802d448, . - text_0802d448
