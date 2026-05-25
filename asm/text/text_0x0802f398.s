@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802f398, 0x0802f4b0)  (0x118 bytes)
@
@ Post-peel chunk after sub_0802F2FC.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802f398
        .type   text_0802f398, %object
text_0802f398:
        .incbin "frog_us_baserom.gba", 0x0002f398, 0x00000118
        .size   text_0802f398, . - text_0802f398
