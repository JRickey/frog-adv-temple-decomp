@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080069bc, 0x08006adc)  (0x120 bytes)
@
@ Post-peel chunk after sub_0800696C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080069bc
        .type   text_080069bc, %object
text_080069bc:
        .incbin "frog_us_baserom.gba", 0x000069bc, 0x00000120
        .size   text_080069bc, . - text_080069bc
