@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0802e1c8, 0x0802e380)  (0x1b8 bytes)
@
@ Pre-peel chunk before sub_0802E380.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0802e1c8
        .type   text_0802e1c8, %object
text_0802e1c8:
        .incbin "frog_us_baserom.gba", 0x0002e1c8, 0x000001b8
        .size   text_0802e1c8, . - text_0802e1c8
