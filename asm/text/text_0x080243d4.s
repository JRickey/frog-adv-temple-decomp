@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080243d4, 0x0802a2f0)  (0x5f1c bytes)
@
@ Post-peel chunk after sub_08024390.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080243d4
        .type   text_080243d4, %object
text_080243d4:
        .incbin "frog_us_baserom.gba", 0x000243d4, 0x00005f1c
        .size   text_080243d4, . - text_080243d4
