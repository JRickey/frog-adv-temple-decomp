@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08011288, 0x0801129c)  (0x14 bytes)
@
@ Post-peel chunk after Scroll_TickBlitDir.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08011288
        .type   text_08011288, %object
text_08011288:
        .incbin "frog_us_baserom.gba", 0x00011288, 0x00000014
        .size   text_08011288, . - text_08011288
