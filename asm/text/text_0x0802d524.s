@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802d524, 0x0802d548)  (0x24 bytes)
@
@ Post-peel chunk after sub_0802D504.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802d524
        .type   text_0802d524, %object
text_0802d524:
        .incbin "frog_us_baserom.gba", 0x0002d524, 0x00000024
        .size   text_0802d524, . - text_0802d524
