@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08015ec4, 0x08016360)  (0x49c bytes)
@
@ Post-peel chunk after sub_08015EA8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08015ec4
        .type   text_08015ec4, %object
text_08015ec4:
        .incbin "frog_us_baserom.gba", 0x00015ec4, 0x0000049c
        .size   text_08015ec4, . - text_08015ec4
