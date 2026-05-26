@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017a88, 0x08019500)  (0x1a78 bytes)
@
@ Post-peel chunk after sub_080179B8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017a88
        .type   text_08017a88, %object
text_08017a88:
        .incbin "frog_us_baserom.gba", 0x00017a88, 0x00001a78
        .size   text_08017a88, . - text_08017a88
