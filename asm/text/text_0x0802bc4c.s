@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802bc4c, 0x0802bc94)  (0x48 bytes)
@
@ Post-peel chunk after sub_0802BC24.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802bc4c
        .type   text_0802bc4c, %object
text_0802bc4c:
        .incbin "frog_us_baserom.gba", 0x0002bc4c, 0x00000048
        .size   text_0802bc4c, . - text_0802bc4c
