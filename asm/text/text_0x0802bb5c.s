@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802bb5c, 0x0802bf58)  (0x3fc bytes)
@
@ Pre-peel chunk before sub_0802BF58.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802bb5c
        .type   text_0802bb5c, %object
text_0802bb5c:
        .incbin "frog_us_baserom.gba", 0x0002bb5c, 0x000003fc
        .size   text_0802bb5c, . - text_0802bb5c
