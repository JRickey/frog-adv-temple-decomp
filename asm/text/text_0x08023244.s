@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08023244, 0x0802a394)  (0x7150 bytes)
@
@ Post-peel chunk after sub_0802321C.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08023244
        .type   text_08023244, %object
text_08023244:
        .incbin "frog_us_baserom.gba", 0x00023244, 0x00007150
        .size   text_08023244, . - text_08023244
