@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802f47c, 0x0802f4b0)  (0x34 bytes)
@
@ Post-peel chunk after sub_0802F398.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802f47c
        .type   text_0802f47c, %object
text_0802f47c:
        .incbin "frog_us_baserom.gba", 0x0002f47c, 0x00000034
        .size   text_0802f47c, . - text_0802f47c
