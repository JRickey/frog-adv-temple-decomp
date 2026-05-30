@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08003604, 0x08003668)  (0x64 bytes)
@
@ Post-peel chunk after sub_080035F8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08003604
        .type   text_08003604, %object
text_08003604:
        .incbin "frog_us_baserom.gba", 0x00003604, 0x00000064
        .size   text_08003604, . - text_08003604
