@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08013ba4, 0x08013c60)  (0xbc bytes)
@
@ Post-peel chunk after sub_08013B54.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08013ba4
        .type   text_08013ba4, %object
text_08013ba4:
        .incbin "frog_us_baserom.gba", 0x00013ba4, 0x000000bc
        .size   text_08013ba4, . - text_08013ba4
