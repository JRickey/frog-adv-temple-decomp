@ Auto-emitted by tools/agent/auto_peel.py — do not hand-edit this header.
@ Address-aligned bucket of unparsed baserom bytes.
@ Range:  [0x08012e2c, 0x08012e64)  (0x38 bytes)
@
@ Pre-peel chunk before sub_08012E64.
@
@ This file holds raw bytes only; no instructions are assembled here.

        .section .text, "ax", %progbits
        .align  2
        .global text_08012e2c
        .type   text_08012e2c, %object
text_08012e2c:
        .incbin "frog_us_baserom.gba", 0x00012e2c, 0x00000038
        .size   text_08012e2c, . - text_08012e2c
