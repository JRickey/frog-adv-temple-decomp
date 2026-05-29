@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08017858, 0x0801793c)  (0xe4 bytes)
@
@ Post-peel chunk after sub_08017814.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08017858
        .type   text_08017858, %object
text_08017858:
        .incbin "frog_us_baserom.gba", 0x00017858, 0x000000e4
        .size   text_08017858, . - text_08017858
