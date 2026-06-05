@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024444, 0x0802a2f0)  (0x5eac bytes)
@
@ Post-peel chunk after sub_080243D4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024444
        .type   text_08024444, %object
text_08024444:
        .incbin "frog_us_baserom.gba", 0x00024444, 0x00005eac
        .size   text_08024444, . - text_08024444
