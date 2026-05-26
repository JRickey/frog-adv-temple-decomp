@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x0800a158, 0x0800a1c8)  (0x70 bytes)
@
@ Pre-peel chunk before sub_0800A1C8.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_0800a158
        .type   text_0800a158, %object
text_0800a158:
        .incbin "frog_us_baserom.gba", 0x0000a158, 0x00000070
        .size   text_0800a158, . - text_0800a158
