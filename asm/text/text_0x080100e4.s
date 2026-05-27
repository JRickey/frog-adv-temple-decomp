@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080100e4, 0x08010694)  (0x5b0 bytes)
@
@ Post-peel chunk after sub_0800FE88.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080100e4
        .type   text_080100e4, %object
text_080100e4:
        .incbin "frog_us_baserom.gba", 0x000100e4, 0x000005b0
        .size   text_080100e4, . - text_080100e4
