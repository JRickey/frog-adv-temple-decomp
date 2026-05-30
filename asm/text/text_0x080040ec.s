@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080040ec, 0x0800411c)  (0x30 bytes)
@
@ Post-peel chunk after sub_080040C4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080040ec
        .type   text_080040ec, %object
text_080040ec:
        .incbin "frog_us_baserom.gba", 0x000040ec, 0x00000030
        .size   text_080040ec, . - text_080040ec
