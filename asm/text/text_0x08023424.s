@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023424, 0x0802a394)  (0x6f70 bytes)
@
@ Post-peel chunk after sub_08023400.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023424
        .type   text_08023424, %object
text_08023424:
        .incbin "frog_us_baserom.gba", 0x00023424, 0x00006f70
        .size   text_08023424, . - text_08023424
