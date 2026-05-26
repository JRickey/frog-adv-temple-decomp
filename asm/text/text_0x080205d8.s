@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080205d8, 0x08020b30)  (0x558 bytes)
@
@ Post-peel chunk after sub_080204A4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080205d8
        .type   text_080205d8, %object
text_080205d8:
        .incbin "frog_us_baserom.gba", 0x000205d8, 0x00000558
        .size   text_080205d8, . - text_080205d8
