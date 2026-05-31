@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080357ec, 0x08035d7c)  (0x590 bytes)
@
@ Post-peel chunk after sub_0803578C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080357ec
        .type   text_080357ec, %object
text_080357ec:
        .incbin "frog_us_baserom.gba", 0x000357ec, 0x00000590
        .size   text_080357ec, . - text_080357ec
