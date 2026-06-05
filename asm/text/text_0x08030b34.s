@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08030b34, 0x080315d8)  (0xaa4 bytes)
@
@ Post-peel chunk after sub_08030A44.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08030b34
        .type   text_08030b34, %object
text_08030b34:
        .incbin "frog_us_baserom.gba", 0x00030b34, 0x00000aa4
        .size   text_08030b34, . - text_08030b34
