@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08003b8c, 0x08003ca8)  (0x11c bytes)
@
@ Post-peel chunk after sub_08003B40.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08003b8c
        .type   text_08003b8c, %object
text_08003b8c:
        .incbin "frog_us_baserom.gba", 0x00003b8c, 0x0000011c
        .size   text_08003b8c, . - text_08003b8c
