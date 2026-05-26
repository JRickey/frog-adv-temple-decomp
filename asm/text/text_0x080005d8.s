@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080005d8, 0x0800072c)  (0x154 bytes)
@
@ Post-peel chunk after sub_080004C4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080005d8
        .type   text_080005d8, %object
text_080005d8:
        .incbin "frog_us_baserom.gba", 0x000005d8, 0x00000154
        .size   text_080005d8, . - text_080005d8
