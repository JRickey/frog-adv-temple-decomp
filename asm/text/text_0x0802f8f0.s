@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802f8f0, 0x0802f9f0)  (0x100 bytes)
@
@ Post-peel chunk after sub_0802F870.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802f8f0
        .type   text_0802f8f0, %object
text_0802f8f0:
        .incbin "frog_us_baserom.gba", 0x0002f8f0, 0x00000100
        .size   text_0802f8f0, . - text_0802f8f0
