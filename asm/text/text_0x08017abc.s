@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017abc, 0x08019500)  (0x1a44 bytes)
@
@ Post-peel chunk after sub_08017AA8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017abc
        .type   text_08017abc, %object
text_08017abc:
        .incbin "frog_us_baserom.gba", 0x00017abc, 0x00001a44
        .size   text_08017abc, . - text_08017abc
