@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080317e0, 0x0803189c)  (0xbc bytes)
@
@ Post-peel chunk after SoundOp_SetEnvelopeC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080317e0
        .type   text_080317e0, %object
text_080317e0:
        .incbin "frog_us_baserom.gba", 0x000317e0, 0x000000bc
        .size   text_080317e0, . - text_080317e0
