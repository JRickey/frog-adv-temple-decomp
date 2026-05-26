@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08030264, 0x080315d8)  (0x1374 bytes)
@
@ Post-peel chunk after sub_080301C4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08030264
        .type   text_08030264, %object
text_08030264:
        .incbin "frog_us_baserom.gba", 0x00030264, 0x00001374
        .size   text_08030264, . - text_08030264
