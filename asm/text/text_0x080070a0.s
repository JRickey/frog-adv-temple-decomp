@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080070a0, 0x08007228)  (0x188 bytes)
@
@ Pre-peel chunk before sub_08007228.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080070a0
        .type   text_080070a0, %object
text_080070a0:
        .incbin "frog_us_baserom.gba", 0x000070a0, 0x00000188
        .size   text_080070a0, . - text_080070a0
