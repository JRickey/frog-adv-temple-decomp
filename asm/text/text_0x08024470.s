@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024470, 0x0802a2f0)  (0x5e80 bytes)
@
@ Post-peel chunk after LoadEntitySlot77.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024470
        .type   text_08024470, %object
text_08024470:
        .incbin "frog_us_baserom.gba", 0x00024470, 0x00005e80
        .size   text_08024470, . - text_08024470
