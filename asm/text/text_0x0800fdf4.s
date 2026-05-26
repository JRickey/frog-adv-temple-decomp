@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800fdf4, 0x08010000)  (0x20c bytes)
@
@ Post-peel chunk after sub_0800FD50.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800fdf4
        .type   text_0800fdf4, %object
text_0800fdf4:
        .incbin "frog_us_baserom.gba", 0x0000fdf4, 0x0000020c
        .size   text_0800fdf4, . - text_0800fdf4
