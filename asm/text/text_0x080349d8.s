@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x080349d8, 0x08035708)  (0xd30 bytes)
@
@ Pre-peel chunk before sub_08035708.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_080349d8
        .type   text_080349d8, %object
text_080349d8:
        .incbin "frog_us_baserom.gba", 0x000349d8, 0x00000d30
        .size   text_080349d8, . - text_080349d8
