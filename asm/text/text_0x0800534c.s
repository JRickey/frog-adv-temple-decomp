@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800534c, 0x080054a8)  (0x15c bytes)
@
@ Post-peel chunk after sub_08005308.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800534c
        .type   text_0800534c, %object
text_0800534c:
        .incbin "frog_us_baserom.gba", 0x0000534c, 0x0000015c
        .size   text_0800534c, . - text_0800534c
