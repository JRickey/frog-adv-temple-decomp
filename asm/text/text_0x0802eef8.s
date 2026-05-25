@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802eef8, 0x0802f054)  (0x15c bytes)
@
@ Pre-peel chunk before sub_0802F054.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802eef8
        .type   text_0802eef8, %object
text_0802eef8:
        .incbin "frog_us_baserom.gba", 0x0002eef8, 0x0000015c
        .size   text_0802eef8, . - text_0802eef8
