@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08007f88, 0x08008174)  (0x1ec bytes)
@
@ Pre-peel chunk before sub_08008174.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08007f88
        .type   text_08007f88, %object
text_08007f88:
        .incbin "frog_us_baserom.gba", 0x00007f88, 0x000001ec
        .size   text_08007f88, . - text_08007f88
