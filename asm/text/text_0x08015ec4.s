@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08015ec4, 0x0801621c)  (0x358 bytes)
@
@ Pre-peel chunk before Mode4_BlitRect.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08015ec4
        .type   text_08015ec4, %object
text_08015ec4:
        .incbin "frog_us_baserom.gba", 0x00015ec4, 0x00000358
        .size   text_08015ec4, . - text_08015ec4
