@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08015a2c, 0x08016360)  (0x934 bytes)
@
@ Post-peel chunk after sub_08015A00.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08015a2c
        .type   text_08015a2c, %object
text_08015a2c:
        .incbin "frog_us_baserom.gba", 0x00015a2c, 0x00000934
        .size   text_08015a2c, . - text_08015a2c
