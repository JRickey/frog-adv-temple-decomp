@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080017dc, 0x080018f8)  (0x11c bytes)
@
@ Post-peel chunk after sub_080017A8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080017dc
        .type   text_080017dc, %object
text_080017dc:
        .incbin "frog_us_baserom.gba", 0x000017dc, 0x0000011c
        .size   text_080017dc, . - text_080017dc
