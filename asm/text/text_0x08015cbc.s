@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08015cbc, 0x08016360)  (0x6a4 bytes)
@
@ Post-peel chunk after sub_08015C24.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08015cbc
        .type   text_08015cbc, %object
text_08015cbc:
        .incbin "frog_us_baserom.gba", 0x00015cbc, 0x000006a4
        .size   text_08015cbc, . - text_08015cbc
