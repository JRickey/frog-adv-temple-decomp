@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08030644, 0x080315d8)  (0xf94 bytes)
@
@ Post-peel chunk after sub_080304F4.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08030644
        .type   text_08030644, %object
text_08030644:
        .incbin "frog_us_baserom.gba", 0x00030644, 0x00000f94
        .size   text_08030644, . - text_08030644
