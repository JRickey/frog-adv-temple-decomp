@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080196ec, 0x08019964)  (0x278 bytes)
@
@ Post-peel chunk after sub_080196A0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080196ec
        .type   text_080196ec, %object
text_080196ec:
        .incbin "frog_us_baserom.gba", 0x000196ec, 0x00000278
        .size   text_080196ec, . - text_080196ec
