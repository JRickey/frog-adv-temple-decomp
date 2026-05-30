@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08005308, 0x080054a8)  (0x1a0 bytes)
@
@ Post-peel chunk after sub_080052CC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08005308
        .type   text_08005308, %object
text_08005308:
        .incbin "frog_us_baserom.gba", 0x00005308, 0x000001a0
        .size   text_08005308, . - text_08005308
