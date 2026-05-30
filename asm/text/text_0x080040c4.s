@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080040c4, 0x0800411c)  (0x58 bytes)
@
@ Post-peel chunk after sub_08004080.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080040c4
        .type   text_080040c4, %object
text_080040c4:
        .incbin "frog_us_baserom.gba", 0x000040c4, 0x00000058
        .size   text_080040c4, . - text_080040c4
