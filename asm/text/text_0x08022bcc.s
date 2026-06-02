@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08022bcc, 0x0802a394)  (0x77c8 bytes)
@
@ Post-peel chunk after sub_08022BB0.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08022bcc
        .type   text_08022bcc, %object
text_08022bcc:
        .incbin "frog_us_baserom.gba", 0x00022bcc, 0x000077c8
        .size   text_08022bcc, . - text_08022bcc
