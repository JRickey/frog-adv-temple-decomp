@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017000, 0x08017364)  (0x364 bytes)
@
@ Post-peel chunk after sub_08016A40.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017000
        .type   text_08017000, %object
text_08017000:
        .incbin "frog_us_baserom.gba", 0x00017000, 0x00000364
        .size   text_08017000, . - text_08017000
