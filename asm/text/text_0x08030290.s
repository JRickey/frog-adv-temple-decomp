@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08030290, 0x080315d8)  (0x1348 bytes)
@
@ Post-peel chunk after sub_08030264.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08030290
        .type   text_08030290, %object
text_08030290:
        .incbin "frog_us_baserom.gba", 0x00030290, 0x00001348
        .size   text_08030290, . - text_08030290
