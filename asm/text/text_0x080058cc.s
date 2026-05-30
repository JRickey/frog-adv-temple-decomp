@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080058cc, 0x080059c4)  (0xf8 bytes)
@
@ Post-peel chunk after sub_08005890.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080058cc
        .type   text_080058cc, %object
text_080058cc:
        .incbin "frog_us_baserom.gba", 0x000058cc, 0x000000f8
        .size   text_080058cc, . - text_080058cc
