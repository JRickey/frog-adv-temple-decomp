@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08009cbc, 0x08009d9c)  (0xe0 bytes)
@
@ Post-peel chunk after sub_08009C14.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08009cbc
        .type   text_08009cbc, %object
text_08009cbc:
        .incbin "frog_us_baserom.gba", 0x00009cbc, 0x000000e0
        .size   text_08009cbc, . - text_08009cbc
