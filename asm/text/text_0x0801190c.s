@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801190c, 0x08012180)  (0x874 bytes)
@
@ Post-peel chunk after sub_080118FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801190c
        .type   text_0801190c, %object
text_0801190c:
        .incbin "frog_us_baserom.gba", 0x0001190c, 0x00000874
        .size   text_0801190c, . - text_0801190c
