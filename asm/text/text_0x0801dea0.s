@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0801dea0, 0x0801e078)  (0x1d8 bytes)
@
@ Pre-peel chunk before sub_0801E078.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0801dea0
        .type   text_0801dea0, %object
text_0801dea0:
        .incbin "frog_us_baserom.gba", 0x0001dea0, 0x000001d8
        .size   text_0801dea0, . - text_0801dea0
