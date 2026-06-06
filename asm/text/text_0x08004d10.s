@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08004d10, 0x08004fac)  (0x29c bytes)
@
@ Post-peel chunk after Mode_EndScene.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08004d10
        .type   text_08004d10, %object
text_08004d10:
        .incbin "frog_us_baserom.gba", 0x00004d10, 0x0000029c
        .size   text_08004d10, . - text_08004d10
