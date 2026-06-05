@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802f99c, 0x0802f9f0)  (0x54 bytes)
@
@ Post-peel chunk after sub_0802F930.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802f99c
        .type   text_0802f99c, %object
text_0802f99c:
        .incbin "frog_us_baserom.gba", 0x0002f99c, 0x00000054
        .size   text_0802f99c, . - text_0802f99c
