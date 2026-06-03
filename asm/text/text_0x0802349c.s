@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802349c, 0x0802a394)  (0x6ef8 bytes)
@
@ Post-peel chunk after sub_08023424.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802349c
        .type   text_0802349c, %object
text_0802349c:
        .incbin "frog_us_baserom.gba", 0x0002349c, 0x00006ef8
        .size   text_0802349c, . - text_0802349c
