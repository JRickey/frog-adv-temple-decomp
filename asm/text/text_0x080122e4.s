@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080122e4, 0x08012664)  (0x380 bytes)
@
@ Post-peel chunk after sub_0801223C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080122e4
        .type   text_080122e4, %object
text_080122e4:
        .incbin "frog_us_baserom.gba", 0x000122e4, 0x00000380
        .size   text_080122e4, . - text_080122e4
