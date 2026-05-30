@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080053a4, 0x080054a8)  (0x104 bytes)
@
@ Post-peel chunk after sub_0800534C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080053a4
        .type   text_080053a4, %object
text_080053a4:
        .incbin "frog_us_baserom.gba", 0x000053a4, 0x00000104
        .size   text_080053a4, . - text_080053a4
