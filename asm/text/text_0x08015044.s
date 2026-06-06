@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08015044, 0x08015194)  (0x150 bytes)
@
@ Post-peel chunk after sub_08014EE8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08015044
        .type   text_08015044, %object
text_08015044:
        .incbin "frog_us_baserom.gba", 0x00015044, 0x00000150
        .size   text_08015044, . - text_08015044
