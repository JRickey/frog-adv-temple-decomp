@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08024260, 0x0802a2f0)  (0x6090 bytes)
@
@ Post-peel chunk after sub_08024234.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08024260
        .type   text_08024260, %object
text_08024260:
        .incbin "frog_us_baserom.gba", 0x00024260, 0x00006090
        .size   text_08024260, . - text_08024260
