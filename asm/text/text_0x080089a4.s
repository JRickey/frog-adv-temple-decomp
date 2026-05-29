@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080089a4, 0x08008a5c)  (0xb8 bytes)
@
@ Post-peel chunk after sub_0800885C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080089a4
        .type   text_080089a4, %object
text_080089a4:
        .incbin "frog_us_baserom.gba", 0x000089a4, 0x000000b8
        .size   text_080089a4, . - text_080089a4
